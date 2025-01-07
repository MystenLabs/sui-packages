module 0x8699c57fdc6ccffe85f656efcb2d080e53fc0f3a9b0f3cd49d2c3ce1d9131dce::shiro {
    struct SHIRO has drop {
        dummy_field: bool,
    }

    fun init(arg0: SHIRO, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SHIRO>(arg0, 6, b"SHIRO", b"Shirocat", b"SHIRO is a funny, cute cat of the blockchain. With its friendliness, SHIRO symbolizes trust, warmth, and friendliness.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/IMG_1110_8c844ca033.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SHIRO>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SHIRO>>(v1);
    }

    // decompiled from Move bytecode v6
}

