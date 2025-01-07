module 0x775297c71767e48cd8f04d1fdcf398f561c75df0d5d355d9c9238bb7e4dc8219::SUIGAR {
    struct SUIGAR has drop {
        dummy_field: bool,
    }

    fun init(arg0: SUIGAR, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SUIGAR>(arg0, 2, b"SUIGAR", b"SUIGAR", b"Suigar is a sweet, fresh & fun coin on the Sui network.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://movepump.com/_next/image?url=https%3A%2F%2Fapi.movepump.com%2Fuploads%2FSUIGAR_PROFIL_b3088c58db.jpg&w=640&q=75")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<SUIGAR>>(v1);
        let v2 = v0;
        0x2::coin::mint_and_transfer<SUIGAR>(&mut v2, 50000000001, @0x7aed1e213e4ed1b16234506f0e78d94bbb3cf60967540beb841d14d3607b09c4, arg1);
        0x2::coin::mint_and_transfer<SUIGAR>(&mut v2, 50000000000, @0x7aed1e213e4ed1b16234506f0e78d94bbb3cf60967540beb841d14d3607b09c4, arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SUIGAR>>(v2, @0x0);
    }

    // decompiled from Move bytecode v6
}

