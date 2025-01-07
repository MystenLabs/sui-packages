module 0xc5b89faf1ea43658711fa1ae4e58ae7305a0688bf313cc3822c5b18ae7814ee1::wdog {
    struct WDOG has drop {
        dummy_field: bool,
    }

    fun init(arg0: WDOG, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<WDOG>(arg0, 6, b"wDOG", b"WrappedDog", b"WrappedDog is wDOG on Sui, Will be the next shitcoinmooners on Sui memecoin", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/Qm_YZTR_6fus_R_Lr_St7_C4_Br_W_Qe_HP_8k_Wp_Ey2pz_Ed_Ntjfm_Tx_Sn3_d7edc10265.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<WDOG>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<WDOG>>(v1);
    }

    // decompiled from Move bytecode v6
}

