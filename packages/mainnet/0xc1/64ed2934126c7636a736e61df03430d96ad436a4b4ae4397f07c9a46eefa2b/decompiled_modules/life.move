module 0xc164ed2934126c7636a736e61df03430d96ad436a4b4ae4397f07c9a46eefa2b::life {
    struct LIFE has drop {
        dummy_field: bool,
    }

    fun init(arg0: LIFE, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<LIFE>(arg0, 6, b"LIFE", b"Life Search AI", x"417374726120697320616e2041492d706f776572656420677561726469616e206578706c6f72696e6720686162697461626c6520776f726c647320666f72206c69666520616e64206d6f6e69746f72696e6720456172746820666f7220636f736d696320746872656174730a", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/Qm_N_Xmyzsz_Y_Qz_P66qnu_Cw_Af_Nn_Egz4c_Qw_B_Bwjcsyz_Xxn_A48i_48d7b825e4.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<LIFE>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<LIFE>>(v1);
    }

    // decompiled from Move bytecode v6
}

