module 0x7a7c8c107b8ecd5dee375522dc06523321292f44d355998ea7cde2d2193fb4ec::ok {
    struct OK has drop {
        dummy_field: bool,
    }

    fun init(arg0: OK, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<OK>(arg0, 9, b"OK", b"Bkqckes", b"Memecoin", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/d78fb291-804a-494a-aa00-6aeedd588783.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<OK>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<OK>>(v1);
    }

    // decompiled from Move bytecode v6
}

