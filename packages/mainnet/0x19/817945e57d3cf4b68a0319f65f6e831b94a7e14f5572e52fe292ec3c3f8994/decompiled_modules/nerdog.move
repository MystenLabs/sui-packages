module 0x19817945e57d3cf4b68a0319f65f6e831b94a7e14f5572e52fe292ec3c3f8994::nerdog {
    struct NERDOG has drop {
        dummy_field: bool,
    }

    fun init(arg0: NERDOG, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<NERDOG>(arg0, 6, b"NERDOG", b"NerDoggo", b"Such a Nerd!", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/Qm_Xgj7_N_Qr_XQ_Ymzdpd2j_F1_Rp_LFA_5_NSY_6j_Xg_Woz55_Aez_VUHU_549b5d3267.jpeg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<NERDOG>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<NERDOG>>(v1);
    }

    // decompiled from Move bytecode v6
}

