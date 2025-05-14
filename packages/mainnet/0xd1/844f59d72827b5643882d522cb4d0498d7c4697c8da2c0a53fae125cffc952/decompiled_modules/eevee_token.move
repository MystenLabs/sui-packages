module 0xd1844f59d72827b5643882d522cb4d0498d7c4697c8da2c0a53fae125cffc952::eevee_token {
    struct EEVEE_TOKEN has drop {
        dummy_field: bool,
    }

    fun init(arg0: EEVEE_TOKEN, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<EEVEE_TOKEN>(arg0, 9, b"EEVEE", b"Eevee", b"$EEVEE- Memes evolve. So do we. X: https://x.com/Eeveesui", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://ipfs.io/ipfs/bafkreicr4iu66hr66cza4qzpq4ntewafjw3nx3xk3cwbuiyws6ma2amm74")), arg1);
        let v2 = v0;
        0x2::coin::mint_and_transfer<EEVEE_TOKEN>(&mut v2, 1000000000000000000, @0xd3f35255cdf3c306e93a9ec0087f496632cb5d39a38a7b7211ec0bcb22fa7a79, arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<EEVEE_TOKEN>>(v2, @0x0);
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<EEVEE_TOKEN>>(v1);
    }

    // decompiled from Move bytecode v6
}

