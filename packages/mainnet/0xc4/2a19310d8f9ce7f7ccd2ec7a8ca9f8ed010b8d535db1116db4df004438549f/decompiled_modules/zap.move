module 0xc42a19310d8f9ce7f7ccd2ec7a8ca9f8ed010b8d535db1116db4df004438549f::zap {
    struct ZAP has drop {
        dummy_field: bool,
    }

    fun init(arg0: ZAP, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<ZAP>(arg0, 6, b"ZAP", b"ZapZap", b"ZAP is the coolest playboy, gambler", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://ipfs.io/ipfs/bafkreicq3jop2gyzwxdw6qddd5p665zzronrkahzl74cepeplrtvjq5b2m")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<ZAP>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<ZAP>>(v1, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

