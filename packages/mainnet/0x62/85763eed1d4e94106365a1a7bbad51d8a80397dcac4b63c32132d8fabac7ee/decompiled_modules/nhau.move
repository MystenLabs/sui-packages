module 0x6285763eed1d4e94106365a1a7bbad51d8a80397dcac4b63c32132d8fabac7ee::nhau {
    struct NHAU has drop {
        dummy_field: bool,
    }

    fun init(arg0: NHAU, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = b"nASTROCAT";
        0x1::vector::remove<u8>(&mut v0, 0);
        let v1 = b"dAccidentally launched into orbit after napping on a launchpad control panel, AstroCat became the galaxy's first accidental space explorer. Now floating through the cosmos with a giant celestial token, this cosmic kitten is on a mission to find the ultimate planetary scratching post.";
        0x1::vector::remove<u8>(&mut v1, 0);
        let (v2, v3) = 0x2::coin::create_currency<NHAU>(arg0, 6, b"NHAU", v0, v1, 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://suidot.fun/i/F1faCJBxOvzuaVA6")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<NHAU>>(v3);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<NHAU>>(v2, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v7
}

