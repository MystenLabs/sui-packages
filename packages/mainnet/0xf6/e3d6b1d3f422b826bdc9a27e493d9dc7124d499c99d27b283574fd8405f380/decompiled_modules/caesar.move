module 0xf6e3d6b1d3f422b826bdc9a27e493d9dc7124d499c99d27b283574fd8405f380::caesar {
    struct CAESAR has drop {
        dummy_field: bool,
    }

    fun init(arg0: CAESAR, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<CAESAR>(arg0, 6, b"CAESAR", b"CAESAR on SUI", b"First CAESAR on SUI", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/Logo_31_49844302e2.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<CAESAR>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<CAESAR>>(v1);
    }

    // decompiled from Move bytecode v6
}

