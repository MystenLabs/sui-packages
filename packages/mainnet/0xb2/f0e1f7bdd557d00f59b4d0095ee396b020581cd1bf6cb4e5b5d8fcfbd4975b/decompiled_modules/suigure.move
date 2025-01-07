module 0xb2f0e1f7bdd557d00f59b4d0095ee396b020581cd1bf6cb4e5b5d8fcfbd4975b::suigure {
    struct SUIGURE has drop {
        dummy_field: bool,
    }

    fun init(arg0: SUIGURE, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SUIGURE>(arg0, 6, b"SUIgure", b"SHIGURE", b"Roll with the $SUIgure Crew: Shigure Badass Gang Bringing the Fun and Flavor to Crypto Dominance!", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/ezgif_6_0b79c66c1e_4a1d8ca8b1_e4710d0118.gif")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SUIGURE>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SUIGURE>>(v1);
    }

    // decompiled from Move bytecode v6
}

