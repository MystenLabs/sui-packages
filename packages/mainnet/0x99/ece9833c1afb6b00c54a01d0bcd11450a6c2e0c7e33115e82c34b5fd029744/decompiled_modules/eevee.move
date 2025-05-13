module 0x99ece9833c1afb6b00c54a01d0bcd11450a6c2e0c7e33115e82c34b5fd029744::eevee {
    struct EEVEE has drop {
        dummy_field: bool,
    }

    fun init(arg0: EEVEE, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<EEVEE>(arg0, 9, b"EEVEE", b"Eevee", b"$EEVEE- Memes evolve. So do we. https://x.com/Eeveesui https://www.eevve.xyz", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://ipfs.io/ipfs/bafkreicr4iu66hr66cza4qzpq4ntewafjw3nx3xk3cwbuiyws6ma2amm74")), arg1);
        let v2 = v0;
        0x2::coin::mint_and_transfer<EEVEE>(&mut v2, 1000000000000000000, @0xaaf1df4c3acec188c977c136a5400221ca6edb798852d31a304bdf67f6f9adaf, arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<EEVEE>>(v2, @0x0);
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<EEVEE>>(v1);
    }

    // decompiled from Move bytecode v6
}

