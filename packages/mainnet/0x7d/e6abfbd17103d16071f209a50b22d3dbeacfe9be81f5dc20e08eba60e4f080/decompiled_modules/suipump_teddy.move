module 0x7de6abfbd17103d16071f209a50b22d3dbeacfe9be81f5dc20e08eba60e4f080::suipump_teddy {
    struct SUIPUMP_TEDDY has drop {
        dummy_field: bool,
    }

    fun init(arg0: SUIPUMP_TEDDY, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::bcs::new(x"0554454444590a54656464792043726577830154656464792069732061206368617261637465722d64726976656e204e46542070726f6a65637420726f6f74656420696e206964656e746974792c2063756c747572652c20616e64206c6976656420657870657269656e63657c7c7b2277656273697465223a2268747470733a2f2f7777772e7465646479637265772e6172742f227d4268747470733a2f2f63646e2e73756970756d702e6f72672f69636f6e732f61343165343233653161396262653639633436383132663332643535353031342e706e67");
        let v1 = 0x2::bcs::into_remainder_bytes(v0);
        assert!(0x1::vector::is_empty<u8>(&v1), 0);
        let (v2, v3) = 0x2::coin::create_currency<SUIPUMP_TEDDY>(arg0, 6, 0x2::bcs::peel_vec_u8(&mut v0), 0x2::bcs::peel_vec_u8(&mut v0), 0x2::bcs::peel_vec_u8(&mut v0), 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(0x2::bcs::peel_vec_u8(&mut v0))), arg1);
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SUIPUMP_TEDDY>>(v3);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SUIPUMP_TEDDY>>(v2, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v7
}

