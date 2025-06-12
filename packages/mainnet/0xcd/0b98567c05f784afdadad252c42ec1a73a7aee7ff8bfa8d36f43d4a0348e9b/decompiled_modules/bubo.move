module 0xcd0b98567c05f784afdadad252c42ec1a73a7aee7ff8bfa8d36f43d4a0348e9b::bubo {
    struct BUBO has drop {
        dummy_field: bool,
    }

    fun init(arg0: BUBO, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<BUBO>(arg0, 6, b"Bubo", b"Bubbo", b"Crypto Bubbles map on SUI Network, track real-time token prices and market trends on the Sui Network with our interactive bubble map.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://ipfs.io/ipfs/bafkreiaepj6sqnyst76rc2zdh42m376avivtijf2zpmppgkpy7r2bxcc24")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<BUBO>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<BUBO>>(v1, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

