module 0x26ef99613828b642dc46d21a63d7cbcc5851837580d999bc4adbe4bb0a9e4f0c::tino_45 {
    struct TINO_45 has drop {
        dummy_field: bool,
    }

    fun init(arg0: TINO_45, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<TINO_45>(arg0, 9, b"TINO_45", b"Tino", b"Tino for fun", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/02caebde-358d-47b9-8bad-4173374c3a63.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<TINO_45>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<TINO_45>>(v1);
    }

    // decompiled from Move bytecode v6
}

