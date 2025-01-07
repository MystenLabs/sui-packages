module 0x5c90e03a203f44164ec5ea251555f90c5b5288b2492c41d7eaea88b23561e3d6::beta {
    struct BETA has drop {
        dummy_field: bool,
    }

    fun init(arg0: BETA, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<BETA>(arg0, 9, b"BETA", b"BETA Token", b"BETA is the native token of BETAfi Protocol", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://letsenhance.io/static/66c1b6abf8f7cf44c19185254d7adb0c/ff1b5/AiArtBefore.jpg")), arg1);
        let v2 = v0;
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<BETA>>(v1);
        0x2::transfer::public_transfer<0x2::coin::Coin<BETA>>(0x2::coin::mint<BETA>(&mut v2, 1000000000000000, arg1), @0xbef197ee83f9c4962f46f271a50af25301585121e116173be25cd86286378e15);
        0x2::transfer::public_transfer<0x2::coin::Coin<BETA>>(0x2::coin::mint<BETA>(&mut v2, 500000000000000, arg1), @0xa511088cc13a632a5e8f9937028a77ae271832465e067360dd13f548fe934d1a);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<BETA>>(v2, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

