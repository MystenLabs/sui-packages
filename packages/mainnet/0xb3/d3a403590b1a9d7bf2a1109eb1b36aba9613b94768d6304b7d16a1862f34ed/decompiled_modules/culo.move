module 0xb3d3a403590b1a9d7bf2a1109eb1b36aba9613b94768d6304b7d16a1862f34ed::culo {
    struct CULO has drop {
        dummy_field: bool,
    }

    fun init(arg0: CULO, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<CULO>(arg0, 6, b"CULO", b"Culo_SUI", b"The cheekiest meme token on Sui! Join the rumpus, moon with us!", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://ipfs.io/ipfs/bafkreieibaty2ckhxqm4i67nu4yy5i53xuxt67g657463wqnrnsnmugsqy")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<CULO>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<CULO>>(v1, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

