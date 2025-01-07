module 0x4b83ebafb58c7488055ad76e7080f2a7cf357052e7c429ec3ea8d428bfaaecf1::itch {
    struct ITCH has drop {
        dummy_field: bool,
    }

    fun init(arg0: ITCH, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<ITCH>(arg0, 6, b"ITCH", b"The mosquito that bit me", b"Join our community and share your memes!", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/Qmak_Gua_B27_Gw_W6_Xa_E4e_Z4j7f3dh_MYL_2_G91_Vi_SKTW_Ui_C_Sx_Z_9b2001ac28.gif")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<ITCH>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<ITCH>>(v1);
    }

    // decompiled from Move bytecode v6
}

