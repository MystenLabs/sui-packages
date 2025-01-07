module 0x301bd27a604b116bfc14bed0c6b1dedc97e3cea55a33d0c56544846edbf432af::gonsui {
    struct GONSUI has drop {
        dummy_field: bool,
    }

    fun init(arg0: GONSUI, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<GONSUI>(arg0, 6, b"GONSUI", b"GONDOLA SUI", x"23476f6e646f6c612c207468652063756c747572616c2069636f6e20696e20686967682d776169737465642070616e74732e0a", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/9l_OBG_Dwd_400x400_1_5ad9c56d7e.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<GONSUI>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<GONSUI>>(v1);
    }

    // decompiled from Move bytecode v6
}

