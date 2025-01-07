module 0xdf9aed98d76f04d67d84faebf5e7d4cc139e86796df3b1b3fa1dc2b933f870a9::kb {
    struct KB has drop {
        dummy_field: bool,
    }

    fun init(arg0: KB, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<KB>(arg0, 9, b"KB", b"Kha", b"Kha Banh", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/a0c773d5-1651-420e-aa72-d6e2283edb9d.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<KB>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<KB>>(v1);
    }

    // decompiled from Move bytecode v6
}

