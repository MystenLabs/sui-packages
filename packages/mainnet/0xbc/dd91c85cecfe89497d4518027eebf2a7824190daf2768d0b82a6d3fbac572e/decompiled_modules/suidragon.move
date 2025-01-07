module 0xbcdd91c85cecfe89497d4518027eebf2a7824190daf2768d0b82a6d3fbac572e::suidragon {
    struct SUIDRAGON has drop {
        dummy_field: bool,
    }

    fun init(arg0: SUIDRAGON, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SUIDRAGON>(arg0, 6, b"SUIDRAGON", b"SUI DRAGON CTO", b"lets cto this shit fuck dev who rugged", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/SUI_DRAGON_901901c560.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SUIDRAGON>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SUIDRAGON>>(v1);
    }

    // decompiled from Move bytecode v6
}

