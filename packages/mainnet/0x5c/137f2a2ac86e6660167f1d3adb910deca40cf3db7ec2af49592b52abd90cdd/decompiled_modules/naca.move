module 0x5c137f2a2ac86e6660167f1d3adb910deca40cf3db7ec2af49592b52abd90cdd::naca {
    struct NACA has drop {
        dummy_field: bool,
    }

    fun init(arg0: NACA, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<NACA>(arg0, 6, b"NACA", b"WelcomeToMars", x"57656c636f6d6520746f204d617273f09f94a5f09f94a5f09f94a54d6172732069732074686520666f7572746820706c616e65742066726f6d207468652053756e2c20616e642074686520736576656e7468206c6172676573742e204974277320746865206f6e6c7920706c616e6574207765206b6e6f77206f6620696e6861626974656420656e746972656c7920627920726f626f74732ef09f9a80f09f9a80f09f9a80", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://r.turbos.finance/icon/1735357515924.jpg")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<NACA>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<NACA>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

