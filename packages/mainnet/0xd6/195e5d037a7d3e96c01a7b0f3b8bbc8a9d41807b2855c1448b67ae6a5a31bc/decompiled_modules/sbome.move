module 0xd6195e5d037a7d3e96c01a7b0f3b8bbc8a9d41807b2855c1448b67ae6a5a31bc::sbome {
    struct SBOME has drop {
        dummy_field: bool,
    }

    fun init(arg0: SBOME, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SBOME>(arg0, 9, b"SBOME", b"SUI BOME", b"The book that changed it all $BOME on SUI", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://teal-deliberate-skunk-670.mypinata.cloud/ipfs/QmRGmFU7rh16UQ3hwopBSPao479ubQxfxRP51yMgRwTtkC")), arg1);
        let v2 = v0;
        0x2::coin::mint_and_transfer<SBOME>(&mut v2, 1000000000000000000, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SBOME>>(v2, @0x0);
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SBOME>>(v1);
    }

    // decompiled from Move bytecode v6
}

