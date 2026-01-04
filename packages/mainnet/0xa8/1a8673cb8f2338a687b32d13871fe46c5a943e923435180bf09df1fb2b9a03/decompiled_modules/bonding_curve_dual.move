module 0xa81a8673cb8f2338a687b32d13871fe46c5a943e923435180bf09df1fb2b9a03::bonding_curve_dual {
    struct BondingCurveSUI<phantom T0> has store, key {
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

    struct BondingCurveAIDA<phantom T0, phantom T1> has store, key {
        id: 0x2::object::UID,
        treasury_cap: 0x2::coin::TreasuryCap<T0>,
        aida_balance: 0x2::balance::Balance<T1>,
        total_supply: u64,
        current_aida: u64,
        bonding_complete: bool,
        creator: address,
        holders: 0x2::table::Table<address, u64>,
        holder_count: u64,
    }

    struct TokenPurchasedSUI has copy, drop {
        buyer: address,
        sui_amount: u64,
        token_amount: u64,
        current_progress: u64,
    }

    struct TokenPurchasedAIDA has copy, drop {
        buyer: address,
        aida_amount: u64,
        token_amount: u64,
        current_progress: u64,
    }

    public fun buy_tokens_aida<T0, T1>(arg0: &mut BondingCurveAIDA<T0, T1>, arg1: 0x2::coin::Coin<T1>, arg2: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<T0> {
        assert!(!arg0.bonding_complete, 2);
        let v0 = 0x2::coin::value<T1>(&arg1);
        assert!(v0 > 0, 1);
        let v1 = 0x2::tx_context::sender(arg2);
        let v2 = calculate_token_amount(v0, arg0.current_aida);
        arg0.current_aida = arg0.current_aida + v0;
        arg0.total_supply = arg0.total_supply + v2;
        0x2::balance::join<T1>(&mut arg0.aida_balance, 0x2::coin::into_balance<T1>(arg1));
        let v3 = &mut arg0.holders;
        let v4 = &mut arg0.holder_count;
        update_holder(v3, v4, v1, v2);
        if (arg0.current_aida >= 100000000000000) {
            arg0.bonding_complete = true;
        };
        let v5 = TokenPurchasedAIDA{
            buyer            : v1,
            aida_amount      : v0,
            token_amount     : v2,
            current_progress : arg0.current_aida * 100 / 100000000000000,
        };
        0x2::event::emit<TokenPurchasedAIDA>(v5);
        0x2::coin::mint<T0>(&mut arg0.treasury_cap, v2, arg2)
    }

    public fun buy_tokens_sui<T0>(arg0: &mut BondingCurveSUI<T0>, arg1: 0x2::coin::Coin<0x2::sui::SUI>, arg2: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<T0> {
        assert!(!arg0.bonding_complete, 2);
        let v0 = 0x2::coin::value<0x2::sui::SUI>(&arg1);
        assert!(v0 > 0, 1);
        let v1 = 0x2::tx_context::sender(arg2);
        let v2 = calculate_token_amount(v0, arg0.current_sui);
        arg0.current_sui = arg0.current_sui + v0;
        arg0.total_supply = arg0.total_supply + v2;
        0x2::balance::join<0x2::sui::SUI>(&mut arg0.sui_balance, 0x2::coin::into_balance<0x2::sui::SUI>(arg1));
        let v3 = &mut arg0.holders;
        let v4 = &mut arg0.holder_count;
        update_holder(v3, v4, v1, v2);
        if (arg0.current_sui >= 2000000000000) {
            arg0.bonding_complete = true;
        };
        let v5 = TokenPurchasedSUI{
            buyer            : v1,
            sui_amount       : v0,
            token_amount     : v2,
            current_progress : arg0.current_sui * 100 / 2000000000000,
        };
        0x2::event::emit<TokenPurchasedSUI>(v5);
        0x2::coin::mint<T0>(&mut arg0.treasury_cap, v2, arg2)
    }

    public fun calculate_token_amount(arg0: u64, arg1: u64) : u64 {
        arg0 * (1000 + arg1 * 100 / 2000000000000 * 10) / 1000
    }

    public fun create_aida_bonding_curve<T0, T1>(arg0: 0x2::coin::TreasuryCap<T0>, arg1: address, arg2: &mut 0x2::tx_context::TxContext) : BondingCurveAIDA<T0, T1> {
        BondingCurveAIDA<T0, T1>{
            id               : 0x2::object::new(arg2),
            treasury_cap     : arg0,
            aida_balance     : 0x2::balance::zero<T1>(),
            total_supply     : 0,
            current_aida     : 0,
            bonding_complete : false,
            creator          : arg1,
            holders          : 0x2::table::new<address, u64>(arg2),
            holder_count     : 0,
        }
    }

    public fun create_sui_bonding_curve<T0>(arg0: 0x2::coin::TreasuryCap<T0>, arg1: address, arg2: &mut 0x2::tx_context::TxContext) : BondingCurveSUI<T0> {
        BondingCurveSUI<T0>{
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

    public fun get_current_aida<T0, T1>(arg0: &BondingCurveAIDA<T0, T1>) : u64 {
        arg0.current_aida
    }

    public fun get_current_sui<T0>(arg0: &BondingCurveSUI<T0>) : u64 {
        arg0.current_sui
    }

    public fun is_aida_bonding_complete<T0, T1>(arg0: &BondingCurveAIDA<T0, T1>) : bool {
        arg0.bonding_complete
    }

    public fun is_sui_bonding_complete<T0>(arg0: &BondingCurveSUI<T0>) : bool {
        arg0.bonding_complete
    }

    fun update_holder(arg0: &mut 0x2::table::Table<address, u64>, arg1: &mut u64, arg2: address, arg3: u64) {
        if (!0x2::table::contains<address, u64>(arg0, arg2)) {
            0x2::table::add<address, u64>(arg0, arg2, arg3);
            *arg1 = *arg1 + 1;
        } else {
            0x2::table::add<address, u64>(arg0, arg2, 0x2::table::remove<address, u64>(arg0, arg2) + arg3);
        };
    }

    // decompiled from Move bytecode v6
}

