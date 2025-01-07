module 0xe083451bd316e23da576aff1d032e262800d11046c0c946b5ad1a2c16fb7b38d::hsh {
    struct HSH has drop {
        dummy_field: bool,
    }

    fun init(arg0: HSH, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<HSH>(arg0, 9, b"HSH", b"HUSH", b"AMPLIFY", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/d9e708ef-373e-406d-8498-0ef4e6e67f51.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<HSH>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<HSH>>(v1);
    }

    // decompiled from Move bytecode v6
}

