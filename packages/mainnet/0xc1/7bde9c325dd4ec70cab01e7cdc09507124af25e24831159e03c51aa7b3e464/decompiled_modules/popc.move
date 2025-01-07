module 0xc17bde9c325dd4ec70cab01e7cdc09507124af25e24831159e03c51aa7b3e464::popc {
    struct POPC has drop {
        dummy_field: bool,
    }

    fun init(arg0: POPC, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<POPC>(arg0, 6, b"POPC", b"POP Chicken", b"POP when Cooking", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/IMG_4359_830d1faf56.jpeg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<POPC>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<POPC>>(v1);
    }

    // decompiled from Move bytecode v6
}

