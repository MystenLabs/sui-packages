module 0xae8a96f8a0239039b93aca55ffadca36aeee03ba3c190e6aea928a6bb7a18232::solonsui {
    struct SOLONSUI has drop {
        dummy_field: bool,
    }

    fun init(arg0: SOLONSUI, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SOLONSUI>(arg0, 6, b"SolOnSui", b"SOLANA ON SUI", x"5468657920776f6e74206c6561766520536f6c2021210a536f206372656174656420536f6c206f6e2053756920746f207361766520746865697220736f756c73", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/solonsui_8194f3af65.jpeg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SOLONSUI>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SOLONSUI>>(v1);
    }

    // decompiled from Move bytecode v6
}

