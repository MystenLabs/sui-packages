module 0x590094e6bc4b0403c80466c3486e3a5319d686700ded8d62108d2d8fc2dcd98c::suipump {
    struct SUIPUMP has drop {
        dummy_field: bool,
    }

    fun init(arg0: SUIPUMP, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::bcs::new(x"0946414d494c595355490a66616d696c79207375697866616d696c79207375697c7c7b2274656c656772616d223a2268747470733a2f2f742e6d652f66616d696c79737569222c2274776974746572223a2268747470733a2f2f782e636f6d2f66616d696c79737569222c2277656273697465223a2268747470733a2f2f742e6d652f66616d696c79737569227d1f68747470733a2f2f692e696d6775722e636f6d2f4936316b6d56512e706e67");
        let v1 = 0x2::bcs::into_remainder_bytes(v0);
        assert!(0x1::vector::is_empty<u8>(&v1), 0);
        let (v2, v3) = 0x2::coin::create_currency<SUIPUMP>(arg0, 6, 0x2::bcs::peel_vec_u8(&mut v0), 0x2::bcs::peel_vec_u8(&mut v0), 0x2::bcs::peel_vec_u8(&mut v0), 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(0x2::bcs::peel_vec_u8(&mut v0))), arg1);
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SUIPUMP>>(v3);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SUIPUMP>>(v2, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v7
}

