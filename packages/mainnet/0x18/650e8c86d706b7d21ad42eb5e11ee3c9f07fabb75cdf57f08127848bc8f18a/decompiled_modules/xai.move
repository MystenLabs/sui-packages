module 0x18650e8c86d706b7d21ad42eb5e11ee3c9f07fabb75cdf57f08127848bc8f18a::xai {
    struct XAI has drop {
        dummy_field: bool,
    }

    fun init(arg0: XAI, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<XAI>(arg0, 6, b"XAI", b"Codexa AI", b"Codexa Ai represents a paradigm shift in how artificial intelligence interacts with blockchain technology", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://ipfs.io/ipfs/bafkreidnq246vg2giejhqnku7a52qerg4ib4fonz6es3ajzrxlb7antati")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<XAI>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<XAI>>(v1, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

