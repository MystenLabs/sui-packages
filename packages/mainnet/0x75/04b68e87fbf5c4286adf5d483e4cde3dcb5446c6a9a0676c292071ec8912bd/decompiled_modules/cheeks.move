module 0x7504b68e87fbf5c4286adf5d483e4cde3dcb5446c6a9a0676c292071ec8912bd::cheeks {
    struct CHEEKS has drop {
        dummy_field: bool,
    }

    fun init(arg0: CHEEKS, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<CHEEKS>(arg0, 6, b"CHEEKS", b"CHEEKS SUI", x"5468652070656f706c657320636f696e21204a6f696e20746865207265766f6c7574696f6e210a", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/Thia_t_ka_ch_AE_a_c_A_t_A_n_23_8611bf3dab.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<CHEEKS>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<CHEEKS>>(v1);
    }

    // decompiled from Move bytecode v6
}

