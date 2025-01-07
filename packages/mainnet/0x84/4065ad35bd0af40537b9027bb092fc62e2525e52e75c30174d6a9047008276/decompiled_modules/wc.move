module 0x844065ad35bd0af40537b9027bb092fc62e2525e52e75c30174d6a9047008276::wc {
    struct WC has drop {
        dummy_field: bool,
    }

    fun init(arg0: WC, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<WC>(arg0, 9, b"WC", b"Wakwaw Cat", b"Meme token", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/2ade4fba-9bba-42c5-b0ee-eca416ab8b1f.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<WC>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<WC>>(v1);
    }

    // decompiled from Move bytecode v6
}

