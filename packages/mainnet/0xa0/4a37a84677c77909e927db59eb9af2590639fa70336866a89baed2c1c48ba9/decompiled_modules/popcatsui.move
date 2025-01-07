module 0xa04a37a84677c77909e927db59eb9af2590639fa70336866a89baed2c1c48ba9::popcatsui {
    struct POPCATSUI has drop {
        dummy_field: bool,
    }

    fun init(arg0: POPCATSUI, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<POPCATSUI>(arg0, 6, b"POPCATSUI", b"PopCatSui", b"Welcome to our sneaky launch, if you prepare this at the beginning of the biggest memecoin of the network SUI", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/pop_cat_bd2583391d.gif")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<POPCATSUI>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<POPCATSUI>>(v1);
    }

    // decompiled from Move bytecode v6
}

