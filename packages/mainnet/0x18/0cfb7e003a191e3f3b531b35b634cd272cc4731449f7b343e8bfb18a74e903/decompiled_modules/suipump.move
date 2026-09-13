module 0x180cfb7e003a191e3f3b531b35b634cd272cc4731449f7b343e8bfb18a74e903::suipump {
    struct SUIPUMP has drop {
        dummy_field: bool,
    }

    fun init(arg0: SUIPUMP, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::bcs::new(x"05414c49454e08537569416c69656e4a7c7c7b2274776974746572223a2268747470733a2f2f782e636f6d2f53756950756d705f53554d502f7374617475732f323039383133373439333138323833323732383f733d3230227d7568747470733a2f2f6173736574732e616c69656e7a2e746563682f636f6c6c656374696f6e732f366131343437313562623237613430326638393866636137363138663862343739313863653331316130666164336564363338636230343037323565643066362f746f6b656e732f302e77656270");
        let v1 = 0x2::bcs::into_remainder_bytes(v0);
        assert!(0x1::vector::is_empty<u8>(&v1), 0);
        let (v2, v3) = 0x2::coin::create_currency<SUIPUMP>(arg0, 6, 0x2::bcs::peel_vec_u8(&mut v0), 0x2::bcs::peel_vec_u8(&mut v0), 0x2::bcs::peel_vec_u8(&mut v0), 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(0x2::bcs::peel_vec_u8(&mut v0))), arg1);
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SUIPUMP>>(v3);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SUIPUMP>>(v2, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v7
}

