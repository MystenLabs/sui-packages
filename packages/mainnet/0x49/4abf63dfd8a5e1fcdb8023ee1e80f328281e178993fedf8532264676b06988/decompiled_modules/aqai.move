module 0x494abf63dfd8a5e1fcdb8023ee1e80f328281e178993fedf8532264676b06988::aqai {
    struct AQAI has drop {
        dummy_field: bool,
    }

    fun init(arg0: AQAI, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<AQAI>(arg0, 6, b"AQAI", b"AquaAI on SUI", b"Let's swim, guys! You have just officially joined the AquaAI family. Here, we are not only talking about money but also friends who are passionate about technology. Let's create big waves in the cryptocurrency world together!", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/Ch_AE_a_c_A_t_A_n_500_x_360_px_360_x_360_px_8_68258801b9.gif")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<AQAI>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<AQAI>>(v1);
    }

    // decompiled from Move bytecode v6
}

