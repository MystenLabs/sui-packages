module 0xac4454fe9b834d05ad24b59f382735eb18145c387ce93ee9b5cc4e6e31582bb9::cyro {
    struct CYRO has drop {
        dummy_field: bool,
    }

    fun init(arg0: CYRO, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<CYRO>(arg0, 6, b"CYRO", b"SUI CYRO", x"e2809c576520646f6ee2809974206b6e6f77206966207765e280996c6c2077696e2c20627574207765e280996c6c20646f206f757220626573742ee2809d0a0ae2809c556e6365727461696e206f7574636f6d652c206365727461696e206566666f72742ee2809d2020e2809c4e6f2070726f6d697365732c206f6e6c79206f757220626573742ee2809d", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://r.turbos.finance/icon/1786209093516.jpeg")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<CYRO>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<CYRO>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

