module 0x29f3cdd4a93472e3ad8271259c5e00dea9e857fba03ad06ebdf0f6ed0876fc8::pinetwork {
    struct PINETWORK has drop {
        dummy_field: bool,
    }

    fun init(arg0: PINETWORK, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<PINETWORK>(arg0, 9, b"PINETWORK", b"Pi", b"Pinetw", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/5e4ac891-ed44-477c-a9e4-1be63fe8a93c.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<PINETWORK>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<PINETWORK>>(v1);
    }

    // decompiled from Move bytecode v6
}

