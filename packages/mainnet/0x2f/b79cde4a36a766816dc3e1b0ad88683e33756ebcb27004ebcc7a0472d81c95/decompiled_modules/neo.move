module 0x2fb79cde4a36a766816dc3e1b0ad88683e33756ebcb27004ebcc7a0472d81c95::neo {
    struct NEO has drop {
        dummy_field: bool,
    }

    fun init(arg0: NEO, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<NEO>(arg0, 6, b"NEO", b"Neo Whale", b"Neo Whale, an AI-integrated entity built on the SUI blockchain, is a digital guardian navigating the vast seas of decentralized data.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://images.hop.ag/ipfs/QmW8tZQKxvxLXLkpzbWDwVAEEVc7ySFXhNgdQB1SS24h2p")), arg1);
        0x2::transfer::public_transfer<0x5c8657a6009556804585cd667be3b43487062195422ff586333721de0f8baeae::connector::Connector<NEO>>(0x5c8657a6009556804585cd667be3b43487062195422ff586333721de0f8baeae::connector::new<NEO>(5481979322076348201, v0, v1, 0x1::string::utf8(b"https://x.com/neoxwhale"), 0x1::string::utf8(b"https://neowhale.tech/"), 0x1::string::utf8(b"no telegram"), 0x2::tx_context::sender(arg1), arg1), @0xfa6d14378e545d7da62d15f7f1b5ac26ed9b2d7ffa6b232b245ffe7645591e91);
    }

    // decompiled from Move bytecode v6
}

