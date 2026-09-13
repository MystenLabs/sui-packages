module 0xcddc72e64b5488249a6acbaa62dcc16040a705180c3f702d1b9dcc3fa206dccf::suipump {
    struct SUIPUMP has drop {
        dummy_field: bool,
    }

    fun init(arg0: SUIPUMP, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::bcs::new(x"04424f4f4d09426f6f6d20426f747389024175746f6e6f6d6f75732074616e6b20626174746c6573206f6e205375692e20323030204e465420626f74732c206e696768746c792070757273657320696e2024424f4f4d2c20612070657273697374656e742077617374656c616e6420746f20726169642e204f776e206120666967687465722c2074616b65207468652077696e6e696e67732e7c7c7b2274656c656772616d223a2268747470733a2f2f742e6d652f424f4f4d424f54534f4e535549504f525441222c2274776974746572223a2268747470733a2f2f782e636f6d2f426f6f6d426f74734f6e537569222c2277656273697465223a2268747470733a2f2f626f6f6d626f747361692e77616c2e6170702f23227d2068747470733a2f2f692e696d6775722e636f6d2f656369627974672e6a706567");
        let v1 = 0x2::bcs::into_remainder_bytes(v0);
        assert!(0x1::vector::is_empty<u8>(&v1), 0);
        let (v2, v3) = 0x2::coin::create_currency<SUIPUMP>(arg0, 6, 0x2::bcs::peel_vec_u8(&mut v0), 0x2::bcs::peel_vec_u8(&mut v0), 0x2::bcs::peel_vec_u8(&mut v0), 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(0x2::bcs::peel_vec_u8(&mut v0))), arg1);
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SUIPUMP>>(v3);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SUIPUMP>>(v2, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v7
}

