module 0x6b4be4c9c2f18a5bbf7792588a097141dfac39c4eb72958b77c85740f8a330b3::pic {
    struct PIC has drop {
        dummy_field: bool,
    }

    fun init(arg0: PIC, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<PIC>(arg0, 9, b"PIC", b"Picker", b"The Dev's pav ", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/d7048b3d-ed1a-4159-aaa4-8c6615ffae75.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<PIC>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<PIC>>(v1);
    }

    // decompiled from Move bytecode v6
}

