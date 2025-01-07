module 0x346660c3b38ef3e742fe5c94df04e8dd78c0873cf0636cd11f24a3caa242fd41::hika {
    struct HIKA has drop {
        dummy_field: bool,
    }

    fun init(arg0: HIKA, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<HIKA>(arg0, 9, b"HIKA", b"Haha", b"Jokba", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/9f88c497-1b69-4f1a-b29b-ade1c8056ade.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<HIKA>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<HIKA>>(v1);
    }

    // decompiled from Move bytecode v6
}

