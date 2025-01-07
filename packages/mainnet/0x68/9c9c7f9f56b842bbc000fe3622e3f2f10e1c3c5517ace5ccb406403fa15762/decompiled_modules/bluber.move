module 0x689c9c7f9f56b842bbc000fe3622e3f2f10e1c3c5517ace5ccb406403fa15762::bluber {
    struct BLUBER has drop {
        dummy_field: bool,
    }

    fun init(arg0: BLUBER, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<BLUBER>(arg0, 6, b"BLuber", b"BLuber Sui", x"497427732074696d6520746f2074616b65206f7665722074686520737569206f6365616e2c2062726f7567687420746f20796f7520627920424c756265722e2024424c7562657220697320726561647920746f20656d6261726b206f6e206869732063727970746f206a6f75726e65792c2066726f6d20496e7465726e65742073656e736174696f6e20746f2053554920696d6d6f7274616c6974792e0a", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/Thia_t_ka_ch_AE_a_c_A_t_A_n_26_9ad99451a1.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<BLUBER>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<BLUBER>>(v1);
    }

    // decompiled from Move bytecode v6
}

