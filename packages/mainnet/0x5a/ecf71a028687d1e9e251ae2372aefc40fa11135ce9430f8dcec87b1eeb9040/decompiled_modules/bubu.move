module 0x5aecf71a028687d1e9e251ae2372aefc40fa11135ce9430f8dcec87b1eeb9040::bubu {
    struct BUBU has drop {
        dummy_field: bool,
    }

    fun init(arg0: BUBU, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<BUBU>(arg0, 6, b"BUBU", b"LABUBU", x"437574657374206167656e74206f6e20746865206661737465737420636861696e2e0a0a234c61627562754f6e537569", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://ipfs.io/ipfs/bafkreiar3cdmlticg5guxl2a33q4efphwqwq3qvdeygufi7cf2c2e2fr7e")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<BUBU>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<BUBU>>(v1, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

