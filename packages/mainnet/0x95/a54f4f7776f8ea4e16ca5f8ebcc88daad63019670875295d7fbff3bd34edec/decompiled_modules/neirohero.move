module 0x95a54f4f7776f8ea4e16ca5f8ebcc88daad63019670875295d7fbff3bd34edec::neirohero {
    struct NEIROHERO has drop {
        dummy_field: bool,
    }

    fun init(arg0: NEIROHERO, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<NEIROHERO>(arg0, 6, b"NeiroHero", b"Suiper Neiro", b"Cat with superpowers.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/o_PNXA_Pz_G_400x400_effc427b7f.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<NEIROHERO>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<NEIROHERO>>(v1);
    }

    // decompiled from Move bytecode v6
}

