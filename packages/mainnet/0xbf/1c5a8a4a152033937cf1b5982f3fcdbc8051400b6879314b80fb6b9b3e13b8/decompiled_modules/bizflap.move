module 0xbf1c5a8a4a152033937cf1b5982f3fcdbc8051400b6879314b80fb6b9b3e13b8::bizflap {
    struct BIZFLAP has drop {
        dummy_field: bool,
    }

    fun init(arg0: BIZFLAP, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<BIZFLAP>(arg0, 9, b"BIZF", b"Bizflap", x"5768656e20796f7520666c61702c207468652062697a2068617070656e73e280946f72206e6f742e", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://ipfs.io/ipfs/bafybeiekzu5zf557rxaqdigmfomfvvm2y6bspxwgacpmczbxrerqva52va")), arg1);
        let v2 = v0;
        0x2::coin::mint_and_transfer<BIZFLAP>(&mut v2, 1000000000000000000, @0xfb20acd7e2a2647568cb859bbe174ade70f49a7e9c762c3ff635ff4a0915dad9, arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<BIZFLAP>>(v2, @0x0);
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<BIZFLAP>>(v1);
    }

    // decompiled from Move bytecode v6
}

