module 0x6d3bb718f66f9cf6d8d5f7ae96901a06d72a4c561c5e78ac7c9027ed9d386ecf::staking {
    struct AdminCap has store, key {
        id: 0x2::object::UID,
        registry: 0x2::object::ID,
    }

    struct BuyerCap has store, key {
        id: 0x2::object::UID,
        registry: 0x2::object::ID,
    }

    struct Registry has key {
        id: 0x2::object::UID,
        version: u64,
        sui_split: vector<u64>,
        tok_split: vector<u64>,
        first_ms: u64,
        first_bps: u64,
        rest_ms: u64,
        pools: 0x2::table::Table<0x1::type_name::TypeName, 0x2::object::ID>,
        protocol: 0x2::balance::Balance<0x2::sui::SUI>,
        sti: 0x2::balance::Balance<0x2::sui::SUI>,
        sti_pot: 0x2::object::ID,
        sti_pool: 0x2::object::ID,
        max_buy: u64,
        max_buy_day: u64,
        day_start_ms: u64,
        bought_today: u64,
        max_slip_bps: u64,
        gas_day_max: u64,
        gas_day_start_ms: u64,
        gas_today: u64,
        bought_sui: u64,
        bought_sti: u64,
        paused: bool,
        buying: bool,
    }

    struct ProofKey has copy, drop, store {
        dummy_field: bool,
    }

    struct CoinPool<phantom T0> has key {
        id: 0x2::object::UID,
        registry: 0x2::object::ID,
        version: u64,
        venue: u8,
        t_is_a: bool,
        pair: 0x2::object::ID,
        proof: 0x2::object::ID,
        creator: address,
        launch_ms: u64,
        first_stake_ms: u64,
        staked_time_ms: u64,
        staked_since_ms: u64,
        carry_ms: u64,
        last_collect_ms: u64,
        staked: 0x2::balance::Balance<T0>,
        weight: u64,
        acc_sui: u256,
        acc_tok: u256,
        carry_sui: u64,
        carry_tok: u64,
        rew_sui: 0x2::balance::Balance<0x2::sui::SUI>,
        rew_tok: 0x2::balance::Balance<T0>,
        creator_sui: 0x2::balance::Balance<0x2::sui::SUI>,
        creator_tok: 0x2::balance::Balance<T0>,
        protocol_sui: 0x2::balance::Balance<0x2::sui::SUI>,
        sti_sui: 0x2::balance::Balance<0x2::sui::SUI>,
        res_sui: 0x2::balance::Balance<0x2::sui::SUI>,
        res_tok: 0x2::balance::Balance<T0>,
        r: vector<u64>,
        rel: vector<u64>,
        fees_sui: u128,
        fees_tok: u128,
    }

    struct Stake<phantom T0> has store, key {
        id: 0x2::object::UID,
        pool: 0x2::object::ID,
        amount: u64,
        mult_bps: u64,
        acc_sui_at: u256,
        acc_tok_at: u256,
        owed_sui: u64,
        owed_tok: u64,
        staked_ms: u64,
    }

    struct BuyTicket {
        registry: 0x2::object::ID,
        sui_in: u64,
        min_out: u64,
    }

    struct PoolCreated has copy, drop {
        pool: 0x2::object::ID,
        coin: 0x1::type_name::TypeName,
        venue: u8,
        pair: 0x2::object::ID,
        proof: 0x2::object::ID,
        creator: address,
        backlog_sui: u64,
        backlog_tok: u64,
    }

    struct Distributed has copy, drop {
        pool: 0x2::object::ID,
        sui: u64,
        tok: u64,
    }

    struct Staked has copy, drop {
        pool: 0x2::object::ID,
        stake: 0x2::object::ID,
        amount: u64,
        weight: u64,
    }

    struct Unstaked has copy, drop {
        pool: 0x2::object::ID,
        stake: 0x2::object::ID,
        amount: u64,
        sui: u64,
        tok: u64,
    }

    struct Claimed has copy, drop {
        pool: 0x2::object::ID,
        stake: 0x2::object::ID,
        sui: u64,
        tok: u64,
        restaked: bool,
    }

    struct CreatorClaimed has copy, drop {
        pool: 0x2::object::ID,
        creator: address,
        sui: u64,
        tok: u64,
    }

    struct CreatorChanged has copy, drop {
        pool: 0x2::object::ID,
        from: address,
        to: address,
    }

    struct Swept has copy, drop {
        pool: 0x2::object::ID,
        protocol: u64,
        sti: u64,
    }

    struct StiBought has copy, drop {
        sui: u64,
        sti: u64,
    }

    struct GasRefilled has copy, drop {
        to: address,
        amount: u64,
        today: u64,
    }

    public fun split(arg0: &Registry) : (vector<u64>, vector<u64>) {
        (arg0.sui_split, arg0.tok_split)
    }

    public(friend) fun add_fees<T0>(arg0: &mut CoinPool<T0>, arg1: &Registry, arg2: 0x2::coin::Coin<0x2::sui::SUI>, arg3: 0x2::coin::Coin<T0>, arg4: &0x2::clock::Clock) {
        live<T0>(arg0, arg1);
        assert!(!arg1.paused, 4);
        tick<T0>(arg0, arg1, 0x2::clock::timestamp_ms(arg4));
        arg0.last_collect_ms = 0x2::clock::timestamp_ms(arg4);
        let v0 = 0x2::coin::value<0x2::sui::SUI>(&arg2);
        let v1 = 0x2::coin::value<T0>(&arg3);
        let v2 = 0x2::coin::into_balance<0x2::sui::SUI>(arg2);
        let v3 = 0x2::coin::into_balance<T0>(arg3);
        let (v4, v5, _, v7) = split_sui(arg1, v0);
        0x2::balance::join<0x2::sui::SUI>(&mut arg0.protocol_sui, 0x2::balance::split<0x2::sui::SUI>(&mut v2, v4));
        0x2::balance::join<0x2::sui::SUI>(&mut arg0.creator_sui, 0x2::balance::split<0x2::sui::SUI>(&mut v2, v5));
        0x2::balance::join<0x2::sui::SUI>(&mut arg0.sti_sui, 0x2::balance::split<0x2::sui::SUI>(&mut v2, v7));
        let (v8, _) = split_tok(arg1, v1);
        0x2::balance::join<T0>(&mut arg0.creator_tok, 0x2::balance::split<T0>(&mut v3, v8));
        to_stakers<T0>(arg0, v2, v3);
        arg0.fees_sui = arg0.fees_sui + (v0 as u128);
        arg0.fees_tok = arg0.fees_tok + (v1 as u128);
        let v10 = Distributed{
            pool : 0x2::object::id<CoinPool<T0>>(arg0),
            sui  : v0,
            tok  : v1,
        };
        0x2::event::emit<Distributed>(v10);
    }

    fun admin(arg0: &Registry, arg1: &AdminCap) {
        assert!(arg0.version == 1, 1);
        assert!(arg1.registry == 0x2::object::id<Registry>(arg0), 2);
    }

    public fun bought(arg0: &Registry) : (u64, u64) {
        (arg0.bought_sui, arg0.bought_sti)
    }

    public fun buy_begin<T0>(arg0: &mut Registry, arg1: &BuyerCap, arg2: &0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T0, 0x2::sui::SUI>, arg3: u64, arg4: u64, arg5: &0x2::clock::Clock, arg6: &mut 0x2::tx_context::TxContext) : (0x2::coin::Coin<0x2::sui::SUI>, BuyTicket) {
        assert!(arg0.version == 1, 1);
        assert!(arg1.registry == 0x2::object::id<Registry>(arg0), 2);
        assert!(!arg0.buying, 10);
        assert!(0x2::object::id<0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T0, 0x2::sui::SUI>>(arg2) == arg0.sti_pool, 3);
        let v0 = if (arg3 > 0) {
            if (arg3 <= arg0.max_buy) {
                arg3 <= 0x2::balance::value<0x2::sui::SUI>(&arg0.sti)
            } else {
                false
            }
        } else {
            false
        };
        assert!(v0, 11);
        day_budget(arg0, arg3, 0x2::clock::timestamp_ms(arg5));
        assert!(arg4 >= min_out_floor(arg3, 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::current_sqrt_price<T0, 0x2::sui::SUI>(arg2), arg0.max_slip_bps) && arg4 > 0, 12);
        arg0.buying = true;
        let v1 = BuyTicket{
            registry : 0x2::object::id<Registry>(arg0),
            sui_in   : arg3,
            min_out  : arg4,
        };
        (0x2::coin::from_balance<0x2::sui::SUI>(0x2::balance::split<0x2::sui::SUI>(&mut arg0.sti, arg3), arg6), v1)
    }

    public fun buy_end<T0>(arg0: &mut Registry, arg1: &mut 0x54e8315e419c9768faf889e36a0a12c90287e14669903f20f92f0ce9a8013c2::rewards::Pot<T0>, arg2: BuyTicket, arg3: 0x2::coin::Coin<T0>, arg4: &0x2::clock::Clock) {
        let BuyTicket {
            registry : v0,
            sui_in   : v1,
            min_out  : v2,
        } = arg2;
        assert!(v0 == 0x2::object::id<Registry>(arg0), 2);
        assert!(0x2::object::id<0x54e8315e419c9768faf889e36a0a12c90287e14669903f20f92f0ce9a8013c2::rewards::Pot<T0>>(arg1) == arg0.sti_pot, 13);
        let v3 = 0x2::coin::value<T0>(&arg3);
        assert!(v3 >= v2, 12);
        0x54e8315e419c9768faf889e36a0a12c90287e14669903f20f92f0ce9a8013c2::rewards::deposit<T0>(arg1, arg3, arg4);
        arg0.buying = false;
        arg0.bought_sui = arg0.bought_sui + v1;
        arg0.bought_sti = arg0.bought_sti + v3;
        let v4 = StiBought{
            sui : v1,
            sti : v3,
        };
        0x2::event::emit<StiBought>(v4);
    }

    public fun carry<T0>(arg0: &CoinPool<T0>) : (u64, u64) {
        (arg0.carry_sui, arg0.carry_tok)
    }

    public(friend) fun check_pair<T0>(arg0: &CoinPool<T0>, arg1: u8, arg2: bool, arg3: 0x2::object::ID) {
        let v0 = if (arg0.venue == arg1) {
            if (arg0.t_is_a == arg2) {
                arg0.pair == arg3
            } else {
                false
            }
        } else {
            false
        };
        assert!(v0, 9);
    }

    public fun claim<T0>(arg0: &mut CoinPool<T0>, arg1: &Registry, arg2: &mut Stake<T0>, arg3: &0x2::clock::Clock, arg4: &mut 0x2::tx_context::TxContext) : (0x2::coin::Coin<0x2::sui::SUI>, 0x2::coin::Coin<T0>) {
        live_exit<T0>(arg0, arg1);
        tick<T0>(arg0, arg1, 0x2::clock::timestamp_ms(arg3));
        settle<T0>(arg0, arg2);
        let v0 = arg2.owed_sui;
        let v1 = arg2.owed_tok;
        arg2.owed_sui = 0;
        arg2.owed_tok = 0;
        let v2 = Claimed{
            pool     : 0x2::object::id<CoinPool<T0>>(arg0),
            stake    : 0x2::object::id<Stake<T0>>(arg2),
            sui      : v0,
            tok      : v1,
            restaked : false,
        };
        0x2::event::emit<Claimed>(v2);
        (0x2::coin::from_balance<0x2::sui::SUI>(0x2::balance::split<0x2::sui::SUI>(&mut arg0.rew_sui, v0), arg4), 0x2::coin::from_balance<T0>(0x2::balance::split<T0>(&mut arg0.rew_tok, v1), arg4))
    }

    public fun claim_and_restake<T0>(arg0: &mut CoinPool<T0>, arg1: &Registry, arg2: &mut Stake<T0>, arg3: &0x2::clock::Clock, arg4: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<0x2::sui::SUI> {
        live<T0>(arg0, arg1);
        let v0 = 0x2::clock::timestamp_ms(arg3);
        assert!(arg0.last_collect_ms == v0, 16);
        tick<T0>(arg0, arg1, v0);
        settle<T0>(arg0, arg2);
        let v1 = arg2.owed_sui;
        let v2 = arg2.owed_tok;
        arg2.owed_sui = 0;
        arg2.owed_tok = 0;
        0x2::balance::join<T0>(&mut arg0.staked, 0x2::balance::split<T0>(&mut arg0.rew_tok, v2));
        arg2.amount = arg2.amount + v2;
        let v3 = arg0.weight - weight_of<T0>(arg2) + weight_of<T0>(arg2);
        set_weight<T0>(arg0, v3, v0);
        let v4 = Claimed{
            pool     : 0x2::object::id<CoinPool<T0>>(arg0),
            stake    : 0x2::object::id<Stake<T0>>(arg2),
            sui      : v1,
            tok      : v2,
            restaked : true,
        };
        0x2::event::emit<Claimed>(v4);
        0x2::coin::from_balance<0x2::sui::SUI>(0x2::balance::split<0x2::sui::SUI>(&mut arg0.rew_sui, v1), arg4)
    }

    public fun create_registry(arg0: 0x2::object::ID, arg1: 0x2::object::ID, arg2: &mut 0x2::tx_context::TxContext) : AdminCap {
        let v0 = Registry{
            id               : 0x2::object::new(arg2),
            version          : 1,
            sui_split        : vector[1000, 3000, 3000, 3000],
            tok_split        : vector[5000, 5000],
            first_ms         : 60 * 86400000,
            first_bps        : 5000,
            rest_ms          : 120 * 86400000,
            pools            : 0x2::table::new<0x1::type_name::TypeName, 0x2::object::ID>(arg2),
            protocol         : 0x2::balance::zero<0x2::sui::SUI>(),
            sti              : 0x2::balance::zero<0x2::sui::SUI>(),
            sti_pot          : arg0,
            sti_pool         : arg1,
            max_buy          : 1000000000,
            max_buy_day      : 10000000000,
            day_start_ms     : 0,
            bought_today     : 0,
            max_slip_bps     : 300,
            gas_day_max      : 500000000,
            gas_day_start_ms : 0,
            gas_today        : 0,
            bought_sui       : 0,
            bought_sti       : 0,
            paused           : false,
            buying           : false,
        };
        let v1 = AdminCap{
            id       : 0x2::object::new(arg2),
            registry : 0x2::object::id<Registry>(&v0),
        };
        0x2::transfer::share_object<Registry>(v0);
        v1
    }

    public fun creator<T0>(arg0: &CoinPool<T0>) : address {
        arg0.creator
    }

    public fun creator_claim<T0>(arg0: &mut CoinPool<T0>, arg1: &Registry, arg2: &0x2::clock::Clock, arg3: &mut 0x2::tx_context::TxContext) : (0x2::coin::Coin<0x2::sui::SUI>, 0x2::coin::Coin<T0>) {
        live_exit<T0>(arg0, arg1);
        assert!(0x2::tx_context::sender(arg3) == arg0.creator, 6);
        tick<T0>(arg0, arg1, 0x2::clock::timestamp_ms(arg2));
        let v0 = 0x2::balance::withdraw_all<0x2::sui::SUI>(&mut arg0.creator_sui);
        let v1 = 0x2::balance::withdraw_all<T0>(&mut arg0.creator_tok);
        let v2 = CreatorClaimed{
            pool    : 0x2::object::id<CoinPool<T0>>(arg0),
            creator : arg0.creator,
            sui     : 0x2::balance::value<0x2::sui::SUI>(&v0),
            tok     : 0x2::balance::value<T0>(&v1),
        };
        0x2::event::emit<CreatorClaimed>(v2);
        (0x2::coin::from_balance<0x2::sui::SUI>(v0, arg3), 0x2::coin::from_balance<T0>(v1, arg3))
    }

    public fun creator_owed<T0>(arg0: &CoinPool<T0>) : (u64, u64) {
        (0x2::balance::value<0x2::sui::SUI>(&arg0.creator_sui), 0x2::balance::value<T0>(&arg0.creator_tok))
    }

    fun day_budget(arg0: &mut Registry, arg1: u64, arg2: u64) {
        if (arg2 >= arg0.day_start_ms + 86400000) {
            arg0.day_start_ms = arg2;
            arg0.bought_today = 0;
        };
        assert!(arg0.bought_today + arg1 <= arg0.max_buy_day, 11);
        arg0.bought_today = arg0.bought_today + arg1;
    }

    fun drip<T0>(arg0: &mut CoinPool<T0>, arg1: u64) {
        if (arg0.weight == 0) {
            arg0.carry_ms = arg1;
            return
        };
        let v0 = if (arg1 > arg0.carry_ms) {
            arg1 - arg0.carry_ms
        } else {
            0
        };
        arg0.carry_ms = arg1;
        if (v0 == 0) {
            return
        };
        let v1 = (arg0.weight as u256);
        let v2 = part(arg0.carry_sui, v0);
        let v3 = part(arg0.carry_tok, v0);
        arg0.carry_sui = arg0.carry_sui - v2;
        arg0.carry_tok = arg0.carry_tok - v3;
        arg0.acc_sui = arg0.acc_sui + (v2 as u256) * 1000000000000000000 / v1;
        arg0.acc_tok = arg0.acc_tok + (v3 as u256) * 1000000000000000000 / v1;
    }

    public fun fees<T0>(arg0: &CoinPool<T0>) : (u128, u128) {
        (arg0.fees_sui, arg0.fees_tok)
    }

    public fun first_stake_ms<T0>(arg0: &CoinPool<T0>) : u64 {
        arg0.first_stake_ms
    }

    public fun gas_left_today(arg0: &Registry, arg1: u64) : u64 {
        if (arg1 >= arg0.gas_day_start_ms + 86400000) {
            arg0.gas_day_max
        } else if (arg0.gas_today >= arg0.gas_day_max) {
            0
        } else {
            arg0.gas_day_max - arg0.gas_today
        }
    }

    public fun gas_refill(arg0: &mut Registry, arg1: &BuyerCap, arg2: u64, arg3: &0x2::clock::Clock, arg4: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<0x2::sui::SUI> {
        assert!(arg0.version == 1, 1);
        assert!(arg1.registry == 0x2::object::id<Registry>(arg0), 2);
        assert!(arg2 > 0 && arg2 <= 0x2::balance::value<0x2::sui::SUI>(&arg0.protocol), 11);
        let v0 = 0x2::clock::timestamp_ms(arg3);
        if (v0 >= arg0.gas_day_start_ms + 86400000) {
            arg0.gas_day_start_ms = v0;
            arg0.gas_today = 0;
        };
        assert!(arg0.gas_today + arg2 <= arg0.gas_day_max, 11);
        arg0.gas_today = arg0.gas_today + arg2;
        let v1 = GasRefilled{
            to     : 0x2::tx_context::sender(arg4),
            amount : arg2,
            today  : arg0.gas_today,
        };
        0x2::event::emit<GasRefilled>(v1);
        0x2::coin::from_balance<0x2::sui::SUI>(0x2::balance::split<0x2::sui::SUI>(&mut arg0.protocol, arg2), arg4)
    }

    public fun issue_buyer_cap(arg0: &Registry, arg1: &AdminCap, arg2: &mut 0x2::tx_context::TxContext) : BuyerCap {
        admin(arg0, arg1);
        BuyerCap{
            id       : 0x2::object::new(arg2),
            registry : 0x2::object::id<Registry>(arg0),
        }
    }

    public fun last_collect_ms<T0>(arg0: &CoinPool<T0>) : u64 {
        arg0.last_collect_ms
    }

    public(friend) fun launch<T0>(arg0: CoinPool<T0>, arg1: &Registry, arg2: 0x2::coin::Coin<0x2::sui::SUI>, arg3: 0x2::coin::Coin<T0>) {
        let v0 = 0x2::coin::value<0x2::sui::SUI>(&arg2);
        let v1 = 0x2::coin::value<T0>(&arg3);
        let (v2, v3, v4, v5) = split_sui(arg1, v0);
        let (v6, v7) = split_tok(arg1, v1);
        let v8 = 0x1::vector::empty<u64>();
        let v9 = &mut v8;
        0x1::vector::push_back<u64>(v9, v2);
        0x1::vector::push_back<u64>(v9, v3);
        0x1::vector::push_back<u64>(v9, v4);
        0x1::vector::push_back<u64>(v9, v5);
        0x1::vector::push_back<u64>(v9, v6);
        0x1::vector::push_back<u64>(v9, v7);
        arg0.r = v8;
        0x2::balance::join<0x2::sui::SUI>(&mut arg0.res_sui, 0x2::coin::into_balance<0x2::sui::SUI>(arg2));
        0x2::balance::join<T0>(&mut arg0.res_tok, 0x2::coin::into_balance<T0>(arg3));
        arg0.fees_sui = (v0 as u128);
        arg0.fees_tok = (v1 as u128);
        let v10 = PoolCreated{
            pool        : 0x2::object::id<CoinPool<T0>>(&arg0),
            coin        : 0x1::type_name::with_defining_ids<T0>(),
            venue       : arg0.venue,
            pair        : arg0.pair,
            proof       : arg0.proof,
            creator     : arg0.creator,
            backlog_sui : v0,
            backlog_tok : v1,
        };
        0x2::event::emit<PoolCreated>(v10);
        0x2::transfer::share_object<CoinPool<T0>>(arg0);
    }

    public fun launch_ms<T0>(arg0: &CoinPool<T0>) : u64 {
        arg0.launch_ms
    }

    fun live<T0>(arg0: &CoinPool<T0>, arg1: &Registry) {
        assert!(arg0.version == 1 && arg1.version == 1, 1);
        assert!(arg0.registry == 0x2::object::id<Registry>(arg1), 2);
    }

    fun live_exit<T0>(arg0: &CoinPool<T0>, arg1: &Registry) {
        assert!(arg0.version <= 1, 1);
        assert!(arg0.registry == 0x2::object::id<Registry>(arg1), 2);
    }

    public fun merge<T0>(arg0: &mut CoinPool<T0>, arg1: &Registry, arg2: &mut Stake<T0>, arg3: Stake<T0>, arg4: &0x2::clock::Clock) {
        live<T0>(arg0, arg1);
        tick<T0>(arg0, arg1, 0x2::clock::timestamp_ms(arg4));
        settle<T0>(arg0, arg2);
        let v0 = &mut arg3;
        settle<T0>(arg0, v0);
        let Stake {
            id         : v1,
            pool       : _,
            amount     : v3,
            mult_bps   : _,
            acc_sui_at : _,
            acc_tok_at : _,
            owed_sui   : v7,
            owed_tok   : v8,
            staked_ms  : v9,
        } = arg3;
        0x2::object::delete(v1);
        arg2.amount = arg2.amount + v3;
        arg2.owed_sui = arg2.owed_sui + v7;
        arg2.owed_tok = arg2.owed_tok + v8;
        if (v9 < arg2.staked_ms) {
            arg2.staked_ms = v9;
        };
        let v10 = arg0.weight - weight_of<T0>(arg2) - weight_of<T0>(&arg3) + weight_of<T0>(arg2);
        set_weight<T0>(arg0, v10, 0x2::clock::timestamp_ms(arg4));
    }

    public fun migrate(arg0: &mut Registry, arg1: &AdminCap) {
        assert!(arg1.registry == 0x2::object::id<Registry>(arg0), 2);
        assert!(arg0.version < 1, 1);
        arg0.version = 1;
    }

    public fun migrate_pool<T0>(arg0: &mut CoinPool<T0>, arg1: &Registry, arg2: &AdminCap) {
        admin(arg1, arg2);
        assert!(arg0.registry == 0x2::object::id<Registry>(arg1), 2);
        assert!(arg0.version < 1, 1);
        arg0.version = 1;
    }

    public fun min_out_floor(arg0: u64, arg1: u128, arg2: u64) : u64 {
        let v0 = (arg1 as u256);
        let v1 = ((arg0 as u256) << 128) / v0 * v0 * ((10000 - arg2) as u256) / (10000 as u256);
        if (v1 > 18446744073709551615) {
            18446744073709551615
        } else {
            (v1 as u64)
        }
    }

    fun mul_bps(arg0: u64, arg1: u64) : u64 {
        (((arg0 as u128) * (arg1 as u128) / (10000 as u128)) as u64)
    }

    public(friend) fun new_pool<T0, T1: store + key>(arg0: &mut Registry, arg1: &AdminCap, arg2: u8, arg3: bool, arg4: 0x2::object::ID, arg5: T1, arg6: address, arg7: &0x2::clock::Clock, arg8: &mut 0x2::tx_context::TxContext) : CoinPool<T0> {
        admin(arg0, arg1);
        let v0 = 0x1::type_name::with_defining_ids<T0>();
        assert!(!0x2::table::contains<0x1::type_name::TypeName, 0x2::object::ID>(&arg0.pools, v0), 8);
        let v1 = CoinPool<T0>{
            id              : 0x2::object::new(arg8),
            registry        : 0x2::object::id<Registry>(arg0),
            version         : 1,
            venue           : arg2,
            t_is_a          : arg3,
            pair            : arg4,
            proof           : 0x2::object::id<T1>(&arg5),
            creator         : arg6,
            launch_ms       : 0x2::clock::timestamp_ms(arg7),
            first_stake_ms  : 0,
            staked_time_ms  : 0,
            staked_since_ms : 0,
            carry_ms        : 0,
            last_collect_ms : 0x2::clock::timestamp_ms(arg7),
            staked          : 0x2::balance::zero<T0>(),
            weight          : 0,
            acc_sui         : 0,
            acc_tok         : 0,
            carry_sui       : 0,
            carry_tok       : 0,
            rew_sui         : 0x2::balance::zero<0x2::sui::SUI>(),
            rew_tok         : 0x2::balance::zero<T0>(),
            creator_sui     : 0x2::balance::zero<0x2::sui::SUI>(),
            creator_tok     : 0x2::balance::zero<T0>(),
            protocol_sui    : 0x2::balance::zero<0x2::sui::SUI>(),
            sti_sui         : 0x2::balance::zero<0x2::sui::SUI>(),
            res_sui         : 0x2::balance::zero<0x2::sui::SUI>(),
            res_tok         : 0x2::balance::zero<T0>(),
            r               : vector[0, 0, 0, 0, 0, 0],
            rel             : vector[0, 0, 0, 0, 0, 0],
            fees_sui        : 0,
            fees_tok        : 0,
        };
        let v2 = ProofKey{dummy_field: false};
        0x2::dynamic_object_field::add<ProofKey, T1>(&mut v1.id, v2, arg5);
        0x2::table::add<0x1::type_name::TypeName, 0x2::object::ID>(&mut arg0.pools, v0, 0x2::object::id<CoinPool<T0>>(&v1));
        v1
    }

    fun part(arg0: u64, arg1: u64) : u64 {
        if (arg1 >= 604800000) {
            arg0
        } else {
            (((arg0 as u128) * (arg1 as u128) / (604800000 as u128)) as u64)
        }
    }

    public fun pending<T0>(arg0: &CoinPool<T0>, arg1: &Stake<T0>) : (u64, u64) {
        let v0 = (weight_of<T0>(arg1) as u256);
        (arg1.owed_sui + (((arg0.acc_sui - arg1.acc_sui_at) * v0 / 1000000000000000000) as u64), arg1.owed_tok + (((arg0.acc_tok - arg1.acc_tok_at) * v0 / 1000000000000000000) as u64))
    }

    public fun pool_of<T0>(arg0: &Registry) : 0x1::option::Option<0x2::object::ID> {
        let v0 = 0x1::type_name::with_defining_ids<T0>();
        if (0x2::table::contains<0x1::type_name::TypeName, 0x2::object::ID>(&arg0.pools, v0)) {
            0x1::option::some<0x2::object::ID>(*0x2::table::borrow<0x1::type_name::TypeName, 0x2::object::ID>(&arg0.pools, v0))
        } else {
            0x1::option::none<0x2::object::ID>()
        }
    }

    public(friend) fun proof_mut<T0, T1: store + key>(arg0: &mut CoinPool<T0>) : &mut T1 {
        let v0 = ProofKey{dummy_field: false};
        0x2::dynamic_object_field::borrow_mut<ProofKey, T1>(&mut arg0.id, v0)
    }

    public fun protocol_waiting(arg0: &Registry) : u64 {
        0x2::balance::value<0x2::sui::SUI>(&arg0.protocol)
    }

    public fun protocol_withdraw(arg0: &mut Registry, arg1: &AdminCap, arg2: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<0x2::sui::SUI> {
        admin(arg0, arg1);
        0x2::coin::from_balance<0x2::sui::SUI>(0x2::balance::withdraw_all<0x2::sui::SUI>(&mut arg0.protocol), arg2)
    }

    public fun released(arg0: u64, arg1: u64, arg2: u64, arg3: u64, arg4: u64) : u64 {
        let v0 = (arg0 as u128);
        let v1 = v0 * (arg3 as u128) / (10000 as u128);
        let v2 = if (arg1 <= arg2) {
            v1 * (arg1 as u128) / (arg2 as u128)
        } else {
            let v3 = arg1 - arg2;
            if (v3 >= arg4) {
                v0
            } else {
                v1 + (v0 - v1) * (v3 as u128) / (arg4 as u128)
            }
        };
        (v2 as u64)
    }

    public fun reserve<T0>(arg0: &CoinPool<T0>) : (vector<u64>, vector<u64>) {
        (arg0.r, arg0.rel)
    }

    public fun set_buying(arg0: &mut Registry, arg1: &AdminCap, arg2: 0x2::object::ID, arg3: u64, arg4: u64, arg5: u64) {
        admin(arg0, arg1);
        let v0 = if (arg5 <= 1000) {
            if (arg4 <= 50000000000) {
                arg3 <= arg4
            } else {
                false
            }
        } else {
            false
        };
        assert!(v0, 15);
        arg0.sti_pool = arg2;
        arg0.max_buy = arg3;
        arg0.max_buy_day = arg4;
        arg0.max_slip_bps = arg5;
    }

    public fun set_creator<T0>(arg0: &mut CoinPool<T0>, arg1: address, arg2: &0x2::tx_context::TxContext) {
        assert!(0x2::tx_context::sender(arg2) == arg0.creator, 6);
        let v0 = CreatorChanged{
            pool : 0x2::object::id<CoinPool<T0>>(arg0),
            from : arg0.creator,
            to   : arg1,
        };
        0x2::event::emit<CreatorChanged>(v0);
        arg0.creator = arg1;
    }

    public fun set_gas_limit(arg0: &mut Registry, arg1: &AdminCap, arg2: u64) {
        admin(arg0, arg1);
        assert!(arg2 <= 1000000000, 15);
        arg0.gas_day_max = arg2;
    }

    public fun set_paused(arg0: &mut Registry, arg1: &AdminCap, arg2: bool) {
        admin(arg0, arg1);
        arg0.paused = arg2;
    }

    public fun set_schedule(arg0: &mut Registry, arg1: &AdminCap, arg2: u64, arg3: u64, arg4: u64) {
        admin(arg0, arg1);
        let v0 = if (arg2 >= arg0.first_ms) {
            if (arg4 >= arg0.rest_ms) {
                arg3 <= arg0.first_bps
            } else {
                false
            }
        } else {
            false
        };
        assert!(v0, 14);
        arg0.first_ms = arg2;
        arg0.first_bps = arg3;
        arg0.rest_ms = arg4;
    }

    public fun set_split(arg0: &mut Registry, arg1: &AdminCap, arg2: vector<u64>, arg3: vector<u64>) {
        admin(arg0, arg1);
        assert!(0x1::vector::length<u64>(&arg2) == 4 && 0x1::vector::length<u64>(&arg3) == 2, 7);
        assert!(sum(&arg2) == 10000 && sum(&arg3) == 10000, 7);
        assert!(*0x1::vector::borrow<u64>(&arg2, 0) <= 1000, 7);
        let v0 = if (*0x1::vector::borrow<u64>(&arg2, 1) >= 2000) {
            if (*0x1::vector::borrow<u64>(&arg2, 2) >= 2000) {
                *0x1::vector::borrow<u64>(&arg2, 3) >= 2000
            } else {
                false
            }
        } else {
            false
        };
        assert!(v0, 7);
        assert!(*0x1::vector::borrow<u64>(&arg3, 0) >= 3000 && *0x1::vector::borrow<u64>(&arg3, 1) >= 3000, 7);
        arg0.sui_split = arg2;
        arg0.tok_split = arg3;
    }

    fun set_weight<T0>(arg0: &mut CoinPool<T0>, arg1: u64, arg2: u64) {
        if (arg0.weight == 0 && arg1 > 0) {
            arg0.staked_since_ms = arg2;
            arg0.carry_ms = arg2;
        } else if (arg0.weight > 0 && arg1 == 0) {
            arg0.staked_time_ms = staker_elapsed<T0>(arg0, arg2);
            arg0.staked_since_ms = 0;
        };
        arg0.weight = arg1;
    }

    fun settle<T0>(arg0: &CoinPool<T0>, arg1: &mut Stake<T0>) {
        assert!(arg1.pool == 0x2::object::id<CoinPool<T0>>(arg0), 3);
        let v0 = (weight_of<T0>(arg1) as u256);
        arg1.owed_sui = arg1.owed_sui + (((arg0.acc_sui - arg1.acc_sui_at) * v0 / 1000000000000000000) as u64);
        arg1.owed_tok = arg1.owed_tok + (((arg0.acc_tok - arg1.acc_tok_at) * v0 / 1000000000000000000) as u64);
        arg1.acc_sui_at = arg0.acc_sui;
        arg1.acc_tok_at = arg0.acc_tok;
    }

    fun split_sui(arg0: &Registry, arg1: u64) : (u64, u64, u64, u64) {
        let v0 = mul_bps(arg1, *0x1::vector::borrow<u64>(&arg0.sui_split, 0));
        let v1 = mul_bps(arg1, *0x1::vector::borrow<u64>(&arg0.sui_split, 1));
        let v2 = mul_bps(arg1, *0x1::vector::borrow<u64>(&arg0.sui_split, 3));
        (v0, v1, arg1 - v0 - v1 - v2, v2)
    }

    fun split_tok(arg0: &Registry, arg1: u64) : (u64, u64) {
        let v0 = mul_bps(arg1, *0x1::vector::borrow<u64>(&arg0.tok_split, 0));
        (v0, arg1 - v0)
    }

    public fun stake<T0>(arg0: &mut CoinPool<T0>, arg1: &Registry, arg2: 0x2::coin::Coin<T0>, arg3: &0x2::clock::Clock, arg4: &mut 0x2::tx_context::TxContext) : Stake<T0> {
        live<T0>(arg0, arg1);
        assert!(!arg1.paused, 4);
        let v0 = 0x2::coin::value<T0>(&arg2);
        assert!(v0 > 0, 5);
        let v1 = 0x2::clock::timestamp_ms(arg3);
        assert!(arg0.last_collect_ms == v1, 16);
        tick<T0>(arg0, arg1, v1);
        if (arg0.first_stake_ms == 0) {
            arg0.first_stake_ms = v1;
        };
        let v2 = Stake<T0>{
            id         : 0x2::object::new(arg4),
            pool       : 0x2::object::id<CoinPool<T0>>(arg0),
            amount     : v0,
            mult_bps   : 10000,
            acc_sui_at : arg0.acc_sui,
            acc_tok_at : arg0.acc_tok,
            owed_sui   : 0,
            owed_tok   : 0,
            staked_ms  : v1,
        };
        0x2::balance::join<T0>(&mut arg0.staked, 0x2::coin::into_balance<T0>(arg2));
        let v3 = weight_of<T0>(&v2);
        let v4 = arg0.weight + v3;
        set_weight<T0>(arg0, v4, v1);
        let v5 = Staked{
            pool   : 0x2::object::id<CoinPool<T0>>(arg0),
            stake  : 0x2::object::id<Stake<T0>>(&v2),
            amount : v0,
            weight : v3,
        };
        0x2::event::emit<Staked>(v5);
        v2
    }

    public fun stake_amount<T0>(arg0: &Stake<T0>) : u64 {
        arg0.amount
    }

    public fun stake_pool<T0>(arg0: &Stake<T0>) : 0x2::object::ID {
        arg0.pool
    }

    fun staker_elapsed<T0>(arg0: &CoinPool<T0>, arg1: u64) : u64 {
        let v0 = if (arg0.weight > 0 && arg1 > arg0.staked_since_ms) {
            arg1 - arg0.staked_since_ms
        } else {
            0
        };
        arg0.staked_time_ms + v0
    }

    public fun stakers_clock_ms<T0>(arg0: &CoinPool<T0>, arg1: u64) : u64 {
        staker_elapsed<T0>(arg0, arg1)
    }

    public fun sti_waiting(arg0: &Registry) : u64 {
        0x2::balance::value<0x2::sui::SUI>(&arg0.sti)
    }

    fun sum(arg0: &vector<u64>) : u64 {
        let v0 = 0;
        let v1 = 0;
        while (v1 < 0x1::vector::length<u64>(arg0)) {
            v0 = v0 + *0x1::vector::borrow<u64>(arg0, v1);
            v1 = v1 + 1;
        };
        v0
    }

    public fun sweep<T0>(arg0: &mut CoinPool<T0>, arg1: &mut Registry, arg2: &0x2::clock::Clock) {
        live<T0>(arg0, arg1);
        tick<T0>(arg0, arg1, 0x2::clock::timestamp_ms(arg2));
        let v0 = 0x2::balance::withdraw_all<0x2::sui::SUI>(&mut arg0.protocol_sui);
        let v1 = 0x2::balance::withdraw_all<0x2::sui::SUI>(&mut arg0.sti_sui);
        let v2 = Swept{
            pool     : 0x2::object::id<CoinPool<T0>>(arg0),
            protocol : 0x2::balance::value<0x2::sui::SUI>(&v0),
            sti      : 0x2::balance::value<0x2::sui::SUI>(&v1),
        };
        0x2::event::emit<Swept>(v2);
        0x2::balance::join<0x2::sui::SUI>(&mut arg1.protocol, v0);
        0x2::balance::join<0x2::sui::SUI>(&mut arg1.sti, v1);
    }

    fun tick<T0>(arg0: &mut CoinPool<T0>, arg1: &Registry, arg2: u64) {
        let v0 = if (arg2 > arg0.launch_ms) {
            arg2 - arg0.launch_ms
        } else {
            0
        };
        drip<T0>(arg0, arg2);
        let v1 = 0;
        while (v1 < 6) {
            let v2 = *0x1::vector::borrow<u64>(&arg0.r, v1);
            if (v2 > *0x1::vector::borrow<u64>(&arg0.rel, v1)) {
                let v3 = if (v1 == 2 || v1 == 5) {
                    staker_elapsed<T0>(arg0, arg2)
                } else {
                    v0
                };
                let v4 = released(v2, v3, arg1.first_ms, arg1.first_bps, arg1.rest_ms);
                if (v4 > *0x1::vector::borrow<u64>(&arg0.rel, v1)) {
                    *0x1::vector::borrow_mut<u64>(&mut arg0.rel, v1) = v4;
                    if (v1 == 0) {
                        0x2::balance::join<0x2::sui::SUI>(&mut arg0.protocol_sui, 0x2::balance::split<0x2::sui::SUI>(&mut arg0.res_sui, v4 - *0x1::vector::borrow<u64>(&arg0.rel, v1)));
                    } else if (v1 == 1) {
                        0x2::balance::join<0x2::sui::SUI>(&mut arg0.creator_sui, 0x2::balance::split<0x2::sui::SUI>(&mut arg0.res_sui, v4 - *0x1::vector::borrow<u64>(&arg0.rel, v1)));
                    } else if (v1 == 3) {
                        0x2::balance::join<0x2::sui::SUI>(&mut arg0.sti_sui, 0x2::balance::split<0x2::sui::SUI>(&mut arg0.res_sui, v4 - *0x1::vector::borrow<u64>(&arg0.rel, v1)));
                    } else if (v1 == 4) {
                        0x2::balance::join<T0>(&mut arg0.creator_tok, 0x2::balance::split<T0>(&mut arg0.res_tok, v4 - *0x1::vector::borrow<u64>(&arg0.rel, v1)));
                    } else if (v1 == 2) {
                        let v5 = 0x2::balance::split<0x2::sui::SUI>(&mut arg0.res_sui, v4 - *0x1::vector::borrow<u64>(&arg0.rel, v1));
                        to_stakers<T0>(arg0, v5, 0x2::balance::zero<T0>());
                    } else {
                        let v6 = 0x2::balance::split<T0>(&mut arg0.res_tok, v4 - *0x1::vector::borrow<u64>(&arg0.rel, v1));
                        to_stakers<T0>(arg0, 0x2::balance::zero<0x2::sui::SUI>(), v6);
                    };
                };
            };
            v1 = v1 + 1;
        };
    }

    fun to_stakers<T0>(arg0: &mut CoinPool<T0>, arg1: 0x2::balance::Balance<0x2::sui::SUI>, arg2: 0x2::balance::Balance<T0>) {
        0x2::balance::join<0x2::sui::SUI>(&mut arg0.rew_sui, arg1);
        0x2::balance::join<T0>(&mut arg0.rew_tok, arg2);
        if (arg0.weight == 0) {
            arg0.carry_sui = arg0.carry_sui + 0x2::balance::value<0x2::sui::SUI>(&arg1);
            arg0.carry_tok = arg0.carry_tok + 0x2::balance::value<T0>(&arg2);
        } else {
            let v0 = (arg0.weight as u256);
            arg0.acc_sui = arg0.acc_sui + (0x2::balance::value<0x2::sui::SUI>(&arg1) as u256) * 1000000000000000000 / v0;
            arg0.acc_tok = arg0.acc_tok + (0x2::balance::value<T0>(&arg2) as u256) * 1000000000000000000 / v0;
        };
    }

    public fun total_staked<T0>(arg0: &CoinPool<T0>) : u64 {
        0x2::balance::value<T0>(&arg0.staked)
    }

    public fun total_weight<T0>(arg0: &CoinPool<T0>) : u64 {
        arg0.weight
    }

    public fun unstake<T0>(arg0: &mut CoinPool<T0>, arg1: &Registry, arg2: Stake<T0>, arg3: &0x2::clock::Clock, arg4: &mut 0x2::tx_context::TxContext) : (0x2::coin::Coin<T0>, 0x2::coin::Coin<0x2::sui::SUI>) {
        live_exit<T0>(arg0, arg1);
        let v0 = 0x2::clock::timestamp_ms(arg3);
        tick<T0>(arg0, arg1, v0);
        let v1 = &mut arg2;
        settle<T0>(arg0, v1);
        let Stake {
            id         : v2,
            pool       : _,
            amount     : v4,
            mult_bps   : _,
            acc_sui_at : _,
            acc_tok_at : _,
            owed_sui   : v8,
            owed_tok   : v9,
            staked_ms  : _,
        } = arg2;
        let v11 = v2;
        let v12 = Unstaked{
            pool   : 0x2::object::id<CoinPool<T0>>(arg0),
            stake  : 0x2::object::uid_to_inner(&v11),
            amount : v4,
            sui    : v8,
            tok    : v9,
        };
        0x2::event::emit<Unstaked>(v12);
        0x2::object::delete(v11);
        let v13 = arg0.weight - weight_of<T0>(&arg2);
        set_weight<T0>(arg0, v13, v0);
        let v14 = 0x2::balance::split<T0>(&mut arg0.staked, v4);
        0x2::balance::join<T0>(&mut v14, 0x2::balance::split<T0>(&mut arg0.rew_tok, v9));
        (0x2::coin::from_balance<T0>(v14, arg4), 0x2::coin::from_balance<0x2::sui::SUI>(0x2::balance::split<0x2::sui::SUI>(&mut arg0.rew_sui, v8), arg4))
    }

    public fun unswept<T0>(arg0: &CoinPool<T0>) : (u64, u64) {
        (0x2::balance::value<0x2::sui::SUI>(&arg0.protocol_sui), 0x2::balance::value<0x2::sui::SUI>(&arg0.sti_sui))
    }

    public fun venue<T0>(arg0: &CoinPool<T0>) : (u8, bool, 0x2::object::ID, 0x2::object::ID) {
        (arg0.venue, arg0.t_is_a, arg0.pair, arg0.proof)
    }

    fun weight_of<T0>(arg0: &Stake<T0>) : u64 {
        mul_bps(arg0.amount, arg0.mult_bps)
    }

    // decompiled from Move bytecode v7
}

