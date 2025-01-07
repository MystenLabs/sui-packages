module 0x3ab30096d49d8603032cb1c5ca77b0a82ad7e389f23e83c6ecc6158905837dfc::navanh {
    struct NAVANH has drop {
        dummy_field: bool,
    }

    fun init(arg0: NAVANH, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<NAVANH>(arg0, 9, b"NAVANH", b"DAN", b"My baby of us", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/e3374b83-dc99-4f38-82b5-31333a869402.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<NAVANH>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<NAVANH>>(v1);
    }

    // decompiled from Move bytecode v6
}

