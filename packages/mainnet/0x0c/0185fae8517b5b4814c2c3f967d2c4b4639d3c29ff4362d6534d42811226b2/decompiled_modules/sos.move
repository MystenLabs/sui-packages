module 0xc0185fae8517b5b4814c2c3f967d2c4b4639d3c29ff4362d6534d42811226b2::sos {
    struct SOS has drop {
        dummy_field: bool,
    }

    fun init(arg0: SOS, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SOS>(arg0, 9, b"SOS", b"Sui Or Siu", b"Special tokens for Ronaldo's die-hard fans, one of which is ishowspeed ", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/0b7facd5-4c2e-482d-bbf8-b67abbc90d6b.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SOS>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<SOS>>(v1);
    }

    // decompiled from Move bytecode v6
}

