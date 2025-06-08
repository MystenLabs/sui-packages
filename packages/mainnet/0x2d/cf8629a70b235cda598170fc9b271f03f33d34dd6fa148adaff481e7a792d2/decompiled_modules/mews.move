module 0x2dcf8629a70b235cda598170fc9b271f03f33d34dd6fa148adaff481e7a792d2::mews {
    struct MEWS has drop {
        dummy_field: bool,
    }

    fun init(arg0: MEWS, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<MEWS>(arg0, 6, b"MEWS", b"SUITWO ON SUI", b"Meme on sui", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://ipfs.io/ipfs/bafkreiflixva2ya2vkq256nasqiuf2atin6fotk2xdhn57bnsolvdmreq4")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<MEWS>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<MEWS>>(v1, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

