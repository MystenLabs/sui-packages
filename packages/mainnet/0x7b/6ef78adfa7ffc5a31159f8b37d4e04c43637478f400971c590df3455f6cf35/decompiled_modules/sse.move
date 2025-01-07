module 0x7b6ef78adfa7ffc5a31159f8b37d4e04c43637478f400971c590df3455f6cf35::sse {
    struct SSE has drop {
        dummy_field: bool,
    }

    fun init(arg0: SSE, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SSE>(arg0, 6, b"SSE", b"SSE7000", b"$SSE Token combines the strength of the Saudi Stock Exchange with decentralized finance, offering security, transparency, and global access, representing Saudi Arabia's economic growth.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/SSE_b0865cf08b.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SSE>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SSE>>(v1);
    }

    // decompiled from Move bytecode v6
}

