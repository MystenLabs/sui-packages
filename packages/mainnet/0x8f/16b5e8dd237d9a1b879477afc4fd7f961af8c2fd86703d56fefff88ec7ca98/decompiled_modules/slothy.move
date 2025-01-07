module 0x8f16b5e8dd237d9a1b879477afc4fd7f961af8c2fd86703d56fefff88ec7ca98::slothy {
    struct SLOTHY has drop {
        dummy_field: bool,
    }

    fun init(arg0: SLOTHY, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SLOTHY>(arg0, 6, b"SLOTHY", b"Slothy", b"Slothy takes over SUI now", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/Herunterladen_436c710d62.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SLOTHY>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SLOTHY>>(v1);
    }

    // decompiled from Move bytecode v6
}

