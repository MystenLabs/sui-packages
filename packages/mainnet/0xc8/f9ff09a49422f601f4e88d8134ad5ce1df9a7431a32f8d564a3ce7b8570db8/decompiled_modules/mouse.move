module 0xc8f9ff09a49422f601f4e88d8134ad5ce1df9a7431a32f8d564a3ce7b8570db8::mouse {
    struct MOUSE has drop {
        dummy_field: bool,
    }

    fun init(arg0: MOUSE, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<MOUSE>(arg0, 6, b"MOUSE", b"Mouse", x"4d4f55534520313333370a50756d70206f7220656174206974", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/173e37dd_cdca_40c6_b72c_b9ea8df4e2a6_ecb0596331.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<MOUSE>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<MOUSE>>(v1);
    }

    // decompiled from Move bytecode v6
}

