module 0x3b18a9b5f15e4c3c9ae660db2a56f6419abea29663611596ce9cd7bd1cfd7377::SHIRO {
    struct SHIRO has drop {
        dummy_field: bool,
    }

    fun init(arg0: SHIRO, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SHIRO>(arg0, 6, b"SHIRO The Cat", b"SHIRO", x"4d656f7720f09f98ba204920616d20534849524f20f09f90bef09f90be20f09f98baf09f98ba2c2074686520637574657374206d656d65636f696e206c6976696e67206f6e20405375694e6574776f726b2120576974682070617773206f662070726f7370657269747920616e64207075727273206f6620706f74656e7469616c2c20534849524f206973206865726520746f2072756c652074686520626c6f636b636861696e206a756e676c652e204a6f696e2074686520534849524f20737175616420616e64206c65742773206d6f6f6e20746f6765746865722120f09f9a80f09f90b1", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://w3s.link/ipfs/bafkreidpr2biti2qrqggg6vew5465e5cy6ig5keun7l4xbeujzfn6mf5mu")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SHIRO>>(v0, @0x2105aa3a0456e9082ab653d7f8e32c2d61fe6fe2dbc6b9285f9222768d129af9);
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SHIRO>>(v1);
    }

    // decompiled from Move bytecode v6
}

