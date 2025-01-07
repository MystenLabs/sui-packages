module 0xc6cab5ec4e40a6eac11c2fdf68e9e01dd118bea2fae6271d2f2ae670baa0c18::neiros {
    struct NEIROS has drop {
        dummy_field: bool,
    }

    fun init(arg0: NEIROS, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<NEIROS>(arg0, 6, b"NEIROS", b"NEIRO SUI", b"Neiro, meaning the color of sound, is a rescue dog adopted by @kabosumama.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/Thia_t_ka_ch_AE_a_c_A_t_A_n_87_d1ec6d7177.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<NEIROS>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<NEIROS>>(v1);
    }

    // decompiled from Move bytecode v6
}

