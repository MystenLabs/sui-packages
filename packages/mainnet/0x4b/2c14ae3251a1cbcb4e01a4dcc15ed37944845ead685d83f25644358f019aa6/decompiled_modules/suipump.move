module 0x4b2c14ae3251a1cbcb4e01a4dcc15ed37944845ead685d83f25644358f019aa6::suipump {
    struct SUIPUMP has drop {
        dummy_field: bool,
    }

    fun init(arg0: SUIPUMP, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::bcs::new(x"05535549424109537569205368696261de01537569536869626120697320746865206c6174657374206d656d652073656e736174696f6e206f6e2074686520537569206e6574776f726b2c2073657420746f206c61756e6368206f6e2073756970756d7020576974682074686520736563757269747920616e642072656c696162696c697479206f6620746865205375692065636f73797374656d20616e6420746865206261636b696e67206f66204d6f766550756d702c20537569536869626120697320706f736974696f6e65642061732061207361666520616e642070726f6d6973696e672070726f6a6563742e4268747470733a2f2f63646e2e73756970756d702e6f72672f69636f6e732f30383164613138386633616465366237666266623966613839346261383133312e706e67");
        let v1 = 0x2::bcs::into_remainder_bytes(v0);
        assert!(0x1::vector::is_empty<u8>(&v1), 0);
        let (v2, v3) = 0x2::coin::create_currency<SUIPUMP>(arg0, 6, 0x2::bcs::peel_vec_u8(&mut v0), 0x2::bcs::peel_vec_u8(&mut v0), 0x2::bcs::peel_vec_u8(&mut v0), 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(0x2::bcs::peel_vec_u8(&mut v0))), arg1);
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SUIPUMP>>(v3);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SUIPUMP>>(v2, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v7
}

