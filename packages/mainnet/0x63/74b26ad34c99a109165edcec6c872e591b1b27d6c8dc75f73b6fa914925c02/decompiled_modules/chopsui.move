module 0x6374b26ad34c99a109165edcec6c872e591b1b27d6c8dc75f73b6fa914925c02::chopsui {
    struct CHOPSUI has drop {
        dummy_field: bool,
    }

    fun init(arg0: CHOPSUI, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<CHOPSUI>(arg0, 6, b"CHOPSUI", b"ChopSui", b"we all know without saying it ", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/chop_suey_08725467bb.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<CHOPSUI>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<CHOPSUI>>(v1);
    }

    // decompiled from Move bytecode v6
}

