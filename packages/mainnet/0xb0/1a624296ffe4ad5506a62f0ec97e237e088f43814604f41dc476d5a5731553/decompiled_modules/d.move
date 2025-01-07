module 0xb01a624296ffe4ad5506a62f0ec97e237e088f43814604f41dc476d5a5731553::d {
    struct D has drop {
        dummy_field: bool,
    }

    fun init(arg0: D, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<D>(arg0, 9, b"D", b"BC", b"XCV", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/867922ee-2ce2-4c1e-8361-fb57652b3f81.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<D>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<D>>(v1);
    }

    // decompiled from Move bytecode v6
}

