module 0xa6a902c5d60855302d4ed503712a767dec11c085894a6ca9085baebef52120dc::hack {
    struct HACK has drop {
        dummy_field: bool,
    }

    fun init(arg0: HACK, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<HACK>(arg0, 6, b"Hack", b"Cetus Hack", b"We know the truth.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/IMG_0150_e7f0788aa6.jpeg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<HACK>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<HACK>>(v1);
    }

    // decompiled from Move bytecode v6
}

