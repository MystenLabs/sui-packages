module 0x4cedfc0d19b9603af0b94f149966b52d9d7902d1d341b4d4378d844e13284658::daden {
    struct DADEN has drop {
        dummy_field: bool,
    }

    fun init(arg0: DADEN, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<DADEN>(arg0, 9, b"DADEN", b"KTH", b"Meme", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/7fb06d71-9d5d-4682-b580-b6067578b1c7.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<DADEN>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<DADEN>>(v1);
    }

    // decompiled from Move bytecode v6
}

