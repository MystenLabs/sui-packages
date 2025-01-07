module 0xf10457ad793ce26a43cba73483d566fa5f5c317e537f568631d6996ac1d2dfbf::miawwwwwwwwwwwwwwww_sui {
    struct MIAWWWWWWWWWWWWWWWW_SUI has drop {
        dummy_field: bool,
    }

    fun init(arg0: MIAWWWWWWWWWWWWWWWW_SUI, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<MIAWWWWWWWWWWWWWWWW_SUI>(arg0, 9, b"MIAWWWWWWWWWWWWWWWW SUI", b"CAT ON APE WORLD", b"https://t.me/catonapeworld http://catonapeworld.xyz/ https://x.com/catonapeworld", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"")), arg1);
        let v2 = v0;
        0x2::coin::mint_and_transfer<MIAWWWWWWWWWWWWWWWW_SUI>(&mut v2, 2859654444000000000, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<MIAWWWWWWWWWWWWWWWW_SUI>>(v2, @0x0);
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<MIAWWWWWWWWWWWWWWWW_SUI>>(v1);
    }

    // decompiled from Move bytecode v6
}

