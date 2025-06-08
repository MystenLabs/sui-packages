module 0xa6fffe08c02cb0748aacaa8c6dfbba3324295cff63ed4e765cac593d8f9c5d4::wss {
    struct WSS has drop {
        dummy_field: bool,
    }

    fun init(arg0: WSS, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<WSS>(arg0, 6, b"WSS", b"Wall Street Sui", b"The future of finance runs on Sui.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://ipfs.io/ipfs/bafybeigoj4i4vfsly4vcmb44zvmc6x6aspnl4hlszymtfnc7kwnzfctzx4")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<WSS>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<WSS>>(v1, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

