module 0x9bd59646d0930973db2e30d06c6b28eb77e9c5a63b0e5d44612caebc5273e6be::suipump {
    struct SUIPUMP has drop {
        dummy_field: bool,
    }

    fun init(arg0: SUIPUMP, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::bcs::new(x"06504c49454e5a0950756d706c69656e7acf01412063726577206f662068616e6420647261776e20726562656c6c696f757320616c69656e206d697366697473206275696c74206c61796572206279206c6179657220696e2074686520416c69656e7a20486976652e7c7c7b2274656c656772616d223a2268747470733a2f2f782e636f6d2f416c69656e7a74656368222c2274776974746572223a2268747470733a2f2f782e636f6d2f416c69656e7a74656368222c2277656273697465223a2268747470733a2f2f70756d706c69656e7a2e73756970756d702e6f72672f227d2068747470733a2f2f692e696d6775722e636f6d2f543030594f36302e6a706567");
        let v1 = 0x2::bcs::into_remainder_bytes(v0);
        assert!(0x1::vector::is_empty<u8>(&v1), 0);
        let (v2, v3) = 0x2::coin::create_currency<SUIPUMP>(arg0, 6, 0x2::bcs::peel_vec_u8(&mut v0), 0x2::bcs::peel_vec_u8(&mut v0), 0x2::bcs::peel_vec_u8(&mut v0), 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(0x2::bcs::peel_vec_u8(&mut v0))), arg1);
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SUIPUMP>>(v3);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SUIPUMP>>(v2, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v7
}

