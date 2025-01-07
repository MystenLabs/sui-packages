module 0xb434f4942e61dd22bdc55e7196403faa30325f68d26915f7231160678fadad2a::artist {
    struct ARTIST has drop {
        dummy_field: bool,
    }

    fun init(arg0: ARTIST, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<ARTIST>(arg0, 9, b"ARTIST", b"Nawaz khan", b"Nawaz khan coin developed on sui blockchain", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/ffe442ae-cdd3-48ff-9318-4a2bc08e1ea3.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<ARTIST>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<ARTIST>>(v1);
    }

    // decompiled from Move bytecode v6
}

