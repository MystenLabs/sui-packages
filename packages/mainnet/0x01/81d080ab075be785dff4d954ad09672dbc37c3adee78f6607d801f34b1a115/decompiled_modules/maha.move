module 0x181d080ab075be785dff4d954ad09672dbc37c3adee78f6607d801f34b1a115::maha {
    struct MAHA has drop {
        dummy_field: bool,
    }

    fun init(arg0: MAHA, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<MAHA>(arg0, 6, b"MAHA", b"Make America Healthy Again", b"Make America Healthy Again ", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/IMG_20241117_002951_495_eaffd6b0e7.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<MAHA>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<MAHA>>(v1);
    }

    // decompiled from Move bytecode v6
}

