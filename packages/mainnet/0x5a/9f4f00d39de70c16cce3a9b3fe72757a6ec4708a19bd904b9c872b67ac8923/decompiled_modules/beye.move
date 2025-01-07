module 0x5a9f4f00d39de70c16cce3a9b3fe72757a6ec4708a19bd904b9c872b67ac8923::beye {
    struct BEYE has drop {
        dummy_field: bool,
    }

    fun init(arg0: BEYE, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<BEYE>(arg0, 9, b"BEYE", b"BIGEYE", b"BIG EYE", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/35afde46-e5f6-44e4-9886-d32dc755482a.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<BEYE>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<BEYE>>(v1);
    }

    // decompiled from Move bytecode v6
}

