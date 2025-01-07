module 0x83a25208c02b16c18ff46458852d5c2924ad6646588ecdaefd9d5610bd6a7cfa::pup {
    struct PUP has drop {
        dummy_field: bool,
    }

    fun init(arg0: PUP, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<PUP>(arg0, 6, b"PUP", b"PUP in a Cup", b"Milo the pomeranian that will bring fun upto billions in Sui", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/IMG_1848_e80de2c4f9.jpeg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<PUP>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<PUP>>(v1);
    }

    // decompiled from Move bytecode v6
}

