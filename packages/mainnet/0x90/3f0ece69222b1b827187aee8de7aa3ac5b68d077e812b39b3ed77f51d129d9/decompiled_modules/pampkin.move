module 0x903f0ece69222b1b827187aee8de7aa3ac5b68d077e812b39b3ed77f51d129d9::pampkin {
    struct PAMPKIN has drop {
        dummy_field: bool,
    }

    fun init(arg0: PAMPKIN, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<PAMPKIN>(arg0, 6, b"PAMPKIN", b"Pampkin", b"Pampkin Halloween  token", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/Qm_TS_Tf7_X4_Wk_X7o2_N_Cp_Hpc_K_Hk_C6e5ty7hxz_Ln_NSX_1cmj4_UV_7a8199ab4c.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<PAMPKIN>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<PAMPKIN>>(v1);
    }

    // decompiled from Move bytecode v6
}

