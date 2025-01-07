module 0x4c69f4ff8e4c2d6777442723f8bf9f9f80070fc0c2c94bb24e53c6be4b37e7cc::hippoween {
    struct HIPPOWEEN has drop {
        dummy_field: bool,
    }

    fun init(arg0: HIPPOWEEN, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<HIPPOWEEN>(arg0, 6, b"Hippoween", b"Halloween Hippo", b"halloween coming soon...", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/G_Zjn_Z8_U_Wc_Ag23n_P_0844bae335.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<HIPPOWEEN>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<HIPPOWEEN>>(v1);
    }

    // decompiled from Move bytecode v6
}

