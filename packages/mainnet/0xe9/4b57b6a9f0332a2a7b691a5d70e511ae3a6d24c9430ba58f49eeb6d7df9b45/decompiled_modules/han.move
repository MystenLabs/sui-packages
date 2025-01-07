module 0xe94b57b6a9f0332a2a7b691a5d70e511ae3a6d24c9430ba58f49eeb6d7df9b45::han {
    struct HAN has drop {
        dummy_field: bool,
    }

    fun init(arg0: HAN, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<HAN>(arg0, 9, b"HAN", b"HANDS", b"Powerful hands reach out to the weak", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/9ea47605-4a02-4cb8-af0d-f23ccfcd912f.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<HAN>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<HAN>>(v1);
    }

    // decompiled from Move bytecode v6
}

