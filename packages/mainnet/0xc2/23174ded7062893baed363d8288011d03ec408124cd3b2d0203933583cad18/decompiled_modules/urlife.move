module 0xc223174ded7062893baed363d8288011d03ec408124cd3b2d0203933583cad18::urlife {
    struct URLIFE has drop {
        dummy_field: bool,
    }

    fun init(arg0: URLIFE, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<URLIFE>(arg0, 6, b"URLIFE", b"Change Urlife", b"One moment can change everything", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://ipfs.io/ipfs/bafkreie4fx2c5ub7rjfwgmxmqcen4qo2gqwh6xmgjxyw47emzhltzy2cri")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<URLIFE>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<URLIFE>>(v1, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

