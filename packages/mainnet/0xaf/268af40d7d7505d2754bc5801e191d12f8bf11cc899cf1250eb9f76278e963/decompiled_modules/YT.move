module 0xaf268af40d7d7505d2754bc5801e191d12f8bf11cc899cf1250eb9f76278e963::YT {
    struct YT has drop {
        dummy_field: bool,
    }

    fun init(arg0: YT, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin_registry::new_currency_with_otw<YT>(arg0, 6, 0x1::string::utf8(b"YT-haSUI"), 0x1::string::utf8(b"YT-haSUI"), 0x1::string::utf8(b"YT token for Jitter Haedal haSUI, maturity 2027-01-18."), 0x1::string::utf8(b"https://assets.haedal.xyz/logos/hasui.svg"), arg1);
        0x2::transfer::public_transfer<0x2::coin_registry::MetadataCap<YT>>(0x2::coin_registry::finalize<YT>(v0, arg1), 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<YT>>(v1, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

