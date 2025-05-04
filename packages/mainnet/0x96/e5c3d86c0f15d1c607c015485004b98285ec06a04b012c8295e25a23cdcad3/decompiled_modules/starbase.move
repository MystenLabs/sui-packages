module 0x96e5c3d86c0f15d1c607c015485004b98285ec06a04b012c8295e25a23cdcad3::starbase {
    struct STARBASE has drop {
        dummy_field: bool,
    }

    fun init(arg0: STARBASE, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<STARBASE>(arg0, 9, b"STARBASE", b"NEW USA CITY", b"Starbase Citizens come together to show the world Starbase is the Gateway To Mars!", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://dd.dexscreener.com/ds-data/tokens/solana/2MVy9drHqSBinPoSyUrUVS19m5u8Cjj3mZcnpYshpump.png?size=xl&key=dc932b")), arg1);
        let v2 = v0;
        0x2::coin::mint_and_transfer<STARBASE>(&mut v2, 100000000000000000, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<STARBASE>>(v2, @0x0);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<STARBASE>>(v1);
    }

    // decompiled from Move bytecode v6
}

