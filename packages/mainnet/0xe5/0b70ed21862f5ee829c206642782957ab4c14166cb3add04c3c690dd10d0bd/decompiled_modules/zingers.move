module 0xe50b70ed21862f5ee829c206642782957ab4c14166cb3add04c3c690dd10d0bd::zingers {
    struct ZINGERS has drop {
        dummy_field: bool,
    }

    fun init(arg0: ZINGERS, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<ZINGERS>(arg0, 6, b"ZINGERS", b"ZINGER", b"ZINGERS MEMES ", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/photo_2024_10_09_11_40_41_13a93d41b1.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<ZINGERS>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<ZINGERS>>(v1);
    }

    // decompiled from Move bytecode v6
}

