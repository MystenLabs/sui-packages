module 0x9da1251172760039cada5682faf91f2167b06744ebbb470c53f8b12b85cfdbeb::init {
    public fun init_app(arg0: &mut 0xe48eb713da3329d3ae653274bff0ec36aaabe7dfe0d3cb63edca9aef31901582::ledger::Ledger, arg1: &mut 0x2::tx_context::TxContext) {
        0xe48eb713da3329d3ae653274bff0ec36aaabe7dfe0d3cb63edca9aef31901582::ledger::init_app<0x9da1251172760039cada5682faf91f2167b06744ebbb470c53f8b12b85cfdbeb::auth::Witness>(arg0, 0x9da1251172760039cada5682faf91f2167b06744ebbb470c53f8b12b85cfdbeb::auth::witness(), arg1);
    }

    // decompiled from Move bytecode v6
}

