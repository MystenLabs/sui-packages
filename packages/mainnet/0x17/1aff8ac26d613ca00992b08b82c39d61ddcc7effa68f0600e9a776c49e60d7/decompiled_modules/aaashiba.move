module 0x171aff8ac26d613ca00992b08b82c39d61ddcc7effa68f0600e9a776c49e60d7::aaashiba {
    struct AAASHIBA has drop {
        dummy_field: bool,
    }

    fun init(arg0: AAASHIBA, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<AAASHIBA>(arg0, 6, b"AAASHIBA", b"aaashibaaa", b"aaaaaaaaaashibaaaaaaaaaaaaaa", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/cacacac_3768f093c1.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<AAASHIBA>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<AAASHIBA>>(v1);
    }

    // decompiled from Move bytecode v6
}

