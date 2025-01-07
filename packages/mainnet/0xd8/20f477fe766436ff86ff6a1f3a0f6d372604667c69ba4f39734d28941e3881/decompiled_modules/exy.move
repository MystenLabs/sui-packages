module 0xd820f477fe766436ff86ff6a1f3a0f6d372604667c69ba4f39734d28941e3881::exy {
    struct EXY has drop {
        dummy_field: bool,
    }

    fun init(arg0: EXY, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<EXY>(arg0, 6, b"EXY", b"European Degen Index", x"24455859202d204575726f7065616e20446567656e20496e6465780a0a42656c6965766520696e2057616966750a0a5468657265206973206e6f2063686172742e0a0a5577552e", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/0xa7c8c6f9048b77dd69bcd9892968aef6e4b85268_cbee1b05db.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<EXY>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<EXY>>(v1);
    }

    // decompiled from Move bytecode v6
}

