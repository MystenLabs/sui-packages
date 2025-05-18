module 0xaa12233e2c7af654b1db572f671a0998fffdcc6e204ca68a9e22307af9c40911::jelo {
    struct JELO has drop {
        dummy_field: bool,
    }

    fun init(arg0: JELO, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<JELO>(arg0, 6, b"JELO", b"JELO the CAT", b"Introducing Jelo The Cat. Born from the degenerate labs of deep Sui came a curious cat fused with an edible substance like no other. $JELO is tired of Ai, Celebs, and larps taking over our beloved Sui Chain. Jelo invites you to the brighter side of the Trenches.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://ipfs.io/ipfs/bafkreie5qdwsr7upes4avfjnmexcxq45qifn6za3vypqpeumisndxqimnq")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<JELO>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<JELO>>(v1, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

