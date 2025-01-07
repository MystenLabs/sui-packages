module 0xea584bc469f35cda162bf4ae085064b8ef8e3113c89a35fc8cc0a21fdfe95188::tendi {
    struct TENDI has drop {
        dummy_field: bool,
    }

    fun init(arg0: TENDI, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<TENDI>(arg0, 6, b"TENDI", b"TENDISUI", b"TENDI ON SUI", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/Qmecmhw_Xzaz9x_En_XZ_9oq_N_Bgp_D_Eo_Vggo_Bu_Fy_KV_7t9as_X_Vy_U_1dc25feb84.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<TENDI>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<TENDI>>(v1);
    }

    // decompiled from Move bytecode v6
}

