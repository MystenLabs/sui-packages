module 0x163aa70b5e37253a06cdf171606d8eacef7916b0b80ea43bf9f0f80bf0d6f485::grbot {
    struct GRBOT has drop {
        dummy_field: bool,
    }

    fun init(arg0: GRBOT, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<GRBOT>(arg0, 6, b"GRBOT", b"GOROBOT ON SUI", b"And remember with $GRBOT, the sky's not the limit - it's just the beginning!", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/Thia_t_ka_ch_AE_a_c_A_t_A_n_2_9e15135afa.gif")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<GRBOT>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<GRBOT>>(v1);
    }

    // decompiled from Move bytecode v6
}

