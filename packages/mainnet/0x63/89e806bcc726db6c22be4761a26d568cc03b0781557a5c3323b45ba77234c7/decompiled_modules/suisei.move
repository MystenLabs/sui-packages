module 0x6389e806bcc726db6c22be4761a26d568cc03b0781557a5c3323b45ba77234c7::suisei {
    struct SUISEI has drop {
        dummy_field: bool,
    }

    fun init(arg0: SUISEI, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SUISEI>(arg0, 6, b"SUISEI", b"Hoshimachi suisei", b"An AI Vtuber called Suisei is going viral after being the first every AI anime character starring on Forbes 2025.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://ipfs.io/ipfs/bafkreie4usagxen7vurrhiuolpgfbwue6m7zxwxzrpadvji2qkqazv65li")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SUISEI>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<SUISEI>>(v1, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

