module 0xe387444e5fd92434d37704a5280d0bfc0599c7de2b758cc78918410d513274cc::sulon {
    struct SULON has drop {
        dummy_field: bool,
    }

    fun init(arg0: SULON, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SULON>(arg0, 6, b"SULON", b"SU LON", b"In the ever-evolving universe of meme coins and community-driven tokens, $SULON stands out as the ultimate homage to the architect of meme culture himself - Elon Musk.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/dwadwad1_9dd87e9c2f.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SULON>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SULON>>(v1);
    }

    // decompiled from Move bytecode v6
}

