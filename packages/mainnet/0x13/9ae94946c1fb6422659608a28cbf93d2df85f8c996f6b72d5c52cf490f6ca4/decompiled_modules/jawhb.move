module 0x139ae94946c1fb6422659608a28cbf93d2df85f8c996f6b72d5c52cf490f6ca4::jawhb {
    struct JAWHB has drop {
        dummy_field: bool,
    }

    fun init(arg0: JAWHB, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<JAWHB>(arg0, 6, b"JAWHB", b"GIT A JAWHB", b"Karens say get a job with out understanding meme trading is a job", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/IMG_0832_5dccc726b7.jpeg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<JAWHB>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<JAWHB>>(v1);
    }

    // decompiled from Move bytecode v6
}

