module 0x7bd62a3c0f464241af3311df6bf18b5ef1c929396cee8a9ec427aab431c02f95::chillec {
    struct CHILLEC has drop {
        dummy_field: bool,
    }

    fun init(arg0: CHILLEC, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<CHILLEC>(arg0, 6, b"CHILLEC", b"Chill Evan Cheng", b"Hold $CHILLEC and chill with Evan Cheng", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://ipfs.io/ipfs/bafkreidhvmmqy3grg5o624laksi36w2fmx7kqr4mapnmespb5xl6qrltam")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<CHILLEC>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<CHILLEC>>(v1, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

