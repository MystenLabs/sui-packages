module 0x8fc257820ce717e8ece9b56c976bfcb507fdce099f66f6ad2d5d02ebf5cea621::suipump {
    struct SUIPUMP has drop {
        dummy_field: bool,
    }

    fun init(arg0: SUIPUMP, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::bcs::new(x"04464f4d4f09666f6d6f2067616d6557412067616d6520746861742063616e206272696e672076616c756520746f20796f7572206d656d6520636f696e217c7c7b2277656273697465223a2268747470733a2f2f666f6d6f2e646170706e61762e6f72672f227d4268747470733a2f2f63646e2e73756970756d702e6f72672f69636f6e732f30633637633133366238383762653930376563383032333734376165633633302e706e67");
        let v1 = 0x2::bcs::into_remainder_bytes(v0);
        assert!(0x1::vector::is_empty<u8>(&v1), 0);
        let (v2, v3) = 0x2::coin::create_currency<SUIPUMP>(arg0, 6, 0x2::bcs::peel_vec_u8(&mut v0), 0x2::bcs::peel_vec_u8(&mut v0), 0x2::bcs::peel_vec_u8(&mut v0), 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(0x2::bcs::peel_vec_u8(&mut v0))), arg1);
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SUIPUMP>>(v3);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SUIPUMP>>(v2, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v7
}

