module 0x3236de80fab6042a0b3a1b89d8c4d12733652727a1d451a5d0470ed17416ca8e::init_tides {
    struct INIT_TIDES has drop {
        dummy_field: bool,
    }

    struct EventInit has copy, drop {
        dummy_field: bool,
    }

    fun init(arg0: INIT_TIDES, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = EventInit{dummy_field: false};
        0x2::event::emit<EventInit>(v0);
    }

    // decompiled from Move bytecode v6
}

