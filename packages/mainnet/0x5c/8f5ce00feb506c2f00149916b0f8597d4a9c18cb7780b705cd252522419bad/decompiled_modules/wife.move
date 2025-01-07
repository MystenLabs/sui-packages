module 0x5c8f5ce00feb506c2f00149916b0f8597d4a9c18cb7780b705cd252522419bad::wife {
    struct WIFE has drop {
        dummy_field: bool,
    }

    fun init(arg0: WIFE, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<WIFE>(arg0, 6, b"WIFE", b"Wifejak", b"Meet Wifejak, the better half of Wojak and your newest favorite meme coin, $WIFE. Built on the Sui Network, $WIFE brings all the charm, humor, and meme energy youve been waiting for. Because every Wojak needs a Wifejakand the Sui blockchain is where their love story unfolds.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/PP_1_a23fdfb93a.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<WIFE>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<WIFE>>(v1);
    }

    // decompiled from Move bytecode v6
}

