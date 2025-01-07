module 0x91966f20e97f867246569bb130869f5bd9fbf2ee7fda8b8a8fe89c3dbb47eb49::asu {
    struct ASU has drop {
        dummy_field: bool,
    }

    fun init(arg0: ASU, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<ASU>(arg0, 9, b"ASU", b"Anjing", b"Asu is dog in jawa", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/b721e955-389e-4389-b62b-71c1b811692c.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<ASU>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<ASU>>(v1);
    }

    // decompiled from Move bytecode v6
}

