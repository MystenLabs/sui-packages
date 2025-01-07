module 0x5aa3a512bbc2a5d56309753a0c2c57da0e8a2d6b0904eb9a87033227cfcaf961::fyp {
    struct FYP has drop {
        dummy_field: bool,
    }

    fun init(arg0: FYP, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<FYP>(arg0, 6, b"FYP", b"For You", b"Made with meme love on SUI.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/IMG_4809_27a0afb7f5.jpeg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<FYP>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<FYP>>(v1);
    }

    // decompiled from Move bytecode v6
}

