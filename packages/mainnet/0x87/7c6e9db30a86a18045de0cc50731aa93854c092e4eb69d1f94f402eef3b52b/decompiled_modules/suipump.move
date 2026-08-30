module 0x877c6e9db30a86a18045de0cc50731aa93854c092e4eb69d1f94f402eef3b52b::suipump {
    struct SUIPUMP has drop {
        dummy_field: bool,
    }

    fun init(arg0: SUIPUMP, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::bcs::new(x"065a4950504552065a6970706572c00153656e642073746f636b732c20525741732c20546f6b656e732c20616e64206f746865722041737365747320776974686f75742061736b696e6720666f7220612077616c6c657420616464726573732e7c7c7b2274656c656772616d223a2268747470733a2f2f7777772e7a69707065722e6c61742f222c2274776974746572223a2268747470733a2f2f782e636f6d2f5573655a6970706572222c2277656273697465223a2268747470733a2f2f7777772e7a69707065722e6c61742f227d2068747470733a2f2f692e696d6775722e636f6d2f4c6964494f6f342e6a706567");
        let v1 = 0x2::bcs::into_remainder_bytes(v0);
        assert!(0x1::vector::is_empty<u8>(&v1), 0);
        let (v2, v3) = 0x2::coin::create_currency<SUIPUMP>(arg0, 6, 0x2::bcs::peel_vec_u8(&mut v0), 0x2::bcs::peel_vec_u8(&mut v0), 0x2::bcs::peel_vec_u8(&mut v0), 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(0x2::bcs::peel_vec_u8(&mut v0))), arg1);
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SUIPUMP>>(v3);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SUIPUMP>>(v2, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v7
}

