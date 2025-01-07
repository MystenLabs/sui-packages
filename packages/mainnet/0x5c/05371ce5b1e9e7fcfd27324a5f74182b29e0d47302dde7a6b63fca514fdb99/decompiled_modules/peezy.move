module 0x5c05371ce5b1e9e7fcfd27324a5f74182b29e0d47302dde7a6b63fca514fdb99::peezy {
    struct PEEZY has drop {
        dummy_field: bool,
    }

    fun init(arg0: PEEZY, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<PEEZY>(arg0, 6, b"PEEZY", b"PEEZY ON SUI", b"$PEEZY coin has no association with Matt Furie or his creation Peezy/Pepe", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/cropped_peezy_logo_2_transparent_Circle_660px_180x180_aa0fe24802.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<PEEZY>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<PEEZY>>(v1);
    }

    // decompiled from Move bytecode v6
}

