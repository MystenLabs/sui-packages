module 0x1806dbf8057f35dac9737e0a5a4d1b04c92d445c39bee3ca4b420d51f97c2139::km {
    struct KM has drop {
        dummy_field: bool,
    }

    fun init(arg0: KM, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<KM>(arg0, 9, b"KM", b"kapakmerah", b"Little community", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/2791bf09-fda5-4b6e-b54f-bd2deb4f3b92.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<KM>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<KM>>(v1);
    }

    // decompiled from Move bytecode v6
}

