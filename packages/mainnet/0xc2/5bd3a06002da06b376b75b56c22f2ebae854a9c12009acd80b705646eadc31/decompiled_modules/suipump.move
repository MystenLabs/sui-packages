module 0xc25bd3a06002da06b376b75b56c22f2ebae854a9c12009acd80b705646eadc31::suipump {
    struct SUIPUMP has drop {
        dummy_field: bool,
    }

    fun init(arg0: SUIPUMP, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::bcs::new(x"034855480748756820436174334855483f7c7c7b2274656c656772616d223a2268747470733a2f2f742e6d652f2b6e507a6f444d355a536331685a6d4d31227d6e68747470733a2f2f706c756d2d6c6567616c2d686164646f636b2d3939332e6d7970696e6174612e636c6f75642f697066732f62616679626569626d6577763265796a337937646873676f663467627870626d7667336161656964613378336d707163686c336e67743466367a34");
        let v1 = 0x2::bcs::into_remainder_bytes(v0);
        assert!(0x1::vector::is_empty<u8>(&v1), 0);
        let (v2, v3) = 0x2::coin::create_currency<SUIPUMP>(arg0, 6, 0x2::bcs::peel_vec_u8(&mut v0), 0x2::bcs::peel_vec_u8(&mut v0), 0x2::bcs::peel_vec_u8(&mut v0), 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(0x2::bcs::peel_vec_u8(&mut v0))), arg1);
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SUIPUMP>>(v3);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SUIPUMP>>(v2, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v7
}

