module 0x31e3a52c5d7caa607b3fb2a37037ecc59ba3d883255d2faecc3469c59471057c::sbunny {
    struct SBUNNY has drop {
        dummy_field: bool,
    }

    fun init(arg0: SBUNNY, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SBUNNY>(arg0, 6, b"SBUNNY", b"SUI BUNNY", b"The New Meme Mascot of SUI", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://ipfs.io/ipfs/bafkreidu4g77nm7ajeuq2m6uqh7p2idnqmrctv4oqj6oagznj7dtlkdmsa")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SBUNNY>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<SBUNNY>>(v1, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

