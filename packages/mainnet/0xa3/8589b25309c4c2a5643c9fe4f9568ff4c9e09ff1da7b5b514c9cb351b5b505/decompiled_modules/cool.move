module 0xa38589b25309c4c2a5643c9fe4f9568ff4c9e09ff1da7b5b514c9cb351b5b505::cool {
    struct COOL has drop {
        dummy_field: bool,
    }

    fun init(arg0: COOL, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<COOL>(arg0, 9, b"COOL", b"COOL AND COOLEST", b"Life Changing Money", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://img.freepik.com/premium-photo/bold-colorful-3d-cool-text-art-with-splatter-effects_1058532-29371.jpg")), arg1);
        let v2 = v0;
        0x2::coin::mint_and_transfer<COOL>(&mut v2, 1000000000000000, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<COOL>>(v2, @0x0);
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<COOL>>(v1);
    }

    // decompiled from Move bytecode v6
}

