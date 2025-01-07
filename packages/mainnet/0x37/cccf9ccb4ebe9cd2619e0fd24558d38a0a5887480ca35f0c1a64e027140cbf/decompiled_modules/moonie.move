module 0x37cccf9ccb4ebe9cd2619e0fd24558d38a0a5887480ca35f0c1a64e027140cbf::moonie {
    struct MOONIE has drop {
        dummy_field: bool,
    }

    fun init(arg0: MOONIE, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<MOONIE>(arg0, 6, b"MOONIE", b"MOONIESUI", b"CHECK OUT  MOONIE", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/Thia_t_ka_ch_AE_a_c_A_t_A_n_22_6b36343ea0.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<MOONIE>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<MOONIE>>(v1);
    }

    // decompiled from Move bytecode v6
}

