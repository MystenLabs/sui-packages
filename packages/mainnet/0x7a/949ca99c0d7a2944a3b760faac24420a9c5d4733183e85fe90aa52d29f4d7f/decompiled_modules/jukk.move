module 0x7a949ca99c0d7a2944a3b760faac24420a9c5d4733183e85fe90aa52d29f4d7f::jukk {
    struct JUKK has drop {
        dummy_field: bool,
    }

    fun init(arg0: JUKK, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<JUKK>(arg0, 6, b"JUKK", b"JUKA", b"JUKK is the first token", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://ipfs.io/ipfs/bafybeif2zj7yuzg4khj5tg7t3b7uhepbucnixkqjt4odsck3hzhrwwmv7y")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<JUKK>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<JUKK>>(v1, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

