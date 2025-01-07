module 0xa36d5211ed4e4018896d0210ff354235ebb726205c387633311d1e242166302a::malupitone {
    struct MALUPITONE has drop {
        dummy_field: bool,
    }

    fun init(arg0: MALUPITONE, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<MALUPITONE>(arg0, 6, b"MALUPITONE", b"MALUPITON", b"MALUPITOPN", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/459874595_1980484142398013_8246889913126390610_n_919ace6587.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<MALUPITONE>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<MALUPITONE>>(v1);
    }

    // decompiled from Move bytecode v6
}

