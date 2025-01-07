module 0x34dd5d71804622584075fc765a0f83f8f1ee63ed862630fec9fc17be5837dab0::dodo {
    struct DODO has drop {
        dummy_field: bool,
    }

    fun init(arg0: DODO, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<DODO>(arg0, 6, b"DODO", b"DODO BANANA", b"DODODODODODODODODOODODODODOOD ", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/96e07cc171c7a6df835abbfc70510eb9_71a051eb45.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<DODO>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<DODO>>(v1);
    }

    // decompiled from Move bytecode v6
}

