module 0x4fcfb461c657747216faee2de91d5a3fbbb62fb7fc54f318f74d572a92c042c::suipump {
    struct SUIPUMP has drop {
        dummy_field: bool,
    }

    fun init(arg0: SUIPUMP, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::bcs::new(x"07425452454e43480a424142595452454e4348df01426f726e20666f7220746865207472656e636865732e0a546f6f20796f756e6720746f20717569742e20546f6f2073747562626f726e20746f206469652e0a4e6f20666561722e204e6f20736c6565702e204e6f2073757272656e6465722e0a4a75737420612062616279207769746820612068656c6d657420616e642061206d697373696f6e7c7c7b2274656c656772616d223a2268747470733a2f2f742e6d652f2b52356b3274753832616470695a6a6b78222c2274776974746572223a2268747470733a2f2f782e636f6d2f426162795472656e63685f537569227d2068747470733a2f2f692e696d6775722e636f6d2f633939635155482e6a706567");
        let v1 = 0x2::bcs::into_remainder_bytes(v0);
        assert!(0x1::vector::is_empty<u8>(&v1), 0);
        let (v2, v3) = 0x2::coin::create_currency<SUIPUMP>(arg0, 6, 0x2::bcs::peel_vec_u8(&mut v0), 0x2::bcs::peel_vec_u8(&mut v0), 0x2::bcs::peel_vec_u8(&mut v0), 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(0x2::bcs::peel_vec_u8(&mut v0))), arg1);
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SUIPUMP>>(v3);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SUIPUMP>>(v2, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v7
}

