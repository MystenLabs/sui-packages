module 0x8456897fc1f8898f73d3a18438ffa64e0a92178a458cb5c115bbc7f3c77c146e::tyron {
    struct TYRON has drop {
        dummy_field: bool,
    }

    fun init(arg0: TYRON, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<TYRON>(arg0, 9, b"TYRON", b"Tyron con", b"Tyroncon", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/90a93dd6-de70-48d5-9fa1-67813259c7ea.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<TYRON>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<TYRON>>(v1);
    }

    // decompiled from Move bytecode v6
}

