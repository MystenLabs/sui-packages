module 0xeee0f04fcc9ef734706e3bfc26c31db53ea702b2b1561679dda5c86f4f6580bc::chicoin47 {
    struct CHICOIN47 has drop {
        dummy_field: bool,
    }

    fun init(arg0: CHICOIN47, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<CHICOIN47>(arg0, 9, b"CHICOIN47", b"Chizzy", b"Simplicity taking you to the moon", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/7588e0d4-eb79-4da3-90fd-81980867ad2f.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<CHICOIN47>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<CHICOIN47>>(v1);
    }

    // decompiled from Move bytecode v6
}

