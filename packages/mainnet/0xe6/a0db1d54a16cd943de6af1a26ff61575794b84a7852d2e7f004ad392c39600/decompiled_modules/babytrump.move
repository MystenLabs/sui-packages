module 0xe6a0db1d54a16cd943de6af1a26ff61575794b84a7852d2e7f004ad392c39600::babytrump {
    struct BABYTRUMP has drop {
        dummy_field: bool,
    }

    fun init(arg0: BABYTRUMP, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<BABYTRUMP>(arg0, 6, b"BabyTrump", b"Future crypto president", b"$BabyTrump is the token of the crypto revolution after $Trump, dedicated to empowering the global community and driving decentralized governance and innovative development.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/Qm_WE_58_Gw_LZJ_6h2q_WU_Le_Sdw_Gk5a_SVVXK_588g4_DPZ_Uk_U_Uqe7_1_d7c770824b.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<BABYTRUMP>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<BABYTRUMP>>(v1);
    }

    // decompiled from Move bytecode v6
}

