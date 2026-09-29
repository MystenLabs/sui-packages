module 0x2c566aad611c33b8164af96c3b7512f4390504378600861ea25d23911011c4bc::suipump {
    struct SUIPUMP has drop {
        dummy_field: bool,
    }

    fun init(arg0: SUIPUMP, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::bcs::new(x"085041524153495445085061726173697465f201436f696e732071756f74656420696e20616e6f7468657220636f696e2e2045766572792074726164652070617973206974732066656520696e2074686520686f737420746f6b656e2c20616e64207468617420666565206275726e732074686520686f73742e0a0a68747470733a2f2f70617261736974656f6e736f6c2e66756e2f0a68747470733a2f2f782e636f6d2f7061726173697465646f7466756e7c7c7b2274776974746572223a2268747470733a2f2f782e636f6d2f7061726173697465646f7466756e222c2277656273697465223a2268747470733a2f2f70617261736974656f6e736f6c2e66756e2f227d4268747470733a2f2f63646e2e73756970756d702e6f72672f69636f6e732f66376232613133386162663136396165366164333833653832346532643834652e706e67");
        let v1 = 0x2::bcs::into_remainder_bytes(v0);
        assert!(0x1::vector::is_empty<u8>(&v1), 0);
        let (v2, v3) = 0x2::coin::create_currency<SUIPUMP>(arg0, 6, 0x2::bcs::peel_vec_u8(&mut v0), 0x2::bcs::peel_vec_u8(&mut v0), 0x2::bcs::peel_vec_u8(&mut v0), 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(0x2::bcs::peel_vec_u8(&mut v0))), arg1);
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SUIPUMP>>(v3);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SUIPUMP>>(v2, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v7
}

