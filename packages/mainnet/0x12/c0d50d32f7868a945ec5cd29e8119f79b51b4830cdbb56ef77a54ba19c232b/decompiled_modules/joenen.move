module 0x12c0d50d32f7868a945ec5cd29e8119f79b51b4830cdbb56ef77a54ba19c232b::joenen {
    struct JOENEN has drop {
        dummy_field: bool,
    }

    fun init(arg0: JOENEN, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<JOENEN>(arg0, 9, b"JOENEN", b"jenen", b"gebeb", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/1b0c233f-6614-4907-a168-fe2a536363dc.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<JOENEN>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<JOENEN>>(v1);
    }

    // decompiled from Move bytecode v6
}

