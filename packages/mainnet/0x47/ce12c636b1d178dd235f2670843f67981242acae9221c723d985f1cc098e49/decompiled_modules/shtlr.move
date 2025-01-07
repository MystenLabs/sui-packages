module 0x47ce12c636b1d178dd235f2670843f67981242acae9221c723d985f1cc098e49::shtlr {
    struct SHTLR has drop {
        dummy_field: bool,
    }

    fun init(arg0: SHTLR, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SHTLR>(arg0, 6, b"SHTLR", b"SUITLER", b"He is back", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/adolf_hitler_military_uniform_when_he_chancellor_440nw_10282705a_42801b0777.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SHTLR>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SHTLR>>(v1);
    }

    // decompiled from Move bytecode v6
}

