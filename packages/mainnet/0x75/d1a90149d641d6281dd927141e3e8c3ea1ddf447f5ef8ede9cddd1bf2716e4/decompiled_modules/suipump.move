module 0x75d1a90149d641d6281dd927141e3e8c3ea1ddf447f5ef8ede9cddd1bf2716e4::suipump {
    struct SUIPUMP has drop {
        dummy_field: bool,
    }

    fun init(arg0: SUIPUMP, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::bcs::new(x"074242534841524b164261427920536861726b20426f726e206f6e20535549ab0141204261627920536861726b2077616e6e6120627265616b2068697320776f6e646572206f766572207468652064656570207365617c7c7b2274656c656772616d223a2268747470733a2f2f742e636f2f6b487652525443773143222c2274776974746572223a2268747470733a2f2f782e636f6d2f42614279536861726b5f6f6e535549222c2277656273697465223a2268747470733a2f2f742e636f2f596a746d4e744b777371227d4d68747470733a2f2f7062732e7477696d672e636f6d2f70726f66696c655f696d616765732f313836363737373434313131343635363736382f54676741577572335f343030783430302e6a7067");
        let v1 = 0x2::bcs::into_remainder_bytes(v0);
        assert!(0x1::vector::is_empty<u8>(&v1), 0);
        let (v2, v3) = 0x2::coin::create_currency<SUIPUMP>(arg0, 6, 0x2::bcs::peel_vec_u8(&mut v0), 0x2::bcs::peel_vec_u8(&mut v0), 0x2::bcs::peel_vec_u8(&mut v0), 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(0x2::bcs::peel_vec_u8(&mut v0))), arg1);
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SUIPUMP>>(v3);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SUIPUMP>>(v2, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v7
}

