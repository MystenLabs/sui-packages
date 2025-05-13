module 0x5647c058ada4d7d5e019e4a63625a59f1a69611684bb1d3939ab3d62e42bafc1::HOODCAT {
    struct HOODCAT has drop {
        dummy_field: bool,
    }

    fun init(arg0: HOODCAT, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<HOODCAT>(arg0, 6, b"HOODCAT", b"Cat in a Hoodie", x"546869732061696e2774206a75737420612063617420696e206120686f6f6469652c20697427732024484f4f444341542061626f757420746f206d6f6f6e2120f09f9a80f09f8c95", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://uptos-pump.myfilebase.com/ipfs/QmYtZ461NL8daJSVDNARiDisjGsMPtszRrCUL6RiwqDDEs")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<HOODCAT>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<HOODCAT>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

