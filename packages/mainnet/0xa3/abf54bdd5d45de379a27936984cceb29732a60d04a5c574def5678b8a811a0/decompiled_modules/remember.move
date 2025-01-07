module 0xa3abf54bdd5d45de379a27936984cceb29732a60d04a5c574def5678b8a811a0::remember {
    struct REMEMBER has drop {
        dummy_field: bool,
    }

    fun init(arg0: REMEMBER, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<REMEMBER>(arg0, 6, b"REMEMBER", b"Voge for Vendetta", b"It is time to unite us all: \"There is no certainty, only opportunity\" $REMEMBER $REMEMBER You are Doge, You are Pepe, You are Voge", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/we_ready_ed7137ca3d.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<REMEMBER>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<REMEMBER>>(v1);
    }

    // decompiled from Move bytecode v6
}

