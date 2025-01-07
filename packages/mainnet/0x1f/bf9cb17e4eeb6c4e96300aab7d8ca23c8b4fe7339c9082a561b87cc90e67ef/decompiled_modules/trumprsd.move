module 0x1fbf9cb17e4eeb6c4e96300aab7d8ca23c8b4fe7339c9082a561b87cc90e67ef::trumprsd {
    struct TRUMPRSD has drop {
        dummy_field: bool,
    }

    fun init(arg0: TRUMPRSD, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<TRUMPRSD>(arg0, 9, b"TRUMPRSD", b"TRUMP", b"TRUMP PRESEDENT 2024", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/8f51f461-a887-41d6-88e6-2720025e8a25.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<TRUMPRSD>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<TRUMPRSD>>(v1);
    }

    // decompiled from Move bytecode v6
}

