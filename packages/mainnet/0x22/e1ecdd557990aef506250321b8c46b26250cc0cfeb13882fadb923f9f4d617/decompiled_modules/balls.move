module 0x22e1ecdd557990aef506250321b8c46b26250cc0cfeb13882fadb923f9f4d617::balls {
    struct BALLS has drop {
        dummy_field: bool,
    }

    fun init(arg0: BALLS, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<BALLS>(arg0, 6, b"BALLS", b"Must Have Balls", b"You MUST have BALLS to buy this!", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/009b54ea_7598_4c65_bb08_7c09fcd89029_e88f0ec487.jpeg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<BALLS>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<BALLS>>(v1);
    }

    // decompiled from Move bytecode v6
}

