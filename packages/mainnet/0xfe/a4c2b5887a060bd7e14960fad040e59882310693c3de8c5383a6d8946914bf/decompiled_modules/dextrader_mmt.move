module 0xfea4c2b5887a060bd7e14960fad040e59882310693c3de8c5383a6d8946914bf::dextrader_mmt {
    struct TransferOwnership has copy, drop {
        old_owner: address,
        new_owner: address,
    }

    struct SetOperator has copy, drop {
        old_operator: address,
        new_operator: address,
    }

    struct SetTokenHolder has copy, drop {
        old_token_holder: address,
        new_token_holder: address,
    }

    struct SetPoolWhitelist has copy, drop {
        pool: 0x2::object::ID,
        accepted: bool,
    }

    struct SetPoolTickLimits has copy, drop {
        pool: 0x2::object::ID,
        tick_lowest_idx: u32,
        tick_upperest_idx: u32,
    }

    struct SetPoolPriceLimits has copy, drop {
        pool: 0x2::object::ID,
        sqrt_price_limit_a2b: u128,
        sqrt_price_limit_b2a: u128,
    }

    struct CreatePosition has copy, drop {
        position_wrapper_id: 0x2::object::ID,
        position_id: 0x2::object::ID,
        pool: 0x2::object::ID,
        tick_lower_idx: u32,
        tick_upper_idx: u32,
        state_id: 0x2::object::ID,
    }

    struct ClosePosition has copy, drop {
        position_wrapper_id: 0x2::object::ID,
        position_id: 0x2::object::ID,
        pool: 0x2::object::ID,
        state_id: 0x2::object::ID,
    }

    struct State has key {
        id: 0x2::object::UID,
        version: u64,
        owner: address,
        operator: address,
        token_holder: address,
        pool_whitelist: 0x2::table::Table<0x2::object::ID, bool>,
        pool_tick_limits: 0x2::table::Table<0x2::object::ID, TickLimits>,
        pool_price_limits: 0x2::table::Table<0x2::object::ID, PriceLimits>,
        balances: 0x2::bag::Bag,
        position_mappings: 0x2::table::Table<0x2::object::ID, vector<0x2::object::ID>>,
    }

    struct PositionWrapper has store, key {
        id: 0x2::object::UID,
        pool_id: 0x2::object::ID,
        position: 0x70285592c97965e811e0c6f98dccc3a9c2b4ad854b3594faab9597ada267b860::position::Position,
        tick_lower_idx: u32,
        tick_upper_idx: u32,
        created_at: u64,
        state_id: 0x2::object::ID,
    }

    struct TickLimits has drop, store {
        tick_lowest_idx: u32,
        tick_upperest_idx: u32,
    }

    struct PriceLimits has drop, store {
        sqrt_price_limit_a2b: u128,
        sqrt_price_limit_b2a: u128,
    }

    entry fun swap<T0, T1>(arg0: &mut State, arg1: &mut 0x70285592c97965e811e0c6f98dccc3a9c2b4ad854b3594faab9597ada267b860::pool::Pool<T0, T1>, arg2: bool, arg3: bool, arg4: u64, arg5: u128, arg6: &0x2::clock::Clock, arg7: &0x70285592c97965e811e0c6f98dccc3a9c2b4ad854b3594faab9597ada267b860::version::Version, arg8: &0x2::tx_context::TxContext) {
        check_version(arg0);
        check_operator(arg0, arg8);
        check_pool_prices(arg0, check_pool_id<T0, T1>(arg0, arg1), arg2, arg5);
        let (v0, v1, v2) = 0x70285592c97965e811e0c6f98dccc3a9c2b4ad854b3594faab9597ada267b860::trade::flash_swap<T0, T1>(arg1, arg2, arg3, arg4, arg5, arg6, arg7, arg8);
        let v3 = v2;
        let v4 = &mut arg0.balances;
        0x2::balance::join<T0>(get_balance_mut<T0>(v4), v0);
        let v5 = &mut arg0.balances;
        0x2::balance::join<T1>(get_balance_mut<T1>(v5), v1);
        let (v6, v7) = 0x70285592c97965e811e0c6f98dccc3a9c2b4ad854b3594faab9597ada267b860::trade::swap_receipt_debts(&v3);
        let v8 = &mut arg0.balances;
        let v9 = 0x2::balance::split<T0>(get_balance_mut<T0>(v8), v6);
        let v10 = &mut arg0.balances;
        0x70285592c97965e811e0c6f98dccc3a9c2b4ad854b3594faab9597ada267b860::trade::repay_flash_swap<T0, T1>(arg1, v3, v9, 0x2::balance::split<T1>(get_balance_mut<T1>(v10), v7), arg7, arg8);
    }

    entry fun add_liquidity<T0, T1>(arg0: &mut State, arg1: &mut 0x70285592c97965e811e0c6f98dccc3a9c2b4ad854b3594faab9597ada267b860::pool::Pool<T0, T1>, arg2: u64, arg3: u64, arg4: u64, arg5: u64, arg6: &mut PositionWrapper, arg7: &0x70285592c97965e811e0c6f98dccc3a9c2b4ad854b3594faab9597ada267b860::version::Version, arg8: &0x2::clock::Clock, arg9: &mut 0x2::tx_context::TxContext) {
        check_version(arg0);
        check_operator(arg0, arg9);
        assert!(arg6.state_id == 0x2::object::id<State>(arg0), 111);
        assert!(arg6.pool_id == check_pool_id<T0, T1>(arg0, arg1), 111);
        let v0 = &mut arg0.balances;
        let v1 = 0x2::coin::take<T0>(get_balance_mut<T0>(v0), arg2, arg9);
        let v2 = &mut arg0.balances;
        let (v3, v4) = 0x70285592c97965e811e0c6f98dccc3a9c2b4ad854b3594faab9597ada267b860::liquidity::add_liquidity<T0, T1>(arg1, &mut arg6.position, v1, 0x2::coin::take<T1>(get_balance_mut<T1>(v2), arg3, arg9), arg4, arg5, arg8, arg7, arg9);
        let v5 = &mut arg0.balances;
        0x2::coin::put<T0>(get_balance_mut<T0>(v5), v3);
        let v6 = &mut arg0.balances;
        0x2::coin::put<T1>(get_balance_mut<T1>(v6), v4);
    }

    entry fun close_position<T0, T1>(arg0: &mut State, arg1: &0x70285592c97965e811e0c6f98dccc3a9c2b4ad854b3594faab9597ada267b860::pool::Pool<T0, T1>, arg2: PositionWrapper, arg3: &0x70285592c97965e811e0c6f98dccc3a9c2b4ad854b3594faab9597ada267b860::version::Version, arg4: &0x2::tx_context::TxContext) {
        check_version(arg0);
        check_operator(arg0, arg4);
        let v0 = check_pool_id<T0, T1>(arg0, arg1);
        assert!(arg2.state_id == 0x2::object::id<State>(arg0), 111);
        assert!(arg2.pool_id == v0, 111);
        assert!(0x70285592c97965e811e0c6f98dccc3a9c2b4ad854b3594faab9597ada267b860::position::liquidity(&arg2.position) == 0, 105);
        let v1 = 0x2::object::id<PositionWrapper>(&arg2);
        let v2 = 0x2::table::borrow_mut<0x2::object::ID, vector<0x2::object::ID>>(&mut arg0.position_mappings, v0);
        let (v3, v4) = 0x1::vector::index_of<0x2::object::ID>(v2, &v1);
        if (v3) {
            0x1::vector::remove<0x2::object::ID>(v2, v4);
        };
        let v5 = ClosePosition{
            position_wrapper_id : v1,
            position_id         : 0x2::object::id<0x70285592c97965e811e0c6f98dccc3a9c2b4ad854b3594faab9597ada267b860::position::Position>(&arg2.position),
            pool                : v0,
            state_id            : 0x2::object::id<State>(arg0),
        };
        0x2::event::emit<ClosePosition>(v5);
        let PositionWrapper {
            id             : v6,
            pool_id        : _,
            position       : v8,
            tick_lower_idx : _,
            tick_upper_idx : _,
            created_at     : _,
            state_id       : _,
        } = arg2;
        0x2::object::delete(v6);
        0x70285592c97965e811e0c6f98dccc3a9c2b4ad854b3594faab9597ada267b860::liquidity::close_position(v8, arg3, arg4);
    }

    entry fun remove_liquidity<T0, T1>(arg0: &mut State, arg1: &mut 0x70285592c97965e811e0c6f98dccc3a9c2b4ad854b3594faab9597ada267b860::pool::Pool<T0, T1>, arg2: u128, arg3: u64, arg4: u64, arg5: &mut PositionWrapper, arg6: &0x70285592c97965e811e0c6f98dccc3a9c2b4ad854b3594faab9597ada267b860::version::Version, arg7: &0x2::clock::Clock, arg8: &mut 0x2::tx_context::TxContext) {
        check_version(arg0);
        check_operator(arg0, arg8);
        assert!(arg5.state_id == 0x2::object::id<State>(arg0), 111);
        assert!(arg5.pool_id == check_pool_id<T0, T1>(arg0, arg1), 111);
        let (v0, v1) = 0x70285592c97965e811e0c6f98dccc3a9c2b4ad854b3594faab9597ada267b860::liquidity::remove_liquidity<T0, T1>(arg1, &mut arg5.position, arg2, arg3, arg4, arg7, arg6, arg8);
        let v2 = v1;
        let v3 = v0;
        let (v4, v5) = 0x70285592c97965e811e0c6f98dccc3a9c2b4ad854b3594faab9597ada267b860::collect::fee<T0, T1>(arg1, &mut arg5.position, arg7, arg6, arg8);
        0x2::coin::join<T0>(&mut v3, v4);
        0x2::coin::join<T1>(&mut v2, v5);
        let v6 = &mut arg0.balances;
        0x2::coin::put<T0>(get_balance_mut<T0>(v6), v3);
        let v7 = &mut arg0.balances;
        0x2::coin::put<T1>(get_balance_mut<T1>(v7), v2);
    }

    public fun accept_payment<T0>(arg0: &mut State, arg1: 0x2::transfer::Receiving<0x2::coin::Coin<T0>>, arg2: &0x2::tx_context::TxContext) {
        check_version(arg0);
        check_operator(arg0, arg2);
        let v0 = 0x1::type_name::get<T0>();
        let v1 = 0x1::type_name::get_address(&v0);
        let v2 = 0x2::address::from_ascii_bytes(0x1::ascii::as_bytes(&v1));
        if (!0x2::bag::contains<address>(&arg0.balances, v2)) {
            0x2::bag::add<address, 0x2::balance::Balance<T0>>(&mut arg0.balances, v2, 0x2::balance::zero<T0>());
        };
        0x2::coin::put<T0>(0x2::bag::borrow_mut<address, 0x2::balance::Balance<T0>>(&mut arg0.balances, v2), 0x2::transfer::public_receive<0x2::coin::Coin<T0>>(&mut arg0.id, arg1));
    }

    fun check_operator(arg0: &State, arg1: &0x2::tx_context::TxContext) {
        assert!(0x2::tx_context::sender(arg1) == arg0.operator, 102);
    }

    fun check_owner(arg0: &State, arg1: &0x2::tx_context::TxContext) {
        assert!(0x2::tx_context::sender(arg1) == arg0.owner, 101);
    }

    fun check_pool_id<T0, T1>(arg0: &State, arg1: &0x70285592c97965e811e0c6f98dccc3a9c2b4ad854b3594faab9597ada267b860::pool::Pool<T0, T1>) : 0x2::object::ID {
        let v0 = 0x2::object::id<0x70285592c97965e811e0c6f98dccc3a9c2b4ad854b3594faab9597ada267b860::pool::Pool<T0, T1>>(arg1);
        assert!(0x2::table::contains<0x2::object::ID, bool>(&arg0.pool_whitelist, v0), 104);
        v0
    }

    fun check_pool_prices(arg0: &State, arg1: 0x2::object::ID, arg2: bool, arg3: u128) {
        assert!(0x2::table::contains<0x2::object::ID, PriceLimits>(&arg0.pool_price_limits, arg1), 108);
        if (arg2) {
            assert!(0x2::table::borrow<0x2::object::ID, PriceLimits>(&arg0.pool_price_limits, arg1).sqrt_price_limit_a2b <= arg3, 110);
        } else {
            assert!(0x2::table::borrow<0x2::object::ID, PriceLimits>(&arg0.pool_price_limits, arg1).sqrt_price_limit_b2a >= arg3, 110);
        };
    }

    fun check_pool_ticks(arg0: &State, arg1: 0x2::object::ID, arg2: u32, arg3: u32) {
        assert!(0x2::table::contains<0x2::object::ID, TickLimits>(&arg0.pool_tick_limits, arg1), 107);
        let v0 = 0x2::table::borrow<0x2::object::ID, TickLimits>(&arg0.pool_tick_limits, arg1);
        assert!(v0.tick_lowest_idx <= arg2 && v0.tick_upperest_idx >= arg3, 109);
    }

    fun check_version(arg0: &State) {
        assert!(arg0.version == 1, 100);
    }

    entry fun collect_fee<T0, T1>(arg0: &mut State, arg1: &mut 0x70285592c97965e811e0c6f98dccc3a9c2b4ad854b3594faab9597ada267b860::pool::Pool<T0, T1>, arg2: &mut PositionWrapper, arg3: &0x2::clock::Clock, arg4: &0x70285592c97965e811e0c6f98dccc3a9c2b4ad854b3594faab9597ada267b860::version::Version, arg5: &mut 0x2::tx_context::TxContext) {
        check_version(arg0);
        check_operator(arg0, arg5);
        assert!(arg2.state_id == 0x2::object::id<State>(arg0), 111);
        assert!(arg2.pool_id == check_pool_id<T0, T1>(arg0, arg1), 111);
        let (v0, v1) = 0x70285592c97965e811e0c6f98dccc3a9c2b4ad854b3594faab9597ada267b860::collect::fee<T0, T1>(arg1, &mut arg2.position, arg3, arg4, arg5);
        let v2 = &mut arg0.balances;
        0x2::coin::put<T0>(get_balance_mut<T0>(v2), v0);
        let v3 = &mut arg0.balances;
        0x2::coin::put<T1>(get_balance_mut<T1>(v3), v1);
    }

    entry fun collect_reward<T0, T1, T2>(arg0: &mut State, arg1: &0x2::clock::Clock, arg2: &mut 0x70285592c97965e811e0c6f98dccc3a9c2b4ad854b3594faab9597ada267b860::pool::Pool<T0, T1>, arg3: &mut PositionWrapper, arg4: &0x70285592c97965e811e0c6f98dccc3a9c2b4ad854b3594faab9597ada267b860::version::Version, arg5: &mut 0x2::tx_context::TxContext) {
        check_version(arg0);
        check_operator(arg0, arg5);
        assert!(arg3.state_id == 0x2::object::id<State>(arg0), 111);
        assert!(arg3.pool_id == check_pool_id<T0, T1>(arg0, arg2), 111);
        0x2::transfer::public_transfer<0x2::coin::Coin<T2>>(0x70285592c97965e811e0c6f98dccc3a9c2b4ad854b3594faab9597ada267b860::collect::reward<T0, T1, T2>(arg2, &mut arg3.position, arg1, arg4, arg5), arg0.token_holder);
    }

    entry fun create_position<T0, T1>(arg0: &mut State, arg1: &mut 0x70285592c97965e811e0c6f98dccc3a9c2b4ad854b3594faab9597ada267b860::pool::Pool<T0, T1>, arg2: u32, arg3: u32, arg4: &0x70285592c97965e811e0c6f98dccc3a9c2b4ad854b3594faab9597ada267b860::version::Version, arg5: &mut 0x2::tx_context::TxContext) {
        check_version(arg0);
        check_operator(arg0, arg5);
        let v0 = check_pool_id<T0, T1>(arg0, arg1);
        check_pool_ticks(arg0, v0, arg2, arg3);
        let v1 = 0x70285592c97965e811e0c6f98dccc3a9c2b4ad854b3594faab9597ada267b860::liquidity::open_position<T0, T1>(arg1, 0x70285592c97965e811e0c6f98dccc3a9c2b4ad854b3594faab9597ada267b860::i32::from_u32(arg2), 0x70285592c97965e811e0c6f98dccc3a9c2b4ad854b3594faab9597ada267b860::i32::from_u32(arg3), arg4, arg5);
        let v2 = 0x2::object::id<State>(arg0);
        let v3 = PositionWrapper{
            id             : 0x2::object::new(arg5),
            pool_id        : v0,
            position       : v1,
            tick_lower_idx : arg2,
            tick_upper_idx : arg3,
            created_at     : 0x2::tx_context::epoch(arg5),
            state_id       : v2,
        };
        let v4 = 0x2::object::id<PositionWrapper>(&v3);
        if (!0x2::table::contains<0x2::object::ID, vector<0x2::object::ID>>(&arg0.position_mappings, v0)) {
            0x2::table::add<0x2::object::ID, vector<0x2::object::ID>>(&mut arg0.position_mappings, v0, 0x1::vector::empty<0x2::object::ID>());
        };
        0x1::vector::push_back<0x2::object::ID>(0x2::table::borrow_mut<0x2::object::ID, vector<0x2::object::ID>>(&mut arg0.position_mappings, v0), v4);
        let v5 = CreatePosition{
            position_wrapper_id : v4,
            position_id         : 0x2::object::id<0x70285592c97965e811e0c6f98dccc3a9c2b4ad854b3594faab9597ada267b860::position::Position>(&v1),
            pool                : v0,
            tick_lower_idx      : arg2,
            tick_upper_idx      : arg3,
            state_id            : v2,
        };
        0x2::event::emit<CreatePosition>(v5);
        0x2::transfer::transfer<PositionWrapper>(v3, 0x2::object::id_to_address(&v2));
    }

    entry fun deposit<T0>(arg0: &mut State, arg1: 0x2::coin::Coin<T0>, arg2: &0x2::tx_context::TxContext) {
        check_version(arg0);
        check_operator(arg0, arg2);
        let v0 = 0x1::type_name::get<T0>();
        let v1 = 0x1::type_name::get_address(&v0);
        let v2 = 0x2::address::from_ascii_bytes(0x1::ascii::as_bytes(&v1));
        if (!0x2::bag::contains<address>(&arg0.balances, v2)) {
            0x2::bag::add<address, 0x2::balance::Balance<T0>>(&mut arg0.balances, v2, 0x2::balance::zero<T0>());
        };
        0x2::coin::put<T0>(0x2::bag::borrow_mut<address, 0x2::balance::Balance<T0>>(&mut arg0.balances, v2), arg1);
    }

    public fun get_all_pool_ids(arg0: &State) : vector<0x2::object::ID> {
        0x1::vector::empty<0x2::object::ID>()
    }

    fun get_balance_mut<T0>(arg0: &mut 0x2::bag::Bag) : &mut 0x2::balance::Balance<T0> {
        let v0 = 0x1::type_name::get<T0>();
        let v1 = 0x1::type_name::get_address(&v0);
        let v2 = 0x2::address::from_ascii_bytes(0x1::ascii::as_bytes(&v1));
        assert!(0x2::bag::contains<address>(arg0, v2), 106);
        0x2::bag::borrow_mut<address, 0x2::balance::Balance<T0>>(arg0, v2)
    }

    public fun get_position_count_by_pool(arg0: &State, arg1: 0x2::object::ID) : u64 {
        if (!0x2::table::contains<0x2::object::ID, vector<0x2::object::ID>>(&arg0.position_mappings, arg1)) {
            return 0
        };
        0x1::vector::length<0x2::object::ID>(0x2::table::borrow<0x2::object::ID, vector<0x2::object::ID>>(&arg0.position_mappings, arg1))
    }

    public fun get_position_ids_by_pool(arg0: &State, arg1: 0x2::object::ID) : vector<0x2::object::ID> {
        if (!0x2::table::contains<0x2::object::ID, vector<0x2::object::ID>>(&arg0.position_mappings, arg1)) {
            return 0x1::vector::empty<0x2::object::ID>()
        };
        *0x2::table::borrow<0x2::object::ID, vector<0x2::object::ID>>(&arg0.position_mappings, arg1)
    }

    public fun get_position_info(arg0: &PositionWrapper) : (0x2::object::ID, u32, u32, u64, 0x2::object::ID) {
        (arg0.pool_id, arg0.tick_lower_idx, arg0.tick_upper_idx, arg0.created_at, arg0.state_id)
    }

    fun init(arg0: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg0);
        let v1 = State{
            id                : 0x2::object::new(arg0),
            version           : 1,
            owner             : v0,
            operator          : v0,
            token_holder      : v0,
            pool_whitelist    : 0x2::table::new<0x2::object::ID, bool>(arg0),
            pool_tick_limits  : 0x2::table::new<0x2::object::ID, TickLimits>(arg0),
            pool_price_limits : 0x2::table::new<0x2::object::ID, PriceLimits>(arg0),
            balances          : 0x2::bag::new(arg0),
            position_mappings : 0x2::table::new<0x2::object::ID, vector<0x2::object::ID>>(arg0),
        };
        0x2::transfer::share_object<State>(v1);
    }

    entry fun migrate(arg0: &mut State, arg1: &0x2::tx_context::TxContext) {
        check_owner(arg0, arg1);
        assert!(arg0.version < 1, 100);
        arg0.version = 1;
    }

    public fun package_address(arg0: &State) : address {
        let v0 = 0x1::type_name::get_with_original_ids<State>();
        let v1 = 0x1::type_name::get_address(&v0);
        0x2::address::from_ascii_bytes(0x1::ascii::as_bytes(&v1))
    }

    entry fun set_operator(arg0: &mut State, arg1: address, arg2: &0x2::tx_context::TxContext) {
        check_version(arg0);
        check_owner(arg0, arg2);
        arg0.operator = arg1;
        let v0 = SetOperator{
            old_operator : arg0.operator,
            new_operator : arg1,
        };
        0x2::event::emit<SetOperator>(v0);
    }

    entry fun set_pool_price_limits(arg0: &mut State, arg1: 0x2::object::ID, arg2: u128, arg3: u128, arg4: &0x2::tx_context::TxContext) {
        check_version(arg0);
        check_owner(arg0, arg4);
        if (0x2::table::contains<0x2::object::ID, PriceLimits>(&arg0.pool_price_limits, arg1)) {
            0x2::table::remove<0x2::object::ID, PriceLimits>(&mut arg0.pool_price_limits, arg1);
        };
        let v0 = PriceLimits{
            sqrt_price_limit_a2b : arg2,
            sqrt_price_limit_b2a : arg3,
        };
        0x2::table::add<0x2::object::ID, PriceLimits>(&mut arg0.pool_price_limits, arg1, v0);
        let v1 = SetPoolPriceLimits{
            pool                 : arg1,
            sqrt_price_limit_a2b : arg2,
            sqrt_price_limit_b2a : arg3,
        };
        0x2::event::emit<SetPoolPriceLimits>(v1);
    }

    entry fun set_pool_tick_limits(arg0: &mut State, arg1: 0x2::object::ID, arg2: u32, arg3: u32, arg4: &0x2::tx_context::TxContext) {
        check_version(arg0);
        check_owner(arg0, arg4);
        if (0x2::table::contains<0x2::object::ID, TickLimits>(&arg0.pool_tick_limits, arg1)) {
            0x2::table::remove<0x2::object::ID, TickLimits>(&mut arg0.pool_tick_limits, arg1);
        };
        let v0 = TickLimits{
            tick_lowest_idx   : arg2,
            tick_upperest_idx : arg3,
        };
        0x2::table::add<0x2::object::ID, TickLimits>(&mut arg0.pool_tick_limits, arg1, v0);
        let v1 = SetPoolTickLimits{
            pool              : arg1,
            tick_lowest_idx   : arg2,
            tick_upperest_idx : arg3,
        };
        0x2::event::emit<SetPoolTickLimits>(v1);
    }

    entry fun set_pool_whitelist(arg0: &mut State, arg1: 0x2::object::ID, arg2: bool, arg3: &0x2::tx_context::TxContext) {
        check_version(arg0);
        check_owner(arg0, arg3);
        if (0x2::table::contains<0x2::object::ID, bool>(&arg0.pool_whitelist, arg1)) {
            if (!arg2) {
                0x2::table::remove<0x2::object::ID, bool>(&mut arg0.pool_whitelist, arg1);
            };
        } else if (arg2) {
            0x2::table::add<0x2::object::ID, bool>(&mut arg0.pool_whitelist, arg1, true);
        };
        let v0 = SetPoolWhitelist{
            pool     : arg1,
            accepted : arg2,
        };
        0x2::event::emit<SetPoolWhitelist>(v0);
    }

    entry fun set_token_holder(arg0: &mut State, arg1: address, arg2: &0x2::tx_context::TxContext) {
        check_version(arg0);
        check_owner(arg0, arg2);
        arg0.token_holder = arg1;
        let v0 = SetTokenHolder{
            old_token_holder : arg0.token_holder,
            new_token_holder : arg1,
        };
        0x2::event::emit<SetTokenHolder>(v0);
    }

    entry fun transfer_ownership(arg0: &mut State, arg1: address, arg2: 0x2::package::UpgradeCap, arg3: &0x2::tx_context::TxContext) {
        check_version(arg0);
        check_owner(arg0, arg3);
        let v0 = 0x2::package::upgrade_package(&arg2);
        assert!(0x2::object::id_to_address(&v0) == package_address(arg0), 103);
        0x2::transfer::public_transfer<0x2::package::UpgradeCap>(arg2, arg1);
        arg0.owner = arg1;
        let v1 = TransferOwnership{
            old_owner : arg0.owner,
            new_owner : arg1,
        };
        0x2::event::emit<TransferOwnership>(v1);
    }

    entry fun withdraw<T0>(arg0: &mut State, arg1: u64, arg2: &mut 0x2::tx_context::TxContext) {
        check_version(arg0);
        check_operator(arg0, arg2);
        let v0 = &mut arg0.balances;
        0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(0x2::coin::take<T0>(get_balance_mut<T0>(v0), arg1, arg2), arg0.token_holder);
    }

    // decompiled from Move bytecode v6
}

