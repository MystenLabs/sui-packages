module 0x29701a43eb0e91d68bd587e7dc6ae349fbba61a8fa139453d8866b87d2b4e7c9::suipump {
    struct SUIPUMP has drop {
        dummy_field: bool,
    }

    fun init(arg0: SUIPUMP, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::bcs::new(x"0445535549094573707265735355498b01e29895204675656c20666f7220746865205355492065636f73797374656d2e0a427265772e204275696c642e20506c61792e205265706561742e20f09f92a77c7c7b2274656c656772616d223a2268747470733a2f2f742e636f2f51764264466f576c4635222c2274776974746572223a2268747470733a2f2f782e636f6d2f457370726573537569227d4d68747470733a2f2f7062732e7477696d672e636f6d2f70726f66696c655f696d616765732f323039393033333638353231313338353835362f685f746979776b455f343030783430302e6a7067");
        let v1 = 0x2::bcs::into_remainder_bytes(v0);
        assert!(0x1::vector::is_empty<u8>(&v1), 0);
        let (v2, v3) = 0x2::coin::create_currency<SUIPUMP>(arg0, 6, 0x2::bcs::peel_vec_u8(&mut v0), 0x2::bcs::peel_vec_u8(&mut v0), 0x2::bcs::peel_vec_u8(&mut v0), 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(0x2::bcs::peel_vec_u8(&mut v0))), arg1);
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SUIPUMP>>(v3);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SUIPUMP>>(v2, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v7
}

