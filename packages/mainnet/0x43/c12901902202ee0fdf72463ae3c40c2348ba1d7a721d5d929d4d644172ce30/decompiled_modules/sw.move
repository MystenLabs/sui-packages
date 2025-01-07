module 0x43c12901902202ee0fdf72463ae3c40c2348ba1d7a721d5d929d4d644172ce30::sw {
    struct SW has drop {
        dummy_field: bool,
    }

    fun init(arg0: SW, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SW>(arg0, 9, b"SW", b"siberian", b"siberian wolf", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/d6704c7c-4d39-43ea-8864-e58c0e9acc6a.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SW>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<SW>>(v1);
    }

    // decompiled from Move bytecode v6
}

