module 0x521549cdb3b3eb395f244f240138cb9a36e916c13378dfa0a09e3031a6fdc9d5::miggles {
    struct MIGGLES has drop {
        dummy_field: bool,
    }

    fun init(arg0: MIGGLES, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<MIGGLES>(arg0, 6, b"MIGGLES", b"MIGGLES SUI", b"How strong doneld tremp on this szn ", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/miggles_797e38a69c.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<MIGGLES>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<MIGGLES>>(v1);
    }

    // decompiled from Move bytecode v6
}

