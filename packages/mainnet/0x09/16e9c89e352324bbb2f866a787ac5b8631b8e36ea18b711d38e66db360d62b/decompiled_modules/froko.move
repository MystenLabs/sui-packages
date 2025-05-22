module 0x916e9c89e352324bbb2f866a787ac5b8631b8e36ea18b711d38e66db360d62b::froko {
    struct FROKO has drop {
        dummy_field: bool,
    }

    fun init(arg0: FROKO, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<FROKO>(arg0, 6, b"FROKO", b"Sui Froko", b"Another frog, another story", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://ipfs.io/ipfs/bafkreig63rumfrd4rzrvydxbml5v7vesofclfqrmptzgczl3s43mxd3t3a")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<FROKO>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<FROKO>>(v1, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

