module 0x4f130097d5ac248118a965e02cd85d958aef0813d8099eea47aba12bfdfbbfe1::suipump {
    struct SUIPUMP has drop {
        dummy_field: bool,
    }

    fun init(arg0: SUIPUMP, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::bcs::new(x"084d4953544f524953084d6973746f7269736b6d69737469726f697320697320612067726561742067757920696e2068697374696f72696f737c7c7b2274776974746572223a2268747470733a2f2f782e636f6d2f4d726b6574496e73696465722f7374617475732f32313034343433333935323034393037313438227d4268747470733a2f2f63646e2e73756970756d702e6f72672f69636f6e732f37373764653834653139666433376163623963636465323631643432313363322e706e67");
        let v1 = 0x2::bcs::into_remainder_bytes(v0);
        assert!(0x1::vector::is_empty<u8>(&v1), 0);
        let (v2, v3) = 0x2::coin::create_currency<SUIPUMP>(arg0, 6, 0x2::bcs::peel_vec_u8(&mut v0), 0x2::bcs::peel_vec_u8(&mut v0), 0x2::bcs::peel_vec_u8(&mut v0), 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(0x2::bcs::peel_vec_u8(&mut v0))), arg1);
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SUIPUMP>>(v3);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SUIPUMP>>(v2, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v7
}

