module 0x36434324dea12a2e5bb5f59ac39b72f771c50673c6dacb8f3771f695e8754d3f::mame {
    struct MAME has drop {
        dummy_field: bool,
    }

    fun init(arg0: MAME, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<MAME>(arg0, 9, b"MAME", b"KKK", b"new", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/3b2102db-e0f4-4fec-81a7-b0f6056f640b.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<MAME>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<MAME>>(v1);
    }

    // decompiled from Move bytecode v6
}

