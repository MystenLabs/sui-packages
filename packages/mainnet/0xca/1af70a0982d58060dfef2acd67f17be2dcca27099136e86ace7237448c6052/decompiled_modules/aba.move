module 0xca1af70a0982d58060dfef2acd67f17be2dcca27099136e86ace7237448c6052::aba {
    struct ABA has drop {
        dummy_field: bool,
    }

    fun init(arg0: ABA, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<ABA>(arg0, 9, b"ABA", b"Abubakar", b"Abatoken", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/8548ab28-8a53-4ab6-bd39-1a74cf1d5ca1.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<ABA>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<ABA>>(v1);
    }

    // decompiled from Move bytecode v6
}

