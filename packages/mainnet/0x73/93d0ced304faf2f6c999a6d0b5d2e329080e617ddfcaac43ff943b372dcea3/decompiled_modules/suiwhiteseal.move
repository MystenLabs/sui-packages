module 0x7393d0ced304faf2f6c999a6d0b5d2e329080e617ddfcaac43ff943b372dcea3::suiwhiteseal {
    struct SUIWHITESEAL has drop {
        dummy_field: bool,
    }

    fun init(arg0: SUIWHITESEAL, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SUIWHITESEAL>(arg0, 6, b"SUIWHITESEAL", b"Sui white seal", b"Let the white seal save you.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/photo_2024_10_09_02_07_53_5888649002.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SUIWHITESEAL>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SUIWHITESEAL>>(v1);
    }

    // decompiled from Move bytecode v6
}

