module 0xe4a4018cc84e1bdd746d5f7fd8aa6dbdd8ff7a86fa5c4617284c6adac4655c61::neeey {
    struct NEEEY has drop {
        dummy_field: bool,
    }

    fun init(arg0: NEEEY, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<NEEEY>(arg0, 9, b"NEEEY", b"Pi", b"Ghygfff", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/212a8a23-173e-4c46-a607-f49453cf583f.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<NEEEY>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<NEEEY>>(v1);
    }

    // decompiled from Move bytecode v6
}

