module 0x4be51531287d4507b797d8971968041a6a098ad40a1f3dc6b323e4008d619e8::cos {
    struct COS has drop {
        dummy_field: bool,
    }

    fun init(arg0: COS, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<COS>(arg0, 6, b"COS", b"Color on SUI", b"MEME of SUI.  Lets make SUI truly colorful!", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/Hw_Ptb_Fpd3_V_Te3tfyoso_Vt_Pf9_W_Pu_Sk5g_A_Kk_N5xp6_Npump_2d5d33bb11.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<COS>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<COS>>(v1);
    }

    // decompiled from Move bytecode v6
}

