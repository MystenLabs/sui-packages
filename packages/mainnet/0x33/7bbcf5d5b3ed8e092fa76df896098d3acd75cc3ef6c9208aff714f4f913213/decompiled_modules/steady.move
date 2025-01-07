module 0x337bbcf5d5b3ed8e092fa76df896098d3acd75cc3ef6c9208aff714f4f913213::steady {
    struct STEADY has drop {
        dummy_field: bool,
    }

    fun init(arg0: STEADY, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<STEADY>(arg0, 6, b"Steady", b"Steady on sui", b"STEADY is more than a token; he's a symbol of resilience and innovation on the Sui blockchain. Empowering DeFi and NFTs, Steady  brings unmatched utility to a fast-growing ecosystem. Dive into a world of possibilities as Steady paves the way for an exciting decentralized future!", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/2_478e3b0f63.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<STEADY>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<STEADY>>(v1);
    }

    // decompiled from Move bytecode v6
}

