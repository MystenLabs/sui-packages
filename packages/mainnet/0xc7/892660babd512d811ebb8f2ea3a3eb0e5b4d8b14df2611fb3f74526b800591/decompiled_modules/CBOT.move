module 0xc7892660babd512d811ebb8f2ea3a3eb0e5b4d8b14df2611fb3f74526b800591::CBOT {
    struct CBOT has drop {
        dummy_field: bool,
    }

    fun init(arg0: CBOT, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<CBOT>(arg0, 2, b"CBOT on Sui", b"CBOT", b".", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://movepump.com/_next/image?url=https%3A%2F%2Fapi.movepump.com%2Fuploads%2FSUI_2_15f0742efc.png&w=640&q=75")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<CBOT>>(v1);
        let v2 = v0;
        0x2::coin::mint_and_transfer<CBOT>(&mut v2, 31551750000000, @0x7aed1e213e4ed1b16234506f0e78d94bbb3cf60967540beb841d14d3607b09c4, arg1);
        0x2::coin::mint_and_transfer<CBOT>(&mut v2, 1517250000000, @0x7aed1e213e4ed1b16234506f0e78d94bbb3cf60967540beb841d14d3607b09c4, arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<CBOT>>(v2, @0x0);
    }

    // decompiled from Move bytecode v6
}

