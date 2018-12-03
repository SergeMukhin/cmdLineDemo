% Licensed under the Creative Commons Attribution 4.0 International License (http://creativecommons.org/licenses/by/4.0/).

implement main
    open core, stdio

class facts
    test1 : boolean := false.
    test2 : boolean := false.

clauses
    run() :-
        CLP = commandLineParser::new(),
        CLP:addOption_help("-help"),
        CLP:addOption_0("-test1", "Run test1", { () :- test1 := true }),
        CLP:addOption_0("-test2", "Run test2", { () :- test2 := true }),
        if some(ErrorMessage) = CLP:parse() then
            write(ErrorMessage)
        else
            % command line parsed successfully
            run2(CLP)
        end if.

class predicates
    run2 : (commandLineParser CLP).
clauses
    run2(CLP) :-
        PrintDescription = varM_boolean::new(true),
        Arguments = CLP:arguments,
        if [] <> Arguments then
            PrintDescription:setFalse(),
            write("Ignored regular arguments\n:"),
            foreach Arg in Arguments do
                writef("    %\n:", Arg)
            end foreach
        end if,
        if true = test1 then
            PrintDescription:setFalse(),
            cmdLineTest::test1()
        end if,
        if true = test2 then
            PrintDescription:setFalse(),
            cmdLineTest::test2()
        end if,
        if PrintDescription:isTrue() then
            write(CLP:usage)
        end if.

end implement main

goal
    console::runUtf8(main::run).