module 0xde9d8a3a7852e5bd0055990dfeb9f1d99a2786f052fc620b68dc01df161d3b61::bunni {
    struct BUNNI has drop {
        dummy_field: bool,
    }

    fun init(arg0: BUNNI, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<BUNNI>(arg0, 6, b"BUNNI", b"BUNNISUI", b"$BUNI", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/Qme_Ljr_V_Lc_BXR_Wmc_Xzc_G_Npy_S8_Zbaqjy_GTSW_Lneb_W2ka_U8fv_235eb6c2e0.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<BUNNI>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<BUNNI>>(v1);
    }

    // decompiled from Move bytecode v6
}

