module 0x170fea5f94fc0a6a3d425598dbb1414b9016d41201121441d1ee5740fd00ac8a::grape {
    struct GRAPE has drop {
        dummy_field: bool,
    }

    fun init(arg0: GRAPE, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<GRAPE>(arg0, 6, b"GRAPE", b"Grape Cat", b"the sweetest cat on chain!", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/grape_cat_pfp2_53bc0ccc3e.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<GRAPE>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<GRAPE>>(v1);
    }

    // decompiled from Move bytecode v6
}

