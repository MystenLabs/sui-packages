module 0xda2c10dc0b9c6fcd5af14d68f9803ce20e99ecd8182819c8a45943303de058d::tigsui {
    struct TIGSUI has drop {
        dummy_field: bool,
    }

    fun init(arg0: TIGSUI, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<TIGSUI>(arg0, 6, b"TIGSUI", b"Tiger On Sui", x"24544947535549202d20426c756520546967657220697320467275737472617465640a42656361757365204865277320546f6f20436f6f6c21200a0a4120756e69717565206d656d65206f6e6c79206f6e205375690a426c6f636b636861696e2e", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/Th_A_m_ti_A_u_Ae_a_16_5ee78fe5ff.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<TIGSUI>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<TIGSUI>>(v1);
    }

    // decompiled from Move bytecode v6
}

