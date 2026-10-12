module 0x78fa858a9bb6c8032c60b54d2f2ad3e7f6c53379fea6c1b616b3610250a0734b::suipump {
    struct SUIPUMP has drop {
        dummy_field: bool,
    }

    fun init(arg0: SUIPUMP, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::bcs::new(x"04535355490a5361696c6f7220535549ec015361696c6f722053554920e28094207468652077617272696f72206f66207468652053756920626c6f636b636861696e2e2046756c6c207472616e73666f726d6174696f6e3a20626f6e64696e6720637572766520e286922043657475732e20436f6d6d756e6974792066697273742c206d6f6f6e206c617465722e20466f7220746865206d6167696320616e642074686520535549217c7c7b2274776974746572223a2268747470733a2f2f782e636f6d2f4469676970616c6d6f6e486f64222c2277656273697465223a2268747470733a2f2f7361696c6f726469676970616c6d6f6e2e636f6d2f227d4268747470733a2f2f63646e2e73756970756d702e6f72672f69636f6e732f62643765373938636564363231396634353962366264363032633537623635622e706e67");
        let v1 = 0x2::bcs::into_remainder_bytes(v0);
        assert!(0x1::vector::is_empty<u8>(&v1), 0);
        let (v2, v3) = 0x2::coin::create_currency<SUIPUMP>(arg0, 6, 0x2::bcs::peel_vec_u8(&mut v0), 0x2::bcs::peel_vec_u8(&mut v0), 0x2::bcs::peel_vec_u8(&mut v0), 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(0x2::bcs::peel_vec_u8(&mut v0))), arg1);
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SUIPUMP>>(v3);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SUIPUMP>>(v2, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v7
}

