module 0xa8ff4dcb2a0c9bc037f946af5ced8acd0d205b41160acce9da53bdd977377241::CONTROLLER {
    struct CONTROLLER has drop {
        dummy_field: bool,
    }

    public entry fun mint(arg0: &mut 0x2::coin::TreasuryCap<CONTROLLER>, arg1: address, arg2: u64, arg3: &mut 0x2::tx_context::TxContext) {
        0x2::transfer::public_transfer<0x2::coin::Coin<CONTROLLER>>(0x2::coin::mint<CONTROLLER>(arg0, arg2 * 1000000000, arg3), arg1);
    }

    public entry fun addToDonorList(arg0: &mut 0x2::deny_list::DenyList, arg1: &mut 0x2::coin::DenyCapV2<CONTROLLER>, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        0x2::coin::deny_list_v2_add<CONTROLLER>(arg0, arg1, arg2, arg3);
    }

    public entry fun removeFromDonorList(arg0: &mut 0x2::deny_list::DenyList, arg1: &mut 0x2::coin::DenyCapV2<CONTROLLER>, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        0x2::coin::deny_list_v2_remove<CONTROLLER>(arg0, arg1, arg2, arg3);
    }

    // decompiled from Move bytecode v6
}

