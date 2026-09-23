module 0x81b2998bb670091e22dc9f567362af12a70297b86c266730b8ca4323d5955c8d::suipump {
    struct SUIPUMP has drop {
        dummy_field: bool,
    }

    fun init(arg0: SUIPUMP, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::bcs::new(x"064d414e4b45590750756d706b6579684f6666696369616c206d616e6b657973206f6e205375697c7c7b2274656c656772616d223a2268747470733a2f2f742e6d652f2b4c48706a6744664c505f5a6d4f575531222c2274776974746572223a2268747470733a2f2f782e636f6d2f69726f68676d69227d4268747470733a2f2f63646e2e73756970756d702e6f72672f69636f6e732f35396265363732303766373436633034363734323237373236386530333838632e706e67");
        let v1 = 0x2::bcs::into_remainder_bytes(v0);
        assert!(0x1::vector::is_empty<u8>(&v1), 0);
        let (v2, v3) = 0x2::coin::create_currency<SUIPUMP>(arg0, 6, 0x2::bcs::peel_vec_u8(&mut v0), 0x2::bcs::peel_vec_u8(&mut v0), 0x2::bcs::peel_vec_u8(&mut v0), 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(0x2::bcs::peel_vec_u8(&mut v0))), arg1);
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SUIPUMP>>(v3);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SUIPUMP>>(v2, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v7
}

