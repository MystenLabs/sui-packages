module 0x7e09f912a7ca3759d2cdb5613583329208805b4781c3c28e26797db230a84fb9::suipump {
    struct SUIPUMP has drop {
        dummy_field: bool,
    }

    fun init(arg0: SUIPUMP, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::bcs::new(x"0945535052455353554909457370726573537569e0014573707265735355492028244553505245535355492920e29895f09f92a720e2809420746865206361666665696e652d706f776572656420636f6d6d756e6974792062726577696e67206f6e205355492e20436f666665652c206d656d65732c20414920616e642067616d657320636f6c6c69646520696e206f6e65206375702e20427265772e204275696c642e20506c61792e205265706561742e20476f6f6420636f666665652e2047726561746572207468696e67732e7c7c7b2274776974746572223a2268747470733a2f2f782e636f6d2f657370726573737569227d1b68747470733a2f2f706f7374696d672e63632f72446a6d4e63436e");
        let v1 = 0x2::bcs::into_remainder_bytes(v0);
        assert!(0x1::vector::is_empty<u8>(&v1), 0);
        let (v2, v3) = 0x2::coin::create_currency<SUIPUMP>(arg0, 6, 0x2::bcs::peel_vec_u8(&mut v0), 0x2::bcs::peel_vec_u8(&mut v0), 0x2::bcs::peel_vec_u8(&mut v0), 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(0x2::bcs::peel_vec_u8(&mut v0))), arg1);
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SUIPUMP>>(v3);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SUIPUMP>>(v2, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v7
}

