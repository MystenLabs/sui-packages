module 0xecabcd9d9ab7ce0a0d3753e298add7ba268fbd079611aa5b52bb4e192ee33697::attn {
    struct ATTN has drop {
        dummy_field: bool,
    }

    fun init(arg0: ATTN, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<ATTN>(arg0, 6, b"ATTN", b"ATTNTOKEN", b"ITS pas to pay", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://ipfs.io/ipfs/bafkreiflbg2gqq3cuxsgdzj3wtdkz4qrvmwnj6me3h375udruwfdhr7qfy")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<ATTN>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<ATTN>>(v1, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

