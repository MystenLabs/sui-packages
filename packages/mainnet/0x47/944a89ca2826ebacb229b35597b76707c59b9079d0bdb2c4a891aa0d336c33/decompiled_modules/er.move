module 0x47944a89ca2826ebacb229b35597b76707c59b9079d0bdb2c4a891aa0d336c33::er {
    struct ER has drop {
        dummy_field: bool,
    }

    fun init(arg0: ER, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<ER>(arg0, 9, b"ER", b"HJF", b"DHFH", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/68b908fa-0f5d-4a59-8c98-240a1be31b6b.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<ER>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<ER>>(v1);
    }

    // decompiled from Move bytecode v6
}

