module 0xe43f5c2209502dc4d6ef9f47015092b80c85208bda0d1baf22267ed3a5dfdd5e::scheeks {
    struct SCHEEKS has drop {
        dummy_field: bool,
    }

    fun init(arg0: SCHEEKS, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SCHEEKS>(arg0, 6, b"SCHEEKS", b"SUICHEEKS", b"Memes to follow $SCHEEKS", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/Thia_t_ka_ch_AE_a_c_A_t_A_n_23_57ea2347d0.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SCHEEKS>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SCHEEKS>>(v1);
    }

    // decompiled from Move bytecode v6
}

