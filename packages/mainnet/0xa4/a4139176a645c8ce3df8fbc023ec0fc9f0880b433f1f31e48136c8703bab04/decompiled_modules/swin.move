module 0xa4a4139176a645c8ce3df8fbc023ec0fc9f0880b433f1f31e48136c8703bab04::swin {
    struct SWIN has drop {
        dummy_field: bool,
    }

    fun init(arg0: SWIN, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SWIN>(arg0, 6, b"SWIN", b"SUIWIN", b"All degens are out of control, even the same movepump entered VIBE.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/Thia_t_ka_ch_AE_a_c_A_t_A_n_74_aaac444f91.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SWIN>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SWIN>>(v1);
    }

    // decompiled from Move bytecode v6
}

