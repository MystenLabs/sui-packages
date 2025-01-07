module 0xe67dc26fc75d0e2b6031adbacc7f9b57209edf28015915e2dc5723585760b179::roll {
    struct ROLL has drop {
        dummy_field: bool,
    }

    fun init(arg0: ROLL, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<ROLL>(arg0, 9, b"ROLL", b"RICKROLL", b"TARARARARA", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://dd.dexscreener.com/ds-data/tokens/solana/BuHZAmYGVTJaDzPaLZu2ixKDrvUPTzmPZaWvH1CDmuLb.png?size=lg&key=54b9cc")), arg1);
        let v2 = v0;
        0x2::coin::mint_and_transfer<ROLL>(&mut v2, 10000000000000000000, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<ROLL>>(v2, @0x0);
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<ROLL>>(v1);
    }

    // decompiled from Move bytecode v6
}

