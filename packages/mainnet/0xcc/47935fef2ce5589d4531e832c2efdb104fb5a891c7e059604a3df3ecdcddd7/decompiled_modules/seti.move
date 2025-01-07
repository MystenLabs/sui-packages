module 0xcc47935fef2ce5589d4531e832c2efdb104fb5a891c7e059604a3df3ecdcddd7::seti {
    struct SETI has drop {
        dummy_field: bool,
    }

    fun init(arg0: SETI, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SETI>(arg0, 6, b"SETI", b"SETI SUI", b"SETI NOW MONKEY ON SUI", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/Thia_t_ka_ch_AE_a_c_A_t_A_n_2024_10_21_T194620_300_60c679cdd9.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SETI>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SETI>>(v1);
    }

    // decompiled from Move bytecode v6
}

