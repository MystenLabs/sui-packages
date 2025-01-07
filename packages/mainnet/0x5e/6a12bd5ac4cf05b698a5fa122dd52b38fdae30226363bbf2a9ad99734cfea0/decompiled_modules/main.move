module 0x5e6a12bd5ac4cf05b698a5fa122dd52b38fdae30226363bbf2a9ad99734cfea0::main {
    struct MAIN has drop {
        dummy_field: bool,
    }

    fun init(arg0: MAIN, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<MAIN>(arg0, 6, b"MAIN", b"Main Character", b"Fuck everything, I'm the main character", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/Ho_Cunqc_Wb8b3_Ptu_X8a_Pvv_F3_R2n_Cmfjm_Tj32z_Sg_Svpump_dddb00ad68.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<MAIN>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<MAIN>>(v1);
    }

    // decompiled from Move bytecode v6
}

