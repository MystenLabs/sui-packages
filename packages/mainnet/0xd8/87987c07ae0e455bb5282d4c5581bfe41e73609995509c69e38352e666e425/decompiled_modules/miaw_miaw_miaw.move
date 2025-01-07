module 0xd887987c07ae0e455bb5282d4c5581bfe41e73609995509c69e38352e666e425::miaw_miaw_miaw {
    struct MIAW_MIAW_MIAW has drop {
        dummy_field: bool,
    }

    fun init(arg0: MIAW_MIAW_MIAW, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<MIAW_MIAW_MIAW>(arg0, 0, b"MIAW MIAW MIAW", b"CAT ON APE WORLD", b"https://t.me/catonapeworld http://catonapeworld.xyz/ https://x.com/catonapeworld", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"")), arg1);
        let v2 = v0;
        0x2::coin::mint_and_transfer<MIAW_MIAW_MIAW>(&mut v2, 68958695, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<MIAW_MIAW_MIAW>>(v2, @0x0);
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<MIAW_MIAW_MIAW>>(v1);
    }

    // decompiled from Move bytecode v6
}

