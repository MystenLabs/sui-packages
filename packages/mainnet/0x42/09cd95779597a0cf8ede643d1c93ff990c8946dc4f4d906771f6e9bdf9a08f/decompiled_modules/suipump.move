module 0x4209cd95779597a0cf8ede643d1c93ff990c8946dc4f4d906771f6e9bdf9a08f::suipump {
    struct SUIPUMP has drop {
        dummy_field: bool,
    }

    fun init(arg0: SUIPUMP, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::bcs::new(x"075249434152444f0d5269636172646f204d696c6f734b546865206d61726b6574206d6f7665732e2048652064616e6365732e7c7c7b2274656c656772616d223a2268747470733a2f2f742e6d652f2b7a4e416e50534a564332686c4e7a6339227d5268747470733a2f2f692e706f7374696d672e63632f4c387252714730792f436861742d4750542d496d6167652d323032366e69616e39797565313872692d7368616e672d777531322d30392d31312e706e67");
        let v1 = 0x2::bcs::into_remainder_bytes(v0);
        assert!(0x1::vector::is_empty<u8>(&v1), 0);
        let (v2, v3) = 0x2::coin::create_currency<SUIPUMP>(arg0, 6, 0x2::bcs::peel_vec_u8(&mut v0), 0x2::bcs::peel_vec_u8(&mut v0), 0x2::bcs::peel_vec_u8(&mut v0), 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(0x2::bcs::peel_vec_u8(&mut v0))), arg1);
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SUIPUMP>>(v3);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SUIPUMP>>(v2, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v7
}

