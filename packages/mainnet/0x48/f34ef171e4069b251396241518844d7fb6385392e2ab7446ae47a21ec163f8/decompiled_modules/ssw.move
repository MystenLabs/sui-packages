module 0x48f34ef171e4069b251396241518844d7fb6385392e2ab7446ae47a21ec163f8::ssw {
    struct SSW has drop {
        dummy_field: bool,
    }

    fun init(arg0: SSW, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SSW>(arg0, 9, b"SSW", b"snow", b"beautiful cold", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/cc790d3a-8fe6-4438-95fa-5b1247a4f82e.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SSW>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<SSW>>(v1);
    }

    // decompiled from Move bytecode v6
}

