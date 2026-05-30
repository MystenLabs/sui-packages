module 0xfeb0f02f15d57987cb264c991219268323808d28853f85d51b186af127d44e30::relic {
    struct RelicInitEvent has copy, drop {
        treasury_cap_id: 0x2::object::ID,
        metadata_cap_id: 0x2::object::ID,
        initial_supply: u64,
    }

    struct RelicMintEvent has copy, drop {
        amount: u64,
        new_total_supply: u64,
    }

    struct RELIC has drop {
        dummy_field: bool,
    }

    fun init(arg0: RELIC, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin_registry::new_currency_with_otw<RELIC>(arg0, 9, 0x1::string::utf8(b"RELIC"), 0x1::string::utf8(b"Cosmic Relic"), 0x1::string::utf8(b"Forged in the distant orbits of the Sui Network, the Cosmic Relic is the ancient currency of The Rewardians, sealed by the Oracles, powered by the four primal forces, and awakened only through contribution. Every farm tilled, every pool seeded, every harvest reaped channels its energy back to those who guard the Era of Rewards. RELIC is not mined. It is unearthed."), 0x1::string::utf8(b"https://suirewards.me/images/relic-icon.jpg"), arg1);
        let v2 = v1;
        0x2::transfer::public_transfer<0x2::coin::Coin<RELIC>>(0x2::coin::mint<RELIC>(&mut v2, 170000000000000000, arg1), 0x2::tx_context::sender(arg1));
        let v3 = 0x2::coin_registry::finalize<RELIC>(v0, arg1);
        let v4 = RelicInitEvent{
            treasury_cap_id : 0x2::object::id<0x2::coin::TreasuryCap<RELIC>>(&v2),
            metadata_cap_id : 0x2::object::id<0x2::coin_registry::MetadataCap<RELIC>>(&v3),
            initial_supply  : 170000000000000000,
        };
        0x2::event::emit<RelicInitEvent>(v4);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<RELIC>>(v2, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::coin_registry::MetadataCap<RELIC>>(v3, 0x2::tx_context::sender(arg1));
    }

    public fun initial_supply() : u64 {
        170000000000000000
    }

    public fun mint_additional(arg0: &mut 0x2::coin::TreasuryCap<RELIC>, arg1: u64, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        let v0 = RelicMintEvent{
            amount           : arg1,
            new_total_supply : 0x2::coin::total_supply<RELIC>(arg0),
        };
        0x2::event::emit<RelicMintEvent>(v0);
        0x2::transfer::public_transfer<0x2::coin::Coin<RELIC>>(0x2::coin::mint<RELIC>(arg0, arg1, arg3), arg2);
    }

    // decompiled from Move bytecode v7
}

