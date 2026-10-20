module 0xe1d1397e497ec102d6ea932fcc7e20b52acb80d74068b23d96ba9c2f72121d6::YT {
    struct YT has drop {
        dummy_field: bool,
    }

    fun init(arg0: YT, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin_registry::new_currency_with_otw<YT>(arg0, 6, 0x1::string::utf8(b"YT-eSUI"), 0x1::string::utf8(b"YT-eSUI"), 0x1::string::utf8(b"YT token for Jitter Ember eSUI, maturity 2027-01-19."), 0x1::string::utf8(b"https://bluefin.io/images/logos/egSUI.svg"), arg1);
        0x2::transfer::public_transfer<0x2::coin_registry::MetadataCap<YT>>(0x2::coin_registry::finalize<YT>(v0, arg1), 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<YT>>(v1, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

