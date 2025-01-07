module 0x440e2c9f6ef4878ef2529656893ac60e6deb34191fd84da86336d07afce5de51::feline {
    struct FELINE has drop {
        dummy_field: bool,
    }

    fun init(arg0: FELINE, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<FELINE>(arg0, 6, b"Feline", b"Feline Ze Cat", b"Feline ze cat mi name, meow!", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/logo_858563d9c1.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<FELINE>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<FELINE>>(v1);
    }

    // decompiled from Move bytecode v6
}

