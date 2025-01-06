module 0x11642359832ec3047b28c4c64e7d741eac81d575f9fbfdd5f8e632991f45956e::malic2 {
    struct MALIC2 has drop {
        dummy_field: bool,
    }

    fun init(arg0: MALIC2, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<MALIC2>(arg0, 9, b"MALIC2", b"Maliky", b"Treading ", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/a3308c2c-bf23-4086-98f1-7550108def23.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<MALIC2>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<MALIC2>>(v1);
    }

    // decompiled from Move bytecode v6
}

