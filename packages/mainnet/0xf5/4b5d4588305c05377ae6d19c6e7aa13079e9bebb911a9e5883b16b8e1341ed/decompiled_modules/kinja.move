module 0xf54b5d4588305c05377ae6d19c6e7aa13079e9bebb911a9e5883b16b8e1341ed::kinja {
    struct KINJA has drop {
        dummy_field: bool,
    }

    fun init(arg0: KINJA, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<KINJA>(arg0, 6, b"KINJA", b"Kitty Ninja", b"Unleash KINJA  The Kitty Ninja, master of stealth and crypto supremacy!  Forged in the shadows and sharpened by the art of precision, KINJA is a force no chain can contain. ", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/Qm_Z_Vm_Pk_GE_Nwg_Zgq9_RHS_1wn_Toabu_P7_Ms_Am_A4ez_J1eo_XS_Eej_e1a92a2b92.gif")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<KINJA>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<KINJA>>(v1);
    }

    // decompiled from Move bytecode v6
}

