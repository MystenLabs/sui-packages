module 0xff3ec338a2c843860006895e820ebac2130496305bb8d6d783222d172abd5db3::trpp {
    struct TRPP has drop {
        dummy_field: bool,
    }

    fun init(arg0: TRPP, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<TRPP>(arg0, 9, b"TRPP", b"TrumpPepe", b"Trump is President of Pepe", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/bc1666d0-2b23-46e3-b5fb-ca5b51e53d50.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<TRPP>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<TRPP>>(v1);
    }

    // decompiled from Move bytecode v6
}

