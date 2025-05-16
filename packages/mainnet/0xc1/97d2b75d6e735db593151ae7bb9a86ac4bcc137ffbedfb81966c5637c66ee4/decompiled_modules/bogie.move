module 0xc197d2b75d6e735db593151ae7bb9a86ac4bcc137ffbedfb81966c5637c66ee4::bogie {
    struct BOGIE has drop {
        dummy_field: bool,
    }

    fun init(arg0: BOGIE, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<BOGIE>(arg0, 6, b"BOGIE", b"Bogie Sui", b"Sui meme No roadmap. No boss. Only vibes.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://ipfs.io/ipfs/bafkreiccp6ygzlophuslszq3bvkapu5hscertstmvnbduielzwzl7qxyhe")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<BOGIE>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<BOGIE>>(v1, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

