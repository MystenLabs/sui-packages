module 0x48e0a704f83c86f4b80b6cca841e535d8151642839855f0984f088c4d0610bc9::dolan {
    struct DOLAN has drop {
        dummy_field: bool,
    }

    fun init(arg0: DOLAN, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<DOLAN>(arg0, 6, b"DOLAN", b"Dolan Duck", b"Look at mi, Dolan iz de cptain now. Doxxed Community Takeover ", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/logo_49b73a12e4.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<DOLAN>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<DOLAN>>(v1);
    }

    // decompiled from Move bytecode v6
}

