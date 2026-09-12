module 0x5b8a7f52acd3e16ac39fcb8078e55b68ea7de8c4509d9f09968ef15d5e11745::suipump {
    struct SUIPUMP has drop {
        dummy_field: bool,
    }

    fun init(arg0: SUIPUMP, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::bcs::new(x"03554e4903554e4980024d65657420556e692c2074686520646f67206f662053756920436f2d666f756e646572204576616e204368656e672e2041646f70746564206e6561726c792031312079656172732061676f2c20556e6920686173206265656e2070617274206f6620746865206a6f75726e6579206c6f6e67206265666f72652053756920657869737465642e204e6f7720556e69206861732061207469636b65722c206120636f6d6d756e6974792c20616e64206120706c616365206f6e2d636861696e2e7c7c7b2274776974746572223a2268747470733a2f2f782e636f6d2f4576616e576562332f7374617475732f31383537383531303937313335393335383430227d2068747470733a2f2f692e696d6775722e636f6d2f4a3762767878542e6a706567");
        let v1 = 0x2::bcs::into_remainder_bytes(v0);
        assert!(0x1::vector::is_empty<u8>(&v1), 0);
        let (v2, v3) = 0x2::coin::create_currency<SUIPUMP>(arg0, 6, 0x2::bcs::peel_vec_u8(&mut v0), 0x2::bcs::peel_vec_u8(&mut v0), 0x2::bcs::peel_vec_u8(&mut v0), 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(0x2::bcs::peel_vec_u8(&mut v0))), arg1);
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SUIPUMP>>(v3);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SUIPUMP>>(v2, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v7
}

