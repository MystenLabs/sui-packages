module 0xe9e330619846e07559c6ed96ee0547ffe41df628b398c9a8fdef553ac635a738::huk {
    struct HUK has drop {
        dummy_field: bool,
    }

    fun init(arg0: HUK, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<HUK>(arg0, 9, b"HUK", b"Husky", b"Funny Husky. Will become source of fund for stray dogs.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/78d8b8a8-58b6-4c4b-8bc9-f02ce09c53b7.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<HUK>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<HUK>>(v1);
    }

    // decompiled from Move bytecode v6
}

