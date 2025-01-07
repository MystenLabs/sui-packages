module 0xf5ef48bf5cbb757f7678f3b12c495e75b3495cbc80139e4504f51a0cb035bc6::ms {
    struct MS has drop {
        dummy_field: bool,
    }

    fun init(arg0: MS, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<MS>(arg0, 6, b"MS", b"mfer sui", x"4d616b65206d66657220677265617420616761696e206f6e207375692c0a626c756520726570726573656e747320746865207365612e", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/1727860269384_0709b2a9ea.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<MS>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<MS>>(v1);
    }

    // decompiled from Move bytecode v6
}

