module 0x6df83d12582d3f795ff0b792830eb9d87adf330e120ecaf0edf371a769d94a61::mtcs {
    struct MTCS has drop {
        dummy_field: bool,
    }

    fun init(arg0: MTCS, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<MTCS>(arg0, 6, b"MTCS", b"MelieTheCavy On Sui", b"Melie The Cavy has witnessed the continued growth of the Sui Network ecosystem. She sees the blockchain's huge potential in fueling the growth of meme coins and DeFi.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/29_b51dcb2307.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<MTCS>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<MTCS>>(v1);
    }

    // decompiled from Move bytecode v6
}

