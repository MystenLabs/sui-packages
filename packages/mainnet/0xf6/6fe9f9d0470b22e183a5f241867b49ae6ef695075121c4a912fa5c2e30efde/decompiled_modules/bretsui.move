module 0xf66fe9f9d0470b22e183a5f241867b49ae6ef695075121c4a912fa5c2e30efde::bretsui {
    struct BRETSUI has drop {
        dummy_field: bool,
    }

    fun init(arg0: BRETSUI, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<BRETSUI>(arg0, 6, b"BRETSUI", b"BRET SUI", b"THE BITCH GIRL SUI.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/IMG_3634_172b4c16cd.jpeg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<BRETSUI>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<BRETSUI>>(v1);
    }

    // decompiled from Move bytecode v6
}

