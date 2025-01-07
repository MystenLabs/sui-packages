module 0xc5ec89be437d5461b591b6b554a933dd2a7916e0e30c0f9cbd784bc934dc5088::gombel {
    struct GOMBEL has drop {
        dummy_field: bool,
    }

    fun init(arg0: GOMBEL, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<GOMBEL>(arg0, 9, b"GOMBEL", b"Wewe", b"Hantuuu", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/15bc3fa2-85f4-4cf5-a1c4-edd2fb9aa4cf.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<GOMBEL>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<GOMBEL>>(v1);
    }

    // decompiled from Move bytecode v6
}

