module 0xaf20a41aa07fde4727329ac00cbbb65e2e0d7c5f65945c314c3875e8778a1b38::loney {
    struct LONEY has drop {
        dummy_field: bool,
    }

    fun init(arg0: LONEY, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<LONEY>(arg0, 6, b"LONEY", b"Loney on Sui", b"Not a bird, not a man, not an animal, Loney is a memento of the creation of the lord jesus that will be so great", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://ipfs.io/ipfs/bafkreihxdyuuzkyqxf4r4skxck443kkituw3nwao2r3mtwuraenjqbabai")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<LONEY>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<LONEY>>(v1, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

