module 0xac11e4051062ceea0c3b7c3122ba279920b43b1bb40ad301f54feab6be12360c::fsc {
    struct FSC has drop {
        dummy_field: bool,
    }

    fun init(arg0: FSC, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<FSC>(arg0, 6, b"FSC", b"FROG SMOKING CIGARETTE", b"GUD TEK THE FROG IS SMOKING A CIGGY! ", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/IMG_4627_a75adea0c4.jpeg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<FSC>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<FSC>>(v1);
    }

    // decompiled from Move bytecode v6
}

