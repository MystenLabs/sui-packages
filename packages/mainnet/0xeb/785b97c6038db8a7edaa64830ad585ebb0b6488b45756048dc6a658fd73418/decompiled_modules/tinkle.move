module 0xeb785b97c6038db8a7edaa64830ad585ebb0b6488b45756048dc6a658fd73418::tinkle {
    struct TINKLE has drop {
        dummy_field: bool,
    }

    fun init(arg0: TINKLE, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<TINKLE>(arg0, 6, b"TINKLE", b"Tinkle", x"54696e6b6c65202d2054686520536f756e64206f66205761746572206f6e205375692e20536f6f6e20746f206265202331204d656d65206f6e205375692e20466f7267657420426c75622e204861766520612054696e6b6c652e2e2e0a0a", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/Tinkle_3_96eb9ad0f5_edcb60c873.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<TINKLE>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<TINKLE>>(v1);
    }

    // decompiled from Move bytecode v6
}

