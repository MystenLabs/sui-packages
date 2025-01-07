module 0xeb4f2a24919f6e260a1cef4810614da7bea4845146720c279b4e4b26f79136f::trja {
    struct TRJA has drop {
        dummy_field: bool,
    }

    fun init(arg0: TRJA, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<TRJA>(arg0, 9, b"TRJA", b"Toraja", b"ajajaj", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/ca27fe7d-655d-4e21-80db-cd86e5712ad6.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<TRJA>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<TRJA>>(v1);
    }

    // decompiled from Move bytecode v6
}

