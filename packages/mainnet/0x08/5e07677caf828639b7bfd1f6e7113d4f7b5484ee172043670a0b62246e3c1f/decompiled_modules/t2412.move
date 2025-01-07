module 0x85e07677caf828639b7bfd1f6e7113d4f7b5484ee172043670a0b62246e3c1f::t2412 {
    struct T2412 has drop {
        dummy_field: bool,
    }

    fun init(arg0: T2412, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<T2412>(arg0, 9, b"T2412", b"TonyT", b"A token from Tony", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/9d9db789-b87e-48e8-96a4-09fb1d55ffb2.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<T2412>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<T2412>>(v1);
    }

    // decompiled from Move bytecode v6
}

