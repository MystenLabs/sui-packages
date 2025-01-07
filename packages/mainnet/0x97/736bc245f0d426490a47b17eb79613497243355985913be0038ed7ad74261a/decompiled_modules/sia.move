module 0x97736bc245f0d426490a47b17eb79613497243355985913be0038ed7ad74261a::sia {
    struct SIA has drop {
        dummy_field: bool,
    }

    fun init(arg0: SIA, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SIA>(arg0, 6, b"SIA", b"Sui AI", b"Sui AI is not just another meme coinits a revolution in the world of blockchain technology! Powered by AI and built on the fast, scalable, and innovative Sui Network, Sui AI brings fun and value together in an entirely new way.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/sui_ai_0ab031779f.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SIA>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SIA>>(v1);
    }

    // decompiled from Move bytecode v6
}

