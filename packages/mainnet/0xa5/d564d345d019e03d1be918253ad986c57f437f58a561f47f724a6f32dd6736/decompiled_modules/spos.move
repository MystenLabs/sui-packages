module 0xa5d564d345d019e03d1be918253ad986c57f437f58a561f47f724a6f32dd6736::spos {
    struct SPOS has drop {
        dummy_field: bool,
    }

    fun init(arg0: SPOS, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SPOS>(arg0, 6, b"SPoS", b"Shark Pepe on Sui", b"$Sui is just better", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/G_Zf_IB_Pe_Xs_A_Awijm_8651722445.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SPOS>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SPOS>>(v1);
    }

    // decompiled from Move bytecode v6
}

