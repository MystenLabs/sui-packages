module 0x326903e970677d426f22be6854cfd5e074c73e49cad3563a9a40fbc64d603c8a::fire {
    struct FIRE has drop {
        dummy_field: bool,
    }

    fun init(arg0: FIRE, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<FIRE>(arg0, 6, b"FIRE", x"f09f94a5", x"f09f94a54649524520626567696e732074686520456c656d656e74616c20526562656c6c696f6e206163726f73732074686520636861696e7320746861742073657420757320667265652e0a0a412073656172696e672073796d626f6c206f662070617373696f6e2c20726562656c6c696f6e2c20616e6420756e73746f707061626c6520656e657267792c20626f726e20746f206c6967687420746865207761790a0a0a54686520456c656d656e74616c204177616b656e696e672068617320626567756e0a0a0af09f94a520526561647920746f206265207265626f726e2062792074686520666c616d653ff09f94a5", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://r.turbos.finance/icon/1731693198061.jpg")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<FIRE>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<FIRE>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

