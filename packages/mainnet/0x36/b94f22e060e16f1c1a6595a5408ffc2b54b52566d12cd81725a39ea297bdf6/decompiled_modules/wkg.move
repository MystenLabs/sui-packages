module 0x36b94f22e060e16f1c1a6595a5408ffc2b54b52566d12cd81725a39ea297bdf6::wkg {
    struct WKG has drop {
        dummy_field: bool,
    }

    fun init(arg0: WKG, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<WKG>(arg0, 9, b"WKG", b"Wokang", b"Wokang fan token ", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/66c1fc1c-f447-44cd-99a1-f228494762ef.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<WKG>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<WKG>>(v1);
    }

    // decompiled from Move bytecode v6
}

