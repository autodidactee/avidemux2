#ifndef PythonEngine_h
#define PythonEngine_h

#ifndef CPYTHON_MOD
#define CPYTHON_MOD
#endif

#include <set>
#include <string>
#include <vector>

#include "IScriptEngine.h"
#include "tinypy.h"
#include "pyFunc.h"
#include "pyClassDescriptor.h"

class PythonEngine : public IScriptEngine
{
private:
	IEditor *_editor;
	tp_vm *_vm;

	std::vector<pyClassDescriptor> _pyClasses;
	std::set<eventHandlerFunc*> _eventHandlerSet;
	typedef tp_obj (pyRegisterClass)(tp_vm *vm);

	void registerFunction(const char *group, pyFunc *funcs);
	void registerFunctions();
	void registerClass(const char *className, pyRegisterClass classPy, const char *desc);

	static tp_obj dumpBuiltin(tp_vm *tp);
	static tp_obj getFileSize(tp_vm *tp);
	static tp_obj getFolderContent(tp_vm *tp);

public:
	~PythonEngine();
	void callEventHandlers(EVENT_TYPE eventType, const char *fileName, int lineNo, const char *message);
	IEditor* getEditor();
	std::string getName();
	void initialise(IEditor *videoBody);
	void registerEventHandler(eventHandlerFunc *func);
	bool runScript(std::string script);
	bool runScriptFile(std::string name);
	void unregisterEventHandler(eventHandlerFunc *func);
};

#endif