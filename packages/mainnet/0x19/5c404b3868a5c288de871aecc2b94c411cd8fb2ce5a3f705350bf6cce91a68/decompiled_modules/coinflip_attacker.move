module 0x195c404b3868a5c288de871aecc2b94c411cd8fb2ce5a3f705350bf6cce91a68::coinflip_attacker {
    public entry fun attack(arg0: &mut 0x195c404b3868a5c288de871aecc2b94c411cd8fb2ce5a3f705350bf6cce91a68::flash_pool::FlashPool, arg1: 0x2::coin::Coin<0x2::sui::SUI>, arg2: &mut 0x2::tx_context::TxContext) {
        abort 1
    }

    // decompiled from Move bytecode v6
}

