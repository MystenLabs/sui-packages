module 0x6036af1fb6b73a7b48c7757fae08d1e700429af66e838ec705f4f6d9b01b965a::todad {
    struct TODAD has drop {
        dummy_field: bool,
    }

    fun init(arg0: TODAD, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<TODAD>(arg0, 6, b"TODAD", b"TODAD SUI", b"Meet Todad the shape-shifting toad who can be anything ! One minute, hes the President , and the next, hes saving Gotham . Whether its political power or superhero swagger, Todads always hopping into the next role! ", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/qzpptop_400x400_3fc8310469.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<TODAD>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<TODAD>>(v1);
    }

    // decompiled from Move bytecode v6
}

