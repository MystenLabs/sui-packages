module 0x19cb8467d99558fc5d5cdc4822f9bc2a0780ed82c4ccdeea33040dd4d368dcc3::rekt {
    struct REKT has drop {
        dummy_field: bool,
    }

    fun init(arg0: REKT, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<REKT>(arg0, 6, b"REKT", b"SUIREKT", b"take 1$ profit mferr", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/photo_2024_10_12_00_07_29_1ee878891e.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<REKT>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<REKT>>(v1);
    }

    // decompiled from Move bytecode v6
}

