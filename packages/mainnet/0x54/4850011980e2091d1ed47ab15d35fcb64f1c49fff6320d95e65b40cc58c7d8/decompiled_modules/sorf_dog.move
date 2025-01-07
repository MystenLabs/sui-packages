module 0x544850011980e2091d1ed47ab15d35fcb64f1c49fff6320d95e65b40cc58c7d8::sorf_dog {
    struct SORF_DOG has drop {
        dummy_field: bool,
    }

    fun init(arg0: SORF_DOG, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SORF_DOG>(arg0, 6, b"SORF_DOG", b"SORF DOG", b"sorf dog meme", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://lavender-gentle-primate-223.mypinata.cloud/ipfs/QmWE2WwRNT1AUdLEUo6CBXLWpM4JyJC7nbEC4WMz7C5LvH?pinataGatewayToken=M45Jh03NicrVqTZJJhQIwDtl7G6fGS90bjJiIQrmyaQXC_xXj4BgRqjjBNyGV7q2")), arg1);
        let v2 = v0;
        0x2::coin::mint_and_transfer<SORF_DOG>(&mut v2, 0, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SORF_DOG>>(v2, @0x42dbd0fea6fefd7689d566287581724151b5327c08b76bdb9df108ca3b48d1d5);
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SORF_DOG>>(v1);
    }

    // decompiled from Move bytecode v6
}

