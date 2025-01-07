module 0x35f3c80d51de3b2080bcbab8fdf38c4d17c864c9d33f8ed526c6d56ffd23c18::sbd {
    struct SBD has drop {
        dummy_field: bool,
    }

    fun init(arg0: SBD, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SBD>(arg0, 6, b"SBD", b"SuiBirds", b"A blue bird is SuiBirds $SBD", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/IMG_4004_51c47b1c34.jpeg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SBD>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SBD>>(v1);
    }

    // decompiled from Move bytecode v6
}

