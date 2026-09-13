module 0xd3cda8695f2e28e09329748eb0821c928bbee5872a44c9e0993a959ce70dbc3e::suipump {
    struct SUIPUMP has drop {
        dummy_field: bool,
    }

    fun init(arg0: SUIPUMP, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::bcs::new(x"044d495a55104d495a5520544845204255494c44455292024d797374656e206973206c6f6f6b696e6720666f72207265616c206275696c646572732e20507574206f6e207468652068656c6d65742c206772616220796f757220746f6f6c732c20616e64206a6f696e20746865206372657720616c6f6e6773696465204d495a5520746f20737461727420636f6e737472756374696e672074686520667574757265206f66207468652065636f73797374656d217c7c7b2274656c656772616d223a2268747470733a2f2f742e6d652f2b63726951666736424b3242685a47526b222c2274776974746572223a2268747470733a2f2f782e636f6d2f507570706965736c6f7665722f7374617475732f323039313630343432333835363531373431323f733d3230227d1f68747470733a2f2f692e696d6775722e636f6d2f77733243354f342e706e67");
        let v1 = 0x2::bcs::into_remainder_bytes(v0);
        assert!(0x1::vector::is_empty<u8>(&v1), 0);
        let (v2, v3) = 0x2::coin::create_currency<SUIPUMP>(arg0, 6, 0x2::bcs::peel_vec_u8(&mut v0), 0x2::bcs::peel_vec_u8(&mut v0), 0x2::bcs::peel_vec_u8(&mut v0), 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(0x2::bcs::peel_vec_u8(&mut v0))), arg1);
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SUIPUMP>>(v3);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SUIPUMP>>(v2, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v7
}

