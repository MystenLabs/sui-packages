module 0x6c122344482d9c82e7181e44aa2181f5f398c597f4547d5c1570983f7a4a229::gooch {
    struct GOOCH has drop {
        dummy_field: bool,
    }

    fun init(arg0: GOOCH, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<GOOCH>(arg0, 9, b"gooch", b"gooch coin", b"gooch coin meme token", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://dd.dexscreener.com/ds-data/tokens/solana/e8NFqLCMJBfDTUUARoniADgQtSEFmZNBksPxYzepump.png?size=xl&key=1ef678")), arg1);
        let v2 = v0;
        0x2::coin::mint_and_transfer<GOOCH>(&mut v2, 1000000000000000000, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<GOOCH>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<GOOCH>>(v2, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

