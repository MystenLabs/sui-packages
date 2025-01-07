module 0xcf6ce9be760423f33bf40778e9885776bb24f0f4479d743be4ff89d8be8d57db::pxtrump {
    struct PXTRUMP has drop {
        dummy_field: bool,
    }

    fun init(arg0: PXTRUMP, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<PXTRUMP>(arg0, 6, b"PXTRUMP", b"Pixel Trump", b"Pampy trumpy lfg", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/Qm_Rc_NZ_6_Ratcp8b4s_EPF_9_J_Pizme4b61rs8poz_Cmm_Qujiwga_0e8e4f27a4.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<PXTRUMP>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<PXTRUMP>>(v1);
    }

    // decompiled from Move bytecode v6
}

