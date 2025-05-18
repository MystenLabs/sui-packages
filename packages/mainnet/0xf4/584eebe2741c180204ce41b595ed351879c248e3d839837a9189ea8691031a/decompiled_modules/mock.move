module 0xf4584eebe2741c180204ce41b595ed351879c248e3d839837a9189ea8691031a::mock {
    struct MOCK has drop {
        dummy_field: bool,
    }

    fun init(arg0: MOCK, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<MOCK>(arg0, 6, b"MOCK", b"MOCKEREL", x"4920446f6e74206b6e6f772057686f20416d20493f2120496d0a4a75737420244d6f636b6572656c2c20446f6e74206361726520616e797468696e672e200a0a4e6f20526f61646d61702d204e6f20626f73732d4f6e6c792076696265732e", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://ipfs.io/ipfs/bafkreihtzkjkwdi2xsn63pij7wypmebtgrwbmzpeuey4bdrfm72sdyffjy")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<MOCK>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<MOCK>>(v1, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

