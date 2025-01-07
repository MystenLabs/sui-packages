module 0xac372b0dcc706e5b42d97d4b85d47f28d925772df774c6eaf38930bece4d3ad1::skurtl {
    struct SKURTL has drop {
        dummy_field: bool,
    }

    fun init(arg0: SKURTL, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SKURTL>(arg0, 6, b"SKURTL", b"SuiSkurtl", b"$SKURTL Totally gnarly, dude! This SoCal skaters shredding outta the gate like a stoked turtle on a perfect halfpipe! Movepump.com better buckle up cause were launching into first place. With this killer crew behind me, the skys the limit  gonna be epic!", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/1000001698_7fc8fcca92.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SKURTL>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SKURTL>>(v1);
    }

    // decompiled from Move bytecode v6
}

