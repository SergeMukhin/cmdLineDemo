% Licensed under the Creative Commons Attribution 4.0 International License (http://creativecommons.org/licenses/by/4.0/).

implement cmdLineTest
    open core, stdio

clauses
    test1() :-
        write("==== Test 1 ====\n"),
        CLP = commandLineParser::new(),
        CLP:description := "Demo of '-' options",
        CLP:onRegular := mkHandler_1("regular"),
        CLP:addOption_help("-help"),
        CLP:addOption_0("-test", "Run in test mode", mkHandler_0("test")),
        CLP:addOption_1("-file", "The file to process", "File", mkHandler_1("file")),
        CLP:addOption_2("-user", "Username and password", "Username", "Password", mkHandler_2("user")),
        test(CLP, "-help"),
        test(CLP, "-test -file \"E:\\test help\\qw\" extra"),
        test(CLP, "-file \"E:\\test help\\qw\" -test"),
        test(CLP, "-test -file \"E:\\test help\\qw\" -user tlp password go"),
        test(CLP, "-file -test \"E:\\test help\\qw\" -user tlp password go"),
        write("====  End Test 1 ====\n\n").

clauses
    test2() :-
        write("==== Test 2 ====\n"),
        CLP = commandLineParser::new(),
        CLP:description := "Demo of '/' options",
        CLP:onRegular := mkHandler_1("regular"),
        CLP:optionChar := '/',
        CLP:addOption_help("/?"),
        CLP:addOption_0("/t", "Run in test mode", mkHandler_0("test")),
        CLP:addOption_1("/f", "The file to process", "File", mkHandler_1("file")),
        CLP:addOption_2("/u", "Username and password", "Username", "Password", mkHandler_2("user")),
        test(CLP, "/?"),
        test(CLP, "/t /f \"E:\\test help\\qw\" extra"),
        test(CLP, "/f \"E:\\test help\\qw\" /t"),
        test(CLP, "/t /f \"E:\\test help\\qw\" /u tlp password go"),
        test(CLP, "/f /t \"E:\\test help\\qw\" /u tlp password go"),
        write("==== End Test 2 ====\n\n").

class predicates
    mkHandler_0 : (string Field) -> predicate{} Handler.
clauses
    mkHandler_0(Field) = {  :- writef("    %\n", Field) }.

class predicates
    mkHandler_1 : (string Field) -> predicate{A} Handler.
clauses
    mkHandler_1(Field) = { (V1) :- writef("    %: %\n", Field, V1) }.

class predicates
    mkHandler_2 : (string Field) -> predicate{A, B} Handler.
clauses
    mkHandler_2(Field) = { (V1, V2) :- writef("    %\n        %\n        %\n", Field, V1, V2) }.

class predicates
    test : (commandLineParser CLP, string CmdLine).
clauses
    test(CLP, CmdLine) :-
        writef("%\n", CmdLine),
        Msg = if some(Error) = CLP:parse(CmdLine) then Error else "OK" end if,
        writef("%\n\n", Msg).

end implement cmdLineTest