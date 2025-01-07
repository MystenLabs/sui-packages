module 0x614479cbaa16d1b1135fe1bab0ce8509ea503a2febe62b1bddaec6264c215850::beaver {
    struct BEAVER has drop {
        dummy_field: bool,
    }

    fun init(arg0: BEAVER, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<BEAVER>(arg0, 6, b"BEAVER", b"Beaver on SUI", x"5468652042656176657220636f6d6d756e69747920697320657870616e64696e672c20616e6420697427732074696d6520746f2063656c65627261746520796f757220637265617469766974792e0a0a5765277665207365656e20696e6372656469626c652061727420736f206661722c20627574206e6f77207765206e65656420796f757220756e6971756520746f75636820746f20636f6e717565722074686520776f726c642e", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://r.turbos.finance/icon/1730985233634.jpeg")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<BEAVER>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<BEAVER>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

