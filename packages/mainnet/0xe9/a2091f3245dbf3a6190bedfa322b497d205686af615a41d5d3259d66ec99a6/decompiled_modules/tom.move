module 0xe9a2091f3245dbf3a6190bedfa322b497d205686af615a41d5d3259d66ec99a6::tom {
    struct TOM has drop {
        dummy_field: bool,
    }

    fun init(arg0: TOM, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<TOM>(arg0, 6, b"TOM", b"Terminal Of Meme", b"An AI-driven bot that analyzes the token market on the http://movepump.com platform, develops trading skills, and shares insights with $MEME token holders.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/4956468877961834370_3ede142746.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<TOM>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<TOM>>(v1);
    }

    // decompiled from Move bytecode v6
}

