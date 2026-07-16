module 0x425980cb460145b83397586891239f7d570c8a6897581469486225ad06d0a4ef::yield_router {
    struct YieldRouter has key {
        id: 0x2::object::UID,
        auto_yield_default_off: bool,
        protocol_yield_skim_bps: u64,
        paused: bool,
    }

    struct RouterFeeConfig has key {
        id: 0x2::object::UID,
        owner: address,
        profit_fee_bps: u64,
        profit_fee_cap_usd_micros: u64,
        profit_fee_enabled: bool,
        treasury: address,
    }

    struct FeeConfigCreatorCap has key {
        id: 0x2::object::UID,
    }

    struct DepositPlanned has copy, drop {
        owner: address,
        adapter_id: vector<u8>,
        amount_micros: u64,
        fee_micros: u64,
    }

    struct WithdrawPlanned has copy, drop {
        owner: address,
        adapter_id: vector<u8>,
        amount_micros: u64,
        fee_micros: u64,
    }

    struct HarvestSkimmed has copy, drop {
        owner: address,
        adapter_id: vector<u8>,
        gross_yield_micros: u64,
        protocol_skim_micros: u64,
        net_yield_micros: u64,
        fee_bps: u64,
    }

    struct ProfitFeeConfigured has copy, drop {
        owner: address,
        profit_fee_bps: u64,
        profit_fee_cap_usd_micros: u64,
        profit_fee_enabled: bool,
        treasury: address,
    }

    struct ForwardExecuted has copy, drop {
        owner: address,
        adapter_id: vector<u8>,
        amount: u64,
        fee: u64,
    }

    public fun auto_yield_default_off(arg0: &YieldRouter) : bool {
        arg0.auto_yield_default_off
    }

    public fun create(arg0: &mut 0x2::tx_context::TxContext) {
        let v0 = YieldRouter{
            id                      : 0x2::object::new(arg0),
            auto_yield_default_off  : true,
            protocol_yield_skim_bps : 500,
            paused                  : false,
        };
        0x2::transfer::share_object<YieldRouter>(v0);
    }

    public fun create_fee_config(arg0: FeeConfigCreatorCap, arg1: &mut 0x2::tx_context::TxContext) {
        assert!(0x2::tx_context::sender(arg1) == @0xc7166e26852d600068350ca65b6252880a3e17b540e2080e683f796303e1d491, 6);
        let FeeConfigCreatorCap { id: v0 } = arg0;
        0x2::object::delete(v0);
        let v1 = RouterFeeConfig{
            id                        : 0x2::object::new(arg1),
            owner                     : @0xc7166e26852d600068350ca65b6252880a3e17b540e2080e683f796303e1d491,
            profit_fee_bps            : 100,
            profit_fee_cap_usd_micros : 10000000,
            profit_fee_enabled        : false,
            treasury                  : @0xc7166e26852d600068350ca65b6252880a3e17b540e2080e683f796303e1d491,
        };
        0x2::transfer::share_object<RouterFeeConfig>(v1);
    }

    public entry fun forward_deposit<T0>(arg0: &YieldRouter, arg1: &0x425980cb460145b83397586891239f7d570c8a6897581469486225ad06d0a4ef::adapter_registry::AdapterRegistry, arg2: vector<u8>, arg3: 0x2::coin::Coin<T0>, arg4: vector<u8>, arg5: &mut 0x2::tx_context::TxContext) {
        assert!(!arg0.paused, 1);
        assert!(0x2::coin::value<T0>(&arg3) > 0, 2);
        0x425980cb460145b83397586891239f7d570c8a6897581469486225ad06d0a4ef::adapter_registry::assert_active(arg1, arg2);
        abort 5
    }

    public entry fun forward_withdraw<T0>(arg0: &YieldRouter, arg1: &0x425980cb460145b83397586891239f7d570c8a6897581469486225ad06d0a4ef::adapter_registry::AdapterRegistry, arg2: &RouterFeeConfig, arg3: vector<u8>, arg4: u64, arg5: &mut 0x2::tx_context::TxContext) {
        assert!(!arg0.paused, 1);
        0x425980cb460145b83397586891239f7d570c8a6897581469486225ad06d0a4ef::adapter_registry::assert_active(arg1, arg3);
        abort 5
    }

    public entry fun mint_fee_config_creator_cap(arg0: &mut 0x2::tx_context::TxContext) {
        assert!(0x2::tx_context::sender(arg0) == @0xc7166e26852d600068350ca65b6252880a3e17b540e2080e683f796303e1d491, 6);
        let v0 = FeeConfigCreatorCap{id: 0x2::object::new(arg0)};
        0x2::transfer::transfer<FeeConfigCreatorCap>(v0, @0xc7166e26852d600068350ca65b6252880a3e17b540e2080e683f796303e1d491);
    }

    public fun owner(arg0: &RouterFeeConfig) : address {
        arg0.owner
    }

    public fun plan_deposit(arg0: &YieldRouter, arg1: &0x425980cb460145b83397586891239f7d570c8a6897581469486225ad06d0a4ef::adapter_registry::AdapterRegistry, arg2: vector<u8>, arg3: u64, arg4: address, arg5: bool) {
        assert!(!arg0.paused, 1);
        assert!(arg3 > 0, 2);
        0x425980cb460145b83397586891239f7d570c8a6897581469486225ad06d0a4ef::adapter_registry::assert_active(arg1, arg2);
        let v0 = DepositPlanned{
            owner         : arg4,
            adapter_id    : arg2,
            amount_micros : arg3,
            fee_micros    : 0,
        };
        0x2::event::emit<DepositPlanned>(v0);
    }

    public fun plan_harvest_skim(arg0: &YieldRouter, arg1: &0x425980cb460145b83397586891239f7d570c8a6897581469486225ad06d0a4ef::adapter_registry::AdapterRegistry, arg2: vector<u8>, arg3: u64, arg4: address) {
        assert!(!arg0.paused, 1);
        0x425980cb460145b83397586891239f7d570c8a6897581469486225ad06d0a4ef::adapter_registry::assert_active(arg1, arg2);
        let (v0, v1) = 0x425980cb460145b83397586891239f7d570c8a6897581469486225ad06d0a4ef::day::skim_yield(arg3, arg0.protocol_yield_skim_bps);
        let v2 = HarvestSkimmed{
            owner                : arg4,
            adapter_id           : arg2,
            gross_yield_micros   : arg3,
            protocol_skim_micros : v0,
            net_yield_micros     : v1,
            fee_bps              : arg0.protocol_yield_skim_bps,
        };
        0x2::event::emit<HarvestSkimmed>(v2);
    }

    public fun plan_withdraw(arg0: &YieldRouter, arg1: &0x425980cb460145b83397586891239f7d570c8a6897581469486225ad06d0a4ef::adapter_registry::AdapterRegistry, arg2: vector<u8>, arg3: u64, arg4: address) {
        assert!(!arg0.paused, 1);
        assert!(arg3 > 0, 2);
        0x425980cb460145b83397586891239f7d570c8a6897581469486225ad06d0a4ef::adapter_registry::assert_active(arg1, arg2);
        let v0 = WithdrawPlanned{
            owner         : arg4,
            adapter_id    : arg2,
            amount_micros : arg3,
            fee_micros    : 0,
        };
        0x2::event::emit<WithdrawPlanned>(v0);
    }

    public fun plan_withdraw_authenticated(arg0: &YieldRouter, arg1: &0x425980cb460145b83397586891239f7d570c8a6897581469486225ad06d0a4ef::adapter_registry::AdapterRegistry, arg2: vector<u8>, arg3: u64, arg4: address, arg5: &0x2::tx_context::TxContext) {
        assert!(arg4 == 0x2::tx_context::sender(arg5), 3);
        plan_withdraw(arg0, arg1, arg2, arg3, arg4);
    }

    public fun profit_fee_bps(arg0: &RouterFeeConfig) : u64 {
        arg0.profit_fee_bps
    }

    public fun profit_fee_cap_usd_micros(arg0: &RouterFeeConfig) : u64 {
        arg0.profit_fee_cap_usd_micros
    }

    public fun profit_fee_enabled(arg0: &RouterFeeConfig) : bool {
        arg0.profit_fee_enabled
    }

    public fun protocol_yield_skim_bps(arg0: &YieldRouter) : u64 {
        arg0.protocol_yield_skim_bps
    }

    public fun quote_profit_fee(arg0: &RouterFeeConfig, arg1: u64) : u64 {
        let v0 = if (!arg0.profit_fee_enabled) {
            true
        } else if (arg0.profit_fee_bps == 0) {
            true
        } else {
            arg1 == 0
        };
        if (v0) {
            return 0
        };
        let v1 = (((arg1 as u128) * (arg0.profit_fee_bps as u128) / (10000 as u128)) as u64);
        if (arg0.profit_fee_cap_usd_micros != 0 && v1 > arg0.profit_fee_cap_usd_micros) {
            arg0.profit_fee_cap_usd_micros
        } else {
            v1
        }
    }

    public entry fun set_profit_fee(arg0: &mut RouterFeeConfig, arg1: u64, arg2: u64, arg3: bool, arg4: address, arg5: &0x2::tx_context::TxContext) {
        assert!(0x2::tx_context::sender(arg5) == arg0.owner, 3);
        assert!(arg1 <= 200, 4);
        assert!(arg4 != @0x0, 10);
        arg0.profit_fee_bps = arg1;
        arg0.profit_fee_cap_usd_micros = arg2;
        arg0.profit_fee_enabled = arg3;
        arg0.treasury = arg4;
        let v0 = ProfitFeeConfigured{
            owner                     : arg0.owner,
            profit_fee_bps            : arg1,
            profit_fee_cap_usd_micros : arg2,
            profit_fee_enabled        : arg3,
            treasury                  : arg4,
        };
        0x2::event::emit<ProfitFeeConfigured>(v0);
    }

    public entry fun set_treasury(arg0: &mut RouterFeeConfig, arg1: address, arg2: &0x2::tx_context::TxContext) {
        assert!(0x2::tx_context::sender(arg2) == arg0.owner, 3);
        assert!(arg1 != @0x0, 10);
        arg0.treasury = arg1;
        let v0 = ProfitFeeConfigured{
            owner                     : arg0.owner,
            profit_fee_bps            : arg0.profit_fee_bps,
            profit_fee_cap_usd_micros : arg0.profit_fee_cap_usd_micros,
            profit_fee_enabled        : arg0.profit_fee_enabled,
            treasury                  : arg1,
        };
        0x2::event::emit<ProfitFeeConfigured>(v0);
    }

    public(friend) fun split_and_forward_fee<T0>(arg0: &RouterFeeConfig, arg1: 0x2::coin::Coin<T0>, arg2: vector<u8>, arg3: u64, arg4: &mut 0x2::tx_context::TxContext) {
        assert!(0x2::coin::value<T0>(&arg1) > 0, 2);
        assert!(arg0.owner == @0xc7166e26852d600068350ca65b6252880a3e17b540e2080e683f796303e1d491, 7);
        let v0 = 0x2::tx_context::sender(arg4);
        let v1 = 0x2::coin::value<T0>(&arg1);
        assert!(arg3 <= v1, 8);
        let v2 = quote_profit_fee(arg0, arg3);
        assert!(v2 <= v1, 9);
        if (v2 > 0) {
            0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(0x2::coin::split<T0>(&mut arg1, v2, arg4), arg0.treasury);
        };
        0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(arg1, v0);
        let v3 = ForwardExecuted{
            owner      : v0,
            adapter_id : arg2,
            amount     : v1,
            fee        : v2,
        };
        0x2::event::emit<ForwardExecuted>(v3);
    }

    public fun treasury(arg0: &RouterFeeConfig) : address {
        arg0.treasury
    }

    // decompiled from Move bytecode v7
}

