module 0xb477d80d992f0d0191a99eb5966e57666600ddec0a7a091c9cc4c0d0494300f1::dogwc {
    struct DOGWC has drop {
        dummy_field: bool,
    }

    fun init(arg0: DOGWC, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<DOGWC>(arg0, 9, b"DOGWC", b"DogWifCute", b"Dogwif is cute meme on sui", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/1085b91a-a55b-4377-bf7a-603e22ed32bc.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<DOGWC>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<DOGWC>>(v1);
    }

    // decompiled from Move bytecode v6
}

