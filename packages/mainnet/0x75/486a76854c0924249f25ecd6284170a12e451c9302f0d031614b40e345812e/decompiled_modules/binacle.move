module 0x75486a76854c0924249f25ecd6284170a12e451c9302f0d031614b40e345812e::binacle {
    struct BINACLE has drop {
        dummy_field: bool,
    }

    fun init(arg0: BINACLE, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<BINACLE>(arg0, 6, b"BINACLE", b"Binary Oracle", b"01101110 01101111 01110100 00100000 01100001 01101110 01101111 01110100 01101000 01100101 01110010 00100000 01100001 01100111 01100101 01101110 01110100", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/cut_e200646d2d.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<BINACLE>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<BINACLE>>(v1);
    }

    // decompiled from Move bytecode v6
}

