module 0xdb2ec78860edf5491288f8238aae1394c75724528e31756a0db5b17a2eeeb01a::gmcat {
    struct GMCAT has drop {
        dummy_field: bool,
    }

    fun init(arg0: GMCAT, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<GMCAT>(arg0, 6, b"GMCAT", b"GMSUICAT", b"another cat say GM", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/83_H_Dsxu_N_Fnhan_Lgk_Tdij3d_T7t_P5_FH_3bb1_TV_1rb_TT_7atz_0192a8444c.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<GMCAT>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<GMCAT>>(v1);
    }

    // decompiled from Move bytecode v6
}

