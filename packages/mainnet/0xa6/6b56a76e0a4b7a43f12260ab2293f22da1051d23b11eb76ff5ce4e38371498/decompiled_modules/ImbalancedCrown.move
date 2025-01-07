module 0xa66b56a76e0a4b7a43f12260ab2293f22da1051d23b11eb76ff5ce4e38371498::ImbalancedCrown {
    struct IMBALANCEDCROWN has drop {
        dummy_field: bool,
    }

    fun init(arg0: IMBALANCEDCROWN, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<IMBALANCEDCROWN>(arg0, 0, b"COS", b"Imbalanced Crown", b"Revelry knows no sickness...", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://aurahma-canvas-test-bucket.s3.eu-west-3.amazonaws.com/cosmetic/Head_Imbalanced_Crown.png")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<IMBALANCEDCROWN>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<IMBALANCEDCROWN>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

