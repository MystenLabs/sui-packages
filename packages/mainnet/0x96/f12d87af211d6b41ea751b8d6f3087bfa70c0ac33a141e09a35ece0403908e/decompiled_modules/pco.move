module 0x96f12d87af211d6b41ea751b8d6f3087bfa70c0ac33a141e09a35ece0403908e::pco {
    struct PCO has drop {
        dummy_field: bool,
    }

    fun init(arg0: PCO, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<PCO>(arg0, 9, b"PCO", b"pico", x"7069636f20636f696e20f09f9388f09f9388f09f9388f09f9388f09f9388", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/8cfbef2e-a042-4461-9c8a-fb1fea370420.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<PCO>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<PCO>>(v1);
    }

    // decompiled from Move bytecode v6
}

