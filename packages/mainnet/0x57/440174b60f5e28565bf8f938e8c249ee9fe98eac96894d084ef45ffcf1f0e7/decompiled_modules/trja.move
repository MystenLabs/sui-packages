module 0x57440174b60f5e28565bf8f938e8c249ee9fe98eac96894d084ef45ffcf1f0e7::trja {
    struct TRJA has drop {
        dummy_field: bool,
    }

    fun init(arg0: TRJA, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<TRJA>(arg0, 9, b"TRJA", b"Toraja", b"ajajaj", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/8982f85d-0cb6-4501-8e6b-561a4be019dd.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<TRJA>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<TRJA>>(v1);
    }

    // decompiled from Move bytecode v6
}

