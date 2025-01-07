module 0x3580fd1ac94d6b369bba9544147e357d37175ba93e0a33b32c799a863f1c03b5::dumbo {
    struct DUMBO has drop {
        dummy_field: bool,
    }

    fun init(arg0: DUMBO, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<DUMBO>(arg0, 6, b"DUMBO", b"DUMBOSUI", b"Dumbo Octopus is a small octopus that has a unique and adorable appearance. He lives in a super distant and dark place", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/20241005_005818_7c9636cb23.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<DUMBO>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<DUMBO>>(v1);
    }

    // decompiled from Move bytecode v6
}

