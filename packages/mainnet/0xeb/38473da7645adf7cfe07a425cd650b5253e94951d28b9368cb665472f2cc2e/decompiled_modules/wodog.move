module 0xeb38473da7645adf7cfe07a425cd650b5253e94951d28b9368cb665472f2cc2e::wodog {
    struct WODOG has drop {
        dummy_field: bool,
    }

    fun init(arg0: WODOG, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<WODOG>(arg0, 9, b"WODOG", b"Galimeme", b"Ez money powered by trump ", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/cca40a30-a8c3-4bcb-a03b-0e32e4dfb3fa.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<WODOG>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<WODOG>>(v1);
    }

    // decompiled from Move bytecode v6
}

