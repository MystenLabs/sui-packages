module 0x6c8fa3c55705d4450c23e027f7fa6bff49b7f0d65d7a653e9782954189951e98::suipump {
    struct SUIPUMP has drop {
        dummy_field: bool,
    }

    fun init(arg0: SUIPUMP, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::bcs::new(x"0453484f54084f4e452053484f54f9014f6e65207461726765742e204f6e652073686f742e204e6f2063686173696e672e202453484f542069732061205375692d6e617469766520736e69706572206d656d6520666f722074686f73652077686f20776169742c2061696d2c20616e642074616b65207468652073686f742e2041206d61736b6564207765737465726e206f75746c61772068756e74696e6720677265656e2063616e646c6573206163726f737320746865205375692066726f6e746965722e204e6f2070726f6d697365732e204e6f20726f61646d61702e204a757374206d656d65732c2070617469656e63652c20616e64206f6e6520636c65616e2073686f742e4268747470733a2f2f63646e2e73756970756d702e6f72672f69636f6e732f37303139643039646532613263643963323566333631646362353933643436352e706e67");
        let v1 = 0x2::bcs::into_remainder_bytes(v0);
        assert!(0x1::vector::is_empty<u8>(&v1), 0);
        let (v2, v3) = 0x2::coin::create_currency<SUIPUMP>(arg0, 6, 0x2::bcs::peel_vec_u8(&mut v0), 0x2::bcs::peel_vec_u8(&mut v0), 0x2::bcs::peel_vec_u8(&mut v0), 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(0x2::bcs::peel_vec_u8(&mut v0))), arg1);
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SUIPUMP>>(v3);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SUIPUMP>>(v2, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v7
}

