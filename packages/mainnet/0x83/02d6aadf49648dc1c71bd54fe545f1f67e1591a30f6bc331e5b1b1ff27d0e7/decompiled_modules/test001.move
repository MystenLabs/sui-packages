module 0x8302d6aadf49648dc1c71bd54fe545f1f67e1591a30f6bc331e5b1b1ff27d0e7::test001 {
    struct TEST001 has drop {
        dummy_field: bool,
    }

    fun init(arg0: TEST001, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = b"https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcRhTJQSu_qm6C2fF0M88Tq-_LKEsNybDfeuzg&s";
        let v1 = if (0x1::vector::length<u8>(&v0) == 0) {
            0x1::option::none<0x2::url::Url>()
        } else {
            0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(v0))
        };
        let (v2, v3) = 0x2::coin::create_currency<TEST001>(arg0, 9, b"TEST001", b"Test Token", b"A test token created via the token factory", v1, arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<TEST001>>(v3);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<TEST001>>(v2, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

