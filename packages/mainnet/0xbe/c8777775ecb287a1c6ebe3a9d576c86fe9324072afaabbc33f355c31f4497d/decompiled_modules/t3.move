module 0xbec8777775ecb287a1c6ebe3a9d576c86fe9324072afaabbc33f355c31f4497d::t3 {
    struct T3 has drop {
        dummy_field: bool,
    }

    fun init(arg0: T3, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<T3>(arg0, 6, b"T3", b"Test3", b"Dont buy it", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://ipfs.io/ipfs/bafkreigdjzfgusjfuoptqn57hj34q4g3uas76tywiqnj25udassv5rls6u")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<T3>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<T3>>(v1, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

