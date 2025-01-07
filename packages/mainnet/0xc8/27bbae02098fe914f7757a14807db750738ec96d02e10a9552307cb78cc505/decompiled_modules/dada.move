module 0xc827bbae02098fe914f7757a14807db750738ec96d02e10a9552307cb78cc505::dada {
    struct DADA has drop {
        dummy_field: bool,
    }

    fun init(arg0: DADA, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<DADA>(arg0, 4, b"DADA", b"Dada", b"The supply of this coin is the epoch millisecond timestamp at beginning", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://niroq6i2gtlprusga2wpiq3uz3nks4cnjeod55sgwr2ay4m7di3a.arweave.net/aiLoeRo01vjSRgas9EN0ztqpcE1JHD72RrR0DHGfGjY")), arg1);
        let v2 = v0;
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<DADA>>(v1);
        0x2::coin::mint_and_transfer<DADA>(&mut v2, 0x2::tx_context::epoch_timestamp_ms(arg1), 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<DADA>>(v2, @0x0);
    }

    // decompiled from Move bytecode v6
}

