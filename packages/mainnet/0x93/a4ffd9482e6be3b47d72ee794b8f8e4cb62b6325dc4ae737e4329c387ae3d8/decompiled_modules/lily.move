module 0x93a4ffd9482e6be3b47d72ee794b8f8e4cb62b6325dc4ae737e4329c387ae3d8::lily {
    struct LILY has drop {
        dummy_field: bool,
    }

    fun init(arg0: LILY, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<LILY>(arg0, 6, b"LILY", b"LILY  | THE GOLD DIGGER", x"5368652057616e74732049742c2053686520476574732049740a0a53686520506c6179732c20546865792050617920", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/Ehr9_Mn5wt_Ex4_Bk_ZJR_8_M_Ky7m_Ka_Uu_G_Dx_W_Mworvz5_Vvpump_013f8088d2.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<LILY>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<LILY>>(v1);
    }

    // decompiled from Move bytecode v6
}

