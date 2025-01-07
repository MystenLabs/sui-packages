module 0xa23f41b09c582a43ce0d9b66b4262cd6b3df9e5f9d6a6bd94ff1120bb1594870::trip {
    struct TRIP has drop {
        dummy_field: bool,
    }

    fun init(arg0: TRIP, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<TRIP>(arg0, 6, b"TRIP", b"TRIP on SUI", b"DONT TRIP ON TRIP", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/Qm_Vo3_R_Grv9a_Z_Kk_Y8_BURK_Urz_Ptuk_Fz_Vawc_Wri_Xc7c_Ynzo_D6_a0f333a786.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<TRIP>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<TRIP>>(v1);
    }

    // decompiled from Move bytecode v6
}

