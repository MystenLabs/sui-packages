module 0x803b1aa247aa0de1778f6eb291f3c6732abd1bb90780bc0aa7c513dbb7749a94::forg {
    struct FORG has drop {
        dummy_field: bool,
    }

    fun init(arg0: FORG, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<FORG>(arg0, 6, b"FORG", b"FORG ON SUI", x"54686520756c74696d6174652065766f6c7574696f6e206f662050657065206279200a404d6174745f46757269650a2e205050502024464f5247206275696c64206f6e2023535549", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/forg_lgo_d13e2f904b.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<FORG>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<FORG>>(v1);
    }

    // decompiled from Move bytecode v6
}

