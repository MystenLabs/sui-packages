module 0xeda2346c4d8da26ccc3c87f947cf406a68108ef978f43df866401b4bb4f43b1a::pumplections {
    struct PUMPLECTIONS has drop {
        dummy_field: bool,
    }

    fun init(arg0: PUMPLECTIONS, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<PUMPLECTIONS>(arg0, 6, b"Pumplections", b"SuperElections", x"42757920666f72205472756d700a53656c6c20696620796f752067617920", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/Qmf_Wqdjtxvd_Lgmek_L_Hq_G8boi_Vg5j_W_Br9_Vqh_A7_G_Fs_Fcmsa_V_95a2efb1ae.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<PUMPLECTIONS>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<PUMPLECTIONS>>(v1);
    }

    // decompiled from Move bytecode v6
}

