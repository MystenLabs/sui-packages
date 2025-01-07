module 0x6f27c2231dff3a0fbadd9c81185c80164ecabeb07389473066070cfb902834ca::bonnie {
    struct BONNIE has drop {
        dummy_field: bool,
    }

    fun init(arg0: BONNIE, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<BONNIE>(arg0, 9, b"BONNIE", b"Bonnie ", b"Adventure token ", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/3b0d22ad-60f6-496e-98e4-052d27f65d88.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<BONNIE>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<BONNIE>>(v1);
    }

    // decompiled from Move bytecode v6
}

