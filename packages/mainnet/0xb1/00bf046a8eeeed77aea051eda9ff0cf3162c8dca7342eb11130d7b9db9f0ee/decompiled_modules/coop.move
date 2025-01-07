module 0xb100bf046a8eeeed77aea051eda9ff0cf3162c8dca7342eb11130d7b9db9f0ee::coop {
    struct COOP has drop {
        dummy_field: bool,
    }

    fun init(arg0: COOP, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<COOP>(arg0, 6, b"COOP", b"COOPER", x"20436f6f706572206973207468652063757465737420646f67206f6e20536f6c616e612c20616e6420686973206d697373696f6e20697320746f206d616b65206d696c6c696f6e7320616e642062696c6c696f6e7321200a", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/Qm_P8s4_HFP_Dbg_Kuic_Sz_N_Ud_Qhek_Ry4u16_Wtt_Tdap_V2_UZ_Bq_Zo_035e34e3ab.gif")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<COOP>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<COOP>>(v1);
    }

    // decompiled from Move bytecode v6
}

