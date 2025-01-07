module 0xb8412c99d1876a5e00780156fe78c4881e0666313bde55b46ade5dc1d78d9cc4::hou {
    struct HOU has drop {
        dummy_field: bool,
    }

    fun init(arg0: HOU, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<HOU>(arg0, 9, b"HOU", b"Hocmau", b"Hold coin", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/c49f59c6-17df-427d-ae0e-08e7776f0df9.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<HOU>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<HOU>>(v1);
    }

    // decompiled from Move bytecode v6
}

