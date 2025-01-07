module 0xaf36198f236fec2f22332b17e1a4bbf9274f7ac7e310fa2ac1c9b7296393283e::schat {
    struct SCHAT has drop {
        dummy_field: bool,
    }

    fun init(arg0: SCHAT, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SCHAT>(arg0, 6, b"SCHAT", b"SuiChat", b"SuiChat prioritizes user privacy and security through robust encryption protocols, ensuring confidentiality during communication. Users retain full control over their data, reducing the risk of breaches or unauthorized access.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/IMG_8922_cd1cb6717d.jpeg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SCHAT>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SCHAT>>(v1);
    }

    // decompiled from Move bytecode v6
}

