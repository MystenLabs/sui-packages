module 0x3bcf140e3955c7f828b7546466d57c988e53cb8cb862d9e495d940cf92d44068::suicolor {
    struct SUICOLOR has drop {
        dummy_field: bool,
    }

    fun init(arg0: SUICOLOR, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SUICOLOR>(arg0, 6, b"SUICOLOR", b"SUI MULTICOLOR", b"Sui on multiverse", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/Hw_Ptb_Fpd3_V_Te3tfyoso_Vt_Pf9_W_Pu_Sk5g_A_Kk_N5xp6_Npump_840d7bbb52.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SUICOLOR>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SUICOLOR>>(v1);
    }

    // decompiled from Move bytecode v6
}

