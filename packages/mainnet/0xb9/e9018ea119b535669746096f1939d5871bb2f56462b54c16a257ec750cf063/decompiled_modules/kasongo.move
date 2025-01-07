module 0xb9e9018ea119b535669746096f1939d5871bb2f56462b54c16a257ec750cf063::kasongo {
    struct KASONGO has drop {
        dummy_field: bool,
    }

    fun init(arg0: KASONGO, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<KASONGO>(arg0, 9, b"KASONGO", b"Warthog ", b"Warthog nicknamed kasongo is trending with it's V12 cylinder engine the celebrity pig ", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/2d3f6ae2-43c1-4c6f-ba24-f647236f0d47.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<KASONGO>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<KASONGO>>(v1);
    }

    // decompiled from Move bytecode v6
}

