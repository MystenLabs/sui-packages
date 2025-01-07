module 0x2744fd474dcd8ebf0b20cbbdf93fcd5812f8c4f4077505a554643f940afffbde::hobbit {
    struct HOBBIT has drop {
        dummy_field: bool,
    }

    fun init(arg0: HOBBIT, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<HOBBIT>(arg0, 6, b"Hobbit", b"HOPBIT", b"...", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/IMG_0157_a9ba473fae.jpeg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<HOBBIT>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<HOBBIT>>(v1);
    }

    // decompiled from Move bytecode v6
}

