module 0xc6d4d73812a07cfa73b51a0c3ff774e1f6796f0de711a32b46c7b8f7bad4a182::top {
    struct TOP has drop {
        dummy_field: bool,
    }

    fun init(arg0: TOP, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<TOP>(arg0, 6, b"TOP", b"TOPURIA", b"Ilia Topuria, known as The Matador, is a mixed martial arts (MMA) fighter of Georgian-Spanish descent. Hes here to take down all other memes and claim the #1 spot in the world of memes.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/8a36ac7f_7114_447e_8125_f69e6dbba322_d83d8fceff.jpeg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<TOP>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<TOP>>(v1);
    }

    // decompiled from Move bytecode v6
}

