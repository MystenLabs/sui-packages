module 0xd8acbf92ab4f0ae64ba3507a4dedf4473218234e7904532669e315f1bd064f93::suipump {
    struct SUIPUMP has drop {
        dummy_field: bool,
    }

    fun init(arg0: SUIPUMP, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::bcs::new(x"044245415207426974426561725e4275696c64696e67206165676f72612043727970746f2072657365617263682c2041492c207368697070696e67206f6e636861696e7c7c7b2274776974746572223a2268747470733a2f2f782e636f6d2f526173696b46617264696e227d4268747470733a2f2f63646e2e73756970756d702e6f72672f69636f6e732f34353335383839613931326234343739363133653631313561633338356166652e706e67");
        let v1 = 0x2::bcs::into_remainder_bytes(v0);
        assert!(0x1::vector::is_empty<u8>(&v1), 0);
        let (v2, v3) = 0x2::coin::create_currency<SUIPUMP>(arg0, 6, 0x2::bcs::peel_vec_u8(&mut v0), 0x2::bcs::peel_vec_u8(&mut v0), 0x2::bcs::peel_vec_u8(&mut v0), 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(0x2::bcs::peel_vec_u8(&mut v0))), arg1);
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SUIPUMP>>(v3);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SUIPUMP>>(v2, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v7
}

