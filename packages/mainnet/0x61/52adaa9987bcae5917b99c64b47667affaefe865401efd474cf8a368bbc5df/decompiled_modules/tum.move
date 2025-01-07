module 0x6152adaa9987bcae5917b99c64b47667affaefe865401efd474cf8a368bbc5df::tum {
    struct TUM has drop {
        dummy_field: bool,
    }

    fun init(arg0: TUM, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<TUM>(arg0, 9, b"TUM", b"AUTUMN", b"AUTUMN BECOMES A DREAM", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/609dbd39-9aa9-4626-930c-3f51c925b036.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<TUM>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<TUM>>(v1);
    }

    // decompiled from Move bytecode v6
}

