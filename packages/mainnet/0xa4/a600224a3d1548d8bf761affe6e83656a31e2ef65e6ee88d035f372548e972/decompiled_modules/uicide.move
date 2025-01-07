module 0xa4a600224a3d1548d8bf761affe6e83656a31e2ef65e6ee88d035f372548e972::uicide {
    struct UICIDE has drop {
        dummy_field: bool,
    }

    fun init(arg0: UICIDE, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<UICIDE>(arg0, 6, b"UICIDE", b"UICIDE SOCIAL CLUB", b"$UICIDE SOCIAL CLUB is serious about community and mental health support. ", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/1000048617_80941a0f11.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<UICIDE>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<UICIDE>>(v1);
    }

    // decompiled from Move bytecode v6
}

