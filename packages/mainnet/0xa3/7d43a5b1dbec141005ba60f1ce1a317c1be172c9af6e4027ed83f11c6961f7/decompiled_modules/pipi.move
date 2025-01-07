module 0xa37d43a5b1dbec141005ba60f1ce1a317c1be172c9af6e4027ed83f11c6961f7::pipi {
    struct PIPI has drop {
        dummy_field: bool,
    }

    fun init(arg0: PIPI, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<PIPI>(arg0, 6, b"PIPI", b"PIPIPEPE", b"Pipi, Pepe little bro living on the $SUI blockchain ", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/IMG_4431_cf2cf934c6.jpeg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<PIPI>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<PIPI>>(v1);
    }

    // decompiled from Move bytecode v6
}

