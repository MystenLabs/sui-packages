module 0xabc55dd28de8598887802229377c296bcfe79d67e2f071f4157dfcb6be7dece5::suipump {
    struct SUIPUMP has drop {
        dummy_field: bool,
    }

    fun init(arg0: SUIPUMP, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::bcs::new(x"034341500a4341547769746843415090015265626f6f74696e6720746865207472656e63686573206f6e205375692e7c7c7b2274656c656772616d223a22742e6d652f63617477697468636170222c2274776974746572223a2268747470733a2f2f782e636f6d2f5468655f43415477697468434150222c2277656273697465223a2268747470733a2f2f782e636f6d2f5468655f43415477697468434150227d1f68747470733a2f2f692e696d6775722e636f6d2f45766f6f6336452e706e67");
        let v1 = 0x2::bcs::into_remainder_bytes(v0);
        assert!(0x1::vector::is_empty<u8>(&v1), 0);
        let (v2, v3) = 0x2::coin::create_currency<SUIPUMP>(arg0, 6, 0x2::bcs::peel_vec_u8(&mut v0), 0x2::bcs::peel_vec_u8(&mut v0), 0x2::bcs::peel_vec_u8(&mut v0), 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(0x2::bcs::peel_vec_u8(&mut v0))), arg1);
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SUIPUMP>>(v3);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SUIPUMP>>(v2, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v7
}

