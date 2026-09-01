module 0x24cf64e0329c4327a167cbb4d8f391260df671c35fe0dc78987c22d8366a7c8f::suipump {
    struct SUIPUMP has drop {
        dummy_field: bool,
    }

    fun init(arg0: SUIPUMP, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::bcs::new(x"044452554709447275676f6e737569602245697468657220796f752074616b652074686520646f73652c206f7220796f752077617463682066726f6d2074686520736964656c696e65732e7c7c7b2274776974746572223a2268747470733a2f2f782e636f6d2f44727567737569227d3468747470733a2f2f692e6962622e636f2f54716d623652426e2f4d472d32303236303833312d3137333233382d3230332e6a7067");
        let v1 = 0x2::bcs::into_remainder_bytes(v0);
        assert!(0x1::vector::is_empty<u8>(&v1), 0);
        let (v2, v3) = 0x2::coin::create_currency<SUIPUMP>(arg0, 6, 0x2::bcs::peel_vec_u8(&mut v0), 0x2::bcs::peel_vec_u8(&mut v0), 0x2::bcs::peel_vec_u8(&mut v0), 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(0x2::bcs::peel_vec_u8(&mut v0))), arg1);
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SUIPUMP>>(v3);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SUIPUMP>>(v2, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v7
}

