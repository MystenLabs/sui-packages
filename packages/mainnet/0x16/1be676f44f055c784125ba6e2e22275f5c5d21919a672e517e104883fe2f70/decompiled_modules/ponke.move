module 0x161be676f44f055c784125ba6e2e22275f5c5d21919a672e517e104883fe2f70::ponke {
    struct PONKE has drop {
        dummy_field: bool,
    }

    fun init(arg0: PONKE, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<PONKE>(arg0, 9, b"PONKE", b"Ponke", x"68692049e280996d20506f6e6b65", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/14fe16b7-587d-4b94-97f3-c2fd58c41442.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<PONKE>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<PONKE>>(v1);
    }

    // decompiled from Move bytecode v6
}

