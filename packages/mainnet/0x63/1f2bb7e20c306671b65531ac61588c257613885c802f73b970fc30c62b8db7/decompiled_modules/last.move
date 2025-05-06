module 0x631f2bb7e20c306671b65531ac61588c257613885c802f73b970fc30c62b8db7::last {
    struct LAST has drop {
        dummy_field: bool,
    }

    fun init(arg0: LAST, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<LAST>(arg0, 6, b"LAST", b"LAST TEST", b"SORRY FOR SPAM, JUST TRY MY SNIPER VS RAIDEN X , DON'T BUY THIS COIN PLEASE", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://ipfs.io/ipfs/bafkreienvlrqvy6vkwhg32vp3r4lwxefmjzidond4elizot5tb56qdzkna")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<LAST>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<LAST>>(v1, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

