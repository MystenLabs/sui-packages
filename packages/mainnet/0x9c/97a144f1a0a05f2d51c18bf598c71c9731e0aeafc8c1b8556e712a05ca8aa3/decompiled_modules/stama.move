module 0x9c97a144f1a0a05f2d51c18bf598c71c9731e0aeafc8c1b8556e712a05ca8aa3::stama {
    struct STAMA has drop {
        dummy_field: bool,
    }

    fun init(arg0: STAMA, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<STAMA>(arg0, 6, b"STAMA", b"SUITAMA", b"SUITAMA is revolutionizing the meme coin space with zero dev allocations, 100% community focus, and burned liquidity. Join the movement that's taking the Sui ecosystem by storm!", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://ipfs.io/ipfs/bafkreibnvzdtiqjzgkgztbn23fuwyqoaxlgplaj4ybazudlfedfbnjomcm")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<STAMA>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<STAMA>>(v1, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

