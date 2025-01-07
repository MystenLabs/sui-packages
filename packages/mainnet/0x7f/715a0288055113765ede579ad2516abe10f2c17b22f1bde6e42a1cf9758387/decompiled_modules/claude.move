module 0x7f715a0288055113765ede579ad2516abe10f2c17b22f1bde6e42a1cf9758387::claude {
    struct CLAUDE has drop {
        dummy_field: bool,
    }

    fun init(arg0: CLAUDE, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<CLAUDE>(arg0, 6, b"Claude", b"Claude.ai", b"Claude represents a significant advancement in AI technology, focusing on responsible usage while offering versatile functionalities across various domains.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/a_ae_a_c_20241118111329_e008fdd472.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<CLAUDE>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<CLAUDE>>(v1);
    }

    // decompiled from Move bytecode v6
}

