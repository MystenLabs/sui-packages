module 0x30b171248c0f57ef42e98c09024e8e8d1eeb4783d90ce4ca3b97609fcf05104d::lillo {
    struct LILLO has drop {
        dummy_field: bool,
    }

    fun init(arg0: LILLO, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<LILLO>(arg0, 6, b"Lillo", b"Lillo Ai", b"How to build your own AI Agent with Lillo AI Framework", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://ipfs.io/ipfs/bafybeiaze3pqtzixnmtsyg3edhfz5wjj4mpwaamks7t4dwxrnp5zmd7fpy")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<LILLO>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<LILLO>>(v1, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

