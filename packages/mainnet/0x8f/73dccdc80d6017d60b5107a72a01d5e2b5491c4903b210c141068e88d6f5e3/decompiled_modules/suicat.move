module 0x8f73dccdc80d6017d60b5107a72a01d5e2b5491c4903b210c141068e88d6f5e3::suicat {
    struct SUICAT has drop {
        dummy_field: bool,
    }

    fun init(arg0: SUICAT, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SUICAT>(arg0, 6, b"SUICAT", b"Sui Cat", x"546865206f6e6520616e64206f6e6c79206f6666696369616c20636174206f662074686520537569206e6574776f726b2e2046697273742c206f726967696e616c2c20616e642066756c6c206f662061747469747564652e0a0a", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/PP_3d0308dd03.jpeg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SUICAT>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SUICAT>>(v1);
    }

    // decompiled from Move bytecode v6
}

