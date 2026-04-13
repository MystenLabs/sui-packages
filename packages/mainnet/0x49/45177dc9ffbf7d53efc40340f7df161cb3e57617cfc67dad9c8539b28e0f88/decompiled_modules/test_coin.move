module 0x4945177dc9ffbf7d53efc40340f7df161cb3e57617cfc67dad9c8539b28e0f88::test_coin {
    struct STEST has drop {
        dummy_field: bool,
    }

    public entry fun test_receive(arg0: &mut 0x2::coin::TreasuryCap<STEST>, arg1: &mut 0x2::tx_context::TxContext) {
    }

    // decompiled from Move bytecode v7
}

