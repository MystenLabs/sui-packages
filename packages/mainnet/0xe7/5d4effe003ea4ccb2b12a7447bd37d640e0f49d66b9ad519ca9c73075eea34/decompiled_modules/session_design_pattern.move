module 0xe75d4effe003ea4ccb2b12a7447bd37d640e0f49d66b9ad519ca9c73075eea34::session_design_pattern {
    struct SharedObject has store, key {
        id: 0x2::object::UID,
    }

    struct SessionCap {
        shared_object: SharedObject,
    }

    public fun begin_session_tx(arg0: SharedObject) : SessionCap {
        SessionCap{shared_object: arg0}
    }

    public fun end_session_tx(arg0: SessionCap) {
        let SessionCap { shared_object: v0 } = arg0;
        0x2::transfer::share_object<SharedObject>(v0);
    }

    fun init(arg0: &mut 0x2::tx_context::TxContext) {
        let v0 = SharedObject{id: 0x2::object::new(arg0)};
        0x2::transfer::share_object<SharedObject>(v0);
    }

    // decompiled from Move bytecode v6
}

