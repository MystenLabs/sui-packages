module 0x3b55f92c7cc5b516293ccce767f9e6ac69c22cbd141e217761792577f37bcaa6::trja {
    struct TRJA has drop {
        dummy_field: bool,
    }

    fun init(arg0: TRJA, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<TRJA>(arg0, 9, b"TRJA", b"Toraja", b"ajajaj", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/805f9852-dada-416d-9465-318a62616a63.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<TRJA>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<TRJA>>(v1);
    }

    // decompiled from Move bytecode v6
}

