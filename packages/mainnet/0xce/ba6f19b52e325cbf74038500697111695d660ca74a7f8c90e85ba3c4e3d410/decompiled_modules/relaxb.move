module 0xceba6f19b52e325cbf74038500697111695d660ca74a7f8c90e85ba3c4e3d410::relaxb {
    struct RELAXB has drop {
        dummy_field: bool,
    }

    fun init(arg0: RELAXB, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<RELAXB>(arg0, 6, b"RELAXB", b"Relax Boy", b"Get ready! $RelaxBoy is launching soon on pump.fun! Dont miss your chance to chill with us! #Solana #pumpfun", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/Qm_SCW_8_UW_Qj3jzv_Pv_Di_Rx_Wd5_A_Lrm_Eri_G_Xfq_Q_Kt_Y9w_L6m_V_Eg_1b773f28df.gif")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<RELAXB>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<RELAXB>>(v1);
    }

    // decompiled from Move bytecode v6
}

