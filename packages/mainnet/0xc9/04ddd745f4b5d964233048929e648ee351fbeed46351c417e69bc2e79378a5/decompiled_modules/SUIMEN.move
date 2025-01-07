module 0xc904ddd745f4b5d964233048929e648ee351fbeed46351c417e69bc2e79378a5::SUIMEN {
    struct SUIMEN has drop {
        dummy_field: bool,
    }

    fun init(arg0: SUIMEN, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SUIMEN>(arg0, 2, b"SUIMEN", b"SUIMEN", b"If It Doesn't Taste Like $SUIMEN, I'm Not Buying It. :3", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://movepump.com/_next/image?url=https%3A%2F%2Fapi.movepump.com%2Fuploads%2Fphoto_2024_10_11_04_56_07_2_b29666f893.jpg&w=640&q=75")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<SUIMEN>>(v1);
        let v2 = v0;
        0x2::coin::mint_and_transfer<SUIMEN>(&mut v2, 50000000001, @0x7aed1e213e4ed1b16234506f0e78d94bbb3cf60967540beb841d14d3607b09c4, arg1);
        0x2::coin::mint_and_transfer<SUIMEN>(&mut v2, 50000000000, @0x7aed1e213e4ed1b16234506f0e78d94bbb3cf60967540beb841d14d3607b09c4, arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SUIMEN>>(v2, @0x0);
    }

    // decompiled from Move bytecode v6
}

