module 0xfd3b4a58c5c2403a958993abfca9a9b29fff5a5b83be85505300a3834036af50::memepov {
    struct MEMEPOV has drop {
        dummy_field: bool,
    }

    fun init(arg0: MEMEPOV, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<MEMEPOV>(arg0, 9, b"MEMEPOV", b"Pov Token", b"Pov meme token", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/3bcad99c-1ba7-45ec-8367-8c7bfe29be1f.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<MEMEPOV>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<MEMEPOV>>(v1);
    }

    // decompiled from Move bytecode v6
}

