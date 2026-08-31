module 0x54e5d12ab98358ec136e868f5509d3edfaf87b2423e89f28bca1b17450d1d8c8::suipump {
    struct SUIPUMP has drop {
        dummy_field: bool,
    }

    fun init(arg0: SUIPUMP, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::bcs::new(x"0553424f524707535549424f5247ca01554e49542d372d383030204953204c4956452e0a535549424f5247206973206e6f77206f6e205375694e6574776f726b0a48616c662068756d616e2c2068616c66206d616368696e652e2052656420657965206f6e2e7c7c7b2274656c656772616d223a2268747470733a2f2f742e6d652f737569626f7267756e6974222c2274776974746572223a2268747470733a2f2f782e636f6d2f537569426f7267556e6974222c2277656273697465223a2268747470733a2f2f7777772e737569626f72672e66756e2f227d3268747470733a2f2f692e6962622e636f2f7a544430774643702f5468692d742d6b2d63682d612d632d742d6e2d372e706e67");
        let v1 = 0x2::bcs::into_remainder_bytes(v0);
        assert!(0x1::vector::is_empty<u8>(&v1), 0);
        let (v2, v3) = 0x2::coin::create_currency<SUIPUMP>(arg0, 6, 0x2::bcs::peel_vec_u8(&mut v0), 0x2::bcs::peel_vec_u8(&mut v0), 0x2::bcs::peel_vec_u8(&mut v0), 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(0x2::bcs::peel_vec_u8(&mut v0))), arg1);
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SUIPUMP>>(v3);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SUIPUMP>>(v2, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v7
}

