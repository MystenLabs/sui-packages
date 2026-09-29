module 0x370e17c9a111647f3f4d083f57067f689ada65257a67ccc50501820066202cf0::suipump {
    struct SUIPUMP has drop {
        dummy_field: bool,
    }

    fun init(arg0: SUIPUMP, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::bcs::new(x"0541494341541a4172746966696369616c20496e74656c6567656e636520436174e301414943415420e28094204172746966696369616c20496e74656c6c6967656e6365204361740a5768657265204149206d656574732074686520626c6f636b636861696e2e2054686520736d61727465737420636174206f6e20746865206e6574776f726b2c206275696c7420746f206c6561642c206c6561726e2c20616e642067726f772e20506f776572656420627920696e74656c6c6967656e63652c2064726976656e20627920636f6d6d756e6974792c2065766f6c76696e6720657665727920626c6f636b2e0a536d6172742e20466173742e20556e73746f707061626c652e4268747470733a2f2f63646e2e73756970756d702e6f72672f69636f6e732f65303465363732336665333462643639666632643762333239653439353363352e706e67");
        let v1 = 0x2::bcs::into_remainder_bytes(v0);
        assert!(0x1::vector::is_empty<u8>(&v1), 0);
        let (v2, v3) = 0x2::coin::create_currency<SUIPUMP>(arg0, 6, 0x2::bcs::peel_vec_u8(&mut v0), 0x2::bcs::peel_vec_u8(&mut v0), 0x2::bcs::peel_vec_u8(&mut v0), 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(0x2::bcs::peel_vec_u8(&mut v0))), arg1);
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SUIPUMP>>(v3);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SUIPUMP>>(v2, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v7
}

