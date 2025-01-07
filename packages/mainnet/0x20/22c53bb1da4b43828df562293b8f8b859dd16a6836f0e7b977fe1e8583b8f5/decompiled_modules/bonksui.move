module 0x2022c53bb1da4b43828df562293b8f8b859dd16a6836f0e7b977fe1e8583b8f5::bonksui {
    struct BONKSUI has drop {
        dummy_field: bool,
    }

    fun init(arg0: BONKSUI, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<BONKSUI>(arg0, 6, b"BONKSUI", b"BONK ON SUI", x"4c6574277320656e6a6f7920796f757220426f6e6b2e0a0a", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/IMG_5848_13ad2dda13.jpeg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<BONKSUI>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<BONKSUI>>(v1);
    }

    // decompiled from Move bytecode v6
}

