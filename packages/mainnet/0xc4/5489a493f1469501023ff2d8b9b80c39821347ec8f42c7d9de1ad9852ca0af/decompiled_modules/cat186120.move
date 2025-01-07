module 0xc45489a493f1469501023ff2d8b9b80c39821347ec8f42c7d9de1ad9852ca0af::cat186120 {
    struct CAT186120 has drop {
        dummy_field: bool,
    }

    fun init(arg0: CAT186120, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<CAT186120>(arg0, 6, b"CAT186120", b"Sui Block Cat", b"Block #186120 = Cat", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/Qmcs5ut_Cdpx_F_Wi_F_Kvh_Qr_YW_Vcye_Rbm_J_Tn_Qs_X_Ms_MX_7t_D4k_MU_cd58d03244.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<CAT186120>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<CAT186120>>(v1);
    }

    // decompiled from Move bytecode v6
}

