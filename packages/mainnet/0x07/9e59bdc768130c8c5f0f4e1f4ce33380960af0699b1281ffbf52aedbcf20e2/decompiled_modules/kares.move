module 0x79e59bdc768130c8c5f0f4e1f4ce33380960af0699b1281ffbf52aedbcf20e2::kares {
    struct KARES has drop {
        dummy_field: bool,
    }

    struct Genesis has key {
        id: 0x2::object::UID,
        supply: 0x2::balance::Balance<KARES>,
    }

    public fun split(arg0: Genesis, arg1: &mut 0x2::tx_context::TxContext) : (0x2::coin::Coin<KARES>, 0x2::coin::Coin<KARES>, 0x2::coin::Coin<KARES>) {
        let Genesis {
            id     : v0,
            supply : v1,
        } = arg0;
        let v2 = v1;
        0x2::object::delete(v0);
        (0x2::coin::from_balance<KARES>(0x2::balance::split<KARES>(&mut v2, 540000000000000000), arg1), 0x2::coin::from_balance<KARES>(0x2::balance::split<KARES>(&mut v2, 410000000000000000), arg1), 0x2::coin::from_balance<KARES>(v2, arg1))
    }

    fun init(arg0: KARES, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin_registry::new_currency_with_otw<KARES>(arg0, 9, 0x1::string::utf8(b"KARES"), 0x1::string::utf8(b"KARES"), 0x1::string::utf8(b"KARES is the AresRPG game token."), 0x1::string::utf8(b"https://aresrpg.world/kares.png"), arg1);
        let v2 = v1;
        let v3 = v0;
        0x2::coin_registry::make_supply_burn_only_init<KARES>(&mut v3, v2);
        0x2::transfer::public_transfer<0x2::coin_registry::MetadataCap<KARES>>(0x2::coin_registry::finalize<KARES>(v3, arg1), 0x2::tx_context::sender(arg1));
        let v4 = Genesis{
            id     : 0x2::object::new(arg1),
            supply : 0x2::coin::mint_balance<KARES>(&mut v2, 540000000000000000 + 410000000000000000 + 50000000000000000),
        };
        0x2::transfer::transfer<Genesis>(v4, 0x2::tx_context::sender(arg1));
    }

    public fun liquidity_tokens() : u64 {
        540000000000000000
    }

    public fun reserve_tokens() : u64 {
        410000000000000000
    }

    public fun team_tokens() : u64 {
        50000000000000000
    }

    // decompiled from Move bytecode v7
}

