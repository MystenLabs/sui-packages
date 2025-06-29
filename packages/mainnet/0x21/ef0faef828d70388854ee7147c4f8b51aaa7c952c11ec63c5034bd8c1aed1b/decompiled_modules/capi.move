module 0x21ef0faef828d70388854ee7147c4f8b51aaa7c952c11ec63c5034bd8c1aed1b::capi {
    struct CAPI has drop {
        dummy_field: bool,
    }

    fun init(arg0: CAPI, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<CAPI>(arg0, 6, b"CAPI", b"CapiSUI", b"CapiSUI (CAPI) is a meme token on the Sui blockchain, designed to capture the fun and community spirit of Web3 in 2025.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://r.turbos.finance/icon/1751224465781.png")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<CAPI>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<CAPI>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

