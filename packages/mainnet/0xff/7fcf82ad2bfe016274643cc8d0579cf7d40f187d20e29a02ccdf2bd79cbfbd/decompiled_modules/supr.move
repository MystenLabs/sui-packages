module 0xff7fcf82ad2bfe016274643cc8d0579cf7d40f187d20e29a02ccdf2bd79cbfbd::supr {
    struct SUPR has drop {
        dummy_field: bool,
    }

    fun init(arg0: SUPR, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SUPR>(arg0, 6, b"SUPR", b"SUI PREDICT", b"The fully decentralized prediction market platform on Sui Network. Trade on the outcome of future events and harness the wisdom of the crowd.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/movepump_c7baabc1d5.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SUPR>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SUPR>>(v1);
    }

    // decompiled from Move bytecode v6
}

