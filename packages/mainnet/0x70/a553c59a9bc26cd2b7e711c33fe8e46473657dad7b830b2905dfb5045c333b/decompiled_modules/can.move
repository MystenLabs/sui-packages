module 0x70a553c59a9bc26cd2b7e711c33fe8e46473657dad7b830b2905dfb5045c333b::can {
    struct CAN has drop {
        dummy_field: bool,
    }

    fun init(arg0: CAN, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<CAN>(arg0, 6, b"CAN", b"Can of Sui", b"It's just a can of Sui", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/Soup_afdc4d025e.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<CAN>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<CAN>>(v1);
    }

    // decompiled from Move bytecode v6
}

