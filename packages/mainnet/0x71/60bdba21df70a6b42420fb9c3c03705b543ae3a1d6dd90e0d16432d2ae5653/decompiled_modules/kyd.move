module 0x7160bdba21df70a6b42420fb9c3c03705b543ae3a1d6dd90e0d16432d2ae5653::kyd {
    struct KYD has drop {
        dummy_field: bool,
    }

    fun init(arg0: KYD, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<KYD>(arg0, 9, b"KYD", b"keyboard", b"practical", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/5ed72a75-7b16-4865-9bfb-7c05f91126fa.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<KYD>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<KYD>>(v1);
    }

    // decompiled from Move bytecode v6
}

