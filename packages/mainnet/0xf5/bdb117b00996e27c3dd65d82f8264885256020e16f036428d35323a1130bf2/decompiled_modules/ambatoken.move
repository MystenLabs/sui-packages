module 0xf5bdb117b00996e27c3dd65d82f8264885256020e16f036428d35323a1130bf2::ambatoken {
    struct AMBATOKEN has drop {
        dummy_field: bool,
    }

    fun init(arg0: AMBATOKEN, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<AMBATOKEN>(arg0, 9, b"AMBATOKEN", b"Ibnu Mundz", b"Meme for jmk", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/b76e3dca-d133-4113-8c77-624702e7dc53.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<AMBATOKEN>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<AMBATOKEN>>(v1);
    }

    // decompiled from Move bytecode v6
}

