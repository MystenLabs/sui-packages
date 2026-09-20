module 0x35bb7806bb636c86b75ee275804dece77aea84b14267b30a431a9d3b5cd2ec6b::suipump {
    struct SUIPUMP has drop {
        dummy_field: bool,
    }

    fun init(arg0: SUIPUMP, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::bcs::new(x"074f4c594d5055530c4f6c796d70757320776f7468b70143616c6c65642062792068747470733a2f2f782e636f6d2f5769635769637a2076696120404f7572626c617374626f742022404f7572626c617374626f74206465706c6f7920746f6b656e206e616d65206f6e2053756970756d702e2e2e6e616d653a204f6c796d70757320776f7468207469636b657220244f4c594d50555320696d6167652068747470733a2f2f742e636f2f626375574a3630434d6d2068747470733a2f2f742e636f2f7948357171786970616b222f68747470733a2f2f7062732e7477696d672e636f6d2f6d656469612f485373716a6c79616f4141454f4e6b2e6a7067");
        let v1 = 0x2::bcs::into_remainder_bytes(v0);
        assert!(0x1::vector::is_empty<u8>(&v1), 0);
        let (v2, v3) = 0x2::coin::create_currency<SUIPUMP>(arg0, 6, 0x2::bcs::peel_vec_u8(&mut v0), 0x2::bcs::peel_vec_u8(&mut v0), 0x2::bcs::peel_vec_u8(&mut v0), 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(0x2::bcs::peel_vec_u8(&mut v0))), arg1);
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SUIPUMP>>(v3);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SUIPUMP>>(v2, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v7
}

