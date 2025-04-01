module 0x7d63709e1e0bae2e2a67bb4da96932b71aa623c3409cb4ec2917802919dc16cb::unkown {
    struct UNKOWN has drop {
        dummy_field: bool,
    }

    fun init(arg0: UNKOWN, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<UNKOWN>(arg0, 6, b"UNKOWN", b"?", b"? ???? ??? ???, ???? ???", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/IMG_6717_bf0c4eb7ac.jpeg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<UNKOWN>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<UNKOWN>>(v1);
    }

    // decompiled from Move bytecode v6
}

