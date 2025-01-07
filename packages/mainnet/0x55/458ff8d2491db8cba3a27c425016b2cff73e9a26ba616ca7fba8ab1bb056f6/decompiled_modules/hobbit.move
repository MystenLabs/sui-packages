module 0x55458ff8d2491db8cba3a27c425016b2cff73e9a26ba616ca7fba8ab1bb056f6::hobbit {
    struct HOBBIT has drop {
        dummy_field: bool,
    }

    fun init(arg0: HOBBIT, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<HOBBIT>(arg0, 6, b"Hobbit", b"HOPBIT", b"...", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/IMG_0157_a9ba473fae.jpeg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<HOBBIT>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<HOBBIT>>(v1);
    }

    // decompiled from Move bytecode v6
}

