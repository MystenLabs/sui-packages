module 0x82853665dcd5a67807de5cdd4c5fa6cc4c88715643eba7924a0bdd6eef16796::pdi {
    struct PDI has drop {
        dummy_field: bool,
    }

    fun init(arg0: PDI, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<PDI>(arg0, 9, b"PDI", b"P. Diddy", b"Dear and good boy", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/fe838b77-f7c6-4002-9cef-483cdec13f9f.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<PDI>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<PDI>>(v1);
    }

    // decompiled from Move bytecode v6
}

