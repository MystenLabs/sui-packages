module 0x78e531bcb8cc15fbdb1528815979418897bfe341db67bcd16106fb60c43f666f::egbz {
    struct EGBZ has drop {
        dummy_field: bool,
    }

    fun init(arg0: EGBZ, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<EGBZ>(arg0, 9, b"EGBZ", b"E G B Z", b"'EGBGZ'", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/f255db74-c074-42d2-8ccc-2c8e272528d2.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<EGBZ>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<EGBZ>>(v1);
    }

    // decompiled from Move bytecode v6
}

