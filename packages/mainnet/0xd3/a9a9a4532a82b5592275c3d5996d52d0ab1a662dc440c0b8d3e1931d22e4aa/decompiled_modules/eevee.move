module 0xd3a9a9a4532a82b5592275c3d5996d52d0ab1a662dc440c0b8d3e1931d22e4aa::eevee {
    struct EEVEE has drop {
        dummy_field: bool,
    }

    fun init(arg0: EEVEE, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<EEVEE>(arg0, 9, b"EEVEE", b"Eevee", b"$EEVEE- Memes evolve. So do we. X: https://x.com/Eeveesui", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://ipfs.io/ipfs/bafkreicr4iu66hr66cza4qzpq4ntewafjw3nx3xk3cwbuiyws6ma2amm74")), arg1);
        let v2 = v0;
        0x2::coin::mint_and_transfer<EEVEE>(&mut v2, 1000000000000000000, @0xd3f35255cdf3c306e93a9ec0087f496632cb5d39a38a7b7211ec0bcb22fa7a79, arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<EEVEE>>(v2, @0x0);
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<EEVEE>>(v1);
    }

    // decompiled from Move bytecode v6
}

