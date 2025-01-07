module 0xf1ed997ed8f39354d5f89507c58360a826e16061ef797f9f830bbf4190afa2a6::nemesis {
    struct NEMESIS has drop {
        dummy_field: bool,
    }

    fun init(arg0: NEMESIS, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<NEMESIS>(arg0, 6, b"Nemesis", b"Nemesis on SUI", b"Loyalty is Key", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/Hh_Zph_Dqk_400x400_6987f44b8f.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<NEMESIS>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<NEMESIS>>(v1);
    }

    // decompiled from Move bytecode v6
}

