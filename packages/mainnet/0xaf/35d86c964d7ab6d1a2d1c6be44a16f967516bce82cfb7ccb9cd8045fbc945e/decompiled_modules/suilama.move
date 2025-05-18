module 0xaf35d86c964d7ab6d1a2d1c6be44a16f967516bce82cfb7ccb9cd8045fbc945e::suilama {
    struct SUILAMA has drop {
        dummy_field: bool,
    }

    fun init(arg0: SUILAMA, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SUILAMA>(arg0, 6, b"SUILAMA", b"Suilama on Sui", b"Solama the Official Unofficial Sui Mascot", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://ipfs.io/ipfs/bafkreig6d6wen4oh73tchgcqb3imxlgznopkpphur43qvwipstna6qdxgm")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SUILAMA>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<SUILAMA>>(v1, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

