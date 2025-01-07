module 0xa554515685f76af2977c89b2ec3608998c5e9b5d53860c5b5f16efa342278e9d::tomas {
    struct TOMAS has drop {
        dummy_field: bool,
    }

    fun init(arg0: TOMAS, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<TOMAS>(arg0, 9, b"TOMAS", b"Tomato", b"the most expensive cat of the royal breed...!", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/ae6b81ba-a740-43b2-af26-161c56cec5e3.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<TOMAS>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<TOMAS>>(v1);
    }

    // decompiled from Move bytecode v6
}

