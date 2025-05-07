module 0xbd9c6adf262c795759fc4ef61c1212142b1eb4b5c6e6c62b7b313b1eb07ed6a5::suiguy {
    struct SUIGUY has drop {
        dummy_field: bool,
    }

    fun init(arg0: SUIGUY, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SUIGUY>(arg0, 6, b"Suiguy", b"TheRealSuiGuy", b"The Real Sui Guy", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://ipfs.io/ipfs/bafkreiglpb3fdqfqg5nmwwvmzzbpd4rdeqoid65k637ea2c4dxevwnlbmy")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SUIGUY>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<SUIGUY>>(v1, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

