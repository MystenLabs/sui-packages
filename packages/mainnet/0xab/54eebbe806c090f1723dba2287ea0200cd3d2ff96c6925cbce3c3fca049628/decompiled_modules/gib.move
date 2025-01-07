module 0xab54eebbe806c090f1723dba2287ea0200cd3d2ff96c6925cbce3c3fca049628::gib {
    struct GIB has drop {
        dummy_field: bool,
    }

    fun init(arg0: GIB, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<GIB>(arg0, 6, b"GIB", b"Gib!", x"4e4556455220455645522047494220594f55520a53454544205048524153450a4f520a4d4f4d2753204f462e", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/Captura_de_Tela_2024_10_13_a_I_s_23_55_33_1734adb647.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<GIB>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<GIB>>(v1);
    }

    // decompiled from Move bytecode v6
}

