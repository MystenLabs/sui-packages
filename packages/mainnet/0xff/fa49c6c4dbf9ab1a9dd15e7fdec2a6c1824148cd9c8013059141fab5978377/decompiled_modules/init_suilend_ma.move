module 0xfffa49c6c4dbf9ab1a9dd15e7fdec2a6c1824148cd9c8013059141fab5978377::init_suilend_ma {
    struct INIT_SUILEND_MA has drop {
        dummy_field: bool,
    }

    struct EventInit has copy, drop {
        dummy_field: bool,
    }

    fun init(arg0: INIT_SUILEND_MA, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = EventInit{dummy_field: false};
        0x2::event::emit<EventInit>(v0);
    }

    // decompiled from Move bytecode v6
}

