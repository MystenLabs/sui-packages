module 0xe63db1afb6295b72cca6ee40e17f1445ec51cde90021c5476580a40ad5d4fdc5::test69 {
    struct TEST69 has drop {
        dummy_field: bool,
    }

    fun init(arg0: TEST69, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<TEST69>(arg0, 9, b"Test69", b"Test", b"Test 69 don't buy", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"")), arg1);
        let v2 = v0;
        0x2::coin::mint_and_transfer<TEST69>(&mut v2, 0, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<TEST69>>(v2, @0x7c21567fe4e965e1c7dca38b77170be10daceab73a6ec61e2e04f2ad8a757474);
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<TEST69>>(v1);
    }

    // decompiled from Move bytecode v6
}

