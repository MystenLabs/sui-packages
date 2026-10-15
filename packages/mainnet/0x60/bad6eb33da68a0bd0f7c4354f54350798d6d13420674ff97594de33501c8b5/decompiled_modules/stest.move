module 0x60bad6eb33da68a0bd0f7c4354f54350798d6d13420674ff97594de33501c8b5::stest {
    struct STEST has drop {
        dummy_field: bool,
    }

    fun init(arg0: STEST, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<STEST>(arg0, 6, b"STEST", b"Sluice Test", b"Launch check for sluice.click. Not a real project; it is hidden from the board.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://sluice.click/i/ODRsxoJ8I5QU29dH")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<STEST>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<STEST>>(v1, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v7
}

