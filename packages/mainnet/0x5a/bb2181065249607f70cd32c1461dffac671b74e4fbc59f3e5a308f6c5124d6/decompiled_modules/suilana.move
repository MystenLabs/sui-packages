module 0x5abb2181065249607f70cd32c1461dffac671b74e4fbc59f3e5a308f6c5124d6::suilana {
    struct SUILANA has drop {
        dummy_field: bool,
    }

    fun init(arg0: SUILANA, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SUILANA>(arg0, 6, b"Suilana", b"SUILANA", b"SUI and SOLANA combine two words.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/th_2_16ba3a87e7.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SUILANA>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SUILANA>>(v1);
    }

    // decompiled from Move bytecode v6
}

