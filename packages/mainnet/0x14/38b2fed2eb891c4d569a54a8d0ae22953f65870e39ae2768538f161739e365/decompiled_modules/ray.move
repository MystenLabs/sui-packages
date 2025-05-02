module 0x1438b2fed2eb891c4d569a54a8d0ae22953f65870e39ae2768538f161739e365::ray {
    struct RAY has drop {
        dummy_field: bool,
    }

    fun init(arg0: RAY, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<RAY>(arg0, 6, b"RAY", b"RAY MOON", b"raymoon", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://ipfs.io/ipfs/bafkreibg6alykttigsxzu3e5zutifh3eqsycwvrrhfytycnyqvv5lijk7y")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<RAY>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<RAY>>(v1, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

