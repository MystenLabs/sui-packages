module 0xf69a598277eb21526f81eb05ab8ed3754e65091ea9fb94d4837bd5c1f4e18d33::tuo {
    struct TUO has drop {
        dummy_field: bool,
    }

    fun init(arg0: TUO, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<TUO>(arg0, 9, b"TUO", b"FFWFA", b"FRTQ", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/f38c86db-a7a7-4f80-94ff-ccf21aa8ed2c.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<TUO>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<TUO>>(v1);
    }

    // decompiled from Move bytecode v6
}

