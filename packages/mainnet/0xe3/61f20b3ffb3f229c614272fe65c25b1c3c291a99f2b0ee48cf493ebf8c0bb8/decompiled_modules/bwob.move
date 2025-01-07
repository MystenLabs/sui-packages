module 0xe361f20b3ffb3f229c614272fe65c25b1c3c291a99f2b0ee48cf493ebf8c0bb8::bwob {
    struct BWOB has drop {
        dummy_field: bool,
    }

    fun init(arg0: BWOB, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<BWOB>(arg0, 6, b"BWOB", b"Bwob sui", b"Bwob always had trouble belonging because he didnt have a shape of his own", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/Qma327za_F3e_Gjph_Je6_Wt9o_Go_Gzb_Wpfurae_Puk_Q5_U_Gqs2fm_6c83ec4ad6.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<BWOB>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<BWOB>>(v1);
    }

    // decompiled from Move bytecode v6
}

