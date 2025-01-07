module 0x3f223235e9f499ae8a76d16eacf78c00a88161dca6cffca9ca846ed62c6e7abb::wop {
    struct WOP has drop {
        dummy_field: bool,
    }

    fun init(arg0: WOP, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<WOP>(arg0, 9, b"WOP", b"Pow", b"Test 123", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/256610cf-75fe-4444-ba65-9dbaf41543bf.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<WOP>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<WOP>>(v1);
    }

    // decompiled from Move bytecode v6
}

