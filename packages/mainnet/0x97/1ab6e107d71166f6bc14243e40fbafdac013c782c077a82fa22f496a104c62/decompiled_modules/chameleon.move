module 0x971ab6e107d71166f6bc14243e40fbafdac013c782c077a82fa22f496a104c62::chameleon {
    struct CHAMELEON has drop {
        dummy_field: bool,
    }

    fun init(arg0: CHAMELEON, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<CHAMELEON>(arg0, 6, b"CHAMELEON", b"Sui Chameleon", b"This is the token that adapts, evolves, and dominates.  ", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/chame_1_1_05e764b293.gif")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<CHAMELEON>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<CHAMELEON>>(v1);
    }

    // decompiled from Move bytecode v6
}

