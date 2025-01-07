module 0x7caf02334a79da78e7dae8ae7dd91c195eca3982701348a95819c0ce8c95e180::wow {
    struct WOW has drop {
        dummy_field: bool,
    }

    fun init(arg0: WOW, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<WOW>(arg0, 9, b"WOW", b"wow", b"memecoins", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/945a1bce-f722-4b2a-84d0-59f43db7b020.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<WOW>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<WOW>>(v1);
    }

    // decompiled from Move bytecode v6
}

