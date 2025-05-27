module 0x76172bd0a92a854380bd16d108706659488f0d31c252af66acbc630eeee91eb1::caffeine {
    struct CAFFEINE has drop {
        dummy_field: bool,
    }

    fun init(arg0: CAFFEINE, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<CAFFEINE>(arg0, 6, b"CAFFEINE", b"I NEED CAFFEINE", b"I NEED CAFFEINE!", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://ipfs.io/ipfs/bafybeieltf3vimyym4r2ri5nnzpf6yiakuc35gswtm46s72x72czufi73e")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<CAFFEINE>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<CAFFEINE>>(v1, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

