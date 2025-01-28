module 0xa0512b248477172ec6ce795e76d3e7d9e872f3835fd39543ed75d19fd13a200e::mkas {
    struct MKAS has drop {
        dummy_field: bool,
    }

    fun init(arg0: MKAS, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<MKAS>(arg0, 6, b"MKAS", b"MonKeyAiSui", b"Are you ready for a new journey with Monkeys?", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/5_f5daddf630.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<MKAS>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<MKAS>>(v1);
    }

    // decompiled from Move bytecode v6
}

