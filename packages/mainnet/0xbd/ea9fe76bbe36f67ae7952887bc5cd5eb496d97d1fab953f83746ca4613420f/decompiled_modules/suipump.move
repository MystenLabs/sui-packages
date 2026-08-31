module 0xbdea9fe76bbe36f67ae7952887bc5cd5eb496d97d1fab953f83746ca4613420f::suipump {
    struct SUIPUMP has drop {
        dummy_field: bool,
    }

    fun init(arg0: SUIPUMP, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::bcs::new(x"05484f5050590a486f70707942756e6e799f01484f5050592042554e4e59205448452046495253542042554e4e59204f4e205355494e4554574f524b7c7c7b2274656c656772616d223a2268747470733a2f2f782e636f6d2f486f7070797962756e6e79222c2274776974746572223a2268747470733a2f2f782e636f6d2f486f7070797962756e6e79222c2277656273697465223a2268747470733a2f2f782e636f6d2f486f7070797962756e6e79227d2068747470733a2f2f692e696d6775722e636f6d2f6e3933387773502e6a706567");
        let v1 = 0x2::bcs::into_remainder_bytes(v0);
        assert!(0x1::vector::is_empty<u8>(&v1), 0);
        let (v2, v3) = 0x2::coin::create_currency<SUIPUMP>(arg0, 6, 0x2::bcs::peel_vec_u8(&mut v0), 0x2::bcs::peel_vec_u8(&mut v0), 0x2::bcs::peel_vec_u8(&mut v0), 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(0x2::bcs::peel_vec_u8(&mut v0))), arg1);
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SUIPUMP>>(v3);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SUIPUMP>>(v2, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v7
}

