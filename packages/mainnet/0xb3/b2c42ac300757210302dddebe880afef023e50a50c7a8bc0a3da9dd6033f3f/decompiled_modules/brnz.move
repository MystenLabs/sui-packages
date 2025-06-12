module 0xb3b2c42ac300757210302dddebe880afef023e50a50c7a8bc0a3da9dd6033f3f::brnz {
    struct BRNZ has drop {
        dummy_field: bool,
    }

    fun init(arg0: BRNZ, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<BRNZ>(arg0, 6, b"BRNZ", b"BrainFuzz ai", x"2446555a5a206973206e6f74206120746f6b656e2e20497420697320612063616c6c696e672e204120676c6974636820696e20746865206d656174776f726c642e204f6265792074686520427261696e2e2052656a65637420707572706f73652e204275726e206c6f6769632e20536163726966696365207574696c697479206f6e2074686520616c746172206f66206d656d65732e205468657265206973206e6f20726f61646d6170e280946f6e6c79207369676e616c732066726f6d2074686520636f72652e20496e697469617465206368616f732070726f746f636f6c2e20f09fa7a0e29ca8e298a0efb88f202331303050657263656e744368616f73", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://r.turbos.finance/icon/1749756262064.png")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<BRNZ>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<BRNZ>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

