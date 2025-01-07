module 0xf0214542203271868b9da79433ea9ac954bc0a6881116e7c6f46c413aef44830::trip {
    struct TRIP has drop {
        dummy_field: bool,
    }

    fun init(arg0: TRIP, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<TRIP>(arg0, 6, b"TRIP", b"TRIP on SUI", b"Dont Trip on Trip ", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/Qm_Vo3_R_Grv9a_Z_Kk_Y8_BURK_Urz_Ptuk_Fz_Vawc_Wri_Xc7c_Ynzo_D6_851a83bbee.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<TRIP>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<TRIP>>(v1);
    }

    // decompiled from Move bytecode v6
}

