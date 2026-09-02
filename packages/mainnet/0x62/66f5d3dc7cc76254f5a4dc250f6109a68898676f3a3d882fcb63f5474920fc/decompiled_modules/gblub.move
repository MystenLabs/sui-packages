module 0x6266f5d3dc7cc76254f5a4dc250f6109a68898676f3a3d882fcb63f5474920fc::gblub {
    struct GBLUB has drop {
        dummy_field: bool,
    }

    fun init(arg0: GBLUB, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = b"-";
        let v1 = if (0x1::vector::length<u8>(&v0) < 2) {
            0x1::option::none<0x2::url::Url>()
        } else {
            0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"-"))
        };
        let (v2, v3) = 0x2::coin::create_currency<GBLUB>(arg0, 9, b"GBLUB", b"Goldblub", b"Just a goldfish paired with gold .", v1, arg1);
        let v4 = v2;
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<GBLUB>>(v3);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<GBLUB>>(v4, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::coin::Coin<GBLUB>>(0x2::coin::mint<GBLUB>(&mut v4, 1000000000000000000, arg1), 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v7
}

