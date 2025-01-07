module 0x423d42d4e5fca31dbe3220a2fd7b809224a443a02764aa80108b40aa80130144::second {
    struct SECOND has drop {
        dummy_field: bool,
    }

    fun init(arg0: SECOND, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SECOND>(arg0, 9, b"SECOND", b"Joker", b"It remind me of my visit for this movie", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/501f021a-82ef-4bde-a67e-e582067a900b.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SECOND>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<SECOND>>(v1);
    }

    // decompiled from Move bytecode v6
}

