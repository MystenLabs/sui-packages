module 0x8a6e400a2454a48863f8decbcf7dcba4450643865ee7e1b329616cc76a7f4ffb::sdf {
    struct SDF has drop {
        dummy_field: bool,
    }

    fun init(arg0: SDF, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SDF>(arg0, 6, b"SDF", b"dfsdf", b"dfsdfdfsdf", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://ipfs.io/ipfs/bafybeibq6jfz5qlf5wch3t6htf2p7kxevkvf4tmkgug4aizudhhiivps2i")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SDF>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<SDF>>(v1, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

