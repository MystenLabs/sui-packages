module 0x9b7586b00b1789b6c7eb0600d2ad8620d4bcd04525651a34c8f6b1c114a34ffd::tuo {
    struct TUO has drop {
        dummy_field: bool,
    }

    fun init(arg0: TUO, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<TUO>(arg0, 9, b"TUO", b"FFWAAF", b"FRTQ", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/6f0ad76a-f4d6-4e0d-96f6-b8fc05fe2f11.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<TUO>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<TUO>>(v1);
    }

    // decompiled from Move bytecode v6
}

