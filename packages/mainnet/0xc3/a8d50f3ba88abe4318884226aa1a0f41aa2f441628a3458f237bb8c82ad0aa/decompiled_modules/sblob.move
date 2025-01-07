module 0xc3a8d50f3ba88abe4318884226aa1a0f41aa2f441628a3458f237bb8c82ad0aa::sblob {
    struct SBLOB has drop {
        dummy_field: bool,
    }

    fun init(arg0: SBLOB, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SBLOB>(arg0, 6, b"SBLOB", b"Space BLOB", b"Achieve your dreams before Space BLOB brings you to your end!", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/565_c2bf6a7242.gif")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SBLOB>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SBLOB>>(v1);
    }

    // decompiled from Move bytecode v6
}

