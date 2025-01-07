module 0x9ea5d54e5461405a4a514f98095b4f713bb28db93dd79a5674fc77d289746132::mckeyur {
    struct MCKEYUR has drop {
        dummy_field: bool,
    }

    fun init(arg0: MCKEYUR, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<MCKEYUR>(arg0, 9, b"MCKEYUR", b"Keyur BC", b"The person who scams it's community. It's time to give him a daru party.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/ce3cf2bf-670a-4822-93af-6943980e0175.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<MCKEYUR>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<MCKEYUR>>(v1);
    }

    // decompiled from Move bytecode v6
}

