module 0xdbf301dc7e4c21017849ab27ad92d4ec1657f259e862cd52103503af28356c0c::suipump {
    struct SUIPUMP has drop {
        dummy_field: bool,
    }

    fun init(arg0: SUIPUMP, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::bcs::new(x"0454494c490854696e792050617795013320706f756e64732e20436c6f756420666f726573742e204669727374206e65772063617420696e203130302079656172732e0a0a74e28099696c69206b617975203d2074696e7920666f6f742e0a0a4e6577206361742064726f707065642e20536179207073707370732e7c7c7b2274776974746572223a2268747470733a2f2f782e636f6d2f526173696b46617264696e227d4268747470733a2f2f63646e2e73756970756d702e6f72672f69636f6e732f31613132333364613238323639636333346366366130643839376361333061662e706e67");
        let v1 = 0x2::bcs::into_remainder_bytes(v0);
        assert!(0x1::vector::is_empty<u8>(&v1), 0);
        let (v2, v3) = 0x2::coin::create_currency<SUIPUMP>(arg0, 6, 0x2::bcs::peel_vec_u8(&mut v0), 0x2::bcs::peel_vec_u8(&mut v0), 0x2::bcs::peel_vec_u8(&mut v0), 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(0x2::bcs::peel_vec_u8(&mut v0))), arg1);
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SUIPUMP>>(v3);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SUIPUMP>>(v2, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v7
}

