module 0xb24e476ecd571ad9316c1941f384c9a10bb0a3ff385ddda42415d47757ab3981::controller {
    public entry fun pause(arg0: &mut 0xb24e476ecd571ad9316c1941f384c9a10bb0a3ff385ddda42415d47757ab3981::factory::Global, arg1: &mut 0x2::tx_context::TxContext) {
        assert!(!0xb24e476ecd571ad9316c1941f384c9a10bb0a3ff385ddda42415d47757ab3981::factory::is_emergency(arg0), 202);
        assert!(0xb24e476ecd571ad9316c1941f384c9a10bb0a3ff385ddda42415d47757ab3981::factory::controller(arg0) == 0x2::tx_context::sender(arg1), 201);
        0xb24e476ecd571ad9316c1941f384c9a10bb0a3ff385ddda42415d47757ab3981::factory::pause(arg0);
    }

    public entry fun resume(arg0: &mut 0xb24e476ecd571ad9316c1941f384c9a10bb0a3ff385ddda42415d47757ab3981::factory::Global, arg1: &mut 0x2::tx_context::TxContext) {
        assert!(0xb24e476ecd571ad9316c1941f384c9a10bb0a3ff385ddda42415d47757ab3981::factory::is_emergency(arg0), 203);
        assert!(0xb24e476ecd571ad9316c1941f384c9a10bb0a3ff385ddda42415d47757ab3981::factory::controller(arg0) == 0x2::tx_context::sender(arg1), 201);
        0xb24e476ecd571ad9316c1941f384c9a10bb0a3ff385ddda42415d47757ab3981::factory::resume(arg0);
    }

    // decompiled from Move bytecode v6
}

