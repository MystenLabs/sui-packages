module 0xf5d0f5cfbd687fdbcfbc6e8de148a2510ef4590b2d734448ec9da8ca5b710b1a::notd {
    struct NOTD has drop {
        dummy_field: bool,
    }

    fun init(arg0: NOTD, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<NOTD>(arg0, 9, b"NOTD", b"NOTDOGS", b"Notdogs represents the humor in pretending to be something you're not. This lovable gang of impostors pokes fun at our tendency to disguise or misrepresent ourselves.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/b4ec84a0-3fca-4e5e-bca9-b004d5ca8483.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<NOTD>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<NOTD>>(v1);
    }

    // decompiled from Move bytecode v6
}

