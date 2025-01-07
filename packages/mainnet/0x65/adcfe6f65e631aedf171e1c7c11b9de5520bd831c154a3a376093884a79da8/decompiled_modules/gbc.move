module 0x65adcfe6f65e631aedf171e1c7c11b9de5520bd831c154a3a376093884a79da8::gbc {
    struct GBC has drop {
        dummy_field: bool,
    }

    fun init(arg0: GBC, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<GBC>(arg0, 6, b"GBC", b"GIGA BUTT CHICK", b"NIGGA BUT CHICK", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/header_copy_21e769892e.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<GBC>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<GBC>>(v1);
    }

    // decompiled from Move bytecode v6
}

