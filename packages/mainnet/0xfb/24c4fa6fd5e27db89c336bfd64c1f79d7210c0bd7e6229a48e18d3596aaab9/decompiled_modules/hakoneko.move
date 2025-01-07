module 0xfb24c4fa6fd5e27db89c336bfd64c1f79d7210c0bd7e6229a48e18d3596aaab9::hakoneko {
    struct HAKONEKO has drop {
        dummy_field: bool,
    }

    fun init(arg0: HAKONEKO, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg1);
        let (v1, v2) = 0x2::coin::create_currency<HAKONEKO>(arg0, 6, b"HAKONEKO", b"Hako Neko", x"48616b6f204e656b6f2c2043415420494e204120424f5820546f6b656e20696e204a616e70616e6573652c20746865207075727266656374206d656d6520636f696e20696e73706972656420627920746865206c6567656e6461727920536368726f64696e676572e2809973206361742074686f75676874206578706572696d656e74", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.suiai.fun/uploads/photo_2025_01_04_18_14_58_d41407502c.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<HAKONEKO>>(v2, v0);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<HAKONEKO>>(v1, v0);
    }

    // decompiled from Move bytecode v6
}

