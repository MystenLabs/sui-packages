module 0x4de1d0f48b9b2ddd35e904cf522ec3d336f2656951ce1d3a90e25b774432bec9::z {
    struct Z has drop {
        dummy_field: bool,
    }

    fun init(arg0: Z, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<Z>(arg0, 9, b"Z", b"Z coin", x"f09f87b7f09f87ba", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/26d243ad-e071-47cf-8860-2aa2637ad0e9.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<Z>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<Z>>(v1);
    }

    // decompiled from Move bytecode v6
}

