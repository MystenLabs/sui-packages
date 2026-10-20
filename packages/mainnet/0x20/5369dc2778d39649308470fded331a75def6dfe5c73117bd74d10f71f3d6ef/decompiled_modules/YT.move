module 0x205369dc2778d39649308470fded331a75def6dfe5c73117bd74d10f71f3d6ef::YT {
    struct YT has drop {
        dummy_field: bool,
    }

    fun init(arg0: YT, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin_registry::new_currency_with_otw<YT>(arg0, 6, 0x1::string::utf8(b"YT-eEARN"), 0x1::string::utf8(b"YT-eEARN"), 0x1::string::utf8(b"YT token for Jitter Ember eEARN, maturity 2027-01-19."), 0x1::string::utf8(b"https://cdn.bluefin.io/images/eEARN.svg"), arg1);
        0x2::transfer::public_transfer<0x2::coin_registry::MetadataCap<YT>>(0x2::coin_registry::finalize<YT>(v0, arg1), 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<YT>>(v1, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

