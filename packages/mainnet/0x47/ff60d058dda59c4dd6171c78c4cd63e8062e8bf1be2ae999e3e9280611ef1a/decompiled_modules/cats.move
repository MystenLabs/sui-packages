module 0x47ff60d058dda59c4dd6171c78c4cd63e8062e8bf1be2ae999e3e9280611ef1a::cats {
    struct CATS has drop {
        dummy_field: bool,
    }

    fun init(arg0: CATS, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<CATS>(arg0, 6, b"CATS", b"mutant cats", b"Meet Mutant Cats an infectious disease has spread over the world causing cats to mutate.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/mutant_frame_at_0m1s_b24b744233.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<CATS>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<CATS>>(v1);
    }

    // decompiled from Move bytecode v6
}

