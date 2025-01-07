module 0xddf7b1f1ee9ab1a25c39b2fb5a20777735c09afbb607023bd63cafca5e9c109d::splo {
    struct SPLO has drop {
        dummy_field: bool,
    }

    fun init(arg0: SPLO, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SPLO>(arg0, 6, b"SPLO", b"Splo On Sui", b"Splo, the degenerate tadpole, is a reckless little creature with a love for gambling. Always swimming through chaos, he's obsessed with the thrill of betting and drinks the infamous sui water for fun.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/Splo_b38fed46d5.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SPLO>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SPLO>>(v1);
    }

    // decompiled from Move bytecode v6
}

