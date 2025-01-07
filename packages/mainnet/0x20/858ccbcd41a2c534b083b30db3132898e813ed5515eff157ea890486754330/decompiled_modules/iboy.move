module 0x20858ccbcd41a2c534b083b30db3132898e813ed5515eff157ea890486754330::iboy {
    struct IBOY has drop {
        dummy_field: bool,
    }

    fun init(arg0: IBOY, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<IBOY>(arg0, 6, b"IBOY", b"IBOY SUI", b"The collection was created by iBoy", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/IMG_6523_9864420ffb.JPG")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<IBOY>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<IBOY>>(v1);
    }

    // decompiled from Move bytecode v6
}

