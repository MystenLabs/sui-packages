module 0xfea5deceed62912f460627cb93e2fc288abba409bf8354d294be9d60e778d491::suipump {
    struct SUIPUMP has drop {
        dummy_field: bool,
    }

    fun init(arg0: SUIPUMP, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::bcs::new(x"0553515549440953717569642073756978537175696420737569207765206172652072656c61756e6368696e672070727620626c6173742e66756e7c7c7b2274656c656772616d223a2268747470733a2f2f742e6d652f53717569646f6e73756969222c2274776974746572223a2248747470733a2f2f782e636f6d2f7375696f6e7371756964227d2068747470733a2f2f692e696d6775722e636f6d2f6b5a6162425a462e6a706567");
        let v1 = 0x2::bcs::into_remainder_bytes(v0);
        assert!(0x1::vector::is_empty<u8>(&v1), 0);
        let (v2, v3) = 0x2::coin::create_currency<SUIPUMP>(arg0, 6, 0x2::bcs::peel_vec_u8(&mut v0), 0x2::bcs::peel_vec_u8(&mut v0), 0x2::bcs::peel_vec_u8(&mut v0), 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(0x2::bcs::peel_vec_u8(&mut v0))), arg1);
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SUIPUMP>>(v3);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SUIPUMP>>(v2, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v7
}

