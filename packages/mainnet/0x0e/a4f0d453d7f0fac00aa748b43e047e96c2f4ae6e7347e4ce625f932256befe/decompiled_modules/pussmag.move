module 0xea4f0d453d7f0fac00aa748b43e047e96c2f4ae6e7347e4ce625f932256befe::pussmag {
    struct PUSSMAG has drop {
        dummy_field: bool,
    }

    fun init(arg0: PUSSMAG, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<PUSSMAG>(arg0, 6, b"PUSSMAG", b"Pussy Magnet", b"Pussy Magnet is British slang for something which attracts women.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/Untitledp_22e52daea9.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<PUSSMAG>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<PUSSMAG>>(v1);
    }

    // decompiled from Move bytecode v6
}

