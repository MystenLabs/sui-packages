module 0x2edb6d0ea8346f280bc4c7b2e9d2633b80b601631294ee730bffbda2b72043ec::fg {
    struct FG has drop {
        dummy_field: bool,
    }

    fun init(arg0: FG, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<FG>(arg0, 9, b"FG", b"SAF", b"Q", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/82410cb4-37be-4b57-aacf-8cc514be69b8.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<FG>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<FG>>(v1);
    }

    // decompiled from Move bytecode v6
}

