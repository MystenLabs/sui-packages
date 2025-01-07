module 0xc838e5c80e6c27630ec16a93a4597892c93df9a5a7933e4d9928c0ca018fd28a::suicup {
    struct SUICUP has drop {
        dummy_field: bool,
    }

    fun init(arg0: SUICUP, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SUICUP>(arg0, 6, b"SUICUP", b"CUP ON SUI", x"5468652052697365206f6620746865204d6167696320437570200a496e206120636f736d696320736f6e672c20746865202453554943555020637570206973206d6f7265207468616e206a7573742061206472696e6b2c20697427732061206b65792074686174206f70656e732074686520676174657320746f206e657720776f726c64732e0a0a2054686520627261766520636f6d6d756e697479206578706c6f72657320746865206d79737465726965732068696464656e20696e2065766572792064726f70206f662077617465722e", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/Launch_now_b668a892c2.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SUICUP>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SUICUP>>(v1);
    }

    // decompiled from Move bytecode v6
}

