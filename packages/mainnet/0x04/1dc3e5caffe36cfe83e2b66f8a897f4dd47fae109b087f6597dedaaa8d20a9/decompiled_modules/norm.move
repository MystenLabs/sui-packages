module 0x41dc3e5caffe36cfe83e2b66f8a897f4dd47fae109b087f6597dedaaa8d20a9::norm {
    struct NORM has drop {
        dummy_field: bool,
    }

    fun init(arg0: NORM, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<NORM>(arg0, 6, b"NORM", b"Norm", x"697473206f6b20746f206265206e6f726d616c3b206265206c696b65206e6f726d2e0a", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/Qm_QPS_4b_Gk6r_Mv_L_Brmac_BQZW_Ro_PG_Bc_AMHHW_Fd2_Eqw9d_J2mq_29d34ab649.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<NORM>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<NORM>>(v1);
    }

    // decompiled from Move bytecode v6
}

