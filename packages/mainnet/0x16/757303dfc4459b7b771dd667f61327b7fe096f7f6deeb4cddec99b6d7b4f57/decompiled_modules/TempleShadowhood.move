module 0x16757303dfc4459b7b771dd667f61327b7fe096f7f6deeb4cddec99b6d7b4f57::TempleShadowhood {
    struct TEMPLESHADOWHOOD has drop {
        dummy_field: bool,
    }

    fun init(arg0: TEMPLESHADOWHOOD, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<TEMPLESHADOWHOOD>(arg0, 0, b"COS", b"Temple Shadowhood", b"Set forth into the void.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://aurahma-canvas-test-bucket.s3.eu-west-3.amazonaws.com/cosmetic/Head_Temple_Shadowhood.png")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<TEMPLESHADOWHOOD>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<TEMPLESHADOWHOOD>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

