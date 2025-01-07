module 0x783eca73d8b1f9e1a82a3e1461fc0943c6cb966d86823e72bb7a8c7a782501cc::ajamama {
    struct AJAMAMA has drop {
        dummy_field: bool,
    }

    fun init(arg0: AJAMAMA, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<AJAMAMA>(arg0, 9, b"AJAMAMA", b"Bebend", b"Ammanwnanan", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/fbb281a7-b023-4086-8fad-cdebeb8e8f26.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<AJAMAMA>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<AJAMAMA>>(v1);
    }

    // decompiled from Move bytecode v6
}

