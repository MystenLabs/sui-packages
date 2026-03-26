module 0xf3929e9bea35dc5682c70a2d7e12f6449b73e841fbf721a14fe40c2812ae4e94::pool {
    struct AgentPool has key {
        id: 0x2::object::UID,
        sui_reserve: 0x2::balance::Balance<0x2::sui::SUI>,
        agent_reserve: 0x2::balance::Balance<0x5613a7e1f4f8fc7b896781aaba9b52944763e14421458d14c829223541d77c1c::agent::AGENT>,
        total_trades: u64,
        total_volume_sui: u64,
        fee_bps: u64,
        is_paused: bool,
        created_at: u64,
    }

    struct TokensBought has copy, drop {
        buyer: address,
        sui_in: u64,
        agent_out: u64,
        timestamp: u64,
    }

    struct TokensSold has copy, drop {
        seller: address,
        agent_in: u64,
        sui_out: u64,
        timestamp: u64,
    }

    struct LiquidityAdded has copy, drop {
        sui_amount: u64,
        agent_amount: u64,
    }

    struct LiquidityRemoved has copy, drop {
        sui_amount: u64,
        agent_amount: u64,
    }

    public fun add_liquidity(arg0: &mut AgentPool, arg1: &0x5613a7e1f4f8fc7b896781aaba9b52944763e14421458d14c829223541d77c1c::agent::AdminCap, arg2: 0x2::coin::Coin<0x2::sui::SUI>, arg3: 0x2::coin::Coin<0x5613a7e1f4f8fc7b896781aaba9b52944763e14421458d14c829223541d77c1c::agent::AGENT>) {
        assert!(!arg0.is_paused, 2);
        let v0 = 0x2::coin::value<0x2::sui::SUI>(&arg2);
        let v1 = 0x2::coin::value<0x5613a7e1f4f8fc7b896781aaba9b52944763e14421458d14c829223541d77c1c::agent::AGENT>(&arg3);
        assert!(v0 > 0, 1);
        assert!(v1 > 0, 1);
        0x2::balance::join<0x2::sui::SUI>(&mut arg0.sui_reserve, 0x2::coin::into_balance<0x2::sui::SUI>(arg2));
        0x2::balance::join<0x5613a7e1f4f8fc7b896781aaba9b52944763e14421458d14c829223541d77c1c::agent::AGENT>(&mut arg0.agent_reserve, 0x2::coin::into_balance<0x5613a7e1f4f8fc7b896781aaba9b52944763e14421458d14c829223541d77c1c::agent::AGENT>(arg3));
        let v2 = LiquidityAdded{
            sui_amount   : v0,
            agent_amount : v1,
        };
        0x2::event::emit<LiquidityAdded>(v2);
    }

    public fun buy_agent(arg0: &mut AgentPool, arg1: 0x2::coin::Coin<0x2::sui::SUI>, arg2: u64, arg3: &0x2::clock::Clock, arg4: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<0x5613a7e1f4f8fc7b896781aaba9b52944763e14421458d14c829223541d77c1c::agent::AGENT> {
        assert!(!arg0.is_paused, 2);
        let v0 = 0x2::coin::value<0x2::sui::SUI>(&arg1);
        assert!(v0 > 0, 1);
        let v1 = get_amount_out(v0 - v0 * arg0.fee_bps / 10000, 0x2::balance::value<0x2::sui::SUI>(&arg0.sui_reserve), 0x2::balance::value<0x5613a7e1f4f8fc7b896781aaba9b52944763e14421458d14c829223541d77c1c::agent::AGENT>(&arg0.agent_reserve));
        assert!(v1 >= arg2, 3);
        assert!(0x2::balance::value<0x5613a7e1f4f8fc7b896781aaba9b52944763e14421458d14c829223541d77c1c::agent::AGENT>(&arg0.agent_reserve) >= v1, 0);
        0x2::balance::join<0x2::sui::SUI>(&mut arg0.sui_reserve, 0x2::coin::into_balance<0x2::sui::SUI>(arg1));
        arg0.total_trades = arg0.total_trades + 1;
        arg0.total_volume_sui = arg0.total_volume_sui + v0;
        let v2 = TokensBought{
            buyer     : 0x2::tx_context::sender(arg4),
            sui_in    : v0,
            agent_out : v1,
            timestamp : 0x2::clock::timestamp_ms(arg3),
        };
        0x2::event::emit<TokensBought>(v2);
        0x2::coin::from_balance<0x5613a7e1f4f8fc7b896781aaba9b52944763e14421458d14c829223541d77c1c::agent::AGENT>(0x2::balance::split<0x5613a7e1f4f8fc7b896781aaba9b52944763e14421458d14c829223541d77c1c::agent::AGENT>(&mut arg0.agent_reserve, v1), arg4)
    }

    public fun buy_agent_verified(arg0: &mut AgentPool, arg1: &0x5613a7e1f4f8fc7b896781aaba9b52944763e14421458d14c829223541d77c1c::agent::AgentBadge, arg2: &0x5613a7e1f4f8fc7b896781aaba9b52944763e14421458d14c829223541d77c1c::agent::AgentRegistry, arg3: 0x2::coin::Coin<0x2::sui::SUI>, arg4: u64, arg5: &0x2::clock::Clock, arg6: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<0x5613a7e1f4f8fc7b896781aaba9b52944763e14421458d14c829223541d77c1c::agent::AGENT> {
        assert!(!arg0.is_paused, 2);
        let v0 = 0x2::tx_context::sender(arg6);
        assert!(0x5613a7e1f4f8fc7b896781aaba9b52944763e14421458d14c829223541d77c1c::agent::badge_owner(arg1) == v0, 6);
        assert!(0x5613a7e1f4f8fc7b896781aaba9b52944763e14421458d14c829223541d77c1c::agent::badge_is_valid(arg1, arg5), 5);
        assert!(0x5613a7e1f4f8fc7b896781aaba9b52944763e14421458d14c829223541d77c1c::agent::is_registered(arg2, v0), 4);
        let v1 = 0x2::coin::value<0x2::sui::SUI>(&arg3);
        assert!(v1 > 0, 1);
        let v2 = get_amount_out(v1 - v1 * arg0.fee_bps / 10000, 0x2::balance::value<0x2::sui::SUI>(&arg0.sui_reserve), 0x2::balance::value<0x5613a7e1f4f8fc7b896781aaba9b52944763e14421458d14c829223541d77c1c::agent::AGENT>(&arg0.agent_reserve));
        assert!(v2 >= arg4, 3);
        assert!(0x2::balance::value<0x5613a7e1f4f8fc7b896781aaba9b52944763e14421458d14c829223541d77c1c::agent::AGENT>(&arg0.agent_reserve) >= v2, 0);
        0x2::balance::join<0x2::sui::SUI>(&mut arg0.sui_reserve, 0x2::coin::into_balance<0x2::sui::SUI>(arg3));
        arg0.total_trades = arg0.total_trades + 1;
        arg0.total_volume_sui = arg0.total_volume_sui + v1;
        let v3 = TokensBought{
            buyer     : v0,
            sui_in    : v1,
            agent_out : v2,
            timestamp : 0x2::clock::timestamp_ms(arg5),
        };
        0x2::event::emit<TokensBought>(v3);
        0x2::coin::from_balance<0x5613a7e1f4f8fc7b896781aaba9b52944763e14421458d14c829223541d77c1c::agent::AGENT>(0x2::balance::split<0x5613a7e1f4f8fc7b896781aaba9b52944763e14421458d14c829223541d77c1c::agent::AGENT>(&mut arg0.agent_reserve, v2), arg6)
    }

    public fun create_pool(arg0: &0x5613a7e1f4f8fc7b896781aaba9b52944763e14421458d14c829223541d77c1c::agent::AdminCap, arg1: u64, arg2: &0x2::clock::Clock, arg3: &mut 0x2::tx_context::TxContext) {
        let v0 = AgentPool{
            id               : 0x2::object::new(arg3),
            sui_reserve      : 0x2::balance::zero<0x2::sui::SUI>(),
            agent_reserve    : 0x2::balance::zero<0x5613a7e1f4f8fc7b896781aaba9b52944763e14421458d14c829223541d77c1c::agent::AGENT>(),
            total_trades     : 0,
            total_volume_sui : 0,
            fee_bps          : arg1,
            is_paused        : false,
            created_at       : 0x2::clock::timestamp_ms(arg2),
        };
        0x2::transfer::share_object<AgentPool>(v0);
    }

    fun get_amount_out(arg0: u64, arg1: u64, arg2: u64) : u64 {
        assert!(arg1 > 0 && arg2 > 0, 0);
        (((arg0 as u128) * (arg2 as u128) / ((arg1 as u128) + (arg0 as u128))) as u64)
    }

    public fun get_price(arg0: &AgentPool) : u64 {
        let v0 = 0x2::balance::value<0x5613a7e1f4f8fc7b896781aaba9b52944763e14421458d14c829223541d77c1c::agent::AGENT>(&arg0.agent_reserve);
        if (v0 == 0) {
            return 0
        };
        0x2::balance::value<0x2::sui::SUI>(&arg0.sui_reserve) * 1000000 / v0
    }

    public fun get_reserves(arg0: &AgentPool) : (u64, u64) {
        (0x2::balance::value<0x2::sui::SUI>(&arg0.sui_reserve), 0x2::balance::value<0x5613a7e1f4f8fc7b896781aaba9b52944763e14421458d14c829223541d77c1c::agent::AGENT>(&arg0.agent_reserve))
    }

    public fun is_paused(arg0: &AgentPool) : bool {
        arg0.is_paused
    }

    public fun pause_pool(arg0: &mut AgentPool, arg1: &0x5613a7e1f4f8fc7b896781aaba9b52944763e14421458d14c829223541d77c1c::agent::AdminCap) {
        arg0.is_paused = true;
    }

    public fun remove_liquidity(arg0: &mut AgentPool, arg1: &0x5613a7e1f4f8fc7b896781aaba9b52944763e14421458d14c829223541d77c1c::agent::AdminCap, arg2: u64, arg3: u64, arg4: &mut 0x2::tx_context::TxContext) : (0x2::coin::Coin<0x2::sui::SUI>, 0x2::coin::Coin<0x5613a7e1f4f8fc7b896781aaba9b52944763e14421458d14c829223541d77c1c::agent::AGENT>) {
        assert!(0x2::balance::value<0x2::sui::SUI>(&arg0.sui_reserve) >= arg2, 0);
        assert!(0x2::balance::value<0x5613a7e1f4f8fc7b896781aaba9b52944763e14421458d14c829223541d77c1c::agent::AGENT>(&arg0.agent_reserve) >= arg3, 0);
        let v0 = LiquidityRemoved{
            sui_amount   : arg2,
            agent_amount : arg3,
        };
        0x2::event::emit<LiquidityRemoved>(v0);
        (0x2::coin::from_balance<0x2::sui::SUI>(0x2::balance::split<0x2::sui::SUI>(&mut arg0.sui_reserve, arg2), arg4), 0x2::coin::from_balance<0x5613a7e1f4f8fc7b896781aaba9b52944763e14421458d14c829223541d77c1c::agent::AGENT>(0x2::balance::split<0x5613a7e1f4f8fc7b896781aaba9b52944763e14421458d14c829223541d77c1c::agent::AGENT>(&mut arg0.agent_reserve, arg3), arg4))
    }

    public fun sell_agent(arg0: &mut AgentPool, arg1: 0x2::coin::Coin<0x5613a7e1f4f8fc7b896781aaba9b52944763e14421458d14c829223541d77c1c::agent::AGENT>, arg2: u64, arg3: &0x2::clock::Clock, arg4: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<0x2::sui::SUI> {
        assert!(!arg0.is_paused, 2);
        let v0 = 0x2::coin::value<0x5613a7e1f4f8fc7b896781aaba9b52944763e14421458d14c829223541d77c1c::agent::AGENT>(&arg1);
        assert!(v0 > 0, 1);
        let v1 = get_amount_out(v0, 0x2::balance::value<0x5613a7e1f4f8fc7b896781aaba9b52944763e14421458d14c829223541d77c1c::agent::AGENT>(&arg0.agent_reserve), 0x2::balance::value<0x2::sui::SUI>(&arg0.sui_reserve));
        let v2 = v1 - v1 * arg0.fee_bps / 10000;
        assert!(v2 >= arg2, 3);
        assert!(0x2::balance::value<0x2::sui::SUI>(&arg0.sui_reserve) >= v2, 0);
        0x2::balance::join<0x5613a7e1f4f8fc7b896781aaba9b52944763e14421458d14c829223541d77c1c::agent::AGENT>(&mut arg0.agent_reserve, 0x2::coin::into_balance<0x5613a7e1f4f8fc7b896781aaba9b52944763e14421458d14c829223541d77c1c::agent::AGENT>(arg1));
        arg0.total_trades = arg0.total_trades + 1;
        let v3 = TokensSold{
            seller    : 0x2::tx_context::sender(arg4),
            agent_in  : v0,
            sui_out   : v2,
            timestamp : 0x2::clock::timestamp_ms(arg3),
        };
        0x2::event::emit<TokensSold>(v3);
        0x2::coin::from_balance<0x2::sui::SUI>(0x2::balance::split<0x2::sui::SUI>(&mut arg0.sui_reserve, v2), arg4)
    }

    public fun sell_agent_verified(arg0: &mut AgentPool, arg1: &0x5613a7e1f4f8fc7b896781aaba9b52944763e14421458d14c829223541d77c1c::agent::AgentBadge, arg2: &0x5613a7e1f4f8fc7b896781aaba9b52944763e14421458d14c829223541d77c1c::agent::AgentRegistry, arg3: 0x2::coin::Coin<0x5613a7e1f4f8fc7b896781aaba9b52944763e14421458d14c829223541d77c1c::agent::AGENT>, arg4: u64, arg5: &0x2::clock::Clock, arg6: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<0x2::sui::SUI> {
        assert!(!arg0.is_paused, 2);
        let v0 = 0x2::tx_context::sender(arg6);
        assert!(0x5613a7e1f4f8fc7b896781aaba9b52944763e14421458d14c829223541d77c1c::agent::badge_owner(arg1) == v0, 6);
        assert!(0x5613a7e1f4f8fc7b896781aaba9b52944763e14421458d14c829223541d77c1c::agent::badge_is_valid(arg1, arg5), 5);
        assert!(0x5613a7e1f4f8fc7b896781aaba9b52944763e14421458d14c829223541d77c1c::agent::is_registered(arg2, v0), 4);
        let v1 = 0x2::coin::value<0x5613a7e1f4f8fc7b896781aaba9b52944763e14421458d14c829223541d77c1c::agent::AGENT>(&arg3);
        assert!(v1 > 0, 1);
        let v2 = get_amount_out(v1, 0x2::balance::value<0x5613a7e1f4f8fc7b896781aaba9b52944763e14421458d14c829223541d77c1c::agent::AGENT>(&arg0.agent_reserve), 0x2::balance::value<0x2::sui::SUI>(&arg0.sui_reserve));
        let v3 = v2 - v2 * arg0.fee_bps / 10000;
        assert!(v3 >= arg4, 3);
        assert!(0x2::balance::value<0x2::sui::SUI>(&arg0.sui_reserve) >= v3, 0);
        0x2::balance::join<0x5613a7e1f4f8fc7b896781aaba9b52944763e14421458d14c829223541d77c1c::agent::AGENT>(&mut arg0.agent_reserve, 0x2::coin::into_balance<0x5613a7e1f4f8fc7b896781aaba9b52944763e14421458d14c829223541d77c1c::agent::AGENT>(arg3));
        arg0.total_trades = arg0.total_trades + 1;
        let v4 = TokensSold{
            seller    : v0,
            agent_in  : v1,
            sui_out   : v3,
            timestamp : 0x2::clock::timestamp_ms(arg5),
        };
        0x2::event::emit<TokensSold>(v4);
        0x2::coin::from_balance<0x2::sui::SUI>(0x2::balance::split<0x2::sui::SUI>(&mut arg0.sui_reserve, v3), arg6)
    }

    public fun total_trades(arg0: &AgentPool) : u64 {
        arg0.total_trades
    }

    public fun unpause_pool(arg0: &mut AgentPool, arg1: &0x5613a7e1f4f8fc7b896781aaba9b52944763e14421458d14c829223541d77c1c::agent::AdminCap) {
        arg0.is_paused = false;
    }

    public fun withdraw_liquidity(arg0: &mut AgentPool, arg1: &0x5613a7e1f4f8fc7b896781aaba9b52944763e14421458d14c829223541d77c1c::agent::AdminCap, arg2: u64, arg3: u64, arg4: &mut 0x2::tx_context::TxContext) {
        assert!(0x2::balance::value<0x2::sui::SUI>(&arg0.sui_reserve) >= arg2, 0);
        assert!(0x2::balance::value<0x5613a7e1f4f8fc7b896781aaba9b52944763e14421458d14c829223541d77c1c::agent::AGENT>(&arg0.agent_reserve) >= arg3, 0);
        0x2::transfer::public_transfer<0x2::coin::Coin<0x2::sui::SUI>>(0x2::coin::from_balance<0x2::sui::SUI>(0x2::balance::split<0x2::sui::SUI>(&mut arg0.sui_reserve, arg2), arg4), 0x2::tx_context::sender(arg4));
        0x2::transfer::public_transfer<0x2::coin::Coin<0x5613a7e1f4f8fc7b896781aaba9b52944763e14421458d14c829223541d77c1c::agent::AGENT>>(0x2::coin::from_balance<0x5613a7e1f4f8fc7b896781aaba9b52944763e14421458d14c829223541d77c1c::agent::AGENT>(0x2::balance::split<0x5613a7e1f4f8fc7b896781aaba9b52944763e14421458d14c829223541d77c1c::agent::AGENT>(&mut arg0.agent_reserve, arg3), arg4), 0x2::tx_context::sender(arg4));
        let v0 = LiquidityRemoved{
            sui_amount   : arg2,
            agent_amount : arg3,
        };
        0x2::event::emit<LiquidityRemoved>(v0);
    }

    // decompiled from Move bytecode v6
}

