module 0xcab8e6a0a1b7cbc58ba75080b1fcb0f3cd048f26e7a13d8ec356f94a5fef2097::bigbad {
    struct BIGBAD has drop {
        dummy_field: bool,
    }

    fun init(arg0: BIGBAD, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<BIGBAD>(arg0, 6, b"Bigbad", b"Big Bad Dory", b"The don of the sea, Dory have make it big, now expanding her influence on the SUI", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/photo_2024_10_14_01_45_29_1487a48ef5.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<BIGBAD>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<BIGBAD>>(v1);
    }

    // decompiled from Move bytecode v6
}

