module 0xb425fee1a0ebdade10d25c7c267b8634867af8eefab4d71aa70f46d7fdff6092::BUST {
    struct BUST has drop {
        dummy_field: bool,
    }

    fun init(arg0: BUST, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<BUST>(arg0, 2, b"GigaBust Token", b"BUST", b"The GigaBust is coming.. and its going to be BIG", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://movepump.com/_next/image?url=https%3A%2F%2Fapi.movepump.com%2Fuploads%2FIMG_2126_d6e89fb38a.jpeg&w=640&q=75")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<BUST>>(v1);
        let v2 = v0;
        0x2::coin::mint_and_transfer<BUST>(&mut v2, 100000000001, @0x7aed1e213e4ed1b16234506f0e78d94bbb3cf60967540beb841d14d3607b09c4, arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<BUST>>(v2, @0x0);
    }

    // decompiled from Move bytecode v6
}

