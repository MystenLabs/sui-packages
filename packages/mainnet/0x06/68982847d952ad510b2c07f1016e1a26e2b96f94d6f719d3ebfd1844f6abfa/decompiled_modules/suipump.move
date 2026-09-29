module 0x668982847d952ad510b2c07f1016e1a26e2b96f94d6f719d3ebfd1844f6abfa::suipump {
    struct SUIPUMP has drop {
        dummy_field: bool,
    }

    fun init(arg0: SUIPUMP, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::bcs::new(x"05434f5a4d4f0b416e696b6920436f7a6d6fb50124434f5a4d4f20e280942052657669766564206f6e205375690a5468652069636f6e696320414920636f6d70616e696f6e20746861742063617074757265642074686520776f726c64e2809973206865617274206973206261636b2e205265737572726563746564206f6e2053756920e28094207768657265206c6567616379206d6565747320746865206675747572652e0a4c6561726e2e20506c61792e204c61737420466f72657665722e20f09fa496e29ca84268747470733a2f2f63646e2e73756970756d702e6f72672f69636f6e732f36373738613033353238303531656339636439313437633031326337376330352e706e67");
        let v1 = 0x2::bcs::into_remainder_bytes(v0);
        assert!(0x1::vector::is_empty<u8>(&v1), 0);
        let (v2, v3) = 0x2::coin::create_currency<SUIPUMP>(arg0, 6, 0x2::bcs::peel_vec_u8(&mut v0), 0x2::bcs::peel_vec_u8(&mut v0), 0x2::bcs::peel_vec_u8(&mut v0), 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(0x2::bcs::peel_vec_u8(&mut v0))), arg1);
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SUIPUMP>>(v3);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SUIPUMP>>(v2, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v7
}

