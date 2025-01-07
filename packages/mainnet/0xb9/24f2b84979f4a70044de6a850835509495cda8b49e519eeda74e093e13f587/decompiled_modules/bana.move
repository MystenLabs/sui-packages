module 0xb924f2b84979f4a70044de6a850835509495cda8b49e519eeda74e093e13f587::bana {
    struct BANA has drop {
        dummy_field: bool,
    }

    fun init(arg0: BANA, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<BANA>(arg0, 9, b"BANA", b"SillyBanan", b" Peeling the crypto hype.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/747def61-c143-41ea-a45a-13cdeebc8b0a.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<BANA>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<BANA>>(v1);
    }

    // decompiled from Move bytecode v6
}

