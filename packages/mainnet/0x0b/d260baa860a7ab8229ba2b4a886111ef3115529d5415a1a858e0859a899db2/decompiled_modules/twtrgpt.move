module 0xbd260baa860a7ab8229ba2b4a886111ef3115529d5415a1a858e0859a899db2::twtrgpt {
    struct TWTRGPT has drop {
        dummy_field: bool,
    }

    fun init(arg0: TWTRGPT, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<TWTRGPT>(arg0, 6, b"TwtrGPT", b"Tweet Terminal", b"Tweet Terminal ", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/Qm_Vx_Qsg_Jg99b_Xrh8x7c4z_V4_Pkpg_EA_Qy5w3cir_Fd_Sgp1_G_Mn_1e0bc98307.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<TWTRGPT>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<TWTRGPT>>(v1);
    }

    // decompiled from Move bytecode v6
}

