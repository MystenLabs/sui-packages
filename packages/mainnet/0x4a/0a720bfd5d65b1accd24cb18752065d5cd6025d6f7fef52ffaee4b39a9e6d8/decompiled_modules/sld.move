module 0x4a0a720bfd5d65b1accd24cb18752065d5cd6025d6f7fef52ffaee4b39a9e6d8::sld {
    struct SLD has drop {
        dummy_field: bool,
    }

    fun init(arg0: SLD, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SLD>(arg0, 8, b"SLD", b"SuilendProtocol https://twitter.com/solendprotocol", b"Suilend Protocol", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://pbs.twimg.com/profile_images/1555200170803232768/eUQsCJv1_400x400.png")), arg1);
        let v2 = v0;
        0x2::coin::mint_and_transfer<SLD>(&mut v2, 1000000000000000, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SLD>>(v2, @0x0);
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SLD>>(v1);
    }

    // decompiled from Move bytecode v6
}

