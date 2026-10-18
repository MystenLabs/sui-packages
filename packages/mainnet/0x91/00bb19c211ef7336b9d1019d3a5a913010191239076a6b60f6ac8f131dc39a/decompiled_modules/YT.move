module 0x9100bb19c211ef7336b9d1019d3a5a913010191239076a6b60f6ac8f131dc39a::YT {
    struct YT has drop {
        dummy_field: bool,
    }

    fun init(arg0: YT, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin_registry::new_currency_with_otw<YT>(arg0, 6, 0x1::string::utf8(b"YT-sSUI"), 0x1::string::utf8(b"YT-sSUI"), 0x1::string::utf8(b"YT token for Jitter Scallop sSUI, maturity 2027-01-17."), 0x1::string::utf8(b"https://admin.jitter.fi/ssui.png"), arg1);
        0x2::transfer::public_transfer<0x2::coin_registry::MetadataCap<YT>>(0x2::coin_registry::finalize<YT>(v0, arg1), 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<YT>>(v1, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

