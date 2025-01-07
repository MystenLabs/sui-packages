module 0x4dfa88867b20ac46e35cc3cbcb0f1408e8d39e510f4109c193d3e3482ee79fa2::kene {
    struct KENE has drop {
        dummy_field: bool,
    }

    fun init(arg0: KENE, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<KENE>(arg0, 9, b"KENE", b"bsnen", b"bejwn", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/3f278d20-e711-4b43-8cc3-439b6cc3355a.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<KENE>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<KENE>>(v1);
    }

    // decompiled from Move bytecode v6
}

