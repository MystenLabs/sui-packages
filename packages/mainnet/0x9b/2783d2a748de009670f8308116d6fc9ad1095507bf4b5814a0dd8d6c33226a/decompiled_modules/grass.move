module 0x9b2783d2a748de009670f8308116d6fc9ad1095507bf4b5814a0dd8d6c33226a::grass {
    struct GRASS has drop {
        dummy_field: bool,
    }

    fun init(arg0: GRASS, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<GRASS>(arg0, 9, b"GRASS", b"Touch Grass", b"Chill out, and touch some grass", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://dd.dexscreener.com/ds-data/tokens/solana/5EYsHuyYGriuoYah7e9FfbSYuGW3vJevHnm2mtnJPfto.png?size=lg&key=6f8f7f")), arg1);
        let v2 = v0;
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<GRASS>>(v1);
        0x2::transfer::public_transfer<0x2::coin::Coin<GRASS>>(0x2::coin::mint<GRASS>(&mut v2, 1000000000000000000, arg1), 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::TreasuryCap<GRASS>>(v2);
    }

    // decompiled from Move bytecode v6
}

