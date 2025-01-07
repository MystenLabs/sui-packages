module 0xc846a6bf2166c377a041f5ee8f3883dfb552814ce4ed882b1fabbf696c76c393::jellycat {
    struct JELLYCAT has drop {
        dummy_field: bool,
    }

    fun init(arg0: JELLYCAT, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<JELLYCAT>(arg0, 6, b"JELLYCAT", b"POKI", x"4a454c4c59204341542049532054484520504f4b49204f46204a4150414e0a", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/Qm_Wpmufvfzf8_U7hu_WE_Uz_KPG_Jurct_KK_Sqd_GK_Fz5_Mp_Csu_Sc6_ceb355247f.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<JELLYCAT>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<JELLYCAT>>(v1);
    }

    // decompiled from Move bytecode v6
}

