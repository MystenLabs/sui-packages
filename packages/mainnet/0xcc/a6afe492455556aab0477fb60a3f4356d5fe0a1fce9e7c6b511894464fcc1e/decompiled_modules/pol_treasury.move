module 0xcca6afe492455556aab0477fb60a3f4356d5fe0a1fce9e7c6b511894464fcc1e::pol_treasury {
    struct Treasury has key {
        id: 0x2::object::UID,
        sui_accum: 0x2::balance::Balance<0x2::sui::SUI>,
        lp_assets: 0x2::bag::Bag,
    }

    struct PolVault has key {
        id: 0x2::object::UID,
    }

    struct LiquidityAssetsProvided has copy, drop {
        sui_amount: u64,
        tvyn_minted: u64,
        timestamp_ms: u64,
    }

    struct LpPositionDeposited has copy, drop {
        depositor: address,
        asset_id: 0x2::object::ID,
    }

    public entry fun create_and_share(arg0: &mut 0x2::tx_context::TxContext) {
        let v0 = Treasury{
            id        : 0x2::object::new(arg0),
            sui_accum : 0x2::balance::zero<0x2::sui::SUI>(),
            lp_assets : 0x2::bag::new(arg0),
        };
        0x2::transfer::share_object<Treasury>(v0);
        let v1 = PolVault{id: 0x2::object::new(arg0)};
        0x2::transfer::share_object<PolVault>(v1);
    }

    public fun create_liquidity_assets(arg0: &mut Treasury, arg1: &mut 0xcca6afe492455556aab0477fb60a3f4356d5fe0a1fce9e7c6b511894464fcc1e::tvyn::MintVault, arg2: &0xcca6afe492455556aab0477fb60a3f4356d5fe0a1fce9e7c6b511894464fcc1e::config_registry::Config, arg3: &mut 0x2::tx_context::TxContext) : (0x2::coin::Coin<0x2::sui::SUI>, 0x2::coin::Coin<0xcca6afe492455556aab0477fb60a3f4356d5fe0a1fce9e7c6b511894464fcc1e::tvyn::TVYN>) {
        let v0 = 0x2::tx_context::sender(arg3);
        assert!(v0 == 0xcca6afe492455556aab0477fb60a3f4356d5fe0a1fce9e7c6b511894464fcc1e::config_registry::dev_addr(arg2) || v0 == 0xcca6afe492455556aab0477fb60a3f4356d5fe0a1fce9e7c6b511894464fcc1e::config_registry::lp_operator_addr(arg2), 2);
        let v1 = 0x2::balance::value<0x2::sui::SUI>(&arg0.sui_accum);
        if (v1 < 0xcca6afe492455556aab0477fb60a3f4356d5fe0a1fce9e7c6b511894464fcc1e::config_registry::lp_threshold_sui(arg2)) {
            return (0x2::coin::zero<0x2::sui::SUI>(arg3), 0x2::coin::zero<0xcca6afe492455556aab0477fb60a3f4356d5fe0a1fce9e7c6b511894464fcc1e::tvyn::TVYN>(arg3))
        };
        let v2 = 0x2::balance::split<0x2::sui::SUI>(&mut arg0.sui_accum, v1);
        let v3 = 0x2::balance::value<0x2::sui::SUI>(&v2);
        let v4 = v3 * 0xcca6afe492455556aab0477fb60a3f4356d5fe0a1fce9e7c6b511894464fcc1e::config_registry::lp_target_ratio_bps(arg2) / 10000;
        let v5 = LiquidityAssetsProvided{
            sui_amount   : v3,
            tvyn_minted  : v4,
            timestamp_ms : 0,
        };
        0x2::event::emit<LiquidityAssetsProvided>(v5);
        (0x2::coin::from_balance<0x2::sui::SUI>(v2, arg3), 0xcca6afe492455556aab0477fb60a3f4356d5fe0a1fce9e7c6b511894464fcc1e::tvyn::mint_for_protocol(arg1, v4, arg3))
    }

    public fun deposit(arg0: &mut Treasury, arg1: 0x2::coin::Coin<0x2::sui::SUI>) {
        0x2::balance::join<0x2::sui::SUI>(&mut arg0.sui_accum, 0x2::coin::into_balance<0x2::sui::SUI>(arg1));
    }

    public fun deposit_lp_position<T0: store + key>(arg0: &mut Treasury, arg1: T0, arg2: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::object::id<T0>(&arg1);
        0x2::bag::add<0x2::object::ID, T0>(&mut arg0.lp_assets, v0, arg1);
        let v1 = LpPositionDeposited{
            depositor : 0x2::tx_context::sender(arg2),
            asset_id  : v0,
        };
        0x2::event::emit<LpPositionDeposited>(v1);
    }

    fun init(arg0: &mut 0x2::tx_context::TxContext) {
        create_and_share(arg0);
    }

    // decompiled from Move bytecode v6
}

