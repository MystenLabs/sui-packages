module 0x674836d086b14b7bae5508fb0e24d01965059891bd63f5cbe986e9ec9dc36e13::re {
    struct RE has drop {
        dummy_field: bool,
    }

    fun init(arg0: RE, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<RE>(arg0, 9, b"RE", b"Eiee", b"Rr", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/2f588307-8700-4613-ae53-d74503fbcd62.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<RE>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<RE>>(v1);
    }

    // decompiled from Move bytecode v6
}

