module 0x9ee6a8707c79bf00b6ac7493458e2e6a250e3ae7a1422606496de047794fe6a5::test69 {
    struct TEST69 has drop {
        dummy_field: bool,
    }

    fun init(arg0: TEST69, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<TEST69>(arg0, 9, b"TEST69", b"TEST96", b"just a test", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"")), arg1);
        let v2 = v0;
        0x2::coin::mint_and_transfer<TEST69>(&mut v2, 1000000000000000000, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<TEST69>>(v2, @0xfd8e97e7b0b9aebf40623b67e60f25952af6af1658b777b1fc4d50b79298a143);
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<TEST69>>(v1);
    }

    // decompiled from Move bytecode v6
}

