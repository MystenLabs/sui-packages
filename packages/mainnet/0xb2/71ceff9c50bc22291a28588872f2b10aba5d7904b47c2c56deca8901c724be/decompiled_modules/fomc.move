module 0xb271ceff9c50bc22291a28588872f2b10aba5d7904b47c2c56deca8901c724be::fomc {
    struct FOMC has drop {
        dummy_field: bool,
    }

    fun init(arg0: FOMC, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<FOMC>(arg0, 6, b"FOMC", b"FearOfMissuingCat", b"On the prowl for 1000x returns, and with FOMO starting to kick in, kitten somehow ended up on the Sui blockchain. Help him find his new home here, he doesn't want to return to Ethereum. P.s. this kitten isn't afraid of heights!", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/Preview_1_b82f949e23.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<FOMC>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<FOMC>>(v1);
    }

    // decompiled from Move bytecode v6
}

