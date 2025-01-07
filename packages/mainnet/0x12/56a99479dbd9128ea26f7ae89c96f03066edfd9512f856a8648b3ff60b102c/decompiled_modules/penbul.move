module 0x1256a99479dbd9128ea26f7ae89c96f03066edfd9512f856a8648b3ff60b102c::penbul {
    struct PENBUL has drop {
        dummy_field: bool,
    }

    fun init(arg0: PENBUL, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<PENBUL>(arg0, 6, b"PENBUL", b"Penguin Bulldog", b"No socials. Community takes over. Send it send it send it", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/IMG_0946_a5970be3d8.jpeg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<PENBUL>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<PENBUL>>(v1);
    }

    // decompiled from Move bytecode v6
}

