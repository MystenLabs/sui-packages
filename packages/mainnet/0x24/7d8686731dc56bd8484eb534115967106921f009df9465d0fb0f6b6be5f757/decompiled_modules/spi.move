module 0x247d8686731dc56bd8484eb534115967106921f009df9465d0fb0f6b6be5f757::spi {
    struct SPI has drop {
        dummy_field: bool,
    }

    fun init(arg0: SPI, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SPI>(arg0, 9, b"SPI", b"Spider", b"Spider token for wewe project", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/e588e716-4b46-4eca-8146-fed36840ffc6.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SPI>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<SPI>>(v1);
    }

    // decompiled from Move bytecode v6
}

