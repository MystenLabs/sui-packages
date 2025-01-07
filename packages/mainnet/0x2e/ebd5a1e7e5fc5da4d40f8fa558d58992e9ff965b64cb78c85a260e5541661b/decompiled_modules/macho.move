module 0x2eebd5a1e7e5fc5da4d40f8fa558d58992e9ff965b64cb78c85a260e5541661b::macho {
    struct MACHO has drop {
        dummy_field: bool,
    }

    fun init(arg0: MACHO, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<MACHO>(arg0, 6, b"MACHO", b"Machomadness", b"Viral Video of Macho: https://www.tiktok.com/t/ZTYseyEBK/", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/Qmaj_QLQCLS_76fy_Rsje_Ekm_FD_Vi_NF_Vn75_Y_Nuh_Z_Bzps2wxbf_R_1_1_6a90c874e3.gif")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<MACHO>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<MACHO>>(v1);
    }

    // decompiled from Move bytecode v6
}

