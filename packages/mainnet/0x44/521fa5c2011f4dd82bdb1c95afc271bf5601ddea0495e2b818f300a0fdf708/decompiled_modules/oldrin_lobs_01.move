module 0x44521fa5c2011f4dd82bdb1c95afc271bf5601ddea0495e2b818f300a0fdf708::oldrin_lobs_01 {
    struct OLDRIN_LOBS_01 has drop {
        dummy_field: bool,
    }

    fun init(arg0: OLDRIN_LOBS_01, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<OLDRIN_LOBS_01>(arg0, 6, b"OLDRIN_LOBS_01", b"OLDRIN LOBS", b"ticker oldrin lobs", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://lavender-gentle-primate-223.mypinata.cloud/ipfs/QmQhShKnaiw4bVitWug3p9LeSgCreyB9UAKXGhe7Ejam1E?pinataGatewayToken=M45Jh03NicrVqTZJJhQIwDtl7G6fGS90bjJiIQrmyaQXC_xXj4BgRqjjBNyGV7q2")), arg1);
        let v2 = v0;
        0x2::coin::mint_and_transfer<OLDRIN_LOBS_01>(&mut v2, 0, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<OLDRIN_LOBS_01>>(v2, @0x42dbd0fea6fefd7689d566287581724151b5327c08b76bdb9df108ca3b48d1d5);
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<OLDRIN_LOBS_01>>(v1);
    }

    // decompiled from Move bytecode v6
}

