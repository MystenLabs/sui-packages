module 0x4702b3a07c067da3e06c0376a69e3730d9a0a9991db086aa43ac092d2d6bf5b5::eron {
    struct ERON has drop {
        dummy_field: bool,
    }

    fun init(arg0: ERON, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<ERON>(arg0, 6, b"ERON", b"Eron Musk", b"Just a meme, Send it", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/IMG_7180_af270f5e19.jpeg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<ERON>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<ERON>>(v1);
    }

    // decompiled from Move bytecode v6
}

