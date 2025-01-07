module 0x759653fec2f45da2f111e667eafb35953ba5078c5b0347fd557e06cdccf47bdd::pts {
    struct PTS has drop {
        dummy_field: bool,
    }

    fun init(arg0: PTS, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<PTS>(arg0, 6, b"PTS", b"PUNKS THE SUI", x"50554e4b5320544845205355490a", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/Design_sem_nome_56_7a38a3885f.gif")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<PTS>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<PTS>>(v1);
    }

    // decompiled from Move bytecode v6
}

