module 0xe6d83c78eb5d6e5a8579b3a6b479f53d4c49ceb18a20feca29177350792bdcc5::notcoinn {
    struct NOTCOINN has drop {
        dummy_field: bool,
    }

    fun init(arg0: NOTCOINN, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<NOTCOINN>(arg0, 9, b"NOTCOINN", b"Notcoin", b"notcoi for trading", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/c480f22b-8fa9-45c0-91e1-efeafe4ff376.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<NOTCOINN>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<NOTCOINN>>(v1);
    }

    // decompiled from Move bytecode v6
}

