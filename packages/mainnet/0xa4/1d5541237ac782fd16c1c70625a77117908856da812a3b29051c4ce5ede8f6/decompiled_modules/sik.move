module 0xa41d5541237ac782fd16c1c70625a77117908856da812a3b29051c4ce5ede8f6::sik {
    struct SIK has drop {
        dummy_field: bool,
    }

    fun init(arg0: SIK, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SIK>(arg0, 6, b"SIK", b"kae", b"KAE is Japanese high school girl", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://ipfs.io/ipfs/bafybeiehkiqbhh44ydo265w2bvlds4vlim765agq7eaxgzx5fhfxlipape")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SIK>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<SIK>>(v1, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

