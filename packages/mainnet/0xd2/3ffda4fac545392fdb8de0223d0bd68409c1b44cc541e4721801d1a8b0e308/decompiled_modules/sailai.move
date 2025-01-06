module 0xd23ffda4fac545392fdb8de0223d0bd68409c1b44cc541e4721801d1a8b0e308::sailai {
    struct SAILAI has drop {
        dummy_field: bool,
    }

    fun init(arg0: SAILAI, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SAILAI>(arg0, 9, b"SAILAI", b"SAILAI", b"SailAI is a revolutionary token that embodies the spirit of exploration and innovation in the era of artificial intelligence. Built on the Sui blockchain, SailAI represents the seamless integration of cutting-edge AI technology and decentralized blockchain infrastructure, driving progress toward a smarter, more connected future", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://pbs.twimg.com/profile_images/1876256223059963904/6kMRK_uE_400x400.jpg")), arg1);
        let v2 = v0;
        0x2::coin::mint_and_transfer<SAILAI>(&mut v2, 2100000000000000000, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<SAILAI>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SAILAI>>(v2, @0x0);
    }

    // decompiled from Move bytecode v6
}

