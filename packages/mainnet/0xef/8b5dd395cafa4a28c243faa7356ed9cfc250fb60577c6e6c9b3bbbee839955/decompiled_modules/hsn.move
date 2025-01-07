module 0xef8b5dd395cafa4a28c243faa7356ed9cfc250fb60577c6e6c9b3bbbee839955::hsn {
    struct HSN has drop {
        dummy_field: bool,
    }

    fun init(arg0: HSN, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<HSN>(arg0, 9, b"HSN", b"Hasan", b"My Husband", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/28fa66f3-25d4-42a4-9ec6-a0a681438420.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<HSN>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<HSN>>(v1);
    }

    // decompiled from Move bytecode v6
}

