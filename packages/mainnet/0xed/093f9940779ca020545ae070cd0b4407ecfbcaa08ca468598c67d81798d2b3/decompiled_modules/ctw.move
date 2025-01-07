module 0xed093f9940779ca020545ae070cd0b4407ecfbcaa08ca468598c67d81798d2b3::ctw {
    struct CTW has drop {
        dummy_field: bool,
    }

    fun init(arg0: CTW, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<CTW>(arg0, 6, b"CTW", b"CatWar", x"4361745761720a404361745761724f6e535549", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/X_rf_IA_Hv_400x400_c46ccf9847.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<CTW>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<CTW>>(v1);
    }

    // decompiled from Move bytecode v6
}

