module 0x5511b2d3550fcdce424bc24623d97e7ac99e4acf968d1cb61aacbb6e4c6605e5::pool {
    struct PoolConfigDfKey has copy, drop, store {
        dummy_field: bool,
    }

    struct Pool<phantom T0, phantom T1> has store, key {
        id: 0x2::object::UID,
        stake_token_custodian: 0x5511b2d3550fcdce424bc24623d97e7ac99e4acf968d1cb61aacbb6e4c6605e5::custodian::Custodian<T0>,
        reward_token_custodian: 0x5511b2d3550fcdce424bc24623d97e7ac99e4acf968d1cb61aacbb6e4c6605e5::custodian::Custodian<T1>,
        reward_per_seconds: u64,
        acc_reward_per_share: u256,
        last_reward_at_ms: u64,
        started_at_ms: u64,
        ended_at_ms: u64,
        is_emergency: bool,
    }

    struct PoolConfig<phantom T0> has store {
        reward_token_custodian: 0x5511b2d3550fcdce424bc24623d97e7ac99e4acf968d1cb61aacbb6e4c6605e5::custodian::Custodian<T0>,
        acc_reward_per_share: u256,
        last_reward_at_ms: u64,
    }

    struct PoolCreated has copy, drop {
        id: 0x2::object::ID,
        stake_token_type: 0x1::string::String,
        reward_token_type: 0x1::string::String,
        total_reward: u64,
        started_at_ms: u64,
        ended_at_ms: u64,
        user: address,
    }

    fun new<T0, T1>(arg0: &mut 0x2::tx_context::TxContext) : Pool<T0, T1> {
        Pool<T0, T1>{
            id                     : 0x2::object::new(arg0),
            stake_token_custodian  : 0x5511b2d3550fcdce424bc24623d97e7ac99e4acf968d1cb61aacbb6e4c6605e5::custodian::new<T0>(),
            reward_token_custodian : 0x5511b2d3550fcdce424bc24623d97e7ac99e4acf968d1cb61aacbb6e4c6605e5::custodian::new<T1>(),
            reward_per_seconds     : 0,
            acc_reward_per_share   : 0,
            last_reward_at_ms      : 0,
            started_at_ms          : 0,
            ended_at_ms            : 0,
            is_emergency           : false,
        }
    }

    public fun acc_reward_per_share<T0, T1>(arg0: &Pool<T0, T1>) : u256 {
        let v0 = PoolConfigDfKey{dummy_field: false};
        0x2::dynamic_field::borrow<PoolConfigDfKey, PoolConfig<T1>>(&arg0.id, v0).acc_reward_per_share
    }

    public(friend) fun borrow_mut_reward_token_custodian<T0, T1>(arg0: &mut Pool<T0, T1>) : &mut 0x5511b2d3550fcdce424bc24623d97e7ac99e4acf968d1cb61aacbb6e4c6605e5::custodian::Custodian<T1> {
        let v0 = PoolConfigDfKey{dummy_field: false};
        &mut 0x2::dynamic_field::borrow_mut<PoolConfigDfKey, PoolConfig<T1>>(&mut arg0.id, v0).reward_token_custodian
    }

    public(friend) fun borrow_mut_stake_token_custodian<T0, T1>(arg0: &mut Pool<T0, T1>) : &mut 0x5511b2d3550fcdce424bc24623d97e7ac99e4acf968d1cb61aacbb6e4c6605e5::custodian::Custodian<T0> {
        &mut arg0.stake_token_custodian
    }

    public fun borrow_reward_token_custodian<T0, T1>(arg0: &Pool<T0, T1>) : &0x5511b2d3550fcdce424bc24623d97e7ac99e4acf968d1cb61aacbb6e4c6605e5::custodian::Custodian<T1> {
        let v0 = PoolConfigDfKey{dummy_field: false};
        &0x2::dynamic_field::borrow<PoolConfigDfKey, PoolConfig<T1>>(&arg0.id, v0).reward_token_custodian
    }

    public fun borrow_stake_token_custodian<T0, T1>(arg0: &Pool<T0, T1>) : &0x5511b2d3550fcdce424bc24623d97e7ac99e4acf968d1cb61aacbb6e4c6605e5::custodian::Custodian<T0> {
        &arg0.stake_token_custodian
    }

    public fun calc_pending_reward<T0, T1>(arg0: &Pool<T0, T1>, arg1: &0x5511b2d3550fcdce424bc24623d97e7ac99e4acf968d1cb61aacbb6e4c6605e5::position::Position) : u64 {
        ((calc_reward_for<T0, T1>(arg0, arg1) - 0x5511b2d3550fcdce424bc24623d97e7ac99e4acf968d1cb61aacbb6e4c6605e5::position::reward_debt(arg1)) as u64)
    }

    public fun calc_reward_for<T0, T1>(arg0: &Pool<T0, T1>, arg1: &0x5511b2d3550fcdce424bc24623d97e7ac99e4acf968d1cb61aacbb6e4c6605e5::position::Position) : u256 {
        (0x5511b2d3550fcdce424bc24623d97e7ac99e4acf968d1cb61aacbb6e4c6605e5::position::value(arg1) as u256) * acc_reward_per_share<T0, T1>(arg0) / 1000000000000
    }

    public(friend) fun create_pool<T0, T1>(arg0: 0x2::coin::Coin<T1>, arg1: u64, arg2: u64, arg3: &0x2::clock::Clock, arg4: &mut 0x2::tx_context::TxContext) : Pool<T0, T1> {
        let v0 = 0x5511b2d3550fcdce424bc24623d97e7ac99e4acf968d1cb61aacbb6e4c6605e5::utils::to_milliseconds(0x5511b2d3550fcdce424bc24623d97e7ac99e4acf968d1cb61aacbb6e4c6605e5::utils::to_seconds(arg2));
        let v1 = 0x5511b2d3550fcdce424bc24623d97e7ac99e4acf968d1cb61aacbb6e4c6605e5::utils::to_milliseconds(0x5511b2d3550fcdce424bc24623d97e7ac99e4acf968d1cb61aacbb6e4c6605e5::utils::to_seconds(arg1));
        assert!(v1 > 0x2::clock::timestamp_ms(arg3), 0);
        assert!(v0 > v1, 1);
        let v2 = v0 - v1;
        let v3 = 0x5511b2d3550fcdce424bc24623d97e7ac99e4acf968d1cb61aacbb6e4c6605e5::utils::calculate_reward_per_seconds(0x2::coin::value<T1>(&arg0), v2);
        let v4 = 0x5511b2d3550fcdce424bc24623d97e7ac99e4acf968d1cb61aacbb6e4c6605e5::utils::calculate_reward_in_duration(v3, v2);
        assert!(v3 > 0, 2);
        let v5 = 0x2::tx_context::sender(arg4);
        let v6 = new<T0, T1>(arg4);
        0x5511b2d3550fcdce424bc24623d97e7ac99e4acf968d1cb61aacbb6e4c6605e5::custodian::deposit<T1>(&mut v6.reward_token_custodian, 0x2::coin::split<T1>(&mut arg0, v4, arg4));
        v6.reward_per_seconds = v3;
        v6.last_reward_at_ms = v1;
        v6.started_at_ms = v1;
        v6.ended_at_ms = v0;
        let v7 = &mut v6;
        migrate_config<T0, T1>(v7, arg4);
        let v8 = &mut v6;
        set_last_reward_at<T0, T1>(v8, v1);
        0x5511b2d3550fcdce424bc24623d97e7ac99e4acf968d1cb61aacbb6e4c6605e5::utils::transfer_or_destroy_zero<T1>(arg0, v5);
        let v9 = PoolCreated{
            id                : 0x2::object::id<Pool<T0, T1>>(&v6),
            stake_token_type  : 0x1::string::from_ascii(0x1::type_name::into_string(0x1::type_name::get<T0>())),
            reward_token_type : 0x1::string::from_ascii(0x1::type_name::into_string(0x1::type_name::get<T1>())),
            total_reward      : v4,
            started_at_ms     : v1,
            ended_at_ms       : v0,
            user              : v5,
        };
        0x2::event::emit<PoolCreated>(v9);
        v6
    }

    public fun ended_at<T0, T1>(arg0: &Pool<T0, T1>) : u64 {
        arg0.ended_at_ms
    }

    public fun estimate_pending_reward<T0, T1>(arg0: &Pool<T0, T1>, arg1: &0x5511b2d3550fcdce424bc24623d97e7ac99e4acf968d1cb61aacbb6e4c6605e5::position::Position, arg2: &0x2::clock::Clock) : u64 {
        let v0 = 0x2::clock::timestamp_ms(arg2);
        let v1 = 0x5511b2d3550fcdce424bc24623d97e7ac99e4acf968d1cb61aacbb6e4c6605e5::custodian::reserve<T0>(&arg0.stake_token_custodian);
        let v2 = acc_reward_per_share<T0, T1>(arg0);
        let v3 = v2;
        if (0x5511b2d3550fcdce424bc24623d97e7ac99e4acf968d1cb61aacbb6e4c6605e5::utils::to_seconds(v0) > 0x5511b2d3550fcdce424bc24623d97e7ac99e4acf968d1cb61aacbb6e4c6605e5::utils::to_seconds(last_reward_at<T0, T1>(arg0)) && v1 != 0) {
            v3 = v2 + ((get_multiplier<T0, T1>(arg0, v0) * arg0.reward_per_seconds) as u256) * 1000000000000 / (v1 as u256);
        };
        (((0x5511b2d3550fcdce424bc24623d97e7ac99e4acf968d1cb61aacbb6e4c6605e5::position::value(arg1) as u256) * v3 / 1000000000000 - 0x5511b2d3550fcdce424bc24623d97e7ac99e4acf968d1cb61aacbb6e4c6605e5::position::reward_debt(arg1)) as u64)
    }

    public fun get_multiplier<T0, T1>(arg0: &Pool<T0, T1>, arg1: u64) : u64 {
        let v0 = last_reward_at<T0, T1>(arg0);
        let v1 = arg0.ended_at_ms;
        if (arg1 <= v1) {
            0x5511b2d3550fcdce424bc24623d97e7ac99e4acf968d1cb61aacbb6e4c6605e5::utils::to_seconds(arg1) - 0x5511b2d3550fcdce424bc24623d97e7ac99e4acf968d1cb61aacbb6e4c6605e5::utils::to_seconds(v0)
        } else if (v0 > v1) {
            0
        } else {
            0x5511b2d3550fcdce424bc24623d97e7ac99e4acf968d1cb61aacbb6e4c6605e5::utils::to_seconds(v1) - 0x5511b2d3550fcdce424bc24623d97e7ac99e4acf968d1cb61aacbb6e4c6605e5::utils::to_seconds(v0)
        }
    }

    fun increase_acc_reward_per_share<T0, T1>(arg0: &mut Pool<T0, T1>, arg1: u256) {
        let v0 = PoolConfigDfKey{dummy_field: false};
        let v1 = 0x2::dynamic_field::borrow_mut<PoolConfigDfKey, PoolConfig<T1>>(&mut arg0.id, v0);
        v1.acc_reward_per_share = v1.acc_reward_per_share + arg1;
    }

    public fun is_emergency<T0, T1>(arg0: &Pool<T0, T1>) : bool {
        arg0.is_emergency
    }

    public fun last_reward_at<T0, T1>(arg0: &Pool<T0, T1>) : u64 {
        let v0 = PoolConfigDfKey{dummy_field: false};
        0x2::dynamic_field::borrow<PoolConfigDfKey, PoolConfig<T1>>(&arg0.id, v0).last_reward_at_ms
    }

    public fun migrate_config<T0, T1>(arg0: &mut Pool<T0, T1>, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = PoolConfigDfKey{dummy_field: false};
        assert!(!0x2::dynamic_field::exists_with_type<PoolConfigDfKey, PoolConfig<T1>>(&arg0.id, v0), 4);
        arg0.last_reward_at_ms = 18446744073709551615;
        arg0.acc_reward_per_share = 0;
        let v1 = 0x5511b2d3550fcdce424bc24623d97e7ac99e4acf968d1cb61aacbb6e4c6605e5::custodian::new<T1>();
        0x5511b2d3550fcdce424bc24623d97e7ac99e4acf968d1cb61aacbb6e4c6605e5::custodian::deposit<T1>(&mut v1, 0x5511b2d3550fcdce424bc24623d97e7ac99e4acf968d1cb61aacbb6e4c6605e5::custodian::withdraw_all<T1>(&mut arg0.reward_token_custodian, arg1));
        let v2 = PoolConfigDfKey{dummy_field: false};
        let v3 = PoolConfig<T1>{
            reward_token_custodian : v1,
            acc_reward_per_share   : 0,
            last_reward_at_ms      : arg0.started_at_ms,
        };
        0x2::dynamic_field::add<PoolConfigDfKey, PoolConfig<T1>>(&mut arg0.id, v2, v3);
    }

    public fun reward_per_seconds<T0, T1>(arg0: &Pool<T0, T1>) : u64 {
        arg0.reward_per_seconds
    }

    public(friend) fun set_emergency<T0, T1>(arg0: &mut Pool<T0, T1>) {
        arg0.is_emergency = true;
    }

    public(friend) fun set_end_time<T0, T1>(arg0: &mut Pool<T0, T1>, arg1: u64, arg2: &0x2::clock::Clock) {
        assert!(0x2::clock::timestamp_ms(arg2) + 172800000 < arg0.started_at_ms, 3);
        assert!(arg1 > arg0.started_at_ms, 1);
        arg0.ended_at_ms = arg1;
    }

    fun set_last_reward_at<T0, T1>(arg0: &mut Pool<T0, T1>, arg1: u64) {
        let v0 = PoolConfigDfKey{dummy_field: false};
        0x2::dynamic_field::borrow_mut<PoolConfigDfKey, PoolConfig<T1>>(&mut arg0.id, v0).last_reward_at_ms = arg1;
    }

    public fun started_at<T0, T1>(arg0: &Pool<T0, T1>) : u64 {
        arg0.started_at_ms
    }

    public(friend) fun stop_reward<T0, T1>(arg0: &mut Pool<T0, T1>, arg1: &0x2::clock::Clock) {
        arg0.ended_at_ms = 0x2::clock::timestamp_ms(arg1);
    }

    public fun update_pool<T0, T1>(arg0: &mut Pool<T0, T1>, arg1: &0x2::clock::Clock) {
        if (0x5511b2d3550fcdce424bc24623d97e7ac99e4acf968d1cb61aacbb6e4c6605e5::utils::to_seconds(0x2::clock::timestamp_ms(arg1)) <= 0x5511b2d3550fcdce424bc24623d97e7ac99e4acf968d1cb61aacbb6e4c6605e5::utils::to_seconds(last_reward_at<T0, T1>(arg0))) {
            return
        };
        let v0 = 0x5511b2d3550fcdce424bc24623d97e7ac99e4acf968d1cb61aacbb6e4c6605e5::custodian::reserve<T0>(&arg0.stake_token_custodian);
        if (v0 == 0) {
            set_last_reward_at<T0, T1>(arg0, 0x5511b2d3550fcdce424bc24623d97e7ac99e4acf968d1cb61aacbb6e4c6605e5::utils::to_milliseconds(0x5511b2d3550fcdce424bc24623d97e7ac99e4acf968d1cb61aacbb6e4c6605e5::utils::to_seconds(0x2::clock::timestamp_ms(arg1))));
            return
        };
        let v1 = ((get_multiplier<T0, T1>(arg0, 0x2::clock::timestamp_ms(arg1)) * arg0.reward_per_seconds) as u256) * 1000000000000 / (v0 as u256);
        increase_acc_reward_per_share<T0, T1>(arg0, v1);
        set_last_reward_at<T0, T1>(arg0, 0x5511b2d3550fcdce424bc24623d97e7ac99e4acf968d1cb61aacbb6e4c6605e5::utils::to_milliseconds(0x5511b2d3550fcdce424bc24623d97e7ac99e4acf968d1cb61aacbb6e4c6605e5::utils::to_seconds(0x2::clock::timestamp_ms(arg1))));
    }

    // decompiled from Move bytecode v6
}

