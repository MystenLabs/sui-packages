module 0x353ee6e39e854c2fba0f3085fa613d0a055d754daea67ad799eeb042f48721e5::lx_pool_stake {
    struct StakingOrder has copy, drop, store {
        id: 0x2::object::ID,
        stake_amount: u64,
        coin_amount: u64,
        burn_amount: u64,
        power: u64,
        burn_percentage: u64,
        redeemed_amount: u64,
        coin_type: 0x1::string::String,
        stake_time: u64,
        is_platform_coin: bool,
        is_active: bool,
    }

    struct VipStaking has copy, drop, store {
        total_usd_value: u64,
        total_coin_amount: u64,
        last_stake_time: u64,
        is_active: bool,
    }

    struct UserStaking has store {
        orders: vector<StakingOrder>,
        total_power: u64,
        vip_staking: VipStaking,
    }

    struct PoolInfo<phantom T0> has key {
        id: 0x2::object::UID,
        total_staked: u64,
        total_power: u64,
        coin_type: 0x1::string::String,
        balance: 0x2::balance::Balance<T0>,
    }

    struct VipPoolInfo<phantom T0> has key {
        id: 0x2::object::UID,
        total_vip_staked_usd: u64,
        total_vip_coin_amount: u64,
        vip_balance: 0x2::balance::Balance<T0>,
    }

    struct StakingPool<phantom T0> has key {
        id: 0x2::object::UID,
        users: 0x2::table::Table<address, UserStaking>,
        start_time: u64,
        order_counter: u64,
        eco_coins: vector<0x1::string::String>,
        platform_coin: 0x1::string::String,
        burn_balance: 0x2::balance::Balance<T0>,
        total_burned: u64,
        is_paused: bool,
    }

    struct AdminCap has key {
        id: 0x2::object::UID,
    }

    struct StakeEvent has copy, drop {
        user: address,
        order_id: 0x2::object::ID,
        coin_type: 0x1::string::String,
        stake_amount: u64,
        coin_amount: u64,
        burn_amount: u64,
        burn_percentage: u64,
        power: u64,
        timestamp: u64,
    }

    struct RedeemEvent has copy, drop {
        user: address,
        order_id: 0x2::object::ID,
        coin_type: 0x1::string::String,
        redeemed_amount: u64,
        penalty_amount: u64,
        timestamp: u64,
    }

    struct BurnEvent has copy, drop {
        user: address,
        order_id: 0x2::object::ID,
        burn_amount: u64,
        burn_percentage: u64,
        timestamp: u64,
    }

    struct VipStakeEvent has copy, drop {
        user: address,
        usd_value: u64,
        coin_amount: u64,
        total_usd_value: u64,
        total_coin_amount: u64,
        timestamp: u64,
    }

    struct VipRedeemEvent has copy, drop {
        user: address,
        redeemed_amount: u64,
        burned_amount: u64,
        is_early_redemption: bool,
        timestamp: u64,
    }

    struct FuelPaymentEvent has copy, drop {
        user: address,
        order_id: 0x2::object::ID,
        fuel_amount: u64,
        fuel_coin_amount: u64,
        power: u64,
        timestamp: u64,
    }

    public entry fun add_authorized_address(arg0: &AdminCap, arg1: &mut 0x353ee6e39e854c2fba0f3085fa613d0a055d754daea67ad799eeb042f48721e5::config::GlobalConfigMap, arg2: address, arg3: &0x2::clock::Clock, arg4: &mut 0x2::tx_context::TxContext) {
        0x353ee6e39e854c2fba0f3085fa613d0a055d754daea67ad799eeb042f48721e5::config::add_authorized_address(arg1, arg2, arg3, arg4);
    }

    public entry fun add_eco_coin<T0>(arg0: &AdminCap, arg1: &mut StakingPool<T0>, arg2: 0x1::string::String) {
        if (!0x1::vector::contains<0x1::string::String>(&arg1.eco_coins, &arg2)) {
            0x1::vector::push_back<0x1::string::String>(&mut arg1.eco_coins, arg2);
        };
    }

    public entry fun add_price_authorized_address(arg0: &AdminCap, arg1: &mut 0x353ee6e39e854c2fba0f3085fa613d0a055d754daea67ad799eeb042f48721e5::price_oracle::GlobalConfigMap, arg2: address, arg3: &0x2::clock::Clock, arg4: &mut 0x2::tx_context::TxContext) {
        0x353ee6e39e854c2fba0f3085fa613d0a055d754daea67ad799eeb042f48721e5::price_oracle::add_authorized_address(arg1, arg2, arg3, arg4);
    }

    fun calculate_burn_percentage<T0>(arg0: &StakingPool<T0>, arg1: &0x2::clock::Clock) : u64 {
        let v0 = 0x2::clock::timestamp_ms(arg1) - arg0.start_time;
        if (v0 < 1209600000) {
            return 20
        };
        let v1 = 20 + ((v0 - 1209600000) / 604800000 + 1) * 5;
        if (v1 > 40) {
            40
        } else {
            v1
        }
    }

    fun calculate_burn_percentageV1(arg0: &0x353ee6e39e854c2fba0f3085fa613d0a055d754daea67ad799eeb042f48721e5::config::GlobalConfigMap, arg1: 0x1::string::String) : u64 {
        0x353ee6e39e854c2fba0f3085fa613d0a055d754daea67ad799eeb042f48721e5::config::get_burn_percentage(arg0, arg1)
    }

    public fun calculate_fuel_fee(arg0: u64) : u64 {
        arg0 * 2 / 100
    }

    fun calculate_power(arg0: u64, arg1: bool) : u64 {
        if (arg1) {
            arg0 * 150 / 100
        } else {
            arg0 * 100 / 100
        }
    }

    fun calculate_powerV1(arg0: u64, arg1: &0x353ee6e39e854c2fba0f3085fa613d0a055d754daea67ad799eeb042f48721e5::config::GlobalConfigMap, arg2: 0x1::string::String) : u64 {
        arg0 * 0x353ee6e39e854c2fba0f3085fa613d0a055d754daea67ad799eeb042f48721e5::config::get_power_rate(arg1, arg2) / 100
    }

    public fun calculate_redemption<T0>(arg0: &StakingPool<T0>, arg1: address, arg2: 0x2::object::ID, arg3: &0x2::clock::Clock) : (u64, u64) {
        assert!(0x2::table::contains<address, UserStaking>(&arg0.users, arg1), 4);
        let v0 = 0x2::table::borrow<address, UserStaking>(&arg0.users, arg1);
        let v1 = find_order_index(&v0.orders, &arg2);
        assert!(v1 < 0x1::vector::length<StakingOrder>(&v0.orders), 3);
        let v2 = 0x1::vector::borrow<StakingOrder>(&v0.orders, v1);
        if (v2.is_platform_coin) {
            if (0x2::clock::timestamp_ms(arg3) - v2.stake_time >= 94608000000) {
                (v2.coin_amount, 0)
            } else {
                let v5 = v2.coin_amount * 50 / 100;
                (v5, v2.coin_amount - v5)
            }
        } else {
            (v2.coin_amount, 0)
        }
    }

    public fun calculate_vip_redemption<T0>(arg0: &StakingPool<T0>, arg1: address, arg2: &0x2::clock::Clock) : (u64, u64, bool) {
        if (!0x2::table::contains<address, UserStaking>(&arg0.users, arg1)) {
            return (0, 0, false)
        };
        let v0 = 0x2::table::borrow<address, UserStaking>(&arg0.users, arg1);
        if (!v0.vip_staking.is_active) {
            return (0, 0, false)
        };
        let v1 = v0.vip_staking.total_coin_amount;
        if (0x2::clock::timestamp_ms(arg2) - v0.vip_staking.last_stake_time >= 94608000000) {
            (v1, 0, false)
        } else {
            let v5 = v1 * 50 / 100;
            (v5, v1 - v5, true)
        }
    }

    public fun can_full_redeem<T0>(arg0: &StakingPool<T0>, arg1: address, arg2: 0x2::object::ID, arg3: &0x2::clock::Clock) : bool {
        if (!0x2::table::contains<address, UserStaking>(&arg0.users, arg1)) {
            return false
        };
        let v0 = 0x2::table::borrow<address, UserStaking>(&arg0.users, arg1);
        let v1 = find_order_index(&v0.orders, &arg2);
        if (v1 >= 0x1::vector::length<StakingOrder>(&v0.orders)) {
            return false
        };
        let v2 = 0x1::vector::borrow<StakingOrder>(&v0.orders, v1);
        if (!v2.is_platform_coin) {
            return true
        };
        0x2::clock::timestamp_ms(arg3) - v2.stake_time >= 94608000000
    }

    public fun can_vip_full_redeem<T0>(arg0: &StakingPool<T0>, arg1: address, arg2: &0x2::clock::Clock) : bool {
        if (!0x2::table::contains<address, UserStaking>(&arg0.users, arg1)) {
            return false
        };
        let v0 = 0x2::table::borrow<address, UserStaking>(&arg0.users, arg1);
        if (!v0.vip_staking.is_active) {
            return false
        };
        0x2::clock::timestamp_ms(arg2) - v0.vip_staking.last_stake_time >= 94608000000
    }

    fun count_active_orders(arg0: &vector<StakingOrder>) : u64 {
        let v0 = 0;
        let v1 = 0;
        while (v1 < 0x1::vector::length<StakingOrder>(arg0)) {
            if (0x1::vector::borrow<StakingOrder>(arg0, v1).is_active) {
                v0 = v0 + 1;
            };
            v1 = v1 + 1;
        };
        v0
    }

    public fun create_pool<T0>(arg0: 0x1::string::String, arg1: &mut 0x2::tx_context::TxContext) : PoolInfo<T0> {
        PoolInfo<T0>{
            id           : 0x2::object::new(arg1),
            total_staked : 0,
            total_power  : 0,
            coin_type    : arg0,
            balance      : 0x2::balance::zero<T0>(),
        }
    }

    public fun create_staking_pool<T0>(arg0: &mut 0x2::tx_context::TxContext) : StakingPool<T0> {
        let v0 = StakingPool<T0>{
            id            : 0x2::object::new(arg0),
            users         : 0x2::table::new<address, UserStaking>(arg0),
            start_time    : 0,
            order_counter : 0,
            eco_coins     : 0x1::vector::empty<0x1::string::String>(),
            platform_coin : 0x1::string::utf8(b"L"),
            burn_balance  : 0x2::balance::zero<T0>(),
            total_burned  : 0,
            is_paused     : false,
        };
        0x1::vector::push_back<0x1::string::String>(&mut v0.eco_coins, 0x1::string::utf8(b"YY"));
        0x1::vector::push_back<0x1::string::String>(&mut v0.eco_coins, 0x1::string::utf8(b"YUSDT"));
        v0
    }

    public fun create_vip_pool<T0>(arg0: &mut 0x2::tx_context::TxContext) : VipPoolInfo<T0> {
        VipPoolInfo<T0>{
            id                    : 0x2::object::new(arg0),
            total_vip_staked_usd  : 0,
            total_vip_coin_amount : 0,
            vip_balance           : 0x2::balance::zero<T0>(),
        }
    }

    public entry fun execute_burn<T0>(arg0: &AdminCap, arg1: &mut StakingPool<T0>, arg2: u64, arg3: &mut 0x2::tx_context::TxContext) {
        0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(0x2::coin::from_balance<T0>(0x2::balance::split<T0>(&mut arg1.burn_balance, arg2), arg3), @0x0);
    }

    fun find_order_index(arg0: &vector<StakingOrder>, arg1: &0x2::object::ID) : u64 {
        let v0 = 0x1::vector::length<StakingOrder>(arg0);
        let v1 = 0;
        while (v1 < v0) {
            if (&0x1::vector::borrow<StakingOrder>(arg0, v1).id == arg1) {
                return v1
            };
            v1 = v1 + 1;
        };
        v0
    }

    public fun get_burn_balance<T0>(arg0: &StakingPool<T0>) : u64 {
        0x2::balance::value<T0>(&arg0.burn_balance)
    }

    public fun get_current_burn_percentage<T0>(arg0: &StakingPool<T0>, arg1: &0x2::clock::Clock) : u64 {
        calculate_burn_percentage<T0>(arg0, arg1)
    }

    public fun get_current_burn_percentageV1<T0>(arg0: &0x353ee6e39e854c2fba0f3085fa613d0a055d754daea67ad799eeb042f48721e5::config::GlobalConfigMap, arg1: &mut PoolInfo<T0>) : u64 {
        calculate_burn_percentageV1(arg0, arg1.coin_type)
    }

    public fun get_eco_coins<T0>(arg0: &StakingPool<T0>) : vector<0x1::string::String> {
        arg0.eco_coins
    }

    public fun get_order_detail<T0>(arg0: &StakingPool<T0>, arg1: address, arg2: 0x2::object::ID) : (u64, u64, u64, u64, u64, bool) {
        assert!(0x2::table::contains<address, UserStaking>(&arg0.users, arg1), 4);
        let v0 = 0x2::table::borrow<address, UserStaking>(&arg0.users, arg1);
        let v1 = find_order_index(&v0.orders, &arg2);
        assert!(v1 < 0x1::vector::length<StakingOrder>(&v0.orders), 3);
        let v2 = 0x1::vector::borrow<StakingOrder>(&v0.orders, v1);
        (v2.stake_amount, v2.coin_amount, v2.burn_amount, v2.burn_percentage, v2.redeemed_amount, v2.is_active)
    }

    public fun get_pool_coin_type<T0>(arg0: &PoolInfo<T0>) : 0x1::string::String {
        arg0.coin_type
    }

    public fun get_pool_info<T0>(arg0: &PoolInfo<T0>) : (u64, u64, u64) {
        (arg0.total_staked, arg0.total_power, 0x2::balance::value<T0>(&arg0.balance))
    }

    public fun get_remaining_lock_time<T0>(arg0: &StakingPool<T0>, arg1: address, arg2: 0x2::object::ID, arg3: &0x2::clock::Clock) : u64 {
        assert!(0x2::table::contains<address, UserStaking>(&arg0.users, arg1), 4);
        let v0 = 0x2::table::borrow<address, UserStaking>(&arg0.users, arg1);
        let v1 = find_order_index(&v0.orders, &arg2);
        assert!(v1 < 0x1::vector::length<StakingOrder>(&v0.orders), 3);
        let v2 = 0x1::vector::borrow<StakingOrder>(&v0.orders, v1);
        if (!v2.is_platform_coin) {
            return 0
        };
        let v3 = 0x2::clock::timestamp_ms(arg3) - v2.stake_time;
        if (v3 >= 94608000000) {
            0
        } else {
            94608000000 - v3
        }
    }

    public fun get_staking_pool_info<T0>(arg0: &StakingPool<T0>) : (u64, u64, u64, u64, bool) {
        (arg0.start_time, arg0.order_counter, arg0.total_burned, 0x2::balance::value<T0>(&arg0.burn_balance), arg0.is_paused)
    }

    public fun get_total_burned<T0>(arg0: &StakingPool<T0>) : u64 {
        arg0.total_burned
    }

    public fun get_user_orders<T0>(arg0: &StakingPool<T0>, arg1: address) : vector<StakingOrder> {
        if (!0x2::table::contains<address, UserStaking>(&arg0.users, arg1)) {
            return 0x1::vector::empty<StakingOrder>()
        };
        0x2::table::borrow<address, UserStaking>(&arg0.users, arg1).orders
    }

    public fun get_user_staked_by_coin<T0>(arg0: &StakingPool<T0>, arg1: address, arg2: 0x1::string::String) : u64 {
        if (!0x2::table::contains<address, UserStaking>(&arg0.users, arg1)) {
            return 0
        };
        let v0 = &0x2::table::borrow<address, UserStaking>(&arg0.users, arg1).orders;
        let v1 = 0;
        let v2 = 0;
        while (v2 < 0x1::vector::length<StakingOrder>(v0)) {
            let v3 = 0x1::vector::borrow<StakingOrder>(v0, v2);
            if (v3.is_active && v3.coin_type == arg2) {
                v1 = v1 + v3.stake_amount;
            };
            v2 = v2 + 1;
        };
        v1
    }

    public fun get_user_staking<T0>(arg0: &StakingPool<T0>, arg1: address) : (u64, u64) {
        if (!0x2::table::contains<address, UserStaking>(&arg0.users, arg1)) {
            return (0, 0)
        };
        let v0 = 0x2::table::borrow<address, UserStaking>(&arg0.users, arg1);
        (v0.total_power, count_active_orders(&v0.orders))
    }

    public fun get_user_total_staked<T0>(arg0: &StakingPool<T0>, arg1: address) : u64 {
        if (!0x2::table::contains<address, UserStaking>(&arg0.users, arg1)) {
            return 0
        };
        let v0 = &0x2::table::borrow<address, UserStaking>(&arg0.users, arg1).orders;
        let v1 = 0;
        let v2 = 0;
        while (v2 < 0x1::vector::length<StakingOrder>(v0)) {
            let v3 = 0x1::vector::borrow<StakingOrder>(v0, v2);
            if (v3.is_active) {
                v1 = v1 + v3.stake_amount;
            };
            v2 = v2 + 1;
        };
        v1
    }

    public fun get_user_vip_staking<T0>(arg0: &StakingPool<T0>, arg1: address) : (u64, u64, u64, bool) {
        if (!0x2::table::contains<address, UserStaking>(&arg0.users, arg1)) {
            return (0, 0, 0, false)
        };
        let v0 = 0x2::table::borrow<address, UserStaking>(&arg0.users, arg1);
        (v0.vip_staking.total_usd_value, v0.vip_staking.total_coin_amount, v0.vip_staking.last_stake_time, v0.vip_staking.is_active)
    }

    public fun get_vip_pool_info<T0>(arg0: &VipPoolInfo<T0>) : (u64, u64, u64) {
        (arg0.total_vip_staked_usd, arg0.total_vip_coin_amount, 0x2::balance::value<T0>(&arg0.vip_balance))
    }

    public fun get_vip_remaining_lock_time<T0>(arg0: &StakingPool<T0>, arg1: address, arg2: &0x2::clock::Clock) : u64 {
        if (!0x2::table::contains<address, UserStaking>(&arg0.users, arg1)) {
            return 0
        };
        let v0 = 0x2::table::borrow<address, UserStaking>(&arg0.users, arg1);
        if (!v0.vip_staking.is_active) {
            return 0
        };
        let v1 = 0x2::clock::timestamp_ms(arg2) - v0.vip_staking.last_stake_time;
        if (v1 >= 94608000000) {
            0
        } else {
            94608000000 - v1
        }
    }

    fun init(arg0: &mut 0x2::tx_context::TxContext) {
        let v0 = AdminCap{id: 0x2::object::new(arg0)};
        0x2::transfer::transfer<AdminCap>(v0, 0x2::tx_context::sender(arg0));
    }

    public entry fun init_pool<T0>(arg0: 0x1::string::String, arg1: &mut 0x2::tx_context::TxContext) {
        0x2::transfer::share_object<PoolInfo<T0>>(create_pool<T0>(arg0, arg1));
    }

    public entry fun init_pool_config(arg0: &AdminCap, arg1: &mut 0x2::tx_context::TxContext) {
        0x353ee6e39e854c2fba0f3085fa613d0a055d754daea67ad799eeb042f48721e5::config::init_config(arg1);
    }

    public entry fun init_price_config(arg0: &AdminCap, arg1: &mut 0x2::tx_context::TxContext) {
        0x353ee6e39e854c2fba0f3085fa613d0a055d754daea67ad799eeb042f48721e5::price_oracle::init_config(arg1);
    }

    public entry fun init_staking_pool<T0>(arg0: &mut 0x2::tx_context::TxContext) {
        0x2::transfer::share_object<StakingPool<T0>>(create_staking_pool<T0>(arg0));
    }

    public entry fun init_vip_pool<T0>(arg0: &mut 0x2::tx_context::TxContext) {
        0x2::transfer::share_object<VipPoolInfo<T0>>(create_vip_pool<T0>(arg0));
    }

    fun is_eco_coin<T0>(arg0: &StakingPool<T0>, arg1: &0x1::string::String) : bool {
        0x1::vector::contains<0x1::string::String>(&arg0.eco_coins, arg1)
    }

    public fun is_paused<T0>(arg0: &StakingPool<T0>) : bool {
        arg0.is_paused
    }

    fun is_platform_coin<T0>(arg0: &StakingPool<T0>, arg1: &0x1::string::String) : bool {
        arg1 == &arg0.platform_coin
    }

    public entry fun pause<T0>(arg0: &AdminCap, arg1: &mut StakingPool<T0>) {
        arg1.is_paused = true;
    }

    public entry fun pay_miner_fuel<T0, T1>(arg0: &mut StakingPool<T0>, arg1: &mut 0x68114ffc0a0d7c4a582b4494d2370205a23d93e96b9ef6a750d0ba5f8f52b7db::implements::Global, arg2: 0x2::object::ID, arg3: 0x2::coin::Coin<T0>, arg4: &0x2::clock::Clock, arg5: &mut 0x2::tx_context::TxContext) {
        abort 0
    }

    public entry fun pay_miner_fuelV1<T0, T1>(arg0: &mut StakingPool<T0>, arg1: &mut 0x68114ffc0a0d7c4a582b4494d2370205a23d93e96b9ef6a750d0ba5f8f52b7db::implements::Global, arg2: 0x2::object::ID, arg3: u64, arg4: 0x2::coin::Coin<T0>, arg5: &0x2::clock::Clock, arg6: &mut 0x2::tx_context::TxContext) {
        assert!(!arg0.is_paused, 8);
        let v0 = 0x2::tx_context::sender(arg6);
        assert!(0x2::table::contains<address, UserStaking>(&arg0.users, v0), 14);
        let v1 = 0x2::table::borrow_mut<address, UserStaking>(&mut arg0.users, v0);
        let v2 = find_order_index(&v1.orders, &arg2);
        assert!(v2 < 0x1::vector::length<StakingOrder>(&v1.orders), 3);
        let v3 = 0x1::vector::borrow<StakingOrder>(&v1.orders, v2);
        let v4 = if (!v3.is_active) {
            v3.stake_amount * v3.burn_percentage / 100
        } else {
            v3.power
        };
        let v5 = 0x2::coin::value<T0>(&arg4);
        assert!(v5 >= 0x353ee6e39e854c2fba0f3085fa613d0a055d754daea67ad799eeb042f48721e5::coin_price::calculate_yswap_amount_out<T1, T0>(arg1, arg3), 11);
        0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(arg4, @0x0);
        let v6 = FuelPaymentEvent{
            user             : v0,
            order_id         : v3.id,
            fuel_amount      : arg3,
            fuel_coin_amount : v5,
            power            : v4,
            timestamp        : 0x2::clock::timestamp_ms(arg5),
        };
        0x2::event::emit<FuelPaymentEvent>(v6);
    }

    public entry fun redeem<T0, T1>(arg0: &mut StakingPool<T1>, arg1: &mut PoolInfo<T0>, arg2: 0x2::object::ID, arg3: &0x2::clock::Clock, arg4: &mut 0x2::tx_context::TxContext) {
        assert!(!arg0.is_paused, 8);
        let v0 = 0x2::tx_context::sender(arg4);
        assert!(0x2::table::contains<address, UserStaking>(&arg0.users, v0), 4);
        let v1 = 0x2::table::borrow_mut<address, UserStaking>(&mut arg0.users, v0);
        let v2 = find_order_index(&v1.orders, &arg2);
        assert!(v2 < 0x1::vector::length<StakingOrder>(&v1.orders), 3);
        let v3 = 0x1::vector::borrow_mut<StakingOrder>(&mut v1.orders, v2);
        assert!(v3.is_active, 3);
        assert!(arg1.coin_type == v3.coin_type, 12);
        let v4 = 0x2::clock::timestamp_ms(arg3);
        let (v5, v6) = if (v3.is_platform_coin) {
            if (v4 - v3.stake_time >= 94608000000) {
                (v3.coin_amount, 0)
            } else {
                let v7 = v3.coin_amount * 50 / 100;
                (v7, v3.coin_amount - v7)
            }
        } else {
            (v3.coin_amount, 0)
        };
        assert!(0x2::balance::value<T0>(&arg1.balance) >= v5, 9);
        v3.redeemed_amount = v5;
        v3.is_active = false;
        let v8 = v3.power;
        v1.total_power = v1.total_power - v8;
        arg1.total_staked = arg1.total_staked - v3.stake_amount;
        arg1.total_power = arg1.total_power - v8;
        let v9 = RedeemEvent{
            user            : v0,
            order_id        : arg2,
            coin_type       : v3.coin_type,
            redeemed_amount : v5,
            penalty_amount  : v6,
            timestamp       : v4,
        };
        0x2::event::emit<RedeemEvent>(v9);
        0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(0x2::coin::from_balance<T0>(0x2::balance::split<T0>(&mut arg1.balance, v5), arg4), v0);
        if (v6 > 0) {
            0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(0x2::coin::from_balance<T0>(0x2::balance::split<T0>(&mut arg1.balance, v6), arg4), @0x0);
        };
    }

    public entry fun redeem_vip<T0>(arg0: &mut StakingPool<T0>, arg1: &mut VipPoolInfo<T0>, arg2: &0x2::clock::Clock, arg3: &mut 0x2::tx_context::TxContext) {
        assert!(!arg0.is_paused, 8);
        let v0 = 0x2::tx_context::sender(arg3);
        assert!(0x2::table::contains<address, UserStaking>(&arg0.users, v0), 4);
        let v1 = 0x2::table::borrow_mut<address, UserStaking>(&mut arg0.users, v0);
        assert!(v1.vip_staking.is_active, 10);
        assert!(v1.vip_staking.total_coin_amount > 0, 1);
        let v2 = 0x2::clock::timestamp_ms(arg2);
        let v3 = v1.vip_staking.total_coin_amount;
        assert!(0x2::balance::value<T0>(&arg1.vip_balance) >= v3, 9);
        let (v4, v5, v6) = if (v2 - v1.vip_staking.last_stake_time >= 94608000000) {
            (v3, 0, false)
        } else {
            let v7 = v3 * 50 / 100;
            (v7, v3 - v7, true)
        };
        arg1.total_vip_staked_usd = arg1.total_vip_staked_usd - v1.vip_staking.total_usd_value;
        arg1.total_vip_coin_amount = arg1.total_vip_coin_amount - v3;
        v1.vip_staking.total_usd_value = 0;
        v1.vip_staking.total_coin_amount = 0;
        v1.vip_staking.last_stake_time = 0;
        v1.vip_staking.is_active = false;
        if (v4 > 0) {
            0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(0x2::coin::from_balance<T0>(0x2::balance::split<T0>(&mut arg1.vip_balance, v4), arg3), v0);
        };
        if (v5 > 0) {
            0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(0x2::coin::from_balance<T0>(0x2::balance::split<T0>(&mut arg1.vip_balance, v5), arg3), @0x0);
            arg0.total_burned = arg0.total_burned + v5;
        };
        let v8 = VipRedeemEvent{
            user                : v0,
            redeemed_amount     : v4,
            burned_amount       : v5,
            is_early_redemption : v6,
            timestamp           : v2,
        };
        0x2::event::emit<VipRedeemEvent>(v8);
    }

    public entry fun remove_eco_coin<T0>(arg0: &AdminCap, arg1: &mut StakingPool<T0>, arg2: 0x1::string::String) {
        let (v0, v1) = 0x1::vector::index_of<0x1::string::String>(&arg1.eco_coins, &arg2);
        if (v0) {
            0x1::vector::remove<0x1::string::String>(&mut arg1.eco_coins, v1);
        };
    }

    public entry fun set_start_date<T0>(arg0: &AdminCap, arg1: &mut StakingPool<T0>, arg2: u64) {
        arg1.start_time = arg2;
    }

    public entry fun set_start_time<T0>(arg0: &AdminCap, arg1: &mut StakingPool<T0>, arg2: &0x2::clock::Clock) {
        arg1.start_time = 0x2::clock::timestamp_ms(arg2);
    }

    public entry fun stake_l_coin<T0, T1>(arg0: &mut StakingPool<T0>, arg1: &mut 0x68114ffc0a0d7c4a582b4494d2370205a23d93e96b9ef6a750d0ba5f8f52b7db::implements::Global, arg2: &mut PoolInfo<T0>, arg3: 0x2::coin::Coin<T0>, arg4: u64, arg5: &0x2::clock::Clock, arg6: &mut 0x2::tx_context::TxContext) {
        abort 0
    }

    public entry fun stake_l_coinV1<T0, T1>(arg0: &mut StakingPool<T0>, arg1: &mut 0x68114ffc0a0d7c4a582b4494d2370205a23d93e96b9ef6a750d0ba5f8f52b7db::implements::Global, arg2: &mut PoolInfo<T0>, arg3: &0x353ee6e39e854c2fba0f3085fa613d0a055d754daea67ad799eeb042f48721e5::config::GlobalConfigMap, arg4: 0x2::coin::Coin<T0>, arg5: u64, arg6: &0x2::clock::Clock, arg7: &mut 0x2::tx_context::TxContext) {
        assert!(!arg0.is_paused, 8);
        let v0 = 0x2::tx_context::sender(arg7);
        assert!(arg5 >= 100, 1);
        let v1 = 0x2::coin::value<T0>(&arg4);
        assert!(v1 >= 0x353ee6e39e854c2fba0f3085fa613d0a055d754daea67ad799eeb042f48721e5::coin_price::calculate_yswap_amount_out<T1, T0>(arg1, arg5), 11);
        let v2 = calculate_powerV1(arg5, arg3, arg2.coin_type);
        arg0.order_counter = arg0.order_counter + 1;
        let v3 = 0x2::object::id_from_address(0x2::tx_context::fresh_object_address(arg7));
        let v4 = StakingOrder{
            id               : v3,
            stake_amount     : arg5,
            coin_amount      : v1,
            burn_amount      : 0,
            power            : v2,
            burn_percentage  : 0,
            redeemed_amount  : 0,
            coin_type        : arg0.platform_coin,
            stake_time       : 0x2::clock::timestamp_ms(arg6),
            is_platform_coin : true,
            is_active        : true,
        };
        if (!0x2::table::contains<address, UserStaking>(&arg0.users, v0)) {
            let v5 = VipStaking{
                total_usd_value   : 0,
                total_coin_amount : 0,
                last_stake_time   : 0,
                is_active         : false,
            };
            let v6 = UserStaking{
                orders      : 0x1::vector::empty<StakingOrder>(),
                total_power : 0,
                vip_staking : v5,
            };
            0x2::table::add<address, UserStaking>(&mut arg0.users, v0, v6);
        };
        let v7 = 0x2::table::borrow_mut<address, UserStaking>(&mut arg0.users, v0);
        0x1::vector::push_back<StakingOrder>(&mut v7.orders, v4);
        v7.total_power = v7.total_power + v2;
        arg2.total_staked = arg2.total_staked + arg5;
        arg2.total_power = arg2.total_power + v2;
        0x2::balance::join<T0>(&mut arg2.balance, 0x2::coin::into_balance<T0>(arg4));
        let v8 = StakeEvent{
            user            : v0,
            order_id        : v3,
            coin_type       : v4.coin_type,
            stake_amount    : arg5,
            coin_amount     : v1,
            burn_amount     : 0,
            burn_percentage : 0,
            power           : v2,
            timestamp       : 0x2::clock::timestamp_ms(arg6),
        };
        0x2::event::emit<StakeEvent>(v8);
    }

    public entry fun stake_l_vip<T0, T1>(arg0: &mut StakingPool<T0>, arg1: &mut VipPoolInfo<T0>, arg2: &mut 0x68114ffc0a0d7c4a582b4494d2370205a23d93e96b9ef6a750d0ba5f8f52b7db::implements::Global, arg3: 0x2::coin::Coin<T0>, arg4: u64, arg5: &0x2::clock::Clock, arg6: &mut 0x2::tx_context::TxContext) {
        assert!(!arg0.is_paused, 8);
        let v0 = 0x2::tx_context::sender(arg6);
        assert!(arg4 >= 100, 1);
        let v1 = 0x2::coin::value<T0>(&arg3);
        assert!(v1 >= 0x353ee6e39e854c2fba0f3085fa613d0a055d754daea67ad799eeb042f48721e5::coin_price::calculate_yswap_amount_out<T1, T0>(arg2, arg4), 11);
        let v2 = 0x2::clock::timestamp_ms(arg5);
        if (!0x2::table::contains<address, UserStaking>(&arg0.users, v0)) {
            let v3 = VipStaking{
                total_usd_value   : 0,
                total_coin_amount : 0,
                last_stake_time   : 0,
                is_active         : false,
            };
            let v4 = UserStaking{
                orders      : 0x1::vector::empty<StakingOrder>(),
                total_power : 0,
                vip_staking : v3,
            };
            0x2::table::add<address, UserStaking>(&mut arg0.users, v0, v4);
        };
        let v5 = 0x2::table::borrow_mut<address, UserStaking>(&mut arg0.users, v0);
        v5.vip_staking.total_usd_value = v5.vip_staking.total_usd_value + arg4;
        v5.vip_staking.total_coin_amount = v5.vip_staking.total_coin_amount + v1;
        v5.vip_staking.last_stake_time = v2;
        v5.vip_staking.is_active = true;
        arg1.total_vip_staked_usd = arg1.total_vip_staked_usd + arg4;
        arg1.total_vip_coin_amount = arg1.total_vip_coin_amount + v1;
        0x2::balance::join<T0>(&mut arg1.vip_balance, 0x2::coin::into_balance<T0>(arg3));
        let v6 = VipStakeEvent{
            user              : v0,
            usd_value         : arg4,
            coin_amount       : v1,
            total_usd_value   : v5.vip_staking.total_usd_value,
            total_coin_amount : v5.vip_staking.total_coin_amount,
            timestamp         : v2,
        };
        0x2::event::emit<VipStakeEvent>(v6);
    }

    public entry fun stake_platform_coin<T0>(arg0: &mut StakingPool<T0>, arg1: &mut PoolInfo<T0>, arg2: 0x2::coin::Coin<T0>, arg3: u64, arg4: &0x2::clock::Clock, arg5: &mut 0x2::tx_context::TxContext) {
        assert!(!arg0.is_paused, 8);
        let v0 = 0x2::tx_context::sender(arg5);
        assert!(arg3 >= 100, 1);
        let v1 = 0x2::coin::value<T0>(&arg2);
        let v2 = calculate_power(arg3, true);
        arg0.order_counter = arg0.order_counter + 1;
        let v3 = 0x2::object::id_from_address(0x2::tx_context::fresh_object_address(arg5));
        let v4 = StakingOrder{
            id               : v3,
            stake_amount     : arg3,
            coin_amount      : v1,
            burn_amount      : 0,
            power            : v2,
            burn_percentage  : 0,
            redeemed_amount  : 0,
            coin_type        : arg0.platform_coin,
            stake_time       : 0x2::clock::timestamp_ms(arg4),
            is_platform_coin : true,
            is_active        : true,
        };
        if (!0x2::table::contains<address, UserStaking>(&arg0.users, v0)) {
            let v5 = VipStaking{
                total_usd_value   : 0,
                total_coin_amount : 0,
                last_stake_time   : 0,
                is_active         : false,
            };
            let v6 = UserStaking{
                orders      : 0x1::vector::empty<StakingOrder>(),
                total_power : 0,
                vip_staking : v5,
            };
            0x2::table::add<address, UserStaking>(&mut arg0.users, v0, v6);
        };
        let v7 = 0x2::table::borrow_mut<address, UserStaking>(&mut arg0.users, v0);
        0x1::vector::push_back<StakingOrder>(&mut v7.orders, v4);
        v7.total_power = v7.total_power + v2;
        arg1.total_staked = arg1.total_staked + arg3;
        arg1.total_power = arg1.total_power + v2;
        0x2::balance::join<T0>(&mut arg1.balance, 0x2::coin::into_balance<T0>(arg2));
        let v8 = StakeEvent{
            user            : v0,
            order_id        : v3,
            coin_type       : v4.coin_type,
            stake_amount    : arg3,
            coin_amount     : v1,
            burn_amount     : 0,
            burn_percentage : 0,
            power           : v2,
            timestamp       : 0x2::clock::timestamp_ms(arg4),
        };
        0x2::event::emit<StakeEvent>(v8);
    }

    public entry fun stake_sui_coin<T0, T1, T2>(arg0: &mut StakingPool<T0>, arg1: &mut PoolInfo<T1>, arg2: &0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T2, T1>, arg3: &mut 0x68114ffc0a0d7c4a582b4494d2370205a23d93e96b9ef6a750d0ba5f8f52b7db::implements::Global, arg4: 0x2::coin::Coin<T1>, arg5: 0x2::coin::Coin<T0>, arg6: u64, arg7: &0x2::clock::Clock, arg8: &mut 0x2::tx_context::TxContext) {
        abort 0
    }

    public entry fun stake_sui_coinV1<T0, T1, T2>(arg0: &mut StakingPool<T0>, arg1: &mut PoolInfo<T1>, arg2: &0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T2, T1>, arg3: &mut 0x68114ffc0a0d7c4a582b4494d2370205a23d93e96b9ef6a750d0ba5f8f52b7db::implements::Global, arg4: &0x353ee6e39e854c2fba0f3085fa613d0a055d754daea67ad799eeb042f48721e5::config::GlobalConfigMap, arg5: 0x2::coin::Coin<T1>, arg6: 0x2::coin::Coin<T0>, arg7: u64, arg8: &0x2::clock::Clock, arg9: &mut 0x2::tx_context::TxContext) {
        assert!(!arg0.is_paused, 8);
        let v0 = 0x2::tx_context::sender(arg9);
        assert!(arg7 >= 100, 1);
        assert!(is_eco_coin<T0>(arg0, &arg1.coin_type), 2);
        let (_, v2) = 0x353ee6e39e854c2fba0f3085fa613d0a055d754daea67ad799eeb042f48721e5::coin_price::calculate_swap_result<T2, T1>(arg2, arg7, true);
        let v3 = 0x2::coin::value<T1>(&arg5);
        assert!(v3 >= v2, 11);
        let v4 = calculate_burn_percentageV1(arg4, arg1.coin_type);
        let v5 = 0x2::coin::value<T0>(&arg6);
        assert!(v5 >= 0x353ee6e39e854c2fba0f3085fa613d0a055d754daea67ad799eeb042f48721e5::coin_price::calculate_yswap_amount_out<T2, T0>(arg3, arg7 * v4 / 100), 7);
        let v6 = calculate_powerV1(arg7, arg4, arg1.coin_type);
        arg0.order_counter = arg0.order_counter + 1;
        let v7 = 0x2::object::id_from_address(0x2::tx_context::fresh_object_address(arg9));
        let v8 = StakingOrder{
            id               : v7,
            stake_amount     : arg7,
            coin_amount      : v3,
            burn_amount      : v5,
            power            : v6,
            burn_percentage  : v4,
            redeemed_amount  : 0,
            coin_type        : arg1.coin_type,
            stake_time       : 0x2::clock::timestamp_ms(arg8),
            is_platform_coin : false,
            is_active        : true,
        };
        if (!0x2::table::contains<address, UserStaking>(&arg0.users, v0)) {
            let v9 = VipStaking{
                total_usd_value   : 0,
                total_coin_amount : 0,
                last_stake_time   : 0,
                is_active         : false,
            };
            let v10 = UserStaking{
                orders      : 0x1::vector::empty<StakingOrder>(),
                total_power : 0,
                vip_staking : v9,
            };
            0x2::table::add<address, UserStaking>(&mut arg0.users, v0, v10);
        };
        let v11 = 0x2::table::borrow_mut<address, UserStaking>(&mut arg0.users, v0);
        0x1::vector::push_back<StakingOrder>(&mut v11.orders, v8);
        v11.total_power = v11.total_power + v6;
        arg1.total_staked = arg1.total_staked + arg7;
        arg1.total_power = arg1.total_power + v6;
        0x2::balance::join<T1>(&mut arg1.balance, 0x2::coin::into_balance<T1>(arg5));
        0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(arg6, @0x0);
        arg0.total_burned = arg0.total_burned + v5;
        let v12 = StakeEvent{
            user            : v0,
            order_id        : v7,
            coin_type       : v8.coin_type,
            stake_amount    : arg7,
            coin_amount     : v3,
            burn_amount     : v5,
            burn_percentage : v4,
            power           : v6,
            timestamp       : 0x2::clock::timestamp_ms(arg8),
        };
        0x2::event::emit<StakeEvent>(v12);
        let v13 = BurnEvent{
            user            : v0,
            order_id        : v7,
            burn_amount     : v5,
            burn_percentage : v4,
            timestamp       : 0x2::clock::timestamp_ms(arg8),
        };
        0x2::event::emit<BurnEvent>(v13);
    }

    public entry fun stake_vip<T0>(arg0: &mut StakingPool<T0>, arg1: &mut VipPoolInfo<T0>, arg2: 0x2::coin::Coin<T0>, arg3: u64, arg4: &0x2::clock::Clock, arg5: &mut 0x2::tx_context::TxContext) {
        abort 0
    }

    public entry fun stake_yusd_coin<T0, T1, T2>(arg0: &mut StakingPool<T2>, arg1: &mut PoolInfo<T0>, arg2: &mut 0x68114ffc0a0d7c4a582b4494d2370205a23d93e96b9ef6a750d0ba5f8f52b7db::implements::Global, arg3: 0x2::coin::Coin<T0>, arg4: 0x2::coin::Coin<T2>, arg5: u64, arg6: &0x2::clock::Clock, arg7: &mut 0x2::tx_context::TxContext) {
        abort 0
    }

    public entry fun stake_yusd_coinV1<T0, T1, T2>(arg0: &mut StakingPool<T2>, arg1: &mut PoolInfo<T0>, arg2: &mut 0x68114ffc0a0d7c4a582b4494d2370205a23d93e96b9ef6a750d0ba5f8f52b7db::implements::Global, arg3: &0x353ee6e39e854c2fba0f3085fa613d0a055d754daea67ad799eeb042f48721e5::config::GlobalConfigMap, arg4: 0x2::coin::Coin<T0>, arg5: 0x2::coin::Coin<T2>, arg6: u64, arg7: &0x2::clock::Clock, arg8: &mut 0x2::tx_context::TxContext) {
        assert!(!arg0.is_paused, 8);
        let v0 = 0x2::tx_context::sender(arg8);
        assert!(arg6 >= 100, 1);
        assert!(is_eco_coin<T2>(arg0, &arg1.coin_type), 2);
        let v1 = 0x2::coin::value<T0>(&arg4);
        assert!(arg6 == v1, 11);
        let v2 = calculate_burn_percentageV1(arg3, arg1.coin_type);
        let v3 = 0x2::coin::value<T2>(&arg5);
        assert!(v3 >= 0x353ee6e39e854c2fba0f3085fa613d0a055d754daea67ad799eeb042f48721e5::coin_price::calculate_yswap_amount_out<T1, T2>(arg2, arg6 * v2 / 100), 7);
        let v4 = calculate_powerV1(arg6, arg3, arg1.coin_type);
        arg0.order_counter = arg0.order_counter + 1;
        let v5 = 0x2::object::id_from_address(0x2::tx_context::fresh_object_address(arg8));
        let v6 = StakingOrder{
            id               : v5,
            stake_amount     : arg6,
            coin_amount      : v1,
            burn_amount      : v3,
            power            : v4,
            burn_percentage  : v2,
            redeemed_amount  : 0,
            coin_type        : arg1.coin_type,
            stake_time       : 0x2::clock::timestamp_ms(arg7),
            is_platform_coin : false,
            is_active        : true,
        };
        if (!0x2::table::contains<address, UserStaking>(&arg0.users, v0)) {
            let v7 = VipStaking{
                total_usd_value   : 0,
                total_coin_amount : 0,
                last_stake_time   : 0,
                is_active         : false,
            };
            let v8 = UserStaking{
                orders      : 0x1::vector::empty<StakingOrder>(),
                total_power : 0,
                vip_staking : v7,
            };
            0x2::table::add<address, UserStaking>(&mut arg0.users, v0, v8);
        };
        let v9 = 0x2::table::borrow_mut<address, UserStaking>(&mut arg0.users, v0);
        0x1::vector::push_back<StakingOrder>(&mut v9.orders, v6);
        v9.total_power = v9.total_power + v4;
        arg1.total_staked = arg1.total_staked + arg6;
        arg1.total_power = arg1.total_power + v4;
        0x2::balance::join<T0>(&mut arg1.balance, 0x2::coin::into_balance<T0>(arg4));
        0x2::transfer::public_transfer<0x2::coin::Coin<T2>>(arg5, @0x0);
        arg0.total_burned = arg0.total_burned + v3;
        let v10 = StakeEvent{
            user            : v0,
            order_id        : v5,
            coin_type       : v6.coin_type,
            stake_amount    : arg6,
            coin_amount     : v1,
            burn_amount     : v3,
            burn_percentage : v2,
            power           : v4,
            timestamp       : 0x2::clock::timestamp_ms(arg7),
        };
        0x2::event::emit<StakeEvent>(v10);
        let v11 = BurnEvent{
            user            : v0,
            order_id        : v5,
            burn_amount     : v3,
            burn_percentage : v2,
            timestamp       : 0x2::clock::timestamp_ms(arg7),
        };
        0x2::event::emit<BurnEvent>(v11);
    }

    public entry fun stake_yy_coin<T0, T1, T2, T3>(arg0: &mut StakingPool<T0>, arg1: &mut PoolInfo<T0>, arg2: &0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T3, T2>, arg3: &mut 0x68114ffc0a0d7c4a582b4494d2370205a23d93e96b9ef6a750d0ba5f8f52b7db::implements::Global, arg4: 0x2::coin::Coin<T0>, arg5: 0x2::coin::Coin<T1>, arg6: u64, arg7: &0x2::clock::Clock, arg8: &mut 0x2::tx_context::TxContext) {
        abort 0
    }

    public entry fun stake_yy_coinV1<T0, T1, T2, T3>(arg0: &mut StakingPool<T1>, arg1: &mut PoolInfo<T0>, arg2: &0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T3, T2>, arg3: &mut 0x68114ffc0a0d7c4a582b4494d2370205a23d93e96b9ef6a750d0ba5f8f52b7db::implements::Global, arg4: 0x2::coin::Coin<T0>, arg5: 0x2::coin::Coin<T1>, arg6: u64, arg7: &0x2::clock::Clock, arg8: &mut 0x2::tx_context::TxContext) {
        abort 0
    }

    public entry fun stake_yy_coinV2<T0, T1, T2, T3>(arg0: &mut StakingPool<T1>, arg1: &mut PoolInfo<T0>, arg2: &0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T3, T2>, arg3: &mut 0x68114ffc0a0d7c4a582b4494d2370205a23d93e96b9ef6a750d0ba5f8f52b7db::implements::Global, arg4: &0x353ee6e39e854c2fba0f3085fa613d0a055d754daea67ad799eeb042f48721e5::config::GlobalConfigMap, arg5: 0x2::coin::Coin<T0>, arg6: 0x2::coin::Coin<T1>, arg7: u64, arg8: &0x2::clock::Clock, arg9: &mut 0x2::tx_context::TxContext) {
        assert!(!arg0.is_paused, 8);
        let v0 = 0x2::tx_context::sender(arg9);
        assert!(arg7 >= 100, 1);
        assert!(is_eco_coin<T1>(arg0, &arg1.coin_type), 2);
        let (_, v2) = 0x353ee6e39e854c2fba0f3085fa613d0a055d754daea67ad799eeb042f48721e5::coin_price::calculate_usdc_to_yy_route<T3, T2, T0>(arg2, arg3, arg7);
        let v3 = 0x2::coin::value<T0>(&arg5);
        assert!(v3 >= v2, 11);
        let v4 = calculate_burn_percentageV1(arg4, arg1.coin_type);
        let v5 = 0x2::coin::value<T1>(&arg6);
        assert!(v5 >= 0x353ee6e39e854c2fba0f3085fa613d0a055d754daea67ad799eeb042f48721e5::coin_price::calculate_yswap_amount_out<T3, T1>(arg3, arg7 * v4 / 100), 7);
        let v6 = calculate_powerV1(arg7, arg4, arg1.coin_type);
        arg0.order_counter = arg0.order_counter + 1;
        let v7 = 0x2::object::id_from_address(0x2::tx_context::fresh_object_address(arg9));
        let v8 = StakingOrder{
            id               : v7,
            stake_amount     : arg7,
            coin_amount      : v3,
            burn_amount      : v5,
            power            : v6,
            burn_percentage  : v4,
            redeemed_amount  : 0,
            coin_type        : arg1.coin_type,
            stake_time       : 0x2::clock::timestamp_ms(arg8),
            is_platform_coin : false,
            is_active        : true,
        };
        if (!0x2::table::contains<address, UserStaking>(&arg0.users, v0)) {
            let v9 = VipStaking{
                total_usd_value   : 0,
                total_coin_amount : 0,
                last_stake_time   : 0,
                is_active         : false,
            };
            let v10 = UserStaking{
                orders      : 0x1::vector::empty<StakingOrder>(),
                total_power : 0,
                vip_staking : v9,
            };
            0x2::table::add<address, UserStaking>(&mut arg0.users, v0, v10);
        };
        let v11 = 0x2::table::borrow_mut<address, UserStaking>(&mut arg0.users, v0);
        0x1::vector::push_back<StakingOrder>(&mut v11.orders, v8);
        v11.total_power = v11.total_power + v6;
        arg1.total_staked = arg1.total_staked + arg7;
        arg1.total_power = arg1.total_power + v6;
        0x2::balance::join<T0>(&mut arg1.balance, 0x2::coin::into_balance<T0>(arg5));
        0x2::transfer::public_transfer<0x2::coin::Coin<T1>>(arg6, @0x0);
        arg0.total_burned = arg0.total_burned + v5;
        let v12 = StakeEvent{
            user            : v0,
            order_id        : v7,
            coin_type       : v8.coin_type,
            stake_amount    : arg7,
            coin_amount     : v3,
            burn_amount     : v5,
            burn_percentage : v4,
            power           : v6,
            timestamp       : 0x2::clock::timestamp_ms(arg8),
        };
        0x2::event::emit<StakeEvent>(v12);
        let v13 = BurnEvent{
            user            : v0,
            order_id        : v7,
            burn_amount     : v5,
            burn_percentage : v4,
            timestamp       : 0x2::clock::timestamp_ms(arg8),
        };
        0x2::event::emit<BurnEvent>(v13);
    }

    public entry fun unpause<T0>(arg0: &AdminCap, arg1: &mut StakingPool<T0>) {
        arg1.is_paused = false;
    }

    public entry fun withdraw_penalty<T0, T1>(arg0: &AdminCap, arg1: &mut PoolInfo<T0>, arg2: u64, arg3: address, arg4: &mut 0x2::tx_context::TxContext) {
        assert!(arg3 != @0x0, 4);
        0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(0x2::coin::from_balance<T0>(0x2::balance::split<T0>(&mut arg1.balance, arg2), arg4), arg3);
    }

    public entry fun withdraw_vip_penalty<T0>(arg0: &AdminCap, arg1: &mut VipPoolInfo<T0>, arg2: u64, arg3: address, arg4: &mut 0x2::tx_context::TxContext) {
        assert!(arg3 != @0x0, 4);
        0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(0x2::coin::from_balance<T0>(0x2::balance::split<T0>(&mut arg1.vip_balance, arg2), arg4), arg3);
    }

    // decompiled from Move bytecode v6
}

