module 0xe956783d7026edfd64998d453d897c357f85e80ad5753b26e0530be375892a8c::trja {
    struct TRJA has drop {
        dummy_field: bool,
    }

    fun init(arg0: TRJA, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<TRJA>(arg0, 9, b"TRJA", b"Toraja", b"ajajaj", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/6ff82b60-3e9a-4da4-9e83-b6b2f573daf2.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<TRJA>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<TRJA>>(v1);
    }

    // decompiled from Move bytecode v6
}

