module 0x5534966db7793b905ccbf6b2a531434a276a86325f5485e8c3d4b9e46c042f39::suipump {
    struct SUIPUMP has drop {
        dummy_field: bool,
    }

    fun init(arg0: SUIPUMP, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::bcs::new(x"0942554c4c534841524b0942554c4c534841524bbb0142756c6c736861726b7320e2809320666965726365206469676974616c20637265617475726573206f6620746865205375694672656e732066616d696c792e20426f726e20746f2062656e65666974203338306b20414345532050726f6772616d206d656d62657273e280992077616c6c6574732e7c7c7b2277656273697465223a2268747470733a2f2f7777772e6d797374656e6c6162732e636f6d2f626c6f672f696e74726f647563696e672d62756c6c736861726b73227d1f68747470733a2f2f692e696d6775722e636f6d2f494f524b7a68432e706e67");
        let v1 = 0x2::bcs::into_remainder_bytes(v0);
        assert!(0x1::vector::is_empty<u8>(&v1), 0);
        let (v2, v3) = 0x2::coin::create_currency<SUIPUMP>(arg0, 6, 0x2::bcs::peel_vec_u8(&mut v0), 0x2::bcs::peel_vec_u8(&mut v0), 0x2::bcs::peel_vec_u8(&mut v0), 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(0x2::bcs::peel_vec_u8(&mut v0))), arg1);
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SUIPUMP>>(v3);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SUIPUMP>>(v2, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v7
}

