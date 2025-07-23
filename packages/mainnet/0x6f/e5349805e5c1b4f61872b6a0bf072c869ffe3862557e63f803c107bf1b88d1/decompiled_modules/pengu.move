module 0x6fe5349805e5c1b4f61872b6a0bf072c869ffe3862557e63f803c107bf1b88d1::pengu {
    struct PENGU has drop {
        dummy_field: bool,
    }

    fun init(arg0: PENGU, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg1);
        let (v1, v2) = 0x2::coin::create_currency<PENGU>(arg0, 6, b"PENGU", b"PUDGY PENGUIN", b"PENGU is the official coin of Pudgy Penguins...Pudgy Penguins has become the face of crypto with one of the most influential communities in the industry. From large companies wearing the Penguin, to being featured in ETF commercials, to garnering millions of followers and over 50 billion views, the Pengu has become a cultural icon...PENGU allows for the ever-expanding Pudgy Penguin fanbase and the hundreds of millions of people outside of crypto that see and share the Pudgy Penguin everyday, to join The Huddle. PENGU is a symbol for community, memes, and good vibes...Believe in Pengu. Believe in the Prophecy.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.suiai.fun/uploads/1000105224_0a7347cd42.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<PENGU>>(v2, v0);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<PENGU>>(v1, v0);
    }

    // decompiled from Move bytecode v6
}

