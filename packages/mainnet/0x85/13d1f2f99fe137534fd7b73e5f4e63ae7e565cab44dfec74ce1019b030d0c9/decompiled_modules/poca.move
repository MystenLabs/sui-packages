module 0x8513d1f2f99fe137534fd7b73e5f4e63ae7e565cab44dfec74ce1019b030d0c9::poca {
    struct POCA has drop {
        dummy_field: bool,
    }

    fun init(arg0: POCA, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<POCA>(arg0, 6, b"POCA", b"POLAR CAT", b"Polar who?  Wait... POLAR CAT?", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/POCA_1acd90619b.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<POCA>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<POCA>>(v1);
    }

    // decompiled from Move bytecode v6
}

