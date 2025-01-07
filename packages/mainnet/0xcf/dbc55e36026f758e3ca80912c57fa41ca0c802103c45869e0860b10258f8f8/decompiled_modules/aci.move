module 0xcfdbc55e36026f758e3ca80912c57fa41ca0c802103c45869e0860b10258f8f8::aci {
    struct ACI has drop {
        dummy_field: bool,
    }

    fun init(arg0: ACI, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<ACI>(arg0, 9, b"ACI", b"Accing", b"Test", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/be6ab04a-5cbe-4b30-9d62-19427085b92d.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<ACI>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<ACI>>(v1);
    }

    // decompiled from Move bytecode v6
}

