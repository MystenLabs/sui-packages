module 0xcf3f37c332b48e828920d2923546fb74f2f6ad8c302688b7fc92d9e9ef366199::sbsns {
    struct SBSNS has drop {
        dummy_field: bool,
    }

    fun init(arg0: SBSNS, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SBSNS>(arg0, 9, b"SBSNS", b"Aujsns", b"Dndmxm", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/268d6a70-cd7e-458c-a5df-5269d51f896f.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SBSNS>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<SBSNS>>(v1);
    }

    // decompiled from Move bytecode v6
}

