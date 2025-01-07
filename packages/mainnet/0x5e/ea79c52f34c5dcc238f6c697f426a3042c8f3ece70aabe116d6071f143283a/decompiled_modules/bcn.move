module 0x5eea79c52f34c5dcc238f6c697f426a3042c8f3ece70aabe116d6071f143283a::bcn {
    struct BCN has drop {
        dummy_field: bool,
    }

    fun init(arg0: BCN, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<BCN>(arg0, 9, b"BCN", b"GHK", b"BXCVB", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/b53e6802-e720-4400-9fb3-d43928f8f903.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<BCN>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<BCN>>(v1);
    }

    // decompiled from Move bytecode v6
}

