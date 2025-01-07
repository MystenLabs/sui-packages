module 0x380cfb42996c5c23e3aace3c76cfe8c27b37802b1be07f66277c928d256d3057::peace {
    struct PEACE has drop {
        dummy_field: bool,
    }

    fun init(arg0: PEACE, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<PEACE>(arg0, 6, b"PEACE", b"PeaceONSUI", b"https://peace.vin/", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/M_Fo7_M_Hf_C_400x400_35421a240a.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<PEACE>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<PEACE>>(v1);
    }

    // decompiled from Move bytecode v6
}

