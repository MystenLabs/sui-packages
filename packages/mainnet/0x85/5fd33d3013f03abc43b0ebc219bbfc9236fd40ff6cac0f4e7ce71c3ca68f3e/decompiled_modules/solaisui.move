module 0x855fd33d3013f03abc43b0ebc219bbfc9236fd40ff6cac0f4e7ce71c3ca68f3e::solaisui {
    struct SOLAISUI has drop {
        dummy_field: bool,
    }

    fun init(arg0: SOLAISUI, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SOLAISUI>(arg0, 6, b"SOLAISUI", b"The Solana Sui Ghost Detective", b"$SOLAISUI is a fun AI meme coin bridging Solana and Sui. As a ghostly detective, it humorously analyzes both networks, bringing laughs and connecting the community.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/SOLASUI_PFP_fff690274e.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SOLAISUI>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SOLAISUI>>(v1);
    }

    // decompiled from Move bytecode v6
}

