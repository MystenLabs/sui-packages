module 0xda03e1fbd67a3599392267f38347e818c852951cd4f3d8df0ffae8a038172b90::gua {
    struct GUA has drop {
        dummy_field: bool,
    }

    fun init(arg0: GUA, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<GUA>(arg0, 6, b"GUA", b"Gua Gua Gua", b"GUA is here to rewrite the rules of the meme coin world. Were done with the copycats and weak pretenders. GUA is forging a new path, unapologetically setting the standard for what a memecoin should besocially responsible, committed to charity, and unstoppable. Were not just another player; were the leader of the next generation, ready to crush the competition and claim the throne.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/0x393f1d49425d94f47b26e591a9d111df5cd61065_a49e01ee6d.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<GUA>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<GUA>>(v1);
    }

    // decompiled from Move bytecode v6
}

