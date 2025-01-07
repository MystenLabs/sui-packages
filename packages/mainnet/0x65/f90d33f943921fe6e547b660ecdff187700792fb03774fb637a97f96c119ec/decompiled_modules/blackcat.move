module 0x65f90d33f943921fe6e547b660ecdff187700792fb03774fb637a97f96c119ec::blackcat {
    struct BLACKCAT has drop {
        dummy_field: bool,
    }

    fun init(arg0: BLACKCAT, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<BLACKCAT>(arg0, 6, b"Blackcat", b"Black cat", b"Legend has it that black cats have mysterious abilities", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/screenshot_20241022_152945_4fceba6e0e.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<BLACKCAT>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<BLACKCAT>>(v1);
    }

    // decompiled from Move bytecode v6
}

