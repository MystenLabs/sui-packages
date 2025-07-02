module 0x3a1e7d512ab28cf2776bac962a6b9fcb0839fb843399dbfeafe1241c6814840c::blbul {
    struct BLBUL has drop {
        dummy_field: bool,
    }

    fun init(arg0: BLBUL, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<BLBUL>(arg0, 6, b"BLBUL", b"$BLBUL", b"OFFICIAL", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/Unknown_10_61a4c1a2fe.jpeg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<BLBUL>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<BLBUL>>(v1);
    }

    // decompiled from Move bytecode v6
}

