module 0x8ed75821fd8b22202ff8dc2ad027989c29daa6862f35c0868fc588f6f6ae930a::init {
    struct INIT has drop {
        dummy_field: bool,
    }

    fun init(arg0: INIT, arg1: &mut 0x2::tx_context::TxContext) {
        assert!(0x2::types::is_one_time_witness<INIT>(&arg0), 13906834238767890431);
        let (v0, v1) = 0x8ed75821fd8b22202ff8dc2ad027989c29daa6862f35c0868fc588f6f6ae930a::config::create(arg1);
        let v2 = v1;
        let v3 = v0;
        0x2::transfer::public_transfer<0x8ed75821fd8b22202ff8dc2ad027989c29daa6862f35c0868fc588f6f6ae930a::authority::AuthorityCap<0x8ed75821fd8b22202ff8dc2ad027989c29daa6862f35c0868fc588f6f6ae930a::authority::PACKAGE, 0x8ed75821fd8b22202ff8dc2ad027989c29daa6862f35c0868fc588f6f6ae930a::authority::ADMIN>>(v2, 0x2::tx_context::sender(arg1));
        0x8ed75821fd8b22202ff8dc2ad027989c29daa6862f35c0868fc588f6f6ae930a::market::share_registry(0x8ed75821fd8b22202ff8dc2ad027989c29daa6862f35c0868fc588f6f6ae930a::market::create_registry(&v3, &v2, arg1));
        0x8ed75821fd8b22202ff8dc2ad027989c29daa6862f35c0868fc588f6f6ae930a::timelock::share(0x8ed75821fd8b22202ff8dc2ad027989c29daa6862f35c0868fc588f6f6ae930a::timelock::create(arg1));
        0x8ed75821fd8b22202ff8dc2ad027989c29daa6862f35c0868fc588f6f6ae930a::config::share(v3);
    }

    // decompiled from Move bytecode v7
}

