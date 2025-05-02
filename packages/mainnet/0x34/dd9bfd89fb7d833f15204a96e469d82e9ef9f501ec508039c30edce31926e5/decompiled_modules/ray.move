module 0x34dd9bfd89fb7d833f15204a96e469d82e9ef9f501ec508039c30edce31926e5::ray {
    struct RAY has drop {
        dummy_field: bool,
    }

    fun init(arg0: RAY, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<RAY>(arg0, 6, b"RAY", b"RAYMOON", b"RAYMOOON", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://ipfs.io/ipfs/bafkreibg6alykttigsxzu3e5zutifh3eqsycwvrrhfytycnyqvv5lijk7y")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<RAY>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<RAY>>(v1, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

