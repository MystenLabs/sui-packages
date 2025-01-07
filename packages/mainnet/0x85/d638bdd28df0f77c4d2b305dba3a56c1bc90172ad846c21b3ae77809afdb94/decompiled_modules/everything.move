module 0x85d638bdd28df0f77c4d2b305dba3a56c1bc90172ad846c21b3ae77809afdb94::everything {
    struct EVERYTHING has drop {
        dummy_field: bool,
    }

    fun init(arg0: EVERYTHING, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<EVERYTHING>(arg0, 9, b"EVERYTHING", b"OnOff", x"596f752063616e20646f2065766572797468696e6720f09f989c", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/4a8c3282-d237-4f5e-99ab-993c2f8916a5.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<EVERYTHING>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<EVERYTHING>>(v1);
    }

    // decompiled from Move bytecode v6
}

