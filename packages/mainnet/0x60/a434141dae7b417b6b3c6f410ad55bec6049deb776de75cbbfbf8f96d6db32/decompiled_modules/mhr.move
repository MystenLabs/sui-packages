module 0x60a434141dae7b417b6b3c6f410ad55bec6049deb776de75cbbfbf8f96d6db32::mhr {
    struct MHR has drop {
        dummy_field: bool,
    }

    fun init(arg0: MHR, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<MHR>(arg0, 9, b"MHR", b"MIHARU", b"Elephant healing", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/e46e28fe-a605-4fc2-af1e-959c1c20205f.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<MHR>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<MHR>>(v1);
    }

    // decompiled from Move bytecode v6
}

