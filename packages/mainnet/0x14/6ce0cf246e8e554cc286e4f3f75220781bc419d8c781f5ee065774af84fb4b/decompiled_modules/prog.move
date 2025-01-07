module 0x146ce0cf246e8e554cc286e4f3f75220781bc419d8c781f5ee065774af84fb4b::prog {
    struct PROG has drop {
        dummy_field: bool,
    }

    fun init(arg0: PROG, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<PROG>(arg0, 6, b"PROG", b"Pop Frog", b"The frog that pops. IYKYK", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/Qm_Zfmjm_Vkgnk7m_Yg_Ac_Cn_Gv8gip_Ycnhab_U5azdt_V1ya_Xfc7_54ab536644.gif")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<PROG>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<PROG>>(v1);
    }

    // decompiled from Move bytecode v6
}

