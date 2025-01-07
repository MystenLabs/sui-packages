module 0xce0d3403cacd808692b0ac04cfac522928f3cc495653dbe6f562bf29366138bb::sjgsm {
    struct SJGSM has drop {
        dummy_field: bool,
    }

    fun init(arg0: SJGSM, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SJGSM>(arg0, 6, b"SJGSM", b"S. J. G. S. M.", b"S.J.G.S.M.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/256_5afca233b0.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SJGSM>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SJGSM>>(v1);
    }

    // decompiled from Move bytecode v6
}

