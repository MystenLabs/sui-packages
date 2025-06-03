module 0x4bd46a1945b4afdfcb926b37591e7c63caad4794705e018d0a2e520a82793269::suimon {
    struct SUIMON has drop {
        dummy_field: bool,
    }

    fun init(arg0: SUIMON, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SUIMON>(arg0, 6, b"Suimon", b"Sui mon", x"6469652d6861726420506f6bc3a96d6f6e2066616e73206272696e67696e672073617469726520746f20746865202453554920626c6f636b636861696e", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://ipfs.io/ipfs/bafkreidk4di5nhezjjg2zdv5agkkw4fodctqaunyrkdg56qqqfdk4p2ake")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SUIMON>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<SUIMON>>(v1, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

