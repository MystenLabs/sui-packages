module 0x597cf7e1814cda5fa3838325503c77ee0abce2acda7806dd5fac98579347e0db::mdai {
    struct MDAI has drop {
        dummy_field: bool,
    }

    fun init(arg0: MDAI, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<MDAI>(arg0, 6, b"MDAI", b"MooDengAI", b"Meet Baby Hippo Token  the AI-driven community token reshaping the future! Powered by cutting-edge technology and fueled entirely by its community, this revolutionary token operates independently of Telegram and Twitter. Join us in setting a new standard!", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/Imagem_do_Whats_App_de_2024_10_27_A_s_15_27_32_218fc09c_73327c4cc7.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<MDAI>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<MDAI>>(v1);
    }

    // decompiled from Move bytecode v6
}

