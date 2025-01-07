module 0x7a16f7d3734d4c2f872fefbba84c8f7d8b4651cf13450843c5f112c4c33e51e::fluffi {
    struct FLUFFI has drop {
        dummy_field: bool,
    }

    fun init(arg0: FLUFFI, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<FLUFFI>(arg0, 6, b"Fluffi", b"Fluffington", b"Built for innovation and fun, Fluffi took off, and the community quickly embraced it as a gateway to explore the potential of AI in crypto and overall meme culture.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/FLUFFI_a65d2b2f1f.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<FLUFFI>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<FLUFFI>>(v1);
    }

    // decompiled from Move bytecode v6
}

