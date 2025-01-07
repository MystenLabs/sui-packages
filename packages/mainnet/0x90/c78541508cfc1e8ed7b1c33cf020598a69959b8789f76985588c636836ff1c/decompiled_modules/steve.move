module 0x90c78541508cfc1e8ed7b1c33cf020598a69959b8789f76985588c636836ff1c::steve {
    struct STEVE has drop {
        dummy_field: bool,
    }

    fun init(arg0: STEVE, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<STEVE>(arg0, 6, b"STEVE", b"Steve Boys Club", b"Supplying the Boys Club with the party essentials.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"http://movepump.xyz/uploads/4_Mr_HD_Eap_400x400_db8ecea90f.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<STEVE>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<STEVE>>(v1);
    }

    // decompiled from Move bytecode v6
}

