module 0x162cb720dfec495044c8a6b1cc411ed97327a89cee5ab3c993bd8a742dea2b50::aether_coin {
    struct AETHER_COIN has drop {
        dummy_field: bool,
    }

    public fun decimals() : u8 {
        9
    }

    fun init(arg0: AETHER_COIN, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin_registry::new_currency_with_otw<AETHER_COIN>(arg0, 9, 0x1::string::utf8(b"AETHER"), 0x1::string::utf8(b"Aether"), 0x1::string::utf8(b"Aether is the utility coin of the Aether realm inside Luminae, an AI-orchestrated finance, creator and infrastructure network founded by InMotion Tech. Fixed supply of 888,888,888, minted once at publish and permanently sealed. Non-custodial and community-held: it unlocks access, tooling and participation across the InMotion stack. No yield is promised and no price is promised - its value is what it unlocks."), 0x1::string::utf8(b"https://inmotion.tech/aether-token.png"), arg1);
        let v2 = v1;
        let v3 = v0;
        0x2::transfer::public_transfer<0x2::coin::Coin<AETHER_COIN>>(0x2::coin::mint<AETHER_COIN>(&mut v2, 888888888000000000, arg1), 0x2::tx_context::sender(arg1));
        0x2::coin_registry::make_supply_fixed_init<AETHER_COIN>(&mut v3, v2);
        0x2::transfer::public_transfer<0x2::coin_registry::MetadataCap<AETHER_COIN>>(0x2::coin_registry::finalize<AETHER_COIN>(v3, arg1), 0x2::tx_context::sender(arg1));
    }

    public fun max_supply() : u64 {
        888888888000000000
    }

    // decompiled from Move bytecode v7
}

