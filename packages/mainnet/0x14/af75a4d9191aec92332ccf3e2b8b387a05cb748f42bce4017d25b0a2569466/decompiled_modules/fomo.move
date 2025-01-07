module 0x14af75a4d9191aec92332ccf3e2b8b387a05cb748f42bce4017d25b0a2569466::fomo {
    struct FOMO has drop {
        dummy_field: bool,
    }

    fun init(arg0: FOMO, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<FOMO>(arg0, 9, b"FOMO", b"Fomo", b"FOMO is SUI's first AI Agent launchpad, pairing every token with a unique, fully autonomous, and decentralized AI agent. Each agent features distinct abilities, establishing FOMO as the hub for Virtuals in the SUI ecosystem.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://dd.dexscreener.com/ds-data/tokens/solana/ZxBon4vcf3DVcrt63fJU52ywYm9BKZC6YuXDhb3fomo.png?size=xl&key=706b83")), arg1);
        let v2 = v0;
        0x2::coin::mint_and_transfer<FOMO>(&mut v2, 1000000000000000000, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<FOMO>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<FOMO>>(v2, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

