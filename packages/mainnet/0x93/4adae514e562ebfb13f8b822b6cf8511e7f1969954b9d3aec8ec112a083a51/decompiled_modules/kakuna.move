module 0x934adae514e562ebfb13f8b822b6cf8511e7f1969954b9d3aec8ec112a083a51::kakuna {
    struct KAKUNA has drop {
        dummy_field: bool,
    }

    fun init(arg0: KAKUNA, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<KAKUNA>(arg0, 6, b"KAKUNA", b"KAKUNASUI", x"4b616b756e6120697320612079656c6c6f772c20696e7365637420636f636f6f6e2d6c696b6520506f6bc3a96d6f6e2e", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://ipfs.io/ipfs/bafkreihfujivlfcky32vz7f7a5eoq2yznrz63oruntftdozkdyssxcibmq")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<KAKUNA>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<KAKUNA>>(v1, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

