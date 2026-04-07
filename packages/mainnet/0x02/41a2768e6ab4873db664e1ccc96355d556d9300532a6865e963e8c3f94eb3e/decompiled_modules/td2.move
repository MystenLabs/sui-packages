module 0x241a2768e6ab4873db664e1ccc96355d556d9300532a6865e963e8c3f94eb3e::td2 {
    struct TD2 has drop {
        dummy_field: bool,
    }

    fun init(arg0: TD2, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<TD2>(arg0, 9, b"TD2", b"TOILET2.0", b"Toilet 2.0 Token - ToiletStake 2.0 protocol", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://blue-historical-mink-951.mypinata.cloud/ipfs/bafybeiehoc3umvctl6ywhm2ud4hvf3j3urukfdsgxmol7roofbz5adlxxu")), arg1);
        let v2 = v0;
        0x2::transfer::public_transfer<0x2::coin::Coin<TD2>>(0x2::coin::mint<TD2>(&mut v2, 10000000000000000000, arg1), @0xcfe539109f7400cbd1cb4fe755ecd7e6f43e97e5b1051d843d4dfd034528a25f);
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<TD2>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<TD2>>(v2, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

