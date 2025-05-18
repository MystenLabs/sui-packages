module 0xab4907229fa00ec7706c584e96d34ccde1f826df259321821931c8d3b8222402::suiko {
    struct SUIKO has drop {
        dummy_field: bool,
    }

    fun init(arg0: SUIKO, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SUIKO>(arg0, 6, b"SUIKO", b"Suiko Cat", b"Suiko more than just a meme coin, its a symbol of ambition and determination in the rapidly growing cryptocurrency space", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://ipfs.io/ipfs/bafybeicm2h6z2sq3rqmfw4tczk32ecunkquyvjkvyiaxrahmwt34ftconm")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SUIKO>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<SUIKO>>(v1, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

