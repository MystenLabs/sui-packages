module 0xaad1c7ba3c30620f74fd53777734932729d2d6d0861ab65e6fd13f869417f3d9::sma {
    struct SMA has drop {
        dummy_field: bool,
    }

    fun init(arg0: SMA, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SMA>(arg0, 9, b"SMA", b"smart", b"TO THE MOON ", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/bf3ceb8a-ba17-4fff-b618-1fb200500396.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SMA>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<SMA>>(v1);
    }

    // decompiled from Move bytecode v6
}

