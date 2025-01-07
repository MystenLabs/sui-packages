module 0xff20a2f0ceb5422fd05f76edae902180bfa65ac45d6f9fe8b4d4cd56b1ae738b::versus {
    struct VERSUS has drop {
        dummy_field: bool,
    }

    fun init(arg0: VERSUS, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<VERSUS>(arg0, 9, b"VERSUS", b"Dog x hams", b"Dogs and hamster telegram", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/1bb229bb-ba02-4616-850e-fafd41b3afa9.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<VERSUS>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<VERSUS>>(v1);
    }

    // decompiled from Move bytecode v6
}

