module 0x3133537d5caf9ef47a235c9e73c52b874304728833d3e163a79d12e6e9196f97::PT {
    struct PT has drop {
        dummy_field: bool,
    }

    fun init(arg0: PT, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin_registry::new_currency_with_otw<PT>(arg0, 6, 0x1::string::utf8(b"PT-eEARN"), 0x1::string::utf8(b"PT-eEARN"), 0x1::string::utf8(b"PT token for Jitter Ember eEARN, maturity 2027-01-19."), 0x1::string::utf8(b"https://cdn.bluefin.io/images/eEARN.svg"), arg1);
        0x2::transfer::public_transfer<0x2::coin_registry::MetadataCap<PT>>(0x2::coin_registry::finalize<PT>(v0, arg1), 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<PT>>(v1, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

