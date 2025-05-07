module 0x3bbdadbdcc1d3721d21a836aae110a3a9d455d38856ff742d2c5052484af4ace::ngmi {
    struct NGMI has drop {
        dummy_field: bool,
    }

    fun init(arg0: NGMI, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<NGMI>(arg0, 6, b"NGMI", b"NGMI SUI", b"Your favorite whale on SUI trench king is trying to make friends on Ronin Chain.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://ipfs.io/ipfs/bafkreicjsnc7c4lmgioqt6wvxgbeeyvxm4wpvgqu4yrg7mrtqotdvvbnlm")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<NGMI>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<NGMI>>(v1, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

