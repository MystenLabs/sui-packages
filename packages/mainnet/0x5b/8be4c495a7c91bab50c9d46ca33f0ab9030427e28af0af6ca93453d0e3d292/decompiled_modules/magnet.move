module 0x5b8be4c495a7c91bab50c9d46ca33f0ab9030427e28af0af6ca93453d0e3d292::magnet {
    struct MAGNET has drop {
        dummy_field: bool,
    }

    fun init(arg0: MAGNET, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<MAGNET>(arg0, 6, b"Magnet", b"SuiMagnet", b"Magnet On Sui", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/8i_Ws_K2_WH_3_A_Gvi_Qw_Ant43zvc8y_Ly6_QMU_Suv8_PK_2_A7pump_7020a96363.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<MAGNET>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<MAGNET>>(v1);
    }

    // decompiled from Move bytecode v6
}

