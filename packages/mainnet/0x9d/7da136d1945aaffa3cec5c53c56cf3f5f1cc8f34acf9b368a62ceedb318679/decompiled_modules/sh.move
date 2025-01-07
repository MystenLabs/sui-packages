module 0x9d7da136d1945aaffa3cec5c53c56cf3f5f1cc8f34acf9b368a62ceedb318679::sh {
    struct SH has drop {
        dummy_field: bool,
    }

    fun init(arg0: SH, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SH>(arg0, 9, b"SH", b"Sales ", b"Come to my party I am going ", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/53d4fb7a-d810-4930-b5d4-470103e979ef.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SH>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<SH>>(v1);
    }

    // decompiled from Move bytecode v6
}

