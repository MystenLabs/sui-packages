module 0xa4c34f6cff672b4a301f53e26b71016125c1a0c13e42c17f150ba218c68f1eb9::fartcoin {
    struct FARTCOIN has drop {
        dummy_field: bool,
    }

    fun init(arg0: FARTCOIN, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<FARTCOIN>(arg0, 6, b"Fartcoin", b"Fartcoin on Sui", x"46617274636f696e206f6e205375690a4e6f20696e7369646572732c206e6f20636162616c2c206a75737420666172747321", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://ipfs.io/ipfs/bafkreic7dulmv2lkaznuw7bfjwlpz4ypfn4d2yzxrk4uyv223t3233e3le")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<FARTCOIN>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<FARTCOIN>>(v1, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

