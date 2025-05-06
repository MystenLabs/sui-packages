module 0xef78e66b32590a73ccad8fa39b8ca8a7cd6c3b6e1684421086ddb473ecd57551::test7 {
    struct TEST7 has drop {
        dummy_field: bool,
    }

    fun init(arg0: TEST7, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<TEST7>(arg0, 6, b"TEST7", b"TEST TOKEN 7", b"DON'T BUY THIS COIN", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://ipfs.io/ipfs/bafkreiav47hvj5a3odgh72w7tzi43k5rl2xutxo7nnet3hxpvtotfw6yf4")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<TEST7>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<TEST7>>(v1, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

