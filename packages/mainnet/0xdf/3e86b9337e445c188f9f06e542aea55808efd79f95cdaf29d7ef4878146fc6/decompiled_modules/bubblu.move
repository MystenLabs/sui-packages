module 0xdf3e86b9337e445c188f9f06e542aea55808efd79f95cdaf29d7ef4878146fc6::bubblu {
    struct BUBBLU has drop {
        dummy_field: bool,
    }

    fun init(arg0: BUBBLU, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<BUBBLU>(arg0, 6, b"BUBBLU", b"Bubblu on Sui", b"Join Bubblu on his Sui adventures.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/Hh18zh_Bu2q_MA_Cm52_Thf_M_Yn_X6ks8_B1zu_Qus3nxe_Z_Dpump_2c2cb1c3bd.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<BUBBLU>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<BUBBLU>>(v1);
    }

    // decompiled from Move bytecode v6
}

