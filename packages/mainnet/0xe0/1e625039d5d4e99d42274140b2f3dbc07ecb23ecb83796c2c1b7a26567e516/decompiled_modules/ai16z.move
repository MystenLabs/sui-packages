module 0xe01e625039d5d4e99d42274140b2f3dbc07ecb23ecb83796c2c1b7a26567e516::ai16z {
    struct AI16Z has drop {
        dummy_field: bool,
    }

    fun init(arg0: AI16Z, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<AI16Z>(arg0, 6, b"AI16Z", b"Ai16zAgent", b"AI token from A16Z community", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://cdn.hydropump.xyz/logo/01JCMEME6ZQMG6X4ZJ17Z1XZJH/01JCMEMEJ5N3P04HN7JATM3RTZ")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<AI16Z>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<AI16Z>>(v1, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

