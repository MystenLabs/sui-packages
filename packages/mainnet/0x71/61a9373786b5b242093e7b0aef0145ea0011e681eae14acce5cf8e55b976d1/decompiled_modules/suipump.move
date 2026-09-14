module 0x7161a9373786b5b242093e7b0aef0145ea0011e681eae14acce5cf8e55b976d1::suipump {
    struct SUIPUMP has drop {
        dummy_field: bool,
    }

    fun init(arg0: SUIPUMP, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::bcs::new(x"055452554d50085355495452554d507c5375697472756d70206973207468652073656c662d6465636c6172656420507265736964656e74206f662053756920436861696e20e28094204974e280997320616c6c2061626f75742057494e4e494e472e7c7c7b2274776974746572223a2268747470733a2f2f782e636f6d2f5355495452554d50434f494e227d4d68747470733a2f2f7062732e7477696d672e636f6d2f70726f66696c655f696d616765732f313834373033333539373833383231373231362f6869497243627a395f343030783430302e6a7067");
        let v1 = 0x2::bcs::into_remainder_bytes(v0);
        assert!(0x1::vector::is_empty<u8>(&v1), 0);
        let (v2, v3) = 0x2::coin::create_currency<SUIPUMP>(arg0, 6, 0x2::bcs::peel_vec_u8(&mut v0), 0x2::bcs::peel_vec_u8(&mut v0), 0x2::bcs::peel_vec_u8(&mut v0), 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(0x2::bcs::peel_vec_u8(&mut v0))), arg1);
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SUIPUMP>>(v3);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SUIPUMP>>(v2, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v7
}

