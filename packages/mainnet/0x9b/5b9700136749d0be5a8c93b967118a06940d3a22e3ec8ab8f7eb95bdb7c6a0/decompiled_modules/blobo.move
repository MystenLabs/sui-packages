module 0x9b5b9700136749d0be5a8c93b967118a06940d3a22e3ec8ab8f7eb95bdb7c6a0::blobo {
    struct BLOBO has drop {
        dummy_field: bool,
    }

    fun init(arg0: BLOBO, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<BLOBO>(arg0, 6, b"BLOBO", b"Blobo", b"$BLOBO, the stupidest and funniest fish on SUI.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/blobo_e1362e60ab.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<BLOBO>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<BLOBO>>(v1);
    }

    // decompiled from Move bytecode v6
}

