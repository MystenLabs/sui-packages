module 0xbb35423d871aca6f999d39985286441fbf55330d987b5d1194dbd1d5492c246b::bsds {
    struct BSDS has drop {
        dummy_field: bool,
    }

    fun init(arg0: BSDS, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<BSDS>(arg0, 6, b"BSDS", b"Based SUI", b"Based SUI is a meme token on the Sui, combining the Based culture  vibes with the power of the Sui blockchain. Powered by the community, for the community.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/4a3b5bf2_6d2b_4cad_a086_07c202ec81d0_ef841e6975.gif")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<BSDS>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<BSDS>>(v1);
    }

    // decompiled from Move bytecode v6
}

