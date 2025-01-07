module 0x9d33cc3004ed65e541100447e87e43040cd39930ec31d6fcb2419af4f19c56d0::gun {
    struct GUN has drop {
        dummy_field: bool,
    }

    fun init(arg0: GUN, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<GUN>(arg0, 6, b"GUN", b"GUNTHER VI", x"47756e7468657220564920697320746865207269636865737420646f6720616c697665206f6e2065617274682e0a", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/GU_Ne_L5fh_Ac_Tk9_Hca_G3_PP_Xxd_K7p_Si_HN_Cgmio_P_Ju_Dh_Cnq_Q_6584b5c8f2.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<GUN>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<GUN>>(v1);
    }

    // decompiled from Move bytecode v6
}

