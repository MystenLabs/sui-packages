module 0x7ac0bd60961d5d2d0ee0671e717fc19b2f0d0b614c4ce9063ec19c4b788a7d82::pleinphare {
    struct PLEINPHARE has drop {
        dummy_field: bool,
    }

    fun init(arg0: PLEINPHARE, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<PLEINPHARE>(arg0, 6, b"PLEINPHARE", b"DX", b"Ne bougez surtout pas.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/siege_gamer_dxracer_formula_08_series_gc_f08_nr_h1_1172637570.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<PLEINPHARE>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<PLEINPHARE>>(v1);
    }

    // decompiled from Move bytecode v6
}

