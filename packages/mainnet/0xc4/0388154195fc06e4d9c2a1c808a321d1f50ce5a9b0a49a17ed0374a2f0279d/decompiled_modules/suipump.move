module 0xc40388154195fc06e4d9c2a1c808a321d1f50ce5a9b0a49a17ed0374a2f0279d::suipump {
    struct SUIPUMP has drop {
        dummy_field: bool,
    }

    fun init(arg0: SUIPUMP, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::bcs::new(x"0542555443480c42757463686572204865726fe90124425554434820e28094205468652048756e74204e6576657220456e64732e0a200a4d6f6e737465727320726973652066726f6d207468652073616e642e20596f752061726520746865697220656e642e0a486f6f6b207468656d2e204c6f6f74207468656d2e2047726f77207374726f6e67657220e28094206576656e207768656e20796f75e28099726520617761792e0a4275696c74206f6e2053756920e2809420666173742c20666169722c20756e73746f707061626c652e0a200a5468657920646f6ee28099742063616c6c20796f75204275746368657220666f72206e6f7468696e672e4268747470733a2f2f63646e2e73756970756d702e6f72672f69636f6e732f63333235343236373763346632313530616363333434633730303861663965382e706e67");
        let v1 = 0x2::bcs::into_remainder_bytes(v0);
        assert!(0x1::vector::is_empty<u8>(&v1), 0);
        let (v2, v3) = 0x2::coin::create_currency<SUIPUMP>(arg0, 6, 0x2::bcs::peel_vec_u8(&mut v0), 0x2::bcs::peel_vec_u8(&mut v0), 0x2::bcs::peel_vec_u8(&mut v0), 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(0x2::bcs::peel_vec_u8(&mut v0))), arg1);
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SUIPUMP>>(v3);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SUIPUMP>>(v2, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v7
}

