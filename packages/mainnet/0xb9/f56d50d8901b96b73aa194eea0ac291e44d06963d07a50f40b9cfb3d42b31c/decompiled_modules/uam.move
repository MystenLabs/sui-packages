module 0xb9f56d50d8901b96b73aa194eea0ac291e44d06963d07a50f40b9cfb3d42b31c::uam {
    struct UAM has drop {
        dummy_field: bool,
    }

    fun init(arg0: UAM, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<UAM>(arg0, 6, b"UAM", b"Unicorn And Mermaid", b"$UAM The story of unicorn and mermaid is about to begin, are you ready ?", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/IMG_20250123_001032_825_647ecda4db.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<UAM>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<UAM>>(v1);
    }

    // decompiled from Move bytecode v6
}

