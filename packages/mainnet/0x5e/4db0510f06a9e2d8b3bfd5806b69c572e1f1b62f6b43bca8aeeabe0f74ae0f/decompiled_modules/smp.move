module 0x5e4db0510f06a9e2d8b3bfd5806b69c572e1f1b62f6b43bca8aeeabe0f74ae0f::smp {
    struct SMP has drop {
        dummy_field: bool,
    }

    fun init(arg0: SMP, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SMP>(arg0, 6, b"SMP", b"SuiMingPool", x"537569202d2057617465720a4d696e67202d205468652077617920796f752063616c6c20612063617420286d696e67206d696e67206d696e67290a506f6f6c202d20776865726520576174657220616e6420436174206d656574732c0a0a5375694d696e6720506f6f6c202d204c657473207377696d20696e20746865205375692077697468204d696e6720696e2074686520506f6f6c0a0a546869732069732061206d656d6520746f6b656e2c204920616d206e6f742061206465762c204920616d206e6f742074656368792c204920616d206a75737420686176696e672066756e2e", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/1000007837_750bb3ac60.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SMP>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SMP>>(v1);
    }

    // decompiled from Move bytecode v6
}

