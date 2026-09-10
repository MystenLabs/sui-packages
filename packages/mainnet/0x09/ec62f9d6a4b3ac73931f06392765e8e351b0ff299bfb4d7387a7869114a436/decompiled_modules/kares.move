module 0x9ec62f9d6a4b3ac73931f06392765e8e351b0ff299bfb4d7387a7869114a436::kares {
    struct KARES has drop {
        dummy_field: bool,
    }

    struct Genesis has key {
        id: 0x2::object::UID,
        inventory: 0x2::balance::Balance<KARES>,
        metadata_cap: 0x2::coin_registry::MetadataCap<KARES>,
    }

    public fun burn(arg0: &mut 0x2::coin_registry::Currency<KARES>, arg1: 0x2::coin::Coin<KARES>) {
        0x2::coin_registry::burn<KARES>(arg0, arg1);
    }

    public(friend) fun consume(arg0: Genesis) : (0x2::balance::Balance<KARES>, 0x2::coin_registry::MetadataCap<KARES>) {
        let Genesis {
            id           : v0,
            inventory    : v1,
            metadata_cap : v2,
        } = arg0;
        0x2::object::delete(v0);
        (v1, v2)
    }

    fun init(arg0: KARES, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = new_genesis(arg0, arg1);
        0x2::transfer::transfer<Genesis>(v0, 0x2::tx_context::sender(arg1));
    }

    fun new_genesis(arg0: KARES, arg1: &mut 0x2::tx_context::TxContext) : Genesis {
        let (v0, v1) = 0x2::coin_registry::new_currency_with_otw<KARES>(arg0, 9, 0x1::string::utf8(b"KARES"), 0x1::string::utf8(b"kAres"), 0x1::string::utf8(b"Fixed-supply AresRPG community token. Burn KARES for Mastery rewards or stake to share funded rewards."), 0x1::string::utf8(b"https://launchpad.aresrpg.world/kares.png"), arg1);
        let v2 = v1;
        let v3 = v0;
        0x2::coin_registry::make_supply_burn_only_init<KARES>(&mut v3, v2);
        Genesis{
            id           : 0x2::object::new(arg1),
            inventory    : 0x2::coin::mint_balance<KARES>(&mut v2, 1000000000000000),
            metadata_cap : 0x2::coin_registry::finalize<KARES>(v3, arg1),
        }
    }

    public fun unit() : u64 {
        1000000000
    }

    // decompiled from Move bytecode v7
}

