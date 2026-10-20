module 0xc6b4f259687618fc8b1d197d372c1e209d5368f598da04216c5ddb74055095bb::init {
    struct INIT has drop {
        dummy_field: bool,
    }

    fun init(arg0: INIT, arg1: &mut 0x2::tx_context::TxContext) {
        assert!(0x2::types::is_one_time_witness<INIT>(&arg0), 13906834238767890431);
        let (v0, v1) = 0xc6b4f259687618fc8b1d197d372c1e209d5368f598da04216c5ddb74055095bb::config::create(arg1);
        let v2 = v1;
        let v3 = v0;
        0x2::transfer::public_transfer<0xc6b4f259687618fc8b1d197d372c1e209d5368f598da04216c5ddb74055095bb::authority::AuthorityCap<0xc6b4f259687618fc8b1d197d372c1e209d5368f598da04216c5ddb74055095bb::authority::PACKAGE, 0xc6b4f259687618fc8b1d197d372c1e209d5368f598da04216c5ddb74055095bb::authority::ADMIN>>(v2, 0x2::tx_context::sender(arg1));
        0xc6b4f259687618fc8b1d197d372c1e209d5368f598da04216c5ddb74055095bb::market::share_registry(0xc6b4f259687618fc8b1d197d372c1e209d5368f598da04216c5ddb74055095bb::market::create_registry(&v3, &v2, arg1));
        0xc6b4f259687618fc8b1d197d372c1e209d5368f598da04216c5ddb74055095bb::timelock::share(0xc6b4f259687618fc8b1d197d372c1e209d5368f598da04216c5ddb74055095bb::timelock::create(arg1));
        0xc6b4f259687618fc8b1d197d372c1e209d5368f598da04216c5ddb74055095bb::config::share(v3);
    }

    // decompiled from Move bytecode v7
}

