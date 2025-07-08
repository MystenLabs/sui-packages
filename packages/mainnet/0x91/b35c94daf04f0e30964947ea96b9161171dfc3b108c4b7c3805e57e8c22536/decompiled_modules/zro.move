module 0x91b35c94daf04f0e30964947ea96b9161171dfc3b108c4b7c3805e57e8c22536::zro {
    struct ZRO has drop {
        dummy_field: bool,
    }

    fun init(arg0: ZRO, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<ZRO>(arg0, 6, b"ZRO", b"Zoro", b"Roronoa Zoro", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://ipfs.io/ipfs/bafkreidd52j4tkotngjjkxkxjgpahc5xfmcfj3ta57mqfo4ouiwmc7vo4a")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<ZRO>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<ZRO>>(v1, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

