module 0xb6dc64dea47587df9383eb150f4e6613b881d839975cb0389e9c68a9400ab4a7::mondog {
    struct MONDOG has drop {
        dummy_field: bool,
    }

    fun init(arg0: MONDOG, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<MONDOG>(arg0, 9, b"MONDOG", b"MonkeyDoge", b"monkey dog to the moon", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/1d1e1717-7caf-4a59-a90c-368912af392d.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<MONDOG>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<MONDOG>>(v1);
    }

    // decompiled from Move bytecode v6
}

