module 0x39f82e900b7bac9bb38210f89ed831d1be79b82b62d37bbea7f50011e6112218::maneki {
    struct MANEKI has drop {
        dummy_field: bool,
    }

    fun init(arg0: MANEKI, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<MANEKI>(arg0, 6, b"MANEKI", b"MANEKItokenSui", b"from warrior cats' dreams, where shadows fall, $MANEKI neko answers their call.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/Afn_E_Gf96_400x400_bb09c25e44.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<MANEKI>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<MANEKI>>(v1);
    }

    // decompiled from Move bytecode v6
}

