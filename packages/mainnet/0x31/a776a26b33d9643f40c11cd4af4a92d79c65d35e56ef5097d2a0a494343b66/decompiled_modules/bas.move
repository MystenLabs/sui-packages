module 0x31a776a26b33d9643f40c11cd4af4a92d79c65d35e56ef5097d2a0a494343b66::bas {
    struct BAS has drop {
        dummy_field: bool,
    }

    fun init(arg0: BAS, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<BAS>(arg0, 6, b"BAS", b"BossAI on Sui", b"\"BOSS AI: AI power, Sui power\"", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/Ch_AE_a_c_A_t_A_n_500_x_500_px_1_901a38f75d.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<BAS>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<BAS>>(v1);
    }

    // decompiled from Move bytecode v6
}

