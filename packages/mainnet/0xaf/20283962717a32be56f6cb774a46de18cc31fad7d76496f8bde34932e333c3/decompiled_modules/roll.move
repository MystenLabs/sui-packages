module 0xaf20283962717a32be56f6cb774a46de18cc31fad7d76496f8bde34932e333c3::roll {
    struct ROLL has drop {
        dummy_field: bool,
    }

    fun init(arg0: ROLL, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<ROLL>(arg0, 9, b"ROLL", b"Rick", b"Rickroll", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/405b6526-833f-4122-bf30-c7e00772805c.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<ROLL>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<ROLL>>(v1);
    }

    // decompiled from Move bytecode v6
}

