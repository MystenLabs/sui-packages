module 0x27fe1bf3c6d29f82b4fe3153c0968318722375e5c2dcb5d46b85841f2898813b::gee {
    struct GEE has drop {
        dummy_field: bool,
    }

    fun init(arg0: GEE, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<GEE>(arg0, 9, b"GEE", b"GREEN", b"GREEN COLOR", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/c07e5eb4-3582-4750-9da5-63e5b8d21ab2.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<GEE>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<GEE>>(v1);
    }

    // decompiled from Move bytecode v6
}

