module 0x434f666d152f1041fd8d33e56b2852340890e2faa5b383884276e419d0f870cb::notd {
    struct NOTD has drop {
        dummy_field: bool,
    }

    fun init(arg0: NOTD, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<NOTD>(arg0, 9, b"NOTD", b"NOTDOGS", b"Notdogs represents the humor in pretending to be something you're not. This lovable gang of impostors pokes fun at our tendency to disguise or misrepresent ourselves.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/9c1e513d-92e5-4f80-ac6f-41d5e364f270.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<NOTD>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<NOTD>>(v1);
    }

    // decompiled from Move bytecode v6
}

