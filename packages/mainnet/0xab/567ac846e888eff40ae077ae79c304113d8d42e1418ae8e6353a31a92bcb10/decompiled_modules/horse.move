module 0xab567ac846e888eff40ae077ae79c304113d8d42e1418ae8e6353a31a92bcb10::horse {
    struct HORSE has drop {
        dummy_field: bool,
    }

    fun init(arg0: HORSE, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<HORSE>(arg0, 9, b"HORSE", b"Horse", b"Neighing", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/87381123-6e81-47a7-94fc-b541a92dd857.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<HORSE>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<HORSE>>(v1);
    }

    // decompiled from Move bytecode v6
}

