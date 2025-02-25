module 0xe95bc9bf65c4088f1c9ca1c3374c0ca57ddcf7b0e3661d4fe0c8d7a2b216c5c4::suimaxx {
    struct SUIMAXX has drop {
        dummy_field: bool,
    }

    fun init(arg0: SUIMAXX, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SUIMAXX>(arg0, 6, b"SuiMAXX", b"SuiMaXX", x"245375694d617878202d204d41585820596f757220537569204261677320746f20746865204d6f6f6e2120200a0a54686520556c74696d617465204d656d6520546f6b656e20666f722053756920446567656e7320200a0a53756920697320666173742e2053756920697320736d6f6f74682e2042757420245375694d6178783f204974e2809973206865726520746f2074616b6520796f7572206261677320746f204d41585820636170616369747920626563617573652077687920736574746c6520666f72206c657373207768656e20796f752063616e204d415858206974206f75743f20200a", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://r.turbos.finance/icon/1740457879531.png")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<SUIMAXX>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SUIMAXX>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

