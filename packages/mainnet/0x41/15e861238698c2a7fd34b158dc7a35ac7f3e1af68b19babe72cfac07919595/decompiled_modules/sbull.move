module 0x4115e861238698c2a7fd34b158dc7a35ac7f3e1af68b19babe72cfac07919595::sbull {
    struct SBULL has drop {
        dummy_field: bool,
    }

    fun init(arg0: SBULL, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SBULL>(arg0, 6, b"SBULL", b"SUI BULLTASTIC", b"Bulltastic is a meme-inspired, community-driven token that represents bullish moment of SUI blockchain while integrates decentralized finance (DeFi) principles with the exciting world of NFTs and play-to-earn gaming.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://r.turbos.finance/icon/1734134017905.png")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<SBULL>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SBULL>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

