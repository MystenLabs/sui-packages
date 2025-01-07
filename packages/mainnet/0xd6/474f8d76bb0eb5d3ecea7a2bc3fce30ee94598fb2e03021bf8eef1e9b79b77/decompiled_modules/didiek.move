module 0xd6474f8d76bb0eb5d3ecea7a2bc3fce30ee94598fb2e03021bf8eef1e9b79b77::didiek {
    struct DIDIEK has drop {
        dummy_field: bool,
    }

    fun init(arg0: DIDIEK, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<DIDIEK>(arg0, 9, b"DIDIEK", b"Didik", b"Dibidik ir", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/b405c382-60b8-434c-9a0c-fccfa4a46b6f.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<DIDIEK>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<DIDIEK>>(v1);
    }

    // decompiled from Move bytecode v6
}

