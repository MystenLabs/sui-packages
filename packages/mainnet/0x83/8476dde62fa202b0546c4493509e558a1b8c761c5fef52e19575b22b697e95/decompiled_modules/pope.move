module 0x838476dde62fa202b0546c4493509e558a1b8c761c5fef52e19575b22b697e95::pope {
    struct POPE has drop {
        dummy_field: bool,
    }

    fun init(arg0: POPE, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<POPE>(arg0, 6, b"POPE", b"POPE SUI", b"pope is meme like popcat LFGGG", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/Cose_JDE_Hxsfjj_Qs5_Ca_XW_Gd4_PH_2ir_Ham2_Fxeuw_N2jy_AL_9_5c548ae7dd.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<POPE>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<POPE>>(v1);
    }

    // decompiled from Move bytecode v6
}

