module 0x1fd4a8ace51126b4930395f2f62ebf2235cc34c5858ea89d3f322613f8dbaecb::strump {
    struct STRUMP has drop {
        dummy_field: bool,
    }

    fun init(arg0: STRUMP, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<STRUMP>(arg0, 6, b"STRUMP", b"Super President Trump", b"Meet New US President : Super President Trump ! The prophecy has been fulfilled! President Super Trump ! Community Driven & Memecoin on solana Ecosystem Donald Trump fell to Earth from space in 1946. He served as president of the United States between 2017 and 2021 to save the world. He was thinking of retiring, but he thought the world needed him again and became president of the United States again. This project was created to celebrate Trump's presidency and is a large community behind those who support him. ", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/Qm_Zo_Axz_N_Hw1q_Y5_X4a_Znj_Nqk5_ZVKVZ_2_A8zu_N2gv_Rx_GA_1_E_Ec_a0931be6e7.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<STRUMP>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<STRUMP>>(v1);
    }

    // decompiled from Move bytecode v6
}

