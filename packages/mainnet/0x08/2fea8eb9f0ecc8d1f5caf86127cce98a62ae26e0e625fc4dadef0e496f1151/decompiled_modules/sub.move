module 0x82fea8eb9f0ecc8d1f5caf86127cce98a62ae26e0e625fc4dadef0e496f1151::sub {
    struct SUB has drop {
        dummy_field: bool,
    }

    fun init(arg0: SUB, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SUB>(arg0, 9, b"SUB", b"SUIbuddy", b"SUI brotherhood platform, everything SUI", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/7e246cef-0a3b-40c2-9e68-ecb70dcf2dad.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SUB>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<SUB>>(v1);
    }

    // decompiled from Move bytecode v6
}

