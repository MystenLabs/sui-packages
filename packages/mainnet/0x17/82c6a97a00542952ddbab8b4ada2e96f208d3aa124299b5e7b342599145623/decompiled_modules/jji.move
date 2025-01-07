module 0x1782c6a97a00542952ddbab8b4ada2e96f208d3aa124299b5e7b342599145623::jji {
    struct JJI has drop {
        dummy_field: bool,
    }

    fun init(arg0: JJI, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<JJI>(arg0, 9, b"JJI", b"juice", b"Buy and be happy", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/c1d21d67-4eb5-4e39-888d-fe5ce3d2ef21.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<JJI>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<JJI>>(v1);
    }

    // decompiled from Move bytecode v6
}

