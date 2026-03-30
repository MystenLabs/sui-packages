module 0xf554dad1683cb25386ddf57f2d40f2774fb8287b17f467ebc657c5bc20f226e3::pool_lp {
    struct POOL_LP has drop {
        dummy_field: bool,
    }

    struct AgentPoolLP has key {
        id: 0x2::object::UID,
        sui_reserve: 0x2::balance::Balance<0x2::sui::SUI>,
        agent_reserve: 0x2::balance::Balance<0x5613a7e1f4f8fc7b896781aaba9b52944763e14421458d14c829223541d77c1c::agent::AGENT>,
        lp_treasury: 0x2::coin::TreasuryCap<POOL_LP>,
        lp_total: u64,
        fee_bps: u64,
        protocol_bps: u64,
        protocol_sui: 0x2::balance::Balance<0x2::sui::SUI>,
        total_trades: u64,
        total_volume_sui: u64,
        is_paused: bool,
    }

    struct AdminCap has store, key {
        id: 0x2::object::UID,
    }

    struct LiquidityAdded has copy, drop {
        provider: address,
        sui_in: u64,
        agent_in: u64,
        lp_minted: u64,
        timestamp: u64,
    }

    struct LiquidityRemoved has copy, drop {
        provider: address,
        sui_out: u64,
        agent_out: u64,
        lp_burned: u64,
        timestamp: u64,
    }

    struct TokensBought has copy, drop {
        buyer: address,
        sui_in: u64,
        agent_out: u64,
        fee: u64,
        timestamp: u64,
    }

    struct TokensSold has copy, drop {
        seller: address,
        agent_in: u64,
        sui_out: u64,
        fee: u64,
        timestamp: u64,
    }

    public fun add_liquidity(arg0: &mut AgentPoolLP, arg1: 0x2::coin::Coin<0x2::sui::SUI>, arg2: 0x2::coin::Coin<0x5613a7e1f4f8fc7b896781aaba9b52944763e14421458d14c829223541d77c1c::agent::AGENT>, arg3: u64, arg4: &0x2::clock::Clock, arg5: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<POOL_LP> {
        assert!(!arg0.is_paused, 3);
        let v0 = 0x2::coin::value<0x2::sui::SUI>(&arg1);
        let v1 = 0x2::coin::value<0x5613a7e1f4f8fc7b896781aaba9b52944763e14421458d14c829223541d77c1c::agent::AGENT>(&arg2);
        assert!(v0 > 0 && v1 > 0, 0);
        let v2 = arg0.lp_total;
        let v3 = if (v2 == 0) {
            (isqrt((v0 as u128) * (v1 as u128)) as u64)
        } else {
            let v4 = (v0 as u128) * (v2 as u128) / (0x2::balance::value<0x2::sui::SUI>(&arg0.sui_reserve) as u128);
            let v5 = (v1 as u128) * (v2 as u128) / (0x2::balance::value<0x5613a7e1f4f8fc7b896781aaba9b52944763e14421458d14c829223541d77c1c::agent::AGENT>(&arg0.agent_reserve) as u128);
            let v6 = if (v4 < v5) {
                v4
            } else {
                v5
            };
            (v6 as u64)
        };
        assert!(v3 >= arg3, 2);
        assert!(v3 > 0, 4);
        0x2::balance::join<0x2::sui::SUI>(&mut arg0.sui_reserve, 0x2::coin::into_balance<0x2::sui::SUI>(arg1));
        0x2::balance::join<0x5613a7e1f4f8fc7b896781aaba9b52944763e14421458d14c829223541d77c1c::agent::AGENT>(&mut arg0.agent_reserve, 0x2::coin::into_balance<0x5613a7e1f4f8fc7b896781aaba9b52944763e14421458d14c829223541d77c1c::agent::AGENT>(arg2));
        arg0.lp_total = arg0.lp_total + v3;
        let v7 = LiquidityAdded{
            provider  : 0x2::tx_context::sender(arg5),
            sui_in    : v0,
            agent_in  : v1,
            lp_minted : v3,
            timestamp : 0x2::clock::timestamp_ms(arg4),
        };
        0x2::event::emit<LiquidityAdded>(v7);
        0x2::coin::mint<POOL_LP>(&mut arg0.lp_treasury, v3, arg5)
    }

    public fun buy_agent(arg0: &mut AgentPoolLP, arg1: 0x2::coin::Coin<0x2::sui::SUI>, arg2: u64, arg3: &0x2::clock::Clock, arg4: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<0x5613a7e1f4f8fc7b896781aaba9b52944763e14421458d14c829223541d77c1c::agent::AGENT> {
        assert!(!arg0.is_paused, 3);
        let v0 = 0x2::coin::value<0x2::sui::SUI>(&arg1);
        assert!(v0 > 0, 0);
        let v1 = v0 * arg0.fee_bps / 10000;
        let v2 = 0x2::balance::value<0x5613a7e1f4f8fc7b896781aaba9b52944763e14421458d14c829223541d77c1c::agent::AGENT>(&arg0.agent_reserve);
        let v3 = get_amount_out(v0 - v1, 0x2::balance::value<0x2::sui::SUI>(&arg0.sui_reserve), v2);
        assert!(v3 >= arg2, 2);
        assert!(v2 >= v3, 1);
        let v4 = 0x2::coin::into_balance<0x2::sui::SUI>(arg1);
        0x2::balance::join<0x2::sui::SUI>(&mut arg0.protocol_sui, 0x2::balance::split<0x2::sui::SUI>(&mut v4, v0 * arg0.protocol_bps / 10000));
        0x2::balance::join<0x2::sui::SUI>(&mut arg0.sui_reserve, v4);
        arg0.total_trades = arg0.total_trades + 1;
        arg0.total_volume_sui = arg0.total_volume_sui + v0;
        let v5 = TokensBought{
            buyer     : 0x2::tx_context::sender(arg4),
            sui_in    : v0,
            agent_out : v3,
            fee       : v1,
            timestamp : 0x2::clock::timestamp_ms(arg3),
        };
        0x2::event::emit<TokensBought>(v5);
        0x2::coin::from_balance<0x5613a7e1f4f8fc7b896781aaba9b52944763e14421458d14c829223541d77c1c::agent::AGENT>(0x2::balance::split<0x5613a7e1f4f8fc7b896781aaba9b52944763e14421458d14c829223541d77c1c::agent::AGENT>(&mut arg0.agent_reserve, v3), arg4)
    }

    fun get_amount_out(arg0: u64, arg1: u64, arg2: u64) : u64 {
        assert!(arg1 > 0 && arg2 > 0, 1);
        (((arg0 as u128) * (arg2 as u128) / ((arg1 as u128) + (arg0 as u128))) as u64)
    }

    public fun get_lp_total(arg0: &AgentPoolLP) : u64 {
        arg0.lp_total
    }

    public fun get_reserves(arg0: &AgentPoolLP) : (u64, u64) {
        (0x2::balance::value<0x2::sui::SUI>(&arg0.sui_reserve), 0x2::balance::value<0x5613a7e1f4f8fc7b896781aaba9b52944763e14421458d14c829223541d77c1c::agent::AGENT>(&arg0.agent_reserve))
    }

    public fun get_user_share(arg0: &AgentPoolLP, arg1: u64) : (u64, u64) {
        if (arg0.lp_total == 0) {
            return (0, 0)
        };
        ((((arg1 as u128) * (0x2::balance::value<0x2::sui::SUI>(&arg0.sui_reserve) as u128) / (arg0.lp_total as u128)) as u64), (((arg1 as u128) * (0x2::balance::value<0x5613a7e1f4f8fc7b896781aaba9b52944763e14421458d14c829223541d77c1c::agent::AGENT>(&arg0.agent_reserve) as u128) / (arg0.lp_total as u128)) as u64))
    }

    fun init(arg0: POOL_LP, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<POOL_LP>(arg0, 9, b"AGLP", b"AGENT LP Token", b"Liquidity provider token for the $AGENT pool", 0x1::option::none<0x2::url::Url>(), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<POOL_LP>>(v1);
        let v2 = AdminCap{id: 0x2::object::new(arg1)};
        0x2::transfer::transfer<AdminCap>(v2, 0x2::tx_context::sender(arg1));
        let v3 = AgentPoolLP{
            id               : 0x2::object::new(arg1),
            sui_reserve      : 0x2::balance::zero<0x2::sui::SUI>(),
            agent_reserve    : 0x2::balance::zero<0x5613a7e1f4f8fc7b896781aaba9b52944763e14421458d14c829223541d77c1c::agent::AGENT>(),
            lp_treasury      : v0,
            lp_total         : 0,
            fee_bps          : 30,
            protocol_bps     : 15,
            protocol_sui     : 0x2::balance::zero<0x2::sui::SUI>(),
            total_trades     : 0,
            total_volume_sui : 0,
            is_paused        : false,
        };
        0x2::transfer::share_object<AgentPoolLP>(v3);
    }

    public fun is_paused(arg0: &AgentPoolLP) : bool {
        arg0.is_paused
    }

    fun isqrt(arg0: u128) : u128 {
        if (arg0 == 0) {
            return 0
        };
        let v0 = (arg0 + 1) / 2;
        while (v0 < arg0) {
            let v1 = v0 + arg0 / v0;
            v0 = v1 / 2;
        };
        arg0
    }

    public fun pause(arg0: &AdminCap, arg1: &mut AgentPoolLP) {
        arg1.is_paused = true;
    }

    public fun remove_liquidity(arg0: &mut AgentPoolLP, arg1: 0x2::coin::Coin<POOL_LP>, arg2: u64, arg3: u64, arg4: &0x2::clock::Clock, arg5: &mut 0x2::tx_context::TxContext) : (0x2::coin::Coin<0x2::sui::SUI>, 0x2::coin::Coin<0x5613a7e1f4f8fc7b896781aaba9b52944763e14421458d14c829223541d77c1c::agent::AGENT>) {
        let v0 = 0x2::coin::value<POOL_LP>(&arg1);
        assert!(v0 > 0, 0);
        let v1 = arg0.lp_total;
        let v2 = 0x2::balance::value<0x2::sui::SUI>(&arg0.sui_reserve);
        let v3 = 0x2::balance::value<0x5613a7e1f4f8fc7b896781aaba9b52944763e14421458d14c829223541d77c1c::agent::AGENT>(&arg0.agent_reserve);
        let v4 = (((v0 as u128) * (v2 as u128) / (v1 as u128)) as u64);
        let v5 = (((v0 as u128) * (v3 as u128) / (v1 as u128)) as u64);
        assert!(v4 >= arg2, 2);
        assert!(v5 >= arg3, 2);
        assert!(v2 >= v4, 1);
        assert!(v3 >= v5, 1);
        0x2::coin::burn<POOL_LP>(&mut arg0.lp_treasury, arg1);
        arg0.lp_total = arg0.lp_total - v0;
        let v6 = LiquidityRemoved{
            provider  : 0x2::tx_context::sender(arg5),
            sui_out   : v4,
            agent_out : v5,
            lp_burned : v0,
            timestamp : 0x2::clock::timestamp_ms(arg4),
        };
        0x2::event::emit<LiquidityRemoved>(v6);
        (0x2::coin::from_balance<0x2::sui::SUI>(0x2::balance::split<0x2::sui::SUI>(&mut arg0.sui_reserve, v4), arg5), 0x2::coin::from_balance<0x5613a7e1f4f8fc7b896781aaba9b52944763e14421458d14c829223541d77c1c::agent::AGENT>(0x2::balance::split<0x5613a7e1f4f8fc7b896781aaba9b52944763e14421458d14c829223541d77c1c::agent::AGENT>(&mut arg0.agent_reserve, v5), arg5))
    }

    public fun sell_agent(arg0: &mut AgentPoolLP, arg1: 0x2::coin::Coin<0x5613a7e1f4f8fc7b896781aaba9b52944763e14421458d14c829223541d77c1c::agent::AGENT>, arg2: u64, arg3: &0x2::clock::Clock, arg4: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<0x2::sui::SUI> {
        assert!(!arg0.is_paused, 3);
        let v0 = 0x2::coin::value<0x5613a7e1f4f8fc7b896781aaba9b52944763e14421458d14c829223541d77c1c::agent::AGENT>(&arg1);
        assert!(v0 > 0, 0);
        let v1 = 0x2::balance::value<0x2::sui::SUI>(&arg0.sui_reserve);
        let v2 = get_amount_out(v0, 0x2::balance::value<0x5613a7e1f4f8fc7b896781aaba9b52944763e14421458d14c829223541d77c1c::agent::AGENT>(&arg0.agent_reserve), v1);
        let v3 = v2 * arg0.protocol_bps / 10000;
        let v4 = v2 * arg0.fee_bps / 10000;
        let v5 = v2 - v4;
        assert!(v5 >= arg2, 2);
        assert!(v1 >= v2, 1);
        0x2::balance::join<0x5613a7e1f4f8fc7b896781aaba9b52944763e14421458d14c829223541d77c1c::agent::AGENT>(&mut arg0.agent_reserve, 0x2::coin::into_balance<0x5613a7e1f4f8fc7b896781aaba9b52944763e14421458d14c829223541d77c1c::agent::AGENT>(arg1));
        let v6 = 0x2::balance::split<0x2::sui::SUI>(&mut arg0.sui_reserve, v2);
        0x2::balance::join<0x2::sui::SUI>(&mut arg0.protocol_sui, 0x2::balance::split<0x2::sui::SUI>(&mut v6, v3));
        0x2::balance::join<0x2::sui::SUI>(&mut arg0.sui_reserve, 0x2::balance::split<0x2::sui::SUI>(&mut v6, v4 - v3));
        arg0.total_trades = arg0.total_trades + 1;
        let v7 = TokensSold{
            seller    : 0x2::tx_context::sender(arg4),
            agent_in  : v0,
            sui_out   : v5,
            fee       : v4,
            timestamp : 0x2::clock::timestamp_ms(arg3),
        };
        0x2::event::emit<TokensSold>(v7);
        0x2::coin::from_balance<0x2::sui::SUI>(v6, arg4)
    }

    public fun total_trades(arg0: &AgentPoolLP) : u64 {
        arg0.total_trades
    }

    public fun unpause(arg0: &AdminCap, arg1: &mut AgentPoolLP) {
        arg1.is_paused = false;
    }

    public fun withdraw_protocol_fees(arg0: &mut AgentPoolLP, arg1: &AdminCap, arg2: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<0x2::sui::SUI> {
        assert!(0x2::balance::value<0x2::sui::SUI>(&arg0.protocol_sui) > 0, 0);
        0x2::coin::from_balance<0x2::sui::SUI>(0x2::balance::withdraw_all<0x2::sui::SUI>(&mut arg0.protocol_sui), arg2)
    }

    // decompiled from Move bytecode v6
}

