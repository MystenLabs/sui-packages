module 0xa3c8361a27cc095af8d32ab3ec4bad03467c0c73bda204d4de714b6c907ee36c::suilion {
    struct SUILION has drop {
        dummy_field: bool,
    }

    fun init(arg0: SUILION, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SUILION>(arg0, 6, b"SUILION", b"SUI LION", x"0a41667465722066616c6c696e6720696e746f20746865205355492c2074686520666f726d6572206b696e67206f6620746865206a756e676c65205355494c494f4e2c2065766f6c76656420616e642061637175697265642061207461696c20746f20616461707420746f20686973206e657720737572726f756e64696e67732e", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/photo_2024_10_03_21_02_08_5739c73529.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SUILION>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SUILION>>(v1);
    }

    // decompiled from Move bytecode v6
}

