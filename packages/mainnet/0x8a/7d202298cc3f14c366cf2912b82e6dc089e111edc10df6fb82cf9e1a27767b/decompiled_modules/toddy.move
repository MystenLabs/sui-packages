module 0x8a7d202298cc3f14c366cf2912b82e6dc089e111edc10df6fb82cf9e1a27767b::toddy {
    struct TODDY has drop {
        dummy_field: bool,
    }

    fun init(arg0: TODDY, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<TODDY>(arg0, 6, b"TODDY", b"Toddy On Sui", b"Not Financial Advice. It's A Grumpy Frog.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://ipfs.io/ipfs/bafybeicmuniy6kqo2r6jhfwkj3pkqb2hz365bqvmnr73mm7qffukn6tmwu")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<TODDY>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<TODDY>>(v1, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

