module 0xe685dc500ca518d0383913c2831425b054ff568a14dc987b4de9a82fafb01b65::marvin {
    struct MARVIN has drop {
        dummy_field: bool,
    }

    fun init(arg0: MARVIN, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<MARVIN>(arg0, 6, b"MARVIN", b"Marvin's Voyage", b"https://x.com/marvinsvoyage", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/Qm_XBP_Chw2w8h_Q1_FZ_1_Je7_Cbmqx7yqif_Qj_Zkqt_D6c_K2_Jap_Rr_d6426f5eba.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<MARVIN>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<MARVIN>>(v1);
    }

    // decompiled from Move bytecode v6
}

