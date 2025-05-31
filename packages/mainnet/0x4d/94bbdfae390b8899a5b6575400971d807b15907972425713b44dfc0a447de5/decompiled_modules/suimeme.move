module 0x4d94bbdfae390b8899a5b6575400971d807b15907972425713b44dfc0a447de5::suimeme {
    struct SUIMEME has drop {
        dummy_field: bool,
    }

    fun init(arg0: SUIMEME, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SUIMEME>(arg0, 6, b"SUIMEME", b"SUI Meme", b"Welcome to SUIMeme-the Slime, the drop, the origin. I don't follow  trends, i create them. I represent the degenerates and the dreamers, I'm SUI", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://ipfs.io/ipfs/bafkreicoc4rvf7q5faeh3l2i2u5y4qccixrkaahmonw6cgib6yp3o5tdxi")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SUIMEME>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<SUIMEME>>(v1, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

