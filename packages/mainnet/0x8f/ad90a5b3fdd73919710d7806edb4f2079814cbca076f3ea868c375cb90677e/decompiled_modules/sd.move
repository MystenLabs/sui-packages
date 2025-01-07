module 0x8fad90a5b3fdd73919710d7806edb4f2079814cbca076f3ea868c375cb90677e::sd {
    struct SD has drop {
        dummy_field: bool,
    }

    fun init(arg0: SD, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SD>(arg0, 9, b"SD", b"GHDF", b"FGSD", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/8252f9f6-9773-455e-9e16-3aa1493c2735.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SD>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<SD>>(v1);
    }

    // decompiled from Move bytecode v6
}

