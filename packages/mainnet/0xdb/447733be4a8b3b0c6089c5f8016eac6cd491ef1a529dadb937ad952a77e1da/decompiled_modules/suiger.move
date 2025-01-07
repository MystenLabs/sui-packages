module 0xdb447733be4a8b3b0c6089c5f8016eac6cd491ef1a529dadb937ad952a77e1da::suiger {
    struct SUIGER has drop {
        dummy_field: bool,
    }

    fun init(arg0: SUIGER, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SUIGER>(arg0, 6, b"SUIger", b"SUIGER", b"LFG BUY SUIGER FOR RICH ", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/Thia_t_ka_ch_AE_a_c_A_t_A_n_92_2ca4a29b29.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SUIGER>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SUIGER>>(v1);
    }

    // decompiled from Move bytecode v6
}

