find_package(Subversion)

if (NOT VERBOSE)
	set(ffmpegSvnOutput OUTPUT_VARIABLE FFMPEG_SVN_OUTPUT)
	set(swscaleSvnOutput OUTPUT_VARIABLE SWSCALE_SVN_OUTPUT)
endif (NOT VERBOSE)

# Checkout FFmpeg source and patch it
if (NOT IS_DIRECTORY "${FFMPEG_SOURCE_DIR}/.svn")
	message(STATUS "Checking out FFmpeg")
	execute_process(COMMAND ${Subversion_SVN_EXECUTABLE} co svn://svn.ffmpeg.org/ffmpeg/trunk -r ${FFMPEG_VERSION} --ignore-externals "${FFMPEG_SOURCE_DIR}"
					${ffmpegSvnOutput})

	message(STATUS "Checking out libswscale")
	execute_process(COMMAND ${Subversion_SVN_EXECUTABLE} co svn://svn.ffmpeg.org/mplayer/trunk/libswscale -r ${SWSCALE_VERSION} "${FFMPEG_SOURCE_DIR}/libswscale"
					${swscaleSvnOutput})

	message("")

	set(FFMPEG_PERFORM_PATCH 1)
endif (NOT IS_DIRECTORY "${FFMPEG_SOURCE_DIR}/.svn")

# Check version
admGetRevision( ${FFMPEG_SOURCE_DIR} ffmpeg_WC_REVISION)
#Subversion_WC_INFO(${FFMPEG_SOURCE_DIR} ffmpeg)
message(STATUS "FFmpeg revision: ${ffmpeg_WC_REVISION}")

if (NOT ${ffmpeg_WC_REVISION} EQUAL ${FFMPEG_VERSION})
	MESSAGE(STATUS "Updating to revision ${FFMPEG_VERSION}")
	set(FFMPEG_PERFORM_BUILD 1)
	set(FFMPEG_PERFORM_PATCH 1)

	execute_process(COMMAND ${Subversion_SVN_EXECUTABLE} revert -R "${FFMPEG_SOURCE_DIR}"
					${ffmpegSvnOutput})
	execute_process(COMMAND ${Subversion_SVN_EXECUTABLE} up -r ${FFMPEG_VERSION} --ignore-externals "${FFMPEG_SOURCE_DIR}"
					${ffmpegSvnOutput})	

	message("")
endif (NOT ${ffmpeg_WC_REVISION} EQUAL ${FFMPEG_VERSION})

message("")
admGetRevision( ${FFMPEG_SOURCE_DIR}/libswscale swscale_WC_REVISION)
#Subversion_WC_INFO(${FFMPEG_SOURCE_DIR}/libswscale swscale)
message(STATUS "libswscale revision: ${swscale_WC_REVISION}")

if (NOT ${swscale_WC_REVISION} EQUAL ${SWSCALE_VERSION})
	message(STATUS "Updating to revision ${SWSCALE_VERSION}")
	set(FFMPEG_PERFORM_BUILD 1)
	set(FFMPEG_PERFORM_PATCH 1)

	execute_process(COMMAND ${Subversion_SVN_EXECUTABLE} revert -R "${FFMPEG_SOURCE_DIR}/libswscale"
					${swscaleSvnOutput})
	execute_process(COMMAND ${Subversion_SVN_EXECUTABLE} up -r ${SWSCALE_VERSION} "${FFMPEG_SOURCE_DIR}/libswscale"
					${swscaleSvnOutput})
endif (NOT ${swscale_WC_REVISION} EQUAL ${SWSCALE_VERSION})
