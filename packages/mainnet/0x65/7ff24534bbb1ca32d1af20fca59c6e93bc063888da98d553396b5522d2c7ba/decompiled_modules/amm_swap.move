module 0x657ff24534bbb1ca32d1af20fca59c6e93bc063888da98d553396b5522d2c7ba::amm_swap {
    struct Registry has key {
        id: 0x2::object::UID,
        pools: 0x2::table::Table<0x1::type_name::TypeName, address>,
    }

    struct Pool has key {
        id: 0x2::object::UID,
    }

    struct Deployer has store, key {
        id: 0x2::object::UID,
        pool: address,
    }

    struct Provider has copy, drop, store {
        lp: u64,
        euler0: u64,
    }

    struct Metadata has key {
        id: 0x2::object::UID,
        description: 0x1::string::String,
        image: 0x1::string::String,
        chat: 0x1::string::String,
        website: 0x1::string::String,
        social: 0x1::string::String,
    }

    struct RegistryKey<phantom T0, phantom T1> has drop {
        dummy_field: bool,
    }

    struct PoolStateKey has copy, drop, store {
        dummy_field: bool,
    }

    struct AdminCap has key {
        id: 0x2::object::UID,
    }

    struct PoolState<phantom T0, phantom T1> has store {
        coin_a: 0x2::balance::Balance<T0>,
        coin_b: 0x2::balance::Balance<T1>,
        coin_a_admin: 0x2::balance::Balance<T0>,
        coin_b_admin: 0x2::balance::Balance<T1>,
        reward_all_time: u64,
        lp_locked: u64,
        lp_supply: u64,
        trade_fee_buy: u64,
        trade_fee_sell: u64,
        protocol_fee_buy: u64,
        protocol_fee_sell: u64,
        protocol_address: address,
        created_at: u64,
        last_euler: u64,
        euler_mapping: 0x2::table::Table<address, Provider>,
        lp_mapping: 0x2::table::Table<address, u64>,
        metadata: 0x2::object::ID,
    }

    struct InitEvent has copy, drop {
        sender: address,
        global_paulse_status_id: 0x2::object::ID,
    }

    struct InitPoolEvent has copy, drop {
        sender: address,
        pool_id: 0x2::object::ID,
        deployer: 0x2::object::ID,
        trade_fee_buy: u64,
        trade_fee_sell: u64,
        protocol_fee_buy: u64,
        protocol_fee_sell: u64,
        created_at: u64,
    }

    struct DEBUGEVENT has copy, drop {
        name: 0x1::ascii::String,
        module_name: 0x1::ascii::String,
        address: 0x1::ascii::String,
    }

    struct LiquidityEvent has copy, drop {
        sender: address,
        pool_id: 0x2::object::ID,
        is_add_liquidity: bool,
        liquidity: u64,
        amount_a: u64,
        amount_b: u64,
    }

    struct ReserveEvent has copy, drop {
        pool_id: 0x2::object::ID,
        amount_a: u64,
        amount_b: u64,
    }

    struct SwapEvent has copy, drop {
        sender: address,
        pool_id: 0x2::object::ID,
        amount_a_in: u64,
        amount_a_out: u64,
        amount_b_in: u64,
        amount_b_out: u64,
    }

    struct SetFeeEvent has copy, drop {
        sender: address,
        pool_id: 0x2::object::ID,
        trade_fee_buy: u64,
        trade_fee_sell: u64,
        protocol_fee_buy: u64,
        protocol_fee_sell: u64,
    }

    struct ClaimFeeEvent has copy, drop {
        sender: address,
        pool_id: 0x2::object::ID,
        reward: u64,
    }

    struct MetadataUpdated has copy, drop {
        id: 0x2::object::ID,
        description: 0x1::string::String,
        image: 0x1::string::String,
        chat: 0x1::string::String,
        website: 0x1::string::String,
        social: 0x1::string::String,
    }

    struct FlashSwapReceipt<phantom T0, phantom T1> {
        pool_id: 0x2::object::ID,
        a2b: bool,
        pay_amount: u64,
    }

    fun swap<T0, T1>(arg0: &mut Pool, arg1: 0x2::balance::Balance<T0>, arg2: u64, arg3: 0x2::balance::Balance<T1>, arg4: u64) : (0x2::balance::Balance<T0>, 0x2::balance::Balance<T1>, 0x2::balance::Balance<T0>, 0x2::balance::Balance<T1>) {
        assert!(0x2::balance::value<T0>(&arg1) > 0 || 0x2::balance::value<T1>(&arg3) > 0, 0);
        let v0 = pool_state_mut<T0, T1>(arg0);
        let (v1, v2) = get_reserves_pool<T0, T1>(v0);
        0x2::balance::join<T0>(&mut v0.coin_a, arg1);
        0x2::balance::join<T1>(&mut v0.coin_b, arg3);
        assert_lp_value_incr(v1, v2, 0x2::balance::value<T0>(&v0.coin_a), 0x2::balance::value<T1>(&v0.coin_b));
        (0x2::balance::split<T0>(&mut v0.coin_a, arg4), 0x2::balance::split<T1>(&mut v0.coin_b, arg2), 0x2::balance::zero<T0>(), 0x2::balance::zero<T1>())
    }

    fun assert_lp_value_incr(arg0: u64, arg1: u64, arg2: u64, arg3: u64) {
        assert!(0x657ff24534bbb1ca32d1af20fca59c6e93bc063888da98d553396b5522d2c7ba::amm_math::safe_compare_mul_u64(arg2, arg3, arg0, arg1), 1);
    }

    fun burn<T0, T1>(arg0: &mut Pool, arg1: u64, arg2: &0x2::clock::Clock, arg3: &mut 0x2::tx_context::TxContext) : (0x2::coin::Coin<T0>, 0x2::coin::Coin<T1>) {
        let v0 = pool_state_mut<T0, T1>(arg0);
        assert!(0x2::clock::timestamp_ms(arg2) - v0.created_at >= 432000000 || 0x2::tx_context::sender(arg3) == @0x8b368f11e378b38e3be43123ebde77bbd7b38b8deb756bc519f63295e84c9fd2, 7077);
        let v1 = 0x2::tx_context::sender(arg3);
        let v2 = &mut v0.lp_mapping;
        decrease_lp_balance_table(v2, v1, arg1);
        let (v3, v4) = get_reserves_pool<T0, T1>(v0);
        let v5 = v0.lp_supply;
        let v6 = 0x657ff24534bbb1ca32d1af20fca59c6e93bc063888da98d553396b5522d2c7ba::amm_math::safe_mul_div_u64(arg1, v3, v5);
        let v7 = 0x657ff24534bbb1ca32d1af20fca59c6e93bc063888da98d553396b5522d2c7ba::amm_math::safe_mul_div_u64(arg1, v4, v5);
        assert!(v6 > 0 && v7 > 0, 3);
        v0.lp_supply = v5 - arg1;
        update_provider_pool<T0, T1>(v0, v1);
        emit_pool_reserve<T0, T1>(arg0);
        (0x2::coin::from_balance<T0>(0x2::balance::split<T0>(&mut v0.coin_a, v6), arg3), 0x2::coin::from_balance<T1>(0x2::balance::split<T1>(&mut v0.coin_b, v7), arg3))
    }

    public(friend) fun burn_and_emit_event<T0, T1>(arg0: &mut Pool, arg1: u64, arg2: &0x2::clock::Clock, arg3: &mut 0x2::tx_context::TxContext) : (0x2::coin::Coin<T0>, 0x2::coin::Coin<T1>) {
        assert!(lp_balance<T0, T1>(arg0, 0x2::tx_context::sender(arg3)) >= arg1, 3010);
        let (v0, v1) = burn<T0, T1>(arg0, arg1, arg2, arg3);
        let v2 = v1;
        let v3 = v0;
        let v4 = LiquidityEvent{
            sender           : 0x2::tx_context::sender(arg3),
            pool_id          : 0x2::object::id<Pool>(arg0),
            is_add_liquidity : false,
            liquidity        : arg1,
            amount_a         : 0x2::coin::value<T0>(&v3),
            amount_b         : 0x2::coin::value<T1>(&v2),
        };
        0x2::event::emit<LiquidityEvent>(v4);
        (v3, v2)
    }

    public fun claim_reward<T0, T1>(arg0: &mut Pool, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = pool_state_mut<T0, T1>(arg0);
        assert!(v0.last_euler > 0, 4001);
        let v1 = 0x2::tx_context::sender(arg1);
        let v2 = getProvider<T0, T1>(v0, v1);
        let v3 = 0x657ff24534bbb1ca32d1af20fca59c6e93bc063888da98d553396b5522d2c7ba::amm_math::safe_mul_div_u64(v2.lp, v0.last_euler - v2.euler0, 100000000000);
        assert!(v3 > 0, 4002);
        update_provider_pool<T0, T1>(v0, v1);
        if (is_sui_coin<T0>()) {
            0x2::pay::keep<T0>(0x2::coin::from_balance<T0>(0x2::balance::split<T0>(&mut v0.coin_a_admin, v3), arg1), arg1);
        } else {
            0x2::pay::keep<T1>(0x2::coin::from_balance<T1>(0x2::balance::split<T1>(&mut v0.coin_b_admin, v3), arg1), arg1);
        };
        let v4 = ClaimFeeEvent{
            sender  : 0x2::tx_context::sender(arg1),
            pool_id : 0x2::object::id<Pool>(arg0),
            reward  : v3,
        };
        0x2::event::emit<ClaimFeeEvent>(v4);
    }

    fun decrease_lp_balance_table(arg0: &mut 0x2::table::Table<address, u64>, arg1: address, arg2: u64) : u64 {
        assert!(0x2::table::contains<address, u64>(arg0, arg1), 3030);
        let v0 = *0x2::table::borrow<address, u64>(arg0, arg1);
        assert!(v0 >= arg2, 3020);
        0x2::table::remove<address, u64>(arg0, arg1);
        0x2::table::add<address, u64>(arg0, arg1, v0 - arg2);
        arg2
    }

    public(friend) fun emit_pool_reserve<T0, T1>(arg0: &Pool) {
        let v0 = pool_state<T0, T1>(arg0);
        let v1 = ReserveEvent{
            pool_id  : 0x2::object::id<Pool>(arg0),
            amount_a : 0x2::balance::value<T0>(&v0.coin_a),
            amount_b : 0x2::balance::value<T1>(&v0.coin_b),
        };
        0x2::event::emit<ReserveEvent>(v1);
    }

    public(friend) fun emit_swap_event<T0, T1>(arg0: &mut Pool, arg1: u64, arg2: u64, arg3: bool, arg4: &mut 0x2::tx_context::TxContext) {
        if (arg3) {
            let v0 = SwapEvent{
                sender       : 0x2::tx_context::sender(arg4),
                pool_id      : 0x2::object::id<Pool>(arg0),
                amount_a_in  : arg1,
                amount_a_out : 0,
                amount_b_in  : 0,
                amount_b_out : arg2,
            };
            0x2::event::emit<SwapEvent>(v0);
        } else {
            let v1 = SwapEvent{
                sender       : 0x2::tx_context::sender(arg4),
                pool_id      : 0x2::object::id<Pool>(arg0),
                amount_a_in  : 0,
                amount_a_out : arg2,
                amount_b_in  : arg1,
                amount_b_out : 0,
            };
            0x2::event::emit<SwapEvent>(v1);
        };
    }

    public(friend) fun fetch_add_fee_trade<T0, T1>(arg0: &mut Pool, arg1: 0x2::balance::Balance<T0>, arg2: 0x2::balance::Balance<T1>, arg3: bool) : address {
        let v0 = pool_state_mut<T0, T1>(arg0);
        if (arg3) {
            update_euler<T0, T1>(v0, 0x2::balance::value<T0>(&arg1));
            0x2::balance::join<T0>(&mut v0.coin_a_admin, arg1);
            0x2::balance::destroy_zero<T1>(arg2);
        } else {
            update_euler<T0, T1>(v0, 0x2::balance::value<T1>(&arg2));
            0x2::balance::join<T1>(&mut v0.coin_b_admin, arg2);
            0x2::balance::destroy_zero<T0>(arg1);
        };
        v0.protocol_address
    }

    public(friend) fun flash_swap<T0, T1>(arg0: &mut Pool, arg1: u64, arg2: u64, arg3: bool) : (0x2::balance::Balance<T0>, 0x2::balance::Balance<T1>, FlashSwapReceipt<T0, T1>) {
        assert!(arg1 > 0, 0);
        let v0 = pool_state_mut<T0, T1>(arg0);
        let (v1, v2) = get_reserves_pool<T0, T1>(v0);
        let v3 = 0x2::balance::zero<T0>();
        let v4 = 0x2::balance::zero<T1>();
        if (arg3) {
            0x2::balance::join<T1>(&mut v4, 0x2::balance::split<T1>(&mut v0.coin_b, arg2));
            assert_lp_value_incr(v1, v2, v1 + arg1, v2 - arg2);
        } else {
            0x2::balance::join<T0>(&mut v3, 0x2::balance::split<T0>(&mut v0.coin_a, arg2));
            assert_lp_value_incr(v1, v2, v1 - arg2, v2 + arg1);
        };
        let v5 = FlashSwapReceipt<T0, T1>{
            pool_id    : 0x2::object::id<Pool>(arg0),
            a2b        : arg3,
            pay_amount : arg1,
        };
        (v3, v4, v5)
    }

    public(friend) fun flash_swap_wave<T0, T1>(arg0: &mut Pool, arg1: u64, arg2: u64, arg3: bool) : (0x2::balance::Balance<T0>, 0x2::balance::Balance<T1>, FlashSwapReceipt<T0, T1>) {
        flash_swap<T0, T1>(arg0, arg1, arg2, arg3)
    }

    fun getProvider<T0, T1>(arg0: &PoolState<T0, T1>, arg1: address) : Provider {
        *0x2::table::borrow<address, Provider>(&arg0.euler_mapping, arg1)
    }

    public fun get_buy_fees_in<T0, T1>(arg0: &Pool, arg1: u64) : (u64, u64, u64, u64) {
        let v0 = pool_state<T0, T1>(arg0);
        let v1 = 0x657ff24534bbb1ca32d1af20fca59c6e93bc063888da98d553396b5522d2c7ba::amm_math::safe_mul_div_u64(arg1, 10, 10000);
        let v2 = 0x657ff24534bbb1ca32d1af20fca59c6e93bc063888da98d553396b5522d2c7ba::amm_math::safe_mul_div_u64(arg1, v0.protocol_fee_buy, 10000);
        let v3 = 0x657ff24534bbb1ca32d1af20fca59c6e93bc063888da98d553396b5522d2c7ba::amm_math::safe_mul_div_u64(arg1, v0.trade_fee_buy, 10000);
        (v1, v2, v3, arg1 - v1 - v2 - v3)
    }

    public fun get_buy_fees_out<T0, T1>(arg0: &Pool, arg1: u64) : (u64, u64, u64, u64) {
        let v0 = pool_state<T0, T1>(arg0);
        let v1 = 0x657ff24534bbb1ca32d1af20fca59c6e93bc063888da98d553396b5522d2c7ba::amm_math::safe_mul_div_u64(arg1, 10000, 10000 - 10 + v0.protocol_fee_buy + v0.trade_fee_buy);
        (0x657ff24534bbb1ca32d1af20fca59c6e93bc063888da98d553396b5522d2c7ba::amm_math::safe_mul_div_u64(v1, 10, 10000), 0x657ff24534bbb1ca32d1af20fca59c6e93bc063888da98d553396b5522d2c7ba::amm_math::safe_mul_div_u64(v1, v0.protocol_fee_buy, 10000), 0x657ff24534bbb1ca32d1af20fca59c6e93bc063888da98d553396b5522d2c7ba::amm_math::safe_mul_div_u64(v1, v0.trade_fee_buy, 10000), v1)
    }

    public fun get_claimable_reward<T0, T1>(arg0: &Pool, arg1: address) : u64 {
        let v0 = pool_state<T0, T1>(arg0);
        if (v0.last_euler == 0) {
            0
        } else {
            let v2 = getProvider<T0, T1>(v0, arg1);
            0x657ff24534bbb1ca32d1af20fca59c6e93bc063888da98d553396b5522d2c7ba::amm_math::safe_mul_div_u64(v2.lp, v0.last_euler - v2.euler0, 100000000000)
        }
    }

    public fun get_pool_detail<T0, T1>(arg0: &Pool) : &PoolState<T0, T1> {
        pool_state<T0, T1>(arg0)
    }

    public fun get_reserves<T0, T1>(arg0: &Pool) : (u64, u64) {
        let v0 = pool_state<T0, T1>(arg0);
        (0x2::balance::value<T0>(&v0.coin_a), 0x2::balance::value<T1>(&v0.coin_b))
    }

    public fun get_reserves_pool<T0, T1>(arg0: &PoolState<T0, T1>) : (u64, u64) {
        (0x2::balance::value<T0>(&arg0.coin_a), 0x2::balance::value<T1>(&arg0.coin_b))
    }

    public fun get_sell_fees_in<T0, T1>(arg0: &Pool, arg1: u64) : (u64, u64, u64, u64) {
        let v0 = pool_state<T0, T1>(arg0);
        let v1 = 0x657ff24534bbb1ca32d1af20fca59c6e93bc063888da98d553396b5522d2c7ba::amm_math::safe_mul_div_u64(arg1, 10, 10000);
        let v2 = 0x657ff24534bbb1ca32d1af20fca59c6e93bc063888da98d553396b5522d2c7ba::amm_math::safe_mul_div_u64(arg1, v0.protocol_fee_sell, 10000);
        let v3 = 0x657ff24534bbb1ca32d1af20fca59c6e93bc063888da98d553396b5522d2c7ba::amm_math::safe_mul_div_u64(arg1, v0.trade_fee_sell, 10000);
        (v1, v2, v3, arg1 - v1 - v2 - v3)
    }

    public fun get_sell_fees_out<T0, T1>(arg0: &Pool, arg1: u64) : (u64, u64, u64, u64) {
        let v0 = pool_state<T0, T1>(arg0);
        let v1 = 0x657ff24534bbb1ca32d1af20fca59c6e93bc063888da98d553396b5522d2c7ba::amm_math::safe_mul_div_u64(arg1, 10000, 10000 - 10 + v0.protocol_fee_sell + v0.trade_fee_sell);
        (0x657ff24534bbb1ca32d1af20fca59c6e93bc063888da98d553396b5522d2c7ba::amm_math::safe_mul_div_u64(v1, 10, 10000), 0x657ff24534bbb1ca32d1af20fca59c6e93bc063888da98d553396b5522d2c7ba::amm_math::safe_mul_div_u64(v1, v0.protocol_fee_sell, 10000), 0x657ff24534bbb1ca32d1af20fca59c6e93bc063888da98d553396b5522d2c7ba::amm_math::safe_mul_div_u64(v1, v0.trade_fee_sell, 10000), v1)
    }

    public(friend) fun handle_swap_protocol_fee<T0, T1>(arg0: &mut Pool, arg1: 0x2::balance::Balance<T0>, arg2: 0x2::balance::Balance<T1>) {
        let v0 = pool_state_mut<T0, T1>(arg0);
        0x2::balance::join<T0>(&mut v0.coin_a_admin, arg1);
        0x2::balance::join<T1>(&mut v0.coin_b_admin, arg2);
    }

    public(friend) fun increase_lp_balance<T0, T1>(arg0: &mut Pool, arg1: address, arg2: u64) : u64 {
        let v0 = pool_state_mut<T0, T1>(arg0);
        if (0x2::table::contains<address, u64>(&v0.lp_mapping, arg1)) {
            0x2::table::remove<address, u64>(&mut v0.lp_mapping, arg1);
            0x2::table::add<address, u64>(&mut v0.lp_mapping, arg1, arg2 + *0x2::table::borrow<address, u64>(&v0.lp_mapping, arg1));
        } else {
            0x2::table::add<address, u64>(&mut v0.lp_mapping, arg1, arg2);
        };
        update_provider_pool<T0, T1>(v0, arg1);
        arg2
    }

    fun init(arg0: &mut 0x2::tx_context::TxContext) {
        let v0 = AdminCap{id: 0x2::object::new(arg0)};
        0x2::transfer::transfer<AdminCap>(v0, 0x2::tx_context::sender(arg0));
        let v1 = Registry{
            id    : 0x2::object::new(arg0),
            pools : 0x2::table::new<0x1::type_name::TypeName, address>(arg0),
        };
        0x2::transfer::share_object<Registry>(v1);
        let v2 = InitEvent{
            sender                  : 0x2::tx_context::sender(arg0),
            global_paulse_status_id : 0x657ff24534bbb1ca32d1af20fca59c6e93bc063888da98d553396b5522d2c7ba::amm_config::new_global_pause_status_and_shared(arg0),
        };
        0x2::event::emit<InitEvent>(v2);
    }

    public(friend) fun init_pool<T0, T1>(arg0: &mut Registry, arg1: u64, arg2: u64, arg3: u64, arg4: u64, arg5: address, arg6: &0x2::clock::Clock, arg7: &mut 0x2::tx_context::TxContext) {
        assert!(is_sui_coin<T0>() || is_sui_coin<T1>(), 7100);
        let v0 = 0x1::type_name::get<RegistryKey<T0, T1>>();
        assert!(!0x2::table::contains<0x1::type_name::TypeName, address>(&arg0.pools, v0), 7000);
        let v1 = Metadata{
            id          : 0x2::object::new(arg7),
            description : 0x1::string::utf8(b""),
            image       : 0x1::string::utf8(b""),
            chat        : 0x1::string::utf8(b""),
            website     : 0x1::string::utf8(b""),
            social      : 0x1::string::utf8(b""),
        };
        let v2 = make_pool<T0, T1>(arg1, arg2, arg3, arg4, arg5, 0x2::clock::timestamp_ms(arg6), 0x2::object::id<Metadata>(&v1), arg7);
        let v3 = Pool{id: 0x2::object::new(arg7)};
        let v4 = 0x2::object::uid_to_address(&v3.id);
        let v5 = PoolStateKey{dummy_field: false};
        0x2::dynamic_field::add<PoolStateKey, PoolState<T0, T1>>(&mut v3.id, v5, v2);
        0x2::table::add<0x1::type_name::TypeName, address>(&mut arg0.pools, v0, v4);
        let v6 = Deployer{
            id   : 0x2::object::new(arg7),
            pool : v4,
        };
        let v7 = InitPoolEvent{
            sender            : 0x2::tx_context::sender(arg7),
            pool_id           : 0x2::object::id<Pool>(&v3),
            deployer          : 0x2::object::id<Deployer>(&v6),
            trade_fee_buy     : arg1,
            trade_fee_sell    : arg2,
            protocol_fee_buy  : arg3,
            protocol_fee_sell : arg4,
            created_at        : v2.created_at,
        };
        0x2::event::emit<InitPoolEvent>(v7);
        0x2::transfer::share_object<Pool>(v3);
        0x2::transfer::transfer<Deployer>(v6, 0x2::tx_context::sender(arg7));
        0x2::transfer::transfer<Metadata>(v1, 0x2::tx_context::sender(arg7));
    }

    public(friend) fun is_sui_coin<T0>() : bool {
        b"0000000000000000000000000000000000000000000000000000000000000002::sui::SUI" == 0x1::ascii::into_bytes(0x1::type_name::into_string(0x1::type_name::get<T0>()))
    }

    public fun lp_balance<T0, T1>(arg0: &Pool, arg1: address) : u64 {
        lp_balance_pool<T0, T1>(pool_state<T0, T1>(arg0), arg1)
    }

    fun lp_balance_pool<T0, T1>(arg0: &PoolState<T0, T1>, arg1: address) : u64 {
        if (0x2::table::contains<address, u64>(&arg0.lp_mapping, arg1)) {
            *0x2::table::borrow<address, u64>(&arg0.lp_mapping, arg1)
        } else {
            0
        }
    }

    fun make_pool<T0, T1>(arg0: u64, arg1: u64, arg2: u64, arg3: u64, arg4: address, arg5: u64, arg6: 0x2::object::ID, arg7: &mut 0x2::tx_context::TxContext) : PoolState<T0, T1> {
        PoolState<T0, T1>{
            coin_a            : 0x2::balance::zero<T0>(),
            coin_b            : 0x2::balance::zero<T1>(),
            coin_a_admin      : 0x2::balance::zero<T0>(),
            coin_b_admin      : 0x2::balance::zero<T1>(),
            reward_all_time   : 0,
            lp_locked         : 0,
            lp_supply         : 0,
            trade_fee_buy     : arg0,
            trade_fee_sell    : arg1,
            protocol_fee_buy  : arg2,
            protocol_fee_sell : arg3,
            protocol_address  : arg4,
            created_at        : arg5,
            last_euler        : 0,
            euler_mapping     : 0x2::table::new<address, Provider>(arg7),
            lp_mapping        : 0x2::table::new<address, u64>(arg7),
            metadata          : arg6,
        }
    }

    fun mint<T0, T1>(arg0: &mut Pool, arg1: 0x2::balance::Balance<T0>, arg2: 0x2::balance::Balance<T1>, arg3: &0x2::clock::Clock) : u64 {
        let v0 = pool_state_mut<T0, T1>(arg0);
        let (v1, v2) = get_reserves_pool<T0, T1>(v0);
        let v3 = v0.lp_supply;
        let v4 = if (v3 == 0) {
            v0.lp_supply = 10;
            v0.lp_locked = v0.lp_locked + v0.lp_supply;
            v0.created_at = 0x2::clock::timestamp_ms(arg3);
            (0x2::math::sqrt_u128((0x2::balance::value<T0>(&arg1) as u128) * (0x2::balance::value<T1>(&arg2) as u128)) as u64) - 10
        } else {
            0x2::math::min(0x657ff24534bbb1ca32d1af20fca59c6e93bc063888da98d553396b5522d2c7ba::amm_math::safe_mul_div_u64(0x2::balance::value<T0>(&arg1), v3, v1), 0x657ff24534bbb1ca32d1af20fca59c6e93bc063888da98d553396b5522d2c7ba::amm_math::safe_mul_div_u64(0x2::balance::value<T1>(&arg2), v3, v2))
        };
        assert!(v4 > 0, 2);
        0x2::balance::join<T0>(&mut v0.coin_a, arg1);
        0x2::balance::join<T1>(&mut v0.coin_b, arg2);
        v0.lp_supply = v0.lp_supply + v4;
        emit_pool_reserve<T0, T1>(arg0);
        v4
    }

    public(friend) fun mint_and_emit_event<T0, T1>(arg0: &mut Pool, arg1: 0x2::balance::Balance<T0>, arg2: 0x2::balance::Balance<T1>, arg3: u64, arg4: u64, arg5: &0x2::clock::Clock, arg6: &mut 0x2::tx_context::TxContext) : u64 {
        let v0 = mint<T0, T1>(arg0, arg1, arg2, arg5);
        let v1 = LiquidityEvent{
            sender           : 0x2::tx_context::sender(arg6),
            pool_id          : 0x2::object::id<Pool>(arg0),
            is_add_liquidity : true,
            liquidity        : v0,
            amount_a         : arg3,
            amount_b         : arg4,
        };
        0x2::event::emit<LiquidityEvent>(v1);
        v0
    }

    public fun pool_address<T0, T1>(arg0: &Registry) : address {
        *0x2::table::borrow<0x1::type_name::TypeName, address>(&arg0.pools, 0x1::type_name::get<RegistryKey<T0, T1>>())
    }

    fun pool_state<T0, T1>(arg0: &Pool) : &PoolState<T0, T1> {
        let v0 = PoolStateKey{dummy_field: false};
        0x2::dynamic_field::borrow<PoolStateKey, PoolState<T0, T1>>(&arg0.id, v0)
    }

    fun pool_state_mut<T0, T1>(arg0: &mut Pool) : &mut PoolState<T0, T1> {
        let v0 = PoolStateKey{dummy_field: false};
        0x2::dynamic_field::borrow_mut<PoolStateKey, PoolState<T0, T1>>(&mut arg0.id, v0)
    }

    public fun pools(arg0: &Registry) : &0x2::table::Table<0x1::type_name::TypeName, address> {
        &arg0.pools
    }

    public(friend) fun repay_flash_swap<T0, T1>(arg0: &mut Pool, arg1: 0x2::balance::Balance<T0>, arg2: 0x2::balance::Balance<T1>, arg3: FlashSwapReceipt<T0, T1>) {
        let v0 = 0x2::object::id<Pool>(arg0);
        let v1 = pool_state_mut<T0, T1>(arg0);
        let FlashSwapReceipt {
            pool_id    : v2,
            a2b        : v3,
            pay_amount : v4,
        } = arg3;
        assert!(v2 == v0, 4);
        if (v3) {
            assert!(0x2::balance::value<T0>(&arg1) == v4, 5);
            0x2::balance::join<T0>(&mut v1.coin_a, arg1);
            0x2::balance::destroy_zero<T1>(arg2);
        } else {
            assert!(0x2::balance::value<T1>(&arg2) == v4, 5);
            0x2::balance::join<T1>(&mut v1.coin_b, arg2);
            0x2::balance::destroy_zero<T0>(arg1);
        };
        emit_pool_reserve<T0, T1>(arg0);
    }

    public(friend) fun set_fee_and_emit_event<T0, T1>(arg0: &mut Pool, arg1: u64, arg2: u64, arg3: u64, arg4: u64, arg5: &mut 0x2::tx_context::TxContext) {
        let v0 = pool_state_mut<T0, T1>(arg0);
        v0.trade_fee_buy = arg1;
        v0.trade_fee_sell = arg2;
        v0.protocol_fee_buy = arg3;
        v0.protocol_fee_sell = arg4;
        let v1 = SetFeeEvent{
            sender            : 0x2::tx_context::sender(arg5),
            pool_id           : 0x2::object::id<Pool>(arg0),
            trade_fee_buy     : arg1,
            trade_fee_sell    : arg2,
            protocol_fee_buy  : arg3,
            protocol_fee_sell : arg4,
        };
        0x2::event::emit<SetFeeEvent>(v1);
    }

    public fun set_meta_data<T0, T1>(arg0: &mut Metadata, arg1: vector<u8>, arg2: vector<u8>, arg3: vector<u8>, arg4: vector<u8>, arg5: vector<u8>) {
        arg0.description = 0x1::string::utf8(arg1);
        arg0.image = 0x1::string::utf8(arg2);
        arg0.chat = 0x1::string::utf8(arg3);
        arg0.website = 0x1::string::utf8(arg4);
        arg0.social = 0x1::string::utf8(arg5);
        let v0 = MetadataUpdated{
            id          : 0x2::object::id<Metadata>(arg0),
            description : arg0.description,
            image       : arg0.image,
            chat        : arg0.chat,
            website     : arg0.website,
            social      : arg0.social,
        };
        0x2::event::emit<MetadataUpdated>(v0);
    }

    public fun swap_pay_amount<T0, T1>(arg0: &FlashSwapReceipt<T0, T1>) : u64 {
        arg0.pay_amount
    }

    public(friend) fun transfer_fees_balance<T0>(arg0: 0x2::balance::Balance<T0>, arg1: 0x2::balance::Balance<T0>, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        transfer_or_destroy_balance<T0>(arg0, @0x8b368f11e378b38e3be43123ebde77bbd7b38b8deb756bc519f63295e84c9fd2, arg3);
        transfer_or_destroy_balance<T0>(arg1, arg2, arg3);
    }

    fun transfer_or_destroy_balance<T0>(arg0: 0x2::balance::Balance<T0>, arg1: address, arg2: &mut 0x2::tx_context::TxContext) {
        if (0x2::balance::value<T0>(&arg0) > 0) {
            0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(0x2::coin::from_balance<T0>(arg0, arg2), arg1);
        } else {
            0x2::balance::destroy_zero<T0>(arg0);
        };
    }

    fun update_euler<T0, T1>(arg0: &mut PoolState<T0, T1>, arg1: u64) {
        arg0.reward_all_time = arg0.reward_all_time + arg1;
        arg0.last_euler = arg0.last_euler + 0x657ff24534bbb1ca32d1af20fca59c6e93bc063888da98d553396b5522d2c7ba::amm_math::safe_mul_div_u64(arg1, 100000000000, arg0.lp_supply);
    }

    fun update_provider_pool<T0, T1>(arg0: &mut PoolState<T0, T1>, arg1: address) {
        let v0 = Provider{
            lp     : lp_balance_pool<T0, T1>(arg0, arg1),
            euler0 : arg0.last_euler,
        };
        if (0x2::table::contains<address, Provider>(&arg0.euler_mapping, arg1)) {
            0x2::table::remove<address, Provider>(&mut arg0.euler_mapping, arg1);
            0x2::table::add<address, Provider>(&mut arg0.euler_mapping, arg1, v0);
        } else {
            0x2::table::add<address, Provider>(&mut arg0.euler_mapping, arg1, v0);
        };
    }

    // decompiled from Move bytecode v6
}

