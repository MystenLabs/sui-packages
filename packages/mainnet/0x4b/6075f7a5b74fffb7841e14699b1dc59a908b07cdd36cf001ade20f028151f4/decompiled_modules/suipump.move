module 0x4b6075f7a5b74fffb7841e14699b1dc59a908b07cdd36cf001ade20f028151f4::suipump {
    struct SUIPUMP has drop {
        dummy_field: bool,
    }

    fun init(arg0: SUIPUMP, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::bcs::new(x"0357544609547265626c65575446c501547265626c6520697320612066617374206d756c7469706c6179657220656c696d696e6174696f6e2067616d65206f6e205375692e20456e7465722e20537572766976652e20547269706c6520796f757220737461636b2e7c7c7b2274656c656772616d223a2268747470733a2f2f742e6d652f747265626c6567726f7570222c2274776974746572223a2268747470733a2f2f782e636f6d2f747265626c65777466222c2277656273697465223a2268747470733a2f2f747265626c652e7774662f227d4268747470733a2f2f63646e2e73756970756d702e6f72672f69636f6e732f38386134356562633533656139316564313135396533343331353537393664622e706e67");
        let v1 = 0x2::bcs::into_remainder_bytes(v0);
        assert!(0x1::vector::is_empty<u8>(&v1), 0);
        let (v2, v3) = 0x2::coin::create_currency<SUIPUMP>(arg0, 6, 0x2::bcs::peel_vec_u8(&mut v0), 0x2::bcs::peel_vec_u8(&mut v0), 0x2::bcs::peel_vec_u8(&mut v0), 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(0x2::bcs::peel_vec_u8(&mut v0))), arg1);
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SUIPUMP>>(v3);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SUIPUMP>>(v2, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v7
}

