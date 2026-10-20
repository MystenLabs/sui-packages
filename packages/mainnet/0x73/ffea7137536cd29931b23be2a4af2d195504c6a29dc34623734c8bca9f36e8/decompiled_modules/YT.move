module 0x73ffea7137536cd29931b23be2a4af2d195504c6a29dc34623734c8bca9f36e8::YT {
    struct YT has drop {
        dummy_field: bool,
    }

    fun init(arg0: YT, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin_registry::new_currency_with_otw<YT>(arg0, 6, 0x1::string::utf8(b"YT-sUSDC"), 0x1::string::utf8(b"YT-sUSDC"), 0x1::string::utf8(b"YT token for Jitter Scallop sUSDC, maturity 2027-01-19."), 0x1::string::utf8(b"https://admin.jitter.fi/susdc.png"), arg1);
        0x2::transfer::public_transfer<0x2::coin_registry::MetadataCap<YT>>(0x2::coin_registry::finalize<YT>(v0, arg1), 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<YT>>(v1, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

