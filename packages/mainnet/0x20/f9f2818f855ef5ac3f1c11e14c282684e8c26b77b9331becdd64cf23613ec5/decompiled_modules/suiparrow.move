module 0x20f9f2818f855ef5ac3f1c11e14c282684e8c26b77b9331becdd64cf23613ec5::suiparrow {
    struct SUIPARROW has drop {
        dummy_field: bool,
    }

    fun init(arg0: SUIPARROW, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SUIPARROW>(arg0, 6, b"SUIPARROW", b"Jack Suiparrow", b"Jack Suiparrow On Sui", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/IMG_1105_59e0ef4e46.jpeg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SUIPARROW>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SUIPARROW>>(v1);
    }

    // decompiled from Move bytecode v6
}

