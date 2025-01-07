module 0x8095ed183eb78f81163b760d5e6bf8638790da7aec5dc3b2bf0273e1c950b028::shege {
    struct SHEGE has drop {
        dummy_field: bool,
    }

    fun init(arg0: SHEGE, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SHEGE>(arg0, 6, b"SHEGE", b"SUIHEGE", x"486567652069732061206d656d6520776974682061207375692e2e2e0a", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/Thia_t_ka_ch_AE_a_c_A_t_A_n_66_2bc753a04b.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SHEGE>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SHEGE>>(v1);
    }

    // decompiled from Move bytecode v6
}

