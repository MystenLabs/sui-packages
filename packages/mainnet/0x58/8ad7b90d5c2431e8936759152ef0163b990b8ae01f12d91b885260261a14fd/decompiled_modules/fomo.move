module 0x588ad7b90d5c2431e8936759152ef0163b990b8ae01f12d91b885260261a14fd::fomo {
    struct FOMO has drop {
        dummy_field: bool,
    }

    fun init(arg0: FOMO, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<FOMO>(arg0, 6, b"FOMO", b"SUI FOMO", b"Sui fomo is a meme project driven by community ", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/1000013203_bfaef69f3c.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<FOMO>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<FOMO>>(v1);
    }

    // decompiled from Move bytecode v6
}

