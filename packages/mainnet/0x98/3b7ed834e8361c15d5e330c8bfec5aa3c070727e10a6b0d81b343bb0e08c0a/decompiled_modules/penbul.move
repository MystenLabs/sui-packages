module 0x983b7ed834e8361c15d5e330c8bfec5aa3c070727e10a6b0d81b343bb0e08c0a::penbul {
    struct PENBUL has drop {
        dummy_field: bool,
    }

    fun init(arg0: PENBUL, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<PENBUL>(arg0, 6, b"PENBUL", b"Penguin Bulldog", b"No socials. Community takes over. Send it send it send it.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/IMG_0946_790f2450d9.jpeg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<PENBUL>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<PENBUL>>(v1);
    }

    // decompiled from Move bytecode v6
}

