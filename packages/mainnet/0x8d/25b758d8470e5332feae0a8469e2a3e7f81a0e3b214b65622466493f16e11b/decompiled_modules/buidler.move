module 0x8d25b758d8470e5332feae0a8469e2a3e7f81a0e3b214b65622466493f16e11b::buidler {
    struct BUIDLER has drop {
        dummy_field: bool,
    }

    fun init(arg0: BUIDLER, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<BUIDLER>(arg0, 6, b"BUIDLER", b"buidler Cult", b"https://x.com/search?q=buidler%20szn&src=typed_query", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/photo_2025_10_29_12_38_53_98c4e02b22.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<BUIDLER>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<BUIDLER>>(v1);
    }

    // decompiled from Move bytecode v6
}

