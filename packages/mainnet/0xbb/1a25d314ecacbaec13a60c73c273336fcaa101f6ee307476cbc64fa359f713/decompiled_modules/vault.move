module 0xbb1a25d314ecacbaec13a60c73c273336fcaa101f6ee307476cbc64fa359f713::vault {
    struct PositionData has copy, drop, store {
        qty_minted: u64,
        qty_minted_collateralized: u64,
        qty_redeemed: u64,
        premiums: u64,
        payouts: u64,
        unrealized_liability: u64,
        unrealized_assets: u64,
    }

    struct Vault<phantom T0> has store {
        balance: 0x2::balance::Balance<T0>,
        positions: 0x2::table::Table<0xbb1a25d314ecacbaec13a60c73c273336fcaa101f6ee307476cbc64fa359f713::market_key::MarketKey, PositionData>,
        supply_manager: 0xbb1a25d314ecacbaec13a60c73c273336fcaa101f6ee307476cbc64fa359f713::supply_manager::SupplyManager,
        max_liability: u64,
        min_liability: u64,
        unrealized_liability: u64,
        unrealized_assets: u64,
        cumulative_premiums: u64,
        cumulative_payouts: u64,
    }

    public fun balance<T0>(arg0: &Vault<T0>) : u64 {
        0x2::balance::value<T0>(&arg0.balance)
    }

    public(friend) fun new<T0>(arg0: &mut 0x2::tx_context::TxContext) : Vault<T0> {
        Vault<T0>{
            balance              : 0x2::balance::zero<T0>(),
            positions            : 0x2::table::new<0xbb1a25d314ecacbaec13a60c73c273336fcaa101f6ee307476cbc64fa359f713::market_key::MarketKey, PositionData>(arg0),
            supply_manager       : 0xbb1a25d314ecacbaec13a60c73c273336fcaa101f6ee307476cbc64fa359f713::supply_manager::new(arg0),
            max_liability        : 0,
            min_liability        : 0,
            unrealized_liability : 0,
            unrealized_assets    : 0,
            cumulative_premiums  : 0,
            cumulative_payouts   : 0,
        }
    }

    public(friend) fun supply<T0>(arg0: &mut Vault<T0>, arg1: 0x2::coin::Coin<T0>, arg2: &0x2::clock::Clock, arg3: &0x2::tx_context::TxContext) : u64 {
        0x2::balance::join<T0>(&mut arg0.balance, 0x2::coin::into_balance<T0>(arg1));
        0xbb1a25d314ecacbaec13a60c73c273336fcaa101f6ee307476cbc64fa359f713::supply_manager::supply(&mut arg0.supply_manager, 0x2::coin::value<T0>(&arg1), 0x2::balance::value<T0>(&arg0.balance), arg0.unrealized_liability, arg0.unrealized_assets, arg2, arg3)
    }

    public fun supply_data<T0>(arg0: &Vault<T0>, arg1: address) : (u64, u64) {
        0xbb1a25d314ecacbaec13a60c73c273336fcaa101f6ee307476cbc64fa359f713::supply_manager::supply_data(&arg0.supply_manager, arg1)
    }

    public fun total_shares<T0>(arg0: &Vault<T0>) : u64 {
        0xbb1a25d314ecacbaec13a60c73c273336fcaa101f6ee307476cbc64fa359f713::supply_manager::total_shares(&arg0.supply_manager)
    }

    public(friend) fun withdraw<T0>(arg0: &mut Vault<T0>, arg1: u64, arg2: u64, arg3: &0x2::clock::Clock, arg4: &0x2::tx_context::TxContext) : 0x2::balance::Balance<T0> {
        0x2::balance::split<T0>(&mut arg0.balance, 0xbb1a25d314ecacbaec13a60c73c273336fcaa101f6ee307476cbc64fa359f713::supply_manager::withdraw(&mut arg0.supply_manager, arg1, 0x2::balance::value<T0>(&arg0.balance), arg0.unrealized_liability, arg0.unrealized_assets, arg2, arg3, arg4))
    }

    fun add_position<T0>(arg0: &mut Vault<T0>, arg1: 0xbb1a25d314ecacbaec13a60c73c273336fcaa101f6ee307476cbc64fa359f713::market_key::MarketKey, arg2: u64, arg3: u64) {
        add_position_entry<T0>(arg0, arg1);
        let v0 = 0x2::table::borrow_mut<0xbb1a25d314ecacbaec13a60c73c273336fcaa101f6ee307476cbc64fa359f713::market_key::MarketKey, PositionData>(&mut arg0.positions, arg1);
        v0.qty_minted = v0.qty_minted + arg2;
        v0.premiums = v0.premiums + arg3;
    }

    fun add_position_entry<T0>(arg0: &mut Vault<T0>, arg1: 0xbb1a25d314ecacbaec13a60c73c273336fcaa101f6ee307476cbc64fa359f713::market_key::MarketKey) {
        if (!0x2::table::contains<0xbb1a25d314ecacbaec13a60c73c273336fcaa101f6ee307476cbc64fa359f713::market_key::MarketKey, PositionData>(&arg0.positions, arg1)) {
            let v0 = PositionData{
                qty_minted                : 0,
                qty_minted_collateralized : 0,
                qty_redeemed              : 0,
                premiums                  : 0,
                payouts                   : 0,
                unrealized_liability      : 0,
                unrealized_assets         : 0,
            };
            0x2::table::add<0xbb1a25d314ecacbaec13a60c73c273336fcaa101f6ee307476cbc64fa359f713::market_key::MarketKey, PositionData>(&mut arg0.positions, arg1, v0);
        };
    }

    public fun cumulative_payouts<T0>(arg0: &Vault<T0>) : u64 {
        arg0.cumulative_payouts
    }

    public fun cumulative_premiums<T0>(arg0: &Vault<T0>) : u64 {
        arg0.cumulative_premiums
    }

    public(friend) fun execute_mint<T0>(arg0: &mut Vault<T0>, arg1: 0xbb1a25d314ecacbaec13a60c73c273336fcaa101f6ee307476cbc64fa359f713::market_key::MarketKey, arg2: u64, arg3: 0x2::coin::Coin<T0>) {
        let v0 = 0x2::coin::value<T0>(&arg3);
        0x2::balance::join<T0>(&mut arg0.balance, 0x2::coin::into_balance<T0>(arg3));
        arg0.cumulative_premiums = arg0.cumulative_premiums + v0;
        let (v1, v2) = exposure<T0>(arg0, arg1);
        add_position<T0>(arg0, arg1, arg2, v0);
        let (v3, v4) = exposure<T0>(arg0, arg1);
        arg0.max_liability = arg0.max_liability + v3 - v1;
        arg0.min_liability = arg0.min_liability + v4 - v2;
    }

    public(friend) fun execute_mint_collateralized<T0>(arg0: &mut Vault<T0>, arg1: 0xbb1a25d314ecacbaec13a60c73c273336fcaa101f6ee307476cbc64fa359f713::market_key::MarketKey, arg2: u64) {
        add_position_entry<T0>(arg0, arg1);
        0x2::table::borrow_mut<0xbb1a25d314ecacbaec13a60c73c273336fcaa101f6ee307476cbc64fa359f713::market_key::MarketKey, PositionData>(&mut arg0.positions, arg1).qty_minted_collateralized = 0x2::table::borrow<0xbb1a25d314ecacbaec13a60c73c273336fcaa101f6ee307476cbc64fa359f713::market_key::MarketKey, PositionData>(&arg0.positions, arg1).qty_minted_collateralized + arg2;
    }

    public(friend) fun execute_redeem<T0>(arg0: &mut Vault<T0>, arg1: 0xbb1a25d314ecacbaec13a60c73c273336fcaa101f6ee307476cbc64fa359f713::market_key::MarketKey, arg2: u64, arg3: u64) : 0x2::balance::Balance<T0> {
        assert!(0x2::balance::value<T0>(&arg0.balance) >= arg3, 1);
        arg0.cumulative_payouts = arg0.cumulative_payouts + arg3;
        let (v0, v1) = exposure<T0>(arg0, arg1);
        remove_position<T0>(arg0, arg1, arg2, arg3);
        let (v2, v3) = exposure<T0>(arg0, arg1);
        arg0.max_liability = arg0.max_liability + v2 - v0;
        arg0.min_liability = arg0.min_liability + v3 - v1;
        0x2::balance::split<T0>(&mut arg0.balance, arg3)
    }

    public(friend) fun execute_redeem_collateralized<T0>(arg0: &mut Vault<T0>, arg1: 0xbb1a25d314ecacbaec13a60c73c273336fcaa101f6ee307476cbc64fa359f713::market_key::MarketKey, arg2: u64) {
        0x2::table::borrow_mut<0xbb1a25d314ecacbaec13a60c73c273336fcaa101f6ee307476cbc64fa359f713::market_key::MarketKey, PositionData>(&mut arg0.positions, arg1).qty_minted_collateralized = 0x2::table::borrow<0xbb1a25d314ecacbaec13a60c73c273336fcaa101f6ee307476cbc64fa359f713::market_key::MarketKey, PositionData>(&arg0.positions, arg1).qty_minted_collateralized - arg2;
    }

    fun exposure<T0>(arg0: &Vault<T0>, arg1: 0xbb1a25d314ecacbaec13a60c73c273336fcaa101f6ee307476cbc64fa359f713::market_key::MarketKey) : (u64, u64) {
        let (v0, v1) = pair_position<T0>(arg0, arg1);
        if (v0 > v1) {
            (v0, v1)
        } else {
            (v1, v0)
        }
    }

    public(friend) fun finalize_settlement<T0>(arg0: &mut Vault<T0>, arg1: 0xbb1a25d314ecacbaec13a60c73c273336fcaa101f6ee307476cbc64fa359f713::market_key::MarketKey, arg2: bool) {
        let (v0, v1) = pair_position<T0>(arg0, arg1);
        let (v2, v3) = if (v0 > v1) {
            (v0, v1)
        } else {
            (v1, v0)
        };
        let v4 = if (arg2) {
            v0
        } else {
            v1
        };
        arg0.max_liability = arg0.max_liability + v4 - v2;
        arg0.min_liability = arg0.min_liability + v4 - v3;
    }

    public fun market_liability<T0>(arg0: &Vault<T0>, arg1: 0xbb1a25d314ecacbaec13a60c73c273336fcaa101f6ee307476cbc64fa359f713::market_key::MarketKey) : u64 {
        let (v0, v1) = pair_position<T0>(arg0, arg1);
        if (v0 > v1) {
            v0
        } else {
            v1
        }
    }

    public fun max_liability<T0>(arg0: &Vault<T0>) : u64 {
        arg0.max_liability
    }

    public fun min_liability<T0>(arg0: &Vault<T0>) : u64 {
        arg0.min_liability
    }

    public fun pair_position<T0>(arg0: &Vault<T0>, arg1: 0xbb1a25d314ecacbaec13a60c73c273336fcaa101f6ee307476cbc64fa359f713::market_key::MarketKey) : (u64, u64) {
        let (v0, v1) = 0xbb1a25d314ecacbaec13a60c73c273336fcaa101f6ee307476cbc64fa359f713::market_key::up_down_pair(&arg1);
        (position<T0>(arg0, v0), position<T0>(arg0, v1))
    }

    public fun position<T0>(arg0: &Vault<T0>, arg1: 0xbb1a25d314ecacbaec13a60c73c273336fcaa101f6ee307476cbc64fa359f713::market_key::MarketKey) : u64 {
        if (0x2::table::contains<0xbb1a25d314ecacbaec13a60c73c273336fcaa101f6ee307476cbc64fa359f713::market_key::MarketKey, PositionData>(&arg0.positions, arg1)) {
            let v1 = *0x2::table::borrow<0xbb1a25d314ecacbaec13a60c73c273336fcaa101f6ee307476cbc64fa359f713::market_key::MarketKey, PositionData>(&arg0.positions, arg1);
            if (v1.qty_minted > v1.qty_redeemed) {
                v1.qty_minted - v1.qty_redeemed
            } else {
                0
            }
        } else {
            0
        }
    }

    public fun position_quantities<T0>(arg0: &Vault<T0>, arg1: 0xbb1a25d314ecacbaec13a60c73c273336fcaa101f6ee307476cbc64fa359f713::market_key::MarketKey) : (u64, u64) {
        if (0x2::table::contains<0xbb1a25d314ecacbaec13a60c73c273336fcaa101f6ee307476cbc64fa359f713::market_key::MarketKey, PositionData>(&arg0.positions, arg1)) {
            let v2 = *0x2::table::borrow<0xbb1a25d314ecacbaec13a60c73c273336fcaa101f6ee307476cbc64fa359f713::market_key::MarketKey, PositionData>(&arg0.positions, arg1);
            (v2.qty_minted, v2.qty_redeemed)
        } else {
            (0, 0)
        }
    }

    fun remove_position<T0>(arg0: &mut Vault<T0>, arg1: 0xbb1a25d314ecacbaec13a60c73c273336fcaa101f6ee307476cbc64fa359f713::market_key::MarketKey, arg2: u64, arg3: u64) {
        assert!(0x2::table::contains<0xbb1a25d314ecacbaec13a60c73c273336fcaa101f6ee307476cbc64fa359f713::market_key::MarketKey, PositionData>(&arg0.positions, arg1), 0);
        let v0 = 0x2::table::borrow_mut<0xbb1a25d314ecacbaec13a60c73c273336fcaa101f6ee307476cbc64fa359f713::market_key::MarketKey, PositionData>(&mut arg0.positions, arg1);
        v0.qty_redeemed = v0.qty_redeemed + arg2;
        v0.payouts = v0.payouts + arg3;
    }

    public fun unrealized_assets<T0>(arg0: &Vault<T0>) : u64 {
        arg0.unrealized_assets
    }

    public fun unrealized_liability<T0>(arg0: &Vault<T0>) : u64 {
        arg0.unrealized_liability
    }

    public(friend) fun update_unrealized<T0>(arg0: &mut Vault<T0>, arg1: 0xbb1a25d314ecacbaec13a60c73c273336fcaa101f6ee307476cbc64fa359f713::market_key::MarketKey, arg2: u64, arg3: u64) {
        add_position_entry<T0>(arg0, arg1);
        let v0 = 0x2::table::borrow_mut<0xbb1a25d314ecacbaec13a60c73c273336fcaa101f6ee307476cbc64fa359f713::market_key::MarketKey, PositionData>(&mut arg0.positions, arg1);
        v0.unrealized_liability = arg2;
        v0.unrealized_assets = arg3;
        arg0.unrealized_liability = arg0.unrealized_liability + arg2 - v0.unrealized_liability;
        arg0.unrealized_assets = arg0.unrealized_assets + arg3 - v0.unrealized_assets;
    }

    // decompiled from Move bytecode v6
}

