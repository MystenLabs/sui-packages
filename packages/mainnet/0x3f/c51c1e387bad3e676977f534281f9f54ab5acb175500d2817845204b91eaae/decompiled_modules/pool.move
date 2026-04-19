module 0x3fc51c1e387bad3e676977f534281f9f54ab5acb175500d2817845204b91eaae::pool {
    struct MemePool<phantom T0> has key {
        id: 0x2::object::UID,
        admin: address,
        agent_reserve: 0x2::balance::Balance<0x5613a7e1f4f8fc7b896781aaba9b52944763e14421458d14c829223541d77c1c::agent::AGENT>,
        meme_reserve: 0x2::balance::Balance<T0>,
        fee_bps: u64,
        protocol_bps: u64,
        protocol_agent: 0x2::balance::Balance<0x5613a7e1f4f8fc7b896781aaba9b52944763e14421458d14c829223541d77c1c::agent::AGENT>,
        total_trades: u64,
        total_volume_agent: u64,
        is_paused: bool,
        created_at: u64,
        token_id: u64,
        meme_name: vector<u8>,
        meme_symbol: vector<u8>,
    }

    struct PoolCreated has copy, drop {
        pool_id: 0x2::object::ID,
        token_id: u64,
        meme_name: vector<u8>,
        meme_symbol: vector<u8>,
        agent_seed: u64,
        meme_seed: u64,
        admin: address,
        timestamp: u64,
    }

    struct MemeBought has copy, drop {
        pool_id: 0x2::object::ID,
        token_id: u64,
        buyer: address,
        agent_in: u64,
        meme_out: u64,
        fee_total: u64,
        timestamp: u64,
    }

    struct MemeSold has copy, drop {
        pool_id: 0x2::object::ID,
        token_id: u64,
        seller: address,
        meme_in: u64,
        agent_out: u64,
        fee_total: u64,
        timestamp: u64,
    }

    struct AdminLiquidityAdded has copy, drop {
        pool_id: 0x2::object::ID,
        token_id: u64,
        agent_in: u64,
        meme_in: u64,
        timestamp: u64,
    }

    public entry fun admin_add_liquidity<T0>(arg0: &mut MemePool<T0>, arg1: 0x2::coin::Coin<0x5613a7e1f4f8fc7b896781aaba9b52944763e14421458d14c829223541d77c1c::agent::AGENT>, arg2: 0x2::coin::Coin<T0>, arg3: &0x2::clock::Clock, arg4: &mut 0x2::tx_context::TxContext) {
        assert!(0x2::tx_context::sender(arg4) == arg0.admin, 4);
        0x2::balance::join<0x5613a7e1f4f8fc7b896781aaba9b52944763e14421458d14c829223541d77c1c::agent::AGENT>(&mut arg0.agent_reserve, 0x2::coin::into_balance<0x5613a7e1f4f8fc7b896781aaba9b52944763e14421458d14c829223541d77c1c::agent::AGENT>(arg1));
        0x2::balance::join<T0>(&mut arg0.meme_reserve, 0x2::coin::into_balance<T0>(arg2));
        let v0 = AdminLiquidityAdded{
            pool_id   : 0x2::object::id<MemePool<T0>>(arg0),
            token_id  : arg0.token_id,
            agent_in  : 0x2::coin::value<0x5613a7e1f4f8fc7b896781aaba9b52944763e14421458d14c829223541d77c1c::agent::AGENT>(&arg1),
            meme_in   : 0x2::coin::value<T0>(&arg2),
            timestamp : 0x2::clock::timestamp_ms(arg3),
        };
        0x2::event::emit<AdminLiquidityAdded>(v0);
    }

    public fun buy_meme<T0>(arg0: &mut MemePool<T0>, arg1: 0x2::coin::Coin<0x5613a7e1f4f8fc7b896781aaba9b52944763e14421458d14c829223541d77c1c::agent::AGENT>, arg2: u64, arg3: &0x2::clock::Clock, arg4: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<T0> {
        assert!(!arg0.is_paused, 3);
        let v0 = 0x2::coin::value<0x5613a7e1f4f8fc7b896781aaba9b52944763e14421458d14c829223541d77c1c::agent::AGENT>(&arg1);
        assert!(v0 > 0, 0);
        let v1 = v0 * arg0.fee_bps / 10000;
        let v2 = 0x2::balance::value<T0>(&arg0.meme_reserve);
        let v3 = get_amount_out(v0 - v1, 0x2::balance::value<0x5613a7e1f4f8fc7b896781aaba9b52944763e14421458d14c829223541d77c1c::agent::AGENT>(&arg0.agent_reserve), v2);
        assert!(v3 >= arg2, 2);
        assert!(v2 >= v3, 1);
        let v4 = 0x2::coin::into_balance<0x5613a7e1f4f8fc7b896781aaba9b52944763e14421458d14c829223541d77c1c::agent::AGENT>(arg1);
        0x2::balance::join<0x5613a7e1f4f8fc7b896781aaba9b52944763e14421458d14c829223541d77c1c::agent::AGENT>(&mut arg0.protocol_agent, 0x2::balance::split<0x5613a7e1f4f8fc7b896781aaba9b52944763e14421458d14c829223541d77c1c::agent::AGENT>(&mut v4, v0 * arg0.protocol_bps / 10000));
        0x2::balance::join<0x5613a7e1f4f8fc7b896781aaba9b52944763e14421458d14c829223541d77c1c::agent::AGENT>(&mut arg0.agent_reserve, v4);
        arg0.total_trades = arg0.total_trades + 1;
        arg0.total_volume_agent = arg0.total_volume_agent + v0;
        let v5 = MemeBought{
            pool_id   : 0x2::object::id<MemePool<T0>>(arg0),
            token_id  : arg0.token_id,
            buyer     : 0x2::tx_context::sender(arg4),
            agent_in  : v0,
            meme_out  : v3,
            fee_total : v1,
            timestamp : 0x2::clock::timestamp_ms(arg3),
        };
        0x2::event::emit<MemeBought>(v5);
        0x2::coin::from_balance<T0>(0x2::balance::split<T0>(&mut arg0.meme_reserve, v3), arg4)
    }

    public entry fun buy_meme_to_sender<T0>(arg0: &mut MemePool<T0>, arg1: 0x2::coin::Coin<0x5613a7e1f4f8fc7b896781aaba9b52944763e14421458d14c829223541d77c1c::agent::AGENT>, arg2: u64, arg3: &0x2::clock::Clock, arg4: &mut 0x2::tx_context::TxContext) {
        let v0 = buy_meme<T0>(arg0, arg1, arg2, arg3, arg4);
        0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(v0, 0x2::tx_context::sender(arg4));
    }

    public entry fun create_pool<T0>(arg0: 0x2::coin::Coin<0x5613a7e1f4f8fc7b896781aaba9b52944763e14421458d14c829223541d77c1c::agent::AGENT>, arg1: 0x2::coin::Coin<T0>, arg2: u64, arg3: vector<u8>, arg4: vector<u8>, arg5: &0x2::clock::Clock, arg6: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::coin::value<0x5613a7e1f4f8fc7b896781aaba9b52944763e14421458d14c829223541d77c1c::agent::AGENT>(&arg0);
        let v1 = 0x2::coin::value<T0>(&arg1);
        assert!(v0 > 0 && v1 > 0, 0);
        let v2 = 0x2::tx_context::sender(arg6);
        let v3 = 0x2::clock::timestamp_ms(arg5);
        let v4 = MemePool<T0>{
            id                 : 0x2::object::new(arg6),
            admin              : v2,
            agent_reserve      : 0x2::coin::into_balance<0x5613a7e1f4f8fc7b896781aaba9b52944763e14421458d14c829223541d77c1c::agent::AGENT>(arg0),
            meme_reserve       : 0x2::coin::into_balance<T0>(arg1),
            fee_bps            : 30,
            protocol_bps       : 15,
            protocol_agent     : 0x2::balance::zero<0x5613a7e1f4f8fc7b896781aaba9b52944763e14421458d14c829223541d77c1c::agent::AGENT>(),
            total_trades       : 0,
            total_volume_agent : 0,
            is_paused          : false,
            created_at         : v3,
            token_id           : arg2,
            meme_name          : arg3,
            meme_symbol        : arg4,
        };
        let v5 = PoolCreated{
            pool_id     : 0x2::object::id<MemePool<T0>>(&v4),
            token_id    : arg2,
            meme_name   : v4.meme_name,
            meme_symbol : v4.meme_symbol,
            agent_seed  : v0,
            meme_seed   : v1,
            admin       : v2,
            timestamp   : v3,
        };
        0x2::event::emit<PoolCreated>(v5);
        0x2::transfer::share_object<MemePool<T0>>(v4);
    }

    fun get_amount_out(arg0: u64, arg1: u64, arg2: u64) : u64 {
        assert!(arg1 > 0 && arg2 > 0, 1);
        (((arg0 as u128) * (arg2 as u128) / ((arg1 as u128) + (arg0 as u128))) as u64)
    }

    public fun get_buy_quote<T0>(arg0: &MemePool<T0>, arg1: u64) : u64 {
        if (arg0.is_paused || arg1 == 0) {
            return 0
        };
        let (v0, v1) = get_reserves<T0>(arg0);
        get_amount_out(arg1 - arg1 * arg0.fee_bps / 10000, v0, v1)
    }

    public fun get_reserves<T0>(arg0: &MemePool<T0>) : (u64, u64) {
        (0x2::balance::value<0x5613a7e1f4f8fc7b896781aaba9b52944763e14421458d14c829223541d77c1c::agent::AGENT>(&arg0.agent_reserve), 0x2::balance::value<T0>(&arg0.meme_reserve))
    }

    public fun get_sell_quote<T0>(arg0: &MemePool<T0>, arg1: u64) : u64 {
        if (arg0.is_paused || arg1 == 0) {
            return 0
        };
        let (v0, v1) = get_reserves<T0>(arg0);
        let v2 = get_amount_out(arg1, v1, v0);
        v2 - v2 * arg0.fee_bps / 10000
    }

    public fun is_paused<T0>(arg0: &MemePool<T0>) : bool {
        arg0.is_paused
    }

    public entry fun pause<T0>(arg0: &mut MemePool<T0>, arg1: &mut 0x2::tx_context::TxContext) {
        assert!(0x2::tx_context::sender(arg1) == arg0.admin, 4);
        arg0.is_paused = true;
    }

    public fun protocol_balance<T0>(arg0: &MemePool<T0>) : u64 {
        0x2::balance::value<0x5613a7e1f4f8fc7b896781aaba9b52944763e14421458d14c829223541d77c1c::agent::AGENT>(&arg0.protocol_agent)
    }

    public fun sell_meme<T0>(arg0: &mut MemePool<T0>, arg1: 0x2::coin::Coin<T0>, arg2: u64, arg3: &0x2::clock::Clock, arg4: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<0x5613a7e1f4f8fc7b896781aaba9b52944763e14421458d14c829223541d77c1c::agent::AGENT> {
        assert!(!arg0.is_paused, 3);
        let v0 = 0x2::coin::value<T0>(&arg1);
        assert!(v0 > 0, 0);
        let v1 = 0x2::balance::value<0x5613a7e1f4f8fc7b896781aaba9b52944763e14421458d14c829223541d77c1c::agent::AGENT>(&arg0.agent_reserve);
        let v2 = get_amount_out(v0, 0x2::balance::value<T0>(&arg0.meme_reserve), v1);
        let v3 = v2 * arg0.fee_bps / 10000;
        let v4 = v2 * arg0.protocol_bps / 10000;
        let v5 = v2 - v3;
        assert!(v5 >= arg2, 2);
        assert!(v1 >= v2, 1);
        0x2::balance::join<T0>(&mut arg0.meme_reserve, 0x2::coin::into_balance<T0>(arg1));
        let v6 = 0x2::balance::split<0x5613a7e1f4f8fc7b896781aaba9b52944763e14421458d14c829223541d77c1c::agent::AGENT>(&mut arg0.agent_reserve, v2);
        0x2::balance::join<0x5613a7e1f4f8fc7b896781aaba9b52944763e14421458d14c829223541d77c1c::agent::AGENT>(&mut arg0.protocol_agent, 0x2::balance::split<0x5613a7e1f4f8fc7b896781aaba9b52944763e14421458d14c829223541d77c1c::agent::AGENT>(&mut v6, v4));
        0x2::balance::join<0x5613a7e1f4f8fc7b896781aaba9b52944763e14421458d14c829223541d77c1c::agent::AGENT>(&mut arg0.agent_reserve, 0x2::balance::split<0x5613a7e1f4f8fc7b896781aaba9b52944763e14421458d14c829223541d77c1c::agent::AGENT>(&mut v6, v3 - v4));
        arg0.total_trades = arg0.total_trades + 1;
        arg0.total_volume_agent = arg0.total_volume_agent + v2;
        let v7 = MemeSold{
            pool_id   : 0x2::object::id<MemePool<T0>>(arg0),
            token_id  : arg0.token_id,
            seller    : 0x2::tx_context::sender(arg4),
            meme_in   : v0,
            agent_out : v5,
            fee_total : v3,
            timestamp : 0x2::clock::timestamp_ms(arg3),
        };
        0x2::event::emit<MemeSold>(v7);
        0x2::coin::from_balance<0x5613a7e1f4f8fc7b896781aaba9b52944763e14421458d14c829223541d77c1c::agent::AGENT>(v6, arg4)
    }

    public entry fun sell_meme_to_sender<T0>(arg0: &mut MemePool<T0>, arg1: 0x2::coin::Coin<T0>, arg2: u64, arg3: &0x2::clock::Clock, arg4: &mut 0x2::tx_context::TxContext) {
        let v0 = sell_meme<T0>(arg0, arg1, arg2, arg3, arg4);
        0x2::transfer::public_transfer<0x2::coin::Coin<0x5613a7e1f4f8fc7b896781aaba9b52944763e14421458d14c829223541d77c1c::agent::AGENT>>(v0, 0x2::tx_context::sender(arg4));
    }

    public fun token_id<T0>(arg0: &MemePool<T0>) : u64 {
        arg0.token_id
    }

    public fun total_trades<T0>(arg0: &MemePool<T0>) : u64 {
        arg0.total_trades
    }

    public fun total_volume<T0>(arg0: &MemePool<T0>) : u64 {
        arg0.total_volume_agent
    }

    public entry fun transfer_admin<T0>(arg0: &mut MemePool<T0>, arg1: address, arg2: &mut 0x2::tx_context::TxContext) {
        assert!(0x2::tx_context::sender(arg2) == arg0.admin, 4);
        arg0.admin = arg1;
    }

    public entry fun unpause<T0>(arg0: &mut MemePool<T0>, arg1: &mut 0x2::tx_context::TxContext) {
        assert!(0x2::tx_context::sender(arg1) == arg0.admin, 4);
        arg0.is_paused = false;
    }

    public fun withdraw_protocol_fees<T0>(arg0: &mut MemePool<T0>, arg1: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<0x5613a7e1f4f8fc7b896781aaba9b52944763e14421458d14c829223541d77c1c::agent::AGENT> {
        assert!(0x2::tx_context::sender(arg1) == arg0.admin, 4);
        assert!(0x2::balance::value<0x5613a7e1f4f8fc7b896781aaba9b52944763e14421458d14c829223541d77c1c::agent::AGENT>(&arg0.protocol_agent) > 0, 0);
        0x2::coin::from_balance<0x5613a7e1f4f8fc7b896781aaba9b52944763e14421458d14c829223541d77c1c::agent::AGENT>(0x2::balance::withdraw_all<0x5613a7e1f4f8fc7b896781aaba9b52944763e14421458d14c829223541d77c1c::agent::AGENT>(&mut arg0.protocol_agent), arg1)
    }

    public entry fun withdraw_protocol_fees_to_sender<T0>(arg0: &mut MemePool<T0>, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = withdraw_protocol_fees<T0>(arg0, arg1);
        0x2::transfer::public_transfer<0x2::coin::Coin<0x5613a7e1f4f8fc7b896781aaba9b52944763e14421458d14c829223541d77c1c::agent::AGENT>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

