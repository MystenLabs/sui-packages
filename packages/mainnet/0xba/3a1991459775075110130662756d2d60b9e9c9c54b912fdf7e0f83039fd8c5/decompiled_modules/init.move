module 0x906b2a117c2178d9269db60d782bec6c9199c2ba73d209bb63307d77083011f8::init {
    struct INIT has drop {
        dummy_field: bool,
    }

    fun init(arg0: INIT, arg1: &mut 0x2::tx_context::TxContext) {
        assert!(0x2::types::is_one_time_witness<INIT>(&arg0), 13906834238767890431);
        let (v0, v1) = 0x906b2a117c2178d9269db60d782bec6c9199c2ba73d209bb63307d77083011f8::config::create(arg1);
        let v2 = v1;
        let v3 = v0;
        0x2::transfer::public_transfer<0x906b2a117c2178d9269db60d782bec6c9199c2ba73d209bb63307d77083011f8::authority::AuthorityCap<0x906b2a117c2178d9269db60d782bec6c9199c2ba73d209bb63307d77083011f8::authority::PACKAGE, 0x906b2a117c2178d9269db60d782bec6c9199c2ba73d209bb63307d77083011f8::authority::ADMIN>>(v2, 0x2::tx_context::sender(arg1));
        0x906b2a117c2178d9269db60d782bec6c9199c2ba73d209bb63307d77083011f8::market::share_registry(0x906b2a117c2178d9269db60d782bec6c9199c2ba73d209bb63307d77083011f8::market::create_registry(&v3, &v2, arg1));
        0x906b2a117c2178d9269db60d782bec6c9199c2ba73d209bb63307d77083011f8::timelock::share(0x906b2a117c2178d9269db60d782bec6c9199c2ba73d209bb63307d77083011f8::timelock::create(arg1));
        0x906b2a117c2178d9269db60d782bec6c9199c2ba73d209bb63307d77083011f8::config::share(v3);
    }

    // decompiled from Move bytecode v7
}

