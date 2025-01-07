module 0xe15a3f999ed00702d8daebeb613ad6491adf4e0d1f9dce50818f7a31dc168fc1::vinu {
    struct VINU has drop {
        dummy_field: bool,
    }

    fun init(arg0: VINU, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<VINU>(arg0, 6, b"VINU", b"Vita Inu", b"Vita Inu (VINU) is the worlds first fast and feeless dog coin with high TPS and native smart contracts.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/HEC_Zgs7un_Jt_J2626a1_FV_4_Bnm_Vr5_Bphu_Z_Wob_Vavdmp_Yn_Y_7d7a9d6369.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<VINU>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<VINU>>(v1);
    }

    // decompiled from Move bytecode v6
}

