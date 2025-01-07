module 0xf33945da679604ad966a7381156549be43f94bd2d919665d406389ba1475e86b::dogai {
    struct DOGAI has drop {
        dummy_field: bool,
    }

    fun init(arg0: DOGAI, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<DOGAI>(arg0, 6, b"DOGAI", b"SuiDog AI", x"54686520666972737420414920446f67204d656d6520f09f90952020696e2074686520405375696e6574776f726b2e0a0a496620796f7527726520616e204f47206f6e2074686520537569206e6574776f726b2c20636865636b20796f757220656c69676962696c69747920666f72207468652061697264726f70206e6f77210a0a687474703a2f2f737569646f6761692e78797a2f0a0a", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://r.turbos.finance/icon/1731177923663.jpg")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<DOGAI>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<DOGAI>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

