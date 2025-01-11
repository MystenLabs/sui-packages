module 0xbda4bdbd49f79c2bb396e2fe80839016e6ff7c73c5ea0fd9007641099b118c61::yodai {
    struct YODAI has drop {
        dummy_field: bool,
    }

    fun init(arg0: YODAI, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<YODAI>(arg0, 6, b"YODAI", b"Yodai on Sui", x"594f4441493a205468652041492d506f7765726564204d656d6520436f696e0a200a5265766f6c7574696f6e697a696e67207468652043727970746f205370616365", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/Thia_t_ka_ch_AE_a_c_A_t_A_n_12_575dbd16f4.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<YODAI>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<YODAI>>(v1);
    }

    // decompiled from Move bytecode v6
}

