module 0xaf70c634be192fc747c7be1a67c579fa7cf60f93bfe4790026e963f80e8d1413::peff {
    struct PEFF has drop {
        dummy_field: bool,
    }

    fun init(arg0: PEFF, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<PEFF>(arg0, 6, b"PEFF", b"perfect", b"AAAAAA", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://ipfs.io/ipfs/bafkreidusxwrdhly64qtrw3uxj3gf2pc5lrdevgigcaa72dew2vec27cva")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<PEFF>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<PEFF>>(v1, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

