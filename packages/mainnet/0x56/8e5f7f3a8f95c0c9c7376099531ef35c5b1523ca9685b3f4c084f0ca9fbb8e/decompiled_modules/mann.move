module 0x568e5f7f3a8f95c0c9c7376099531ef35c5b1523ca9685b3f4c084f0ca9fbb8e::mann {
    struct MANN has drop {
        dummy_field: bool,
    }

    fun init(arg0: MANN, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<MANN>(arg0, 9, b"MANN", b"Mann", x"46756e20546f6b656e2c2066726f6d20636f6d6d756e697479206f6620746865206368616e6e656c20e2809c447265616d20576f726b20696e2043727970746fe2809d", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/3399caf6-dcb0-4c10-ab8d-5f1c5290fb66.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<MANN>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<MANN>>(v1);
    }

    // decompiled from Move bytecode v6
}

