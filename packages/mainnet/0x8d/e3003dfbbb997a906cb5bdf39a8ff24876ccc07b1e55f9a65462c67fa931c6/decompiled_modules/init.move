module 0x8de3003dfbbb997a906cb5bdf39a8ff24876ccc07b1e55f9a65462c67fa931c6::init {
    struct INIT has drop {
        dummy_field: bool,
    }

    struct EventInit has copy, drop {
        dummy_field: bool,
    }

    fun init(arg0: INIT, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = EventInit{dummy_field: false};
        0x2::event::emit<EventInit>(v0);
    }

    // decompiled from Move bytecode v6
}

