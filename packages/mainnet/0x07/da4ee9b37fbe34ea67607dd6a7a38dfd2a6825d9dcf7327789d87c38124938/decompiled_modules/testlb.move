module 0x7da4ee9b37fbe34ea67607dd6a7a38dfd2a6825d9dcf7327789d87c38124938::testlb {
    struct TESTLB has drop {
        dummy_field: bool,
    }

    fun init(arg0: TESTLB, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<TESTLB>(arg0, 6, b"TestLb", b"TestLb1", b"444422222222222", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/logo_548e617ac7.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<TESTLB>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<TESTLB>>(v1);
    }

    // decompiled from Move bytecode v6
}

