module 0xfddbdf51dab3b8778fe25355a1fe44c078c6cc15fe0987d89b0380b85c930f53::svdia {
    struct SVDIA has drop {
        dummy_field: bool,
    }

    fun init(arg0: SVDIA, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SVDIA>(arg0, 9, b"SVDIA", b"SuVidia", b"SuVidia, inspired by Nvidia, is a next-gen token on the Sui blockchain. Offering fast, scalable, and secure transactions, it's optimized for DeFi, NFTs, and governance, driving blockchain innovation with low fees and eco-friendly tech.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://pbs.twimg.com/profile_images/1617464797716533249/CaPOXWh1.jpg")), arg1);
        let v2 = v0;
        0x2::coin::mint_and_transfer<SVDIA>(&mut v2, 200000000000000000, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SVDIA>>(v2, @0x0);
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SVDIA>>(v1);
    }

    // decompiled from Move bytecode v6
}

