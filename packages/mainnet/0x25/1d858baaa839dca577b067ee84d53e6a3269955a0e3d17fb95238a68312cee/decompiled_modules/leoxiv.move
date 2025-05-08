module 0x251d858baaa839dca577b067ee84d53e6a3269955a0e3d17fb95238a68312cee::leoxiv {
    struct LEOXIV has drop {
        dummy_field: bool,
    }

    fun init(arg0: LEOXIV, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<LEOXIV>(arg0, 9, b"LEOXIV", b"POPE LEO XIV", b"LEOXIV LEOXIV LEOXIV", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://dd.dexscreener.com/ds-data/tokens/solana/6FNopMZvKQMS5prFCjCDFt5sAJ2UmY1JU2jvyf3Lpump.png?size=xl&key=3e9616")), arg1);
        let v2 = v0;
        0x2::coin::mint_and_transfer<LEOXIV>(&mut v2, 100000000000000000, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<LEOXIV>>(v2, @0x0);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<LEOXIV>>(v1);
    }

    // decompiled from Move bytecode v6
}

