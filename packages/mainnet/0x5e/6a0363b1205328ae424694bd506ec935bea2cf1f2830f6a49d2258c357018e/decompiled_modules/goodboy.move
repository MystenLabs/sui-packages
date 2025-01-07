module 0x5e6a0363b1205328ae424694bd506ec935bea2cf1f2830f6a49d2258c357018e::goodboy {
    struct GOODBOY has drop {
        dummy_field: bool,
    }

    fun init(arg0: GOODBOY, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<GOODBOY>(arg0, 6, b"GoodBoy", b"Bitcoin Dog", x"426974636f696e20646f67206973206120676f6f6420626f792e0a", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/Qm_R_Mf_BB_Phn8_A5_F8f2hop_P_Hn_JNQ_Qtbvidb_Tu5_Q3_Magwopw_H_7912c2edc1.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<GOODBOY>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<GOODBOY>>(v1);
    }

    // decompiled from Move bytecode v6
}

