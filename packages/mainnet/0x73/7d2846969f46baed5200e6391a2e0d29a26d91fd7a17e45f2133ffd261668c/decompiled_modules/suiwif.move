module 0x737d2846969f46baed5200e6391a2e0d29a26d91fd7a17e45f2133ffd261668c::suiwif {
    struct SUIWIF has drop {
        dummy_field: bool,
    }

    fun init(arg0: SUIWIF, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SUIWIF>(arg0, 9, b"SUIWIF", b"Suiwifhat", b"Suiwif is a fast and scalable token on the Sui blockchain, designed for efficient and secure transactions in decentralized ecosystems. It focuses on seamless integration and performance in DeFi and digital asset marketplaces.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://pbs.twimg.com/profile_images/1841903901987241984/fiFE0MW3.jpg")), arg1);
        let v2 = v0;
        0x2::coin::mint_and_transfer<SUIWIF>(&mut v2, 1300000000000000000, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SUIWIF>>(v2, @0x0);
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SUIWIF>>(v1);
    }

    // decompiled from Move bytecode v6
}

