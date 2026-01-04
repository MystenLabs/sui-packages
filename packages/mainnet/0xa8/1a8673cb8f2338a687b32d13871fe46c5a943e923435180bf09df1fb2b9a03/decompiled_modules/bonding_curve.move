module 0xa81a8673cb8f2338a687b32d13871fe46c5a943e923435180bf09df1fb2b9a03::bonding_curve {
    struct BondingCurve<phantom T0> has store, key {
        id: 0x2::object::UID,
        treasury_cap: 0x2::coin::TreasuryCap<T0>,
        sui_balance: 0x2::balance::Balance<0x2::sui::SUI>,
        total_supply: u64,
        current_sui: u64,
        bonding_complete: bool,
        creator: address,
        holders: 0x2::table::Table<address, u64>,
        holder_count: u64,
    }

    struct AgentToken<phantom T0> has drop {
        dummy_field: bool,
    }

    struct TokenPurchased has copy, drop {
        buyer: address,
        sui_amount: u64,
        token_amount: u64,
        current_progress: u64,
    }

    struct TokenSold has copy, drop {
        seller: address,
        token_amount: u64,
        sui_amount: u64,
        current_progress: u64,
    }

    struct BondingCompleted has copy, drop {
        agent_id: address,
        total_sui_raised: u64,
        dev_fee: u64,
        liquidity_amount: u64,
    }

    public fun buy_tokens<T0>(arg0: &mut BondingCurve<T0>, arg1: 0x2::coin::Coin<0x2::sui::SUI>, arg2: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<T0> {
        assert!(!arg0.bonding_complete, 2);
        let v0 = 0x2::coin::value<0x2::sui::SUI>(&arg1);
        assert!(v0 > 0, 1);
        let v1 = 0x2::tx_context::sender(arg2);
        let v2 = calculate_token_amount(v0, arg0.current_sui);
        arg0.current_sui = arg0.current_sui + v0;
        arg0.total_supply = arg0.total_supply + v2;
        0x2::balance::join<0x2::sui::SUI>(&mut arg0.sui_balance, 0x2::coin::into_balance<0x2::sui::SUI>(arg1));
        if (!0x2::table::contains<address, u64>(&arg0.holders, v1)) {
            0x2::table::add<address, u64>(&mut arg0.holders, v1, v2);
            arg0.holder_count = arg0.holder_count + 1;
        } else {
            0x2::table::add<address, u64>(&mut arg0.holders, v1, 0x2::table::remove<address, u64>(&mut arg0.holders, v1) + v2);
        };
        if (arg0.current_sui >= 2000000000000) {
            arg0.bonding_complete = true;
        };
        let v3 = TokenPurchased{
            buyer            : v1,
            sui_amount       : v0,
            token_amount     : v2,
            current_progress : arg0.current_sui * 100 / 2000000000000,
        };
        0x2::event::emit<TokenPurchased>(v3);
        0x2::coin::mint<T0>(&mut arg0.treasury_cap, v2, arg2)
    }

    public fun calculate_sui_amount(arg0: u64, arg1: u64) : u64 {
        arg0 * 1000 / (1000 + arg1 * 100 / 2000000000000 * 10)
    }

    public fun calculate_token_amount(arg0: u64, arg1: u64) : u64 {
        arg0 * (1000 + arg1 * 100 / 2000000000000 * 10) / 1000
    }

    public fun complete_bonding<T0>(arg0: &mut BondingCurve<T0>, arg1: address, arg2: &mut 0x2::tx_context::TxContext) : (0x2::coin::Coin<0x2::sui::SUI>, 0x2::coin::Coin<0x2::sui::SUI>) {
        assert!(arg0.bonding_complete, 3);
        let v0 = 0x2::balance::value<0x2::sui::SUI>(&arg0.sui_balance);
        let v1 = v0 * 1 / 100;
        let v2 = v0 - v1;
        let v3 = BondingCompleted{
            agent_id         : 0x2::object::uid_to_address(&arg0.id),
            total_sui_raised : v0,
            dev_fee          : v1,
            liquidity_amount : v2,
        };
        0x2::event::emit<BondingCompleted>(v3);
        (0x2::coin::from_balance<0x2::sui::SUI>(0x2::balance::split<0x2::sui::SUI>(&mut arg0.sui_balance, v1), arg2), 0x2::coin::from_balance<0x2::sui::SUI>(0x2::balance::split<0x2::sui::SUI>(&mut arg0.sui_balance, v2), arg2))
    }

    public fun create_bonding_curve<T0>(arg0: 0x2::coin::TreasuryCap<T0>, arg1: address, arg2: &mut 0x2::tx_context::TxContext) : BondingCurve<T0> {
        BondingCurve<T0>{
            id               : 0x2::object::new(arg2),
            treasury_cap     : arg0,
            sui_balance      : 0x2::balance::zero<0x2::sui::SUI>(),
            total_supply     : 0,
            current_sui      : 0,
            bonding_complete : false,
            creator          : arg1,
            holders          : 0x2::table::new<address, u64>(arg2),
            holder_count     : 0,
        }
    }

    public fun get_bonding_target() : u64 {
        2000000000000
    }

    public fun get_creator<T0>(arg0: &BondingCurve<T0>) : address {
        arg0.creator
    }

    public fun get_current_sui<T0>(arg0: &BondingCurve<T0>) : u64 {
        arg0.current_sui
    }

    public fun get_holder_count<T0>(arg0: &BondingCurve<T0>) : u64 {
        arg0.holder_count
    }

    public fun get_total_supply<T0>(arg0: &BondingCurve<T0>) : u64 {
        arg0.total_supply
    }

    public fun is_bonding_complete<T0>(arg0: &BondingCurve<T0>) : bool {
        arg0.bonding_complete
    }

    public fun owner_buy<T0>(arg0: &mut BondingCurve<T0>, arg1: 0x2::coin::Coin<0x2::sui::SUI>, arg2: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<T0> {
        assert!(0x2::tx_context::sender(arg2) == arg0.creator, 5);
        buy_tokens<T0>(arg0, arg1, arg2)
    }

    public fun sell_tokens<T0>(arg0: &mut BondingCurve<T0>, arg1: 0x2::coin::Coin<T0>, arg2: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<0x2::sui::SUI> {
        assert!(!arg0.bonding_complete, 2);
        let v0 = 0x2::coin::value<T0>(&arg1);
        let v1 = calculate_sui_amount(v0, arg0.current_sui);
        assert!(0x2::balance::value<0x2::sui::SUI>(&arg0.sui_balance) >= v1, 4);
        let v2 = 0x2::tx_context::sender(arg2);
        arg0.current_sui = arg0.current_sui - v1;
        arg0.total_supply = arg0.total_supply - v0;
        if (0x2::table::contains<address, u64>(&arg0.holders, v2)) {
            let v3 = 0x2::table::remove<address, u64>(&mut arg0.holders, v2);
            if (v3 > v0) {
                0x2::table::add<address, u64>(&mut arg0.holders, v2, v3 - v0);
            } else {
                arg0.holder_count = arg0.holder_count - 1;
            };
        };
        0x2::coin::burn<T0>(&mut arg0.treasury_cap, arg1);
        let v4 = TokenSold{
            seller           : v2,
            token_amount     : v0,
            sui_amount       : v1,
            current_progress : arg0.current_sui * 100 / 2000000000000,
        };
        0x2::event::emit<TokenSold>(v4);
        0x2::coin::from_balance<0x2::sui::SUI>(0x2::balance::split<0x2::sui::SUI>(&mut arg0.sui_balance, v1), arg2)
    }

    // decompiled from Move bytecode v6
}

