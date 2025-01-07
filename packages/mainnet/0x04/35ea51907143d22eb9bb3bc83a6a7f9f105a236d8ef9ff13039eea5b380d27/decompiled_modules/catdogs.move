module 0x435ea51907143d22eb9bb3bc83a6a7f9f105a236d8ef9ff13039eea5b380d27::catdogs {
    struct CATDOGS has drop {
        dummy_field: bool,
    }

    fun init(arg0: CATDOGS, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<CATDOGS>(arg0, 6, b"CATDOGS", b"CATDOG ON SUI", x"497427732074696d6520746f20656e6420746865206361742076732e20646f672077617220696e2063727970746f2e2054686174277320776861742024434154444f47206973206865726520666f722e0a0a4e6f7420616666696c696174656420776974682074686520436174446f6720636172746f6f6e3b207269676874732062656c6f6e6720746f204e69636b656c6f64656f6e2e", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/f3nl6_H_c_400x400_cb99353e62.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<CATDOGS>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<CATDOGS>>(v1);
    }

    // decompiled from Move bytecode v6
}

