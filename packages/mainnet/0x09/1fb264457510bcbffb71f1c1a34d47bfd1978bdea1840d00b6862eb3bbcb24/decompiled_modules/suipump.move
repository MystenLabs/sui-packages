module 0x91fb264457510bcbffb71f1c1a34d47bfd1978bdea1840d00b6862eb3bbcb24::suipump {
    struct SUIPUMP has drop {
        dummy_field: bool,
    }

    fun init(arg0: SUIPUMP, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::bcs::new(x"045649534808766973682e737569b701e29aa120566973682e73756920e2809420426f726e206f6e205375690af09f928e20436f6d6d756e69747920e280a220566973696f6e20e280a22056696265730af09f9a80204275696c64696e6720746865206e6578742077617665206f6e205375697c7c7b2274656c656772616d223a2240766973685f686c222c2274776974746572223a2268747470733a2f2f782e636f6d2f766973685f686c222c2277656273697465223a2240766973685f686c2e636f6d227d4268747470733a2f2f63646e2e73756970756d702e6f72672f69636f6e732f37316261363463663062636135666663336331653834326536633439656338362e706e67");
        let v1 = 0x2::bcs::into_remainder_bytes(v0);
        assert!(0x1::vector::is_empty<u8>(&v1), 0);
        let (v2, v3) = 0x2::coin::create_currency<SUIPUMP>(arg0, 6, 0x2::bcs::peel_vec_u8(&mut v0), 0x2::bcs::peel_vec_u8(&mut v0), 0x2::bcs::peel_vec_u8(&mut v0), 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(0x2::bcs::peel_vec_u8(&mut v0))), arg1);
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SUIPUMP>>(v3);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SUIPUMP>>(v2, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v7
}

