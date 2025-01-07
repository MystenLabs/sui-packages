module 0x5b40e9a1bc2b391ad3cd7401cb4f86b0b619a396fde2596fe0f5248ee07842c3::puppeth {
    struct PUPPETH has drop {
        dummy_field: bool,
    }

    fun init(arg0: PUPPETH, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<PUPPETH>(arg0, 6, b"Puppeth", b"Puppeth Sui", b"First Mascot on Sui", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/G_Yw_Tks_T_Xw_A_Ayi3_P_7bf612eda8.jfif")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<PUPPETH>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<PUPPETH>>(v1);
    }

    // decompiled from Move bytecode v6
}

