module 0x399abdf475acdfbc50ebd6b609ed7fc22dfac34bf7b8633738c53b62ddb3c57::cannibal {
    struct CANNIBAL has drop {
        dummy_field: bool,
    }

    fun init(arg0: CANNIBAL, arg1: &mut 0x2::tx_context::TxContext) {
        0x399abdf475acdfbc50ebd6b609ed7fc22dfac34bf7b8633738c53b62ddb3c57::admin::create_and_transfer(arg1);
    }

    // decompiled from Move bytecode v6
}

