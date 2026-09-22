module 0xa7ceaab375d7b93e49cda1e6eda51abd46ee0c8ad963f812a1ebd225de2bee1f::suipump {
    struct SUIPUMP has drop {
        dummy_field: bool,
    }

    fun init(arg0: SUIPUMP, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::bcs::new(x"07414c455853554907416c656b737569c001e29aa120416c657853756920e2809420426f726e206f6e205375690af09f928e204275696c7420666f722074686520636f6d6d756e6974790af09f9a80204a7573742067657474696e6720737461727465647c7c7b2274656c656772616d223a2268747470733a2f2f742e6d652f616c65787375696572222c2274776974746572223a2268747470733a2f2f782e636f6d2f416c65787375696572222c2277656273697465223a2268747470733a2f2f742e6d652f616c65787375696572227d4268747470733a2f2f63646e2e73756970756d702e6f72672f69636f6e732f30353962333030346562313832333233623539663462346532376666396661652e706e67");
        let v1 = 0x2::bcs::into_remainder_bytes(v0);
        assert!(0x1::vector::is_empty<u8>(&v1), 0);
        let (v2, v3) = 0x2::coin::create_currency<SUIPUMP>(arg0, 6, 0x2::bcs::peel_vec_u8(&mut v0), 0x2::bcs::peel_vec_u8(&mut v0), 0x2::bcs::peel_vec_u8(&mut v0), 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(0x2::bcs::peel_vec_u8(&mut v0))), arg1);
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SUIPUMP>>(v3);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SUIPUMP>>(v2, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v7
}

