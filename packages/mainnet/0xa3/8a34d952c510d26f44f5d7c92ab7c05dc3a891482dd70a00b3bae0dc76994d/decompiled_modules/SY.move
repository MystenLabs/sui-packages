module 0xa38a34d952c510d26f44f5d7c92ab7c05dc3a891482dd70a00b3bae0dc76994d::SY {
    struct SY has drop {
        dummy_field: bool,
    }

    fun init(arg0: SY, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin_registry::new_currency_with_otw<SY>(arg0, 6, 0x1::string::utf8(b"SY-eSUI"), 0x1::string::utf8(b"SY-eSUI"), 0x1::string::utf8(b"SY token for Jitter Ember eSUI."), 0x1::string::utf8(b"https://bluefin.io/images/logos/egSUI.svg"), arg1);
        0x2::transfer::public_transfer<0x2::coin_registry::MetadataCap<SY>>(0x2::coin_registry::finalize<SY>(v0, arg1), 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SY>>(v1, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

