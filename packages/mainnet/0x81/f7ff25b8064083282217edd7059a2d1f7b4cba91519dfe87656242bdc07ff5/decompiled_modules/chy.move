module 0x81f7ff25b8064083282217edd7059a2d1f7b4cba91519dfe87656242bdc07ff5::chy {
    struct CHY has drop {
        dummy_field: bool,
    }

    fun init(arg0: CHY, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<CHY>(arg0, 9, b"CHY", b"Chucky", b"Remember Chucky? Now lets make scary money", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/d39ed207-6a77-42b0-b733-a6927c9b540d.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<CHY>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<CHY>>(v1);
    }

    // decompiled from Move bytecode v6
}

