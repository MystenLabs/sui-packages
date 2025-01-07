module 0x11e522c1f4e9d94b0bc82b1cd7d2483ed662877fce149fae080920a1864a1a00::dogggg {
    struct DOGGGG has drop {
        dummy_field: bool,
    }

    fun init(arg0: DOGGGG, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<DOGGGG>(arg0, 9, b"DOGGGG", b"DOGGG", b"DOGGGGG", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/6fb58d50-21da-4bd1-ad02-eb69e1a00659.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<DOGGGG>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<DOGGGG>>(v1);
    }

    // decompiled from Move bytecode v6
}

