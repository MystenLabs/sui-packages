module 0xd07d9421a7a0ab80f652924a8f9dd992c48afe4da84bf2765e110422eb804d09::kenny {
    struct KENNY has drop {
        dummy_field: bool,
    }

    fun init(arg0: KENNY, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<KENNY>(arg0, 6, b"KENNY", b"Sui Kenny", b"Welcome to a world of meme coins, that have unique tickers that cannot be duplicated, on a superior Blockchain that cannot be argued with on any metric.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/1000014500_13ed598f13.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<KENNY>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<KENNY>>(v1);
    }

    // decompiled from Move bytecode v6
}

