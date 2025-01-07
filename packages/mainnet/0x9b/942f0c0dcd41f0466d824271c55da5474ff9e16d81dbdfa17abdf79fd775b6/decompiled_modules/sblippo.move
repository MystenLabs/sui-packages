module 0x9b942f0c0dcd41f0466d824271c55da5474ff9e16d81dbdfa17abdf79fd775b6::sblippo {
    struct SBLIPPO has drop {
        dummy_field: bool,
    }

    fun init(arg0: SBLIPPO, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SBLIPPO>(arg0, 6, b"SBLIPPO", b"SUI BLIPPO", b"The best dog on SUI, BLIP. Community Take Over", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/Thia_t_ka_ch_AE_a_c_A_t_A_n_30_edb12e3658.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SBLIPPO>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SBLIPPO>>(v1);
    }

    // decompiled from Move bytecode v6
}

