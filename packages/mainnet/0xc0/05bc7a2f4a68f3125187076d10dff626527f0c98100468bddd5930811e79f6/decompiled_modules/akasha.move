module 0xc005bc7a2f4a68f3125187076d10dff626527f0c98100468bddd5930811e79f6::akasha {
    struct AKASHA has drop {
        dummy_field: bool,
    }

    fun init(arg0: AKASHA, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<AKASHA>(arg0, 6, b"AKASHA", b"Akasha AI", b"Akasha DAO is a decentralized, community-governed platform powered by its native token. Designed to redefine AI agent creation and management within and beyond the BLOOM ecosystem, Akasha DAO empowers users of all skill levels to develop and deploy AI agents, build businesses, and create games seamlessly.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/IMG_20250110_032726_584_d5ffdb2ec0.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<AKASHA>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<AKASHA>>(v1);
    }

    // decompiled from Move bytecode v6
}

