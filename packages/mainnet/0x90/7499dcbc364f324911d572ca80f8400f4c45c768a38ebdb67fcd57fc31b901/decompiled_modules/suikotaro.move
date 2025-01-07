module 0x907499dcbc364f324911d572ca80f8400f4c45c768a38ebdb67fcd57fc31b901::suikotaro {
    struct SUIKOTARO has drop {
        dummy_field: bool,
    }

    fun init(arg0: SUIKOTARO, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SUIKOTARO>(arg0, 9, b"SuiKotaro", b"Kotaro", b"TOP.1 memecoin on Suinetwork", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://movepump.com/_next/image?url=https%3A%2F%2Fapi.movepump.com%2Fuploads%2FGYI_Xleg_Xk_A_Aym3_D_099185c316.jpeg&w=640&q=75")), arg1);
        let v2 = v0;
        0x2::coin::mint_and_transfer<SUIKOTARO>(&mut v2, 10000000000000000000, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SUIKOTARO>>(v2, @0x0);
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SUIKOTARO>>(v1);
    }

    // decompiled from Move bytecode v6
}

