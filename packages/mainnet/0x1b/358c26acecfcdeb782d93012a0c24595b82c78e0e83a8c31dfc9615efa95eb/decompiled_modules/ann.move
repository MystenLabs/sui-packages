module 0x1b358c26acecfcdeb782d93012a0c24595b82c78e0e83a8c31dfc9615efa95eb::ann {
    struct ANN has drop {
        dummy_field: bool,
    }

    fun init(arg0: ANN, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<ANN>(arg0, 9, b"ANN", b"Ayoyinka H", b"Meme culture @Ann", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/192627b4-db99-4be0-9f5c-37d0ee1f700d.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<ANN>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<ANN>>(v1);
    }

    // decompiled from Move bytecode v6
}

