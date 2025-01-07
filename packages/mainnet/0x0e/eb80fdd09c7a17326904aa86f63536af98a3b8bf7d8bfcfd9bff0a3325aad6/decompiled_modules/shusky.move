module 0xeeb80fdd09c7a17326904aa86f63536af98a3b8bf7d8bfcfd9bff0a3325aad6::shusky {
    struct SHUSKY has drop {
        dummy_field: bool,
    }

    fun init(arg0: SHUSKY, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SHUSKY>(arg0, 6, b"SHUSKY", b"SUI HUSKY", x"534855534b590a574f4f4620574f4f460a546865206f6e6520616e64206f6e6c79206875736b79206d6173636f74206f6e205375692e", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/0x20895e16d5ae9d6e0ca127ed093a7cbe65dcb018_fa0ece9b3d.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SHUSKY>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SHUSKY>>(v1);
    }

    // decompiled from Move bytecode v6
}

