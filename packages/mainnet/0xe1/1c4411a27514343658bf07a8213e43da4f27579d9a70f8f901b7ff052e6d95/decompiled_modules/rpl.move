module 0xe11c4411a27514343658bf07a8213e43da4f27579d9a70f8f901b7ff052e6d95::rpl {
    struct RPL has drop {
        dummy_field: bool,
    }

    fun init(arg0: RPL, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<RPL>(arg0, 6, b"RPL", b"rugpull", b"no description", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/memecoins_1_300x158_bd4889b5c0.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<RPL>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<RPL>>(v1);
    }

    // decompiled from Move bytecode v6
}

