module 0xc1997c630ec588f8600efb6f983d509dc4c67b5aabc8bfd92e1d8d4bba22ec78::deusd_lp_staking {
    struct DeUSDLPStakingManagement has key {
        id: 0x2::object::UID,
        current_epoch: u8,
        stakes: 0x2::table::Table<address, 0x2::table::Table<0x1::type_name::TypeName, StakeData>>,
        stake_parameters_by_token: 0x2::table::Table<0x1::type_name::TypeName, StakeParameters>,
    }

    struct StakeData has copy, drop, store {
        staked_amount: u64,
        cooling_down_amount: u64,
        cooldown_start_timestamp: u64,
    }

    struct StakeParameters has copy, drop, store {
        epoch: u8,
        stake_limit: u64,
        cooldown: u64,
        total_staked: u64,
        total_cooling_down: u64,
    }

    struct BalanceStoreKey<phantom T0> has copy, drop, store {
        dummy_field: bool,
    }

    struct NewEpoch has copy, drop, store {
        new_epoch: u8,
        old_epoch: u8,
    }

    struct StakeParametersUpdated has copy, drop, store {
        token: 0x1::type_name::TypeName,
        epoch: u8,
        stake_limit: u64,
        cooldown: u64,
    }

    struct Stake has copy, drop, store {
        user: address,
        token: 0x1::type_name::TypeName,
        amount: u64,
    }

    struct Unstake has copy, drop, store {
        user: address,
        token: 0x1::type_name::TypeName,
        amount: u64,
    }

    struct Withdraw has copy, drop, store {
        user: address,
        token: 0x1::type_name::TypeName,
        amount: u64,
    }

    fun check_invariant<T0>(arg0: &DeUSDLPStakingManagement) {
        let v0 = 0x2::table::borrow<0x1::type_name::TypeName, StakeParameters>(&arg0.stake_parameters_by_token, 0x1::type_name::get<T0>());
        let v1 = BalanceStoreKey<T0>{dummy_field: false};
        let v2 = if (0x2::dynamic_field::exists_<BalanceStoreKey<T0>>(&arg0.id, v1)) {
            let v3 = BalanceStoreKey<T0>{dummy_field: false};
            0x2::balance::value<T0>(0x2::dynamic_field::borrow<BalanceStoreKey<T0>, 0x2::balance::Balance<T0>>(&arg0.id, v3))
        } else {
            0
        };
        assert!(v2 >= v0.total_staked + v0.total_cooling_down, 8);
    }

    public fun get_balance<T0>(arg0: &DeUSDLPStakingManagement) : u64 {
        let v0 = BalanceStoreKey<T0>{dummy_field: false};
        if (0x2::dynamic_field::exists_<BalanceStoreKey<T0>>(&arg0.id, v0)) {
            let v2 = BalanceStoreKey<T0>{dummy_field: false};
            0x2::balance::value<T0>(0x2::dynamic_field::borrow<BalanceStoreKey<T0>, 0x2::balance::Balance<T0>>(&arg0.id, v2))
        } else {
            0
        }
    }

    public fun get_current_epoch(arg0: &DeUSDLPStakingManagement) : u8 {
        arg0.current_epoch
    }

    fun get_or_create_balance_store<T0>(arg0: &mut DeUSDLPStakingManagement) : &mut 0x2::balance::Balance<T0> {
        let v0 = BalanceStoreKey<T0>{dummy_field: false};
        if (!0x2::dynamic_field::exists_<BalanceStoreKey<T0>>(&arg0.id, v0)) {
            let v1 = BalanceStoreKey<T0>{dummy_field: false};
            0x2::dynamic_field::add<BalanceStoreKey<T0>, 0x2::balance::Balance<T0>>(&mut arg0.id, v1, 0x2::balance::zero<T0>());
        };
        let v2 = BalanceStoreKey<T0>{dummy_field: false};
        0x2::dynamic_field::borrow_mut<BalanceStoreKey<T0>, 0x2::balance::Balance<T0>>(&mut arg0.id, v2)
    }

    public fun get_stake_data<T0>(arg0: &DeUSDLPStakingManagement, arg1: address) : (u64, u64, u64) {
        let v0 = 0x1::type_name::get<T0>();
        if (!0x2::table::contains<address, 0x2::table::Table<0x1::type_name::TypeName, StakeData>>(&arg0.stakes, arg1)) {
            return (0, 0, 0)
        };
        let v1 = 0x2::table::borrow<address, 0x2::table::Table<0x1::type_name::TypeName, StakeData>>(&arg0.stakes, arg1);
        if (!0x2::table::contains<0x1::type_name::TypeName, StakeData>(v1, v0)) {
            return (0, 0, 0)
        };
        let v2 = 0x2::table::borrow<0x1::type_name::TypeName, StakeData>(v1, v0);
        (v2.staked_amount, v2.cooling_down_amount, v2.cooldown_start_timestamp)
    }

    public fun get_stake_parameters<T0>(arg0: &DeUSDLPStakingManagement) : (u8, u64, u64, u64, u64) {
        let v0 = 0x1::type_name::get<T0>();
        if (!0x2::table::contains<0x1::type_name::TypeName, StakeParameters>(&arg0.stake_parameters_by_token, v0)) {
            return (0, 0, 0, 0, 0)
        };
        let v1 = 0x2::table::borrow<0x1::type_name::TypeName, StakeParameters>(&arg0.stake_parameters_by_token, v0);
        (v1.epoch, v1.stake_limit, v1.cooldown, v1.total_staked, v1.total_cooling_down)
    }

    fun init(arg0: &mut 0x2::tx_context::TxContext) {
        let v0 = DeUSDLPStakingManagement{
            id                        : 0x2::object::new(arg0),
            current_epoch             : 0,
            stakes                    : 0x2::table::new<address, 0x2::table::Table<0x1::type_name::TypeName, StakeData>>(arg0),
            stake_parameters_by_token : 0x2::table::new<0x1::type_name::TypeName, StakeParameters>(arg0),
        };
        0x2::transfer::share_object<DeUSDLPStakingManagement>(v0);
    }

    public fun set_epoch(arg0: &0xc1997c630ec588f8600efb6f983d509dc4c67b5aabc8bfd92e1d8d4bba22ec78::admin_cap::AdminCap, arg1: &mut DeUSDLPStakingManagement, arg2: &0xc1997c630ec588f8600efb6f983d509dc4c67b5aabc8bfd92e1d8d4bba22ec78::config::GlobalConfig, arg3: u8) {
        0xc1997c630ec588f8600efb6f983d509dc4c67b5aabc8bfd92e1d8d4bba22ec78::config::check_package_version(arg2);
        assert!(arg3 != arg1.current_epoch, 4);
        arg1.current_epoch = arg3;
        let v0 = NewEpoch{
            new_epoch : arg3,
            old_epoch : arg1.current_epoch,
        };
        0x2::event::emit<NewEpoch>(v0);
    }

    public fun stake<T0>(arg0: &mut DeUSDLPStakingManagement, arg1: &0xc1997c630ec588f8600efb6f983d509dc4c67b5aabc8bfd92e1d8d4bba22ec78::config::GlobalConfig, arg2: 0x2::coin::Coin<T0>, arg3: &mut 0x2::tx_context::TxContext) {
        0xc1997c630ec588f8600efb6f983d509dc4c67b5aabc8bfd92e1d8d4bba22ec78::config::check_package_version(arg1);
        let v0 = 0x2::coin::value<T0>(&arg2);
        assert!(v0 > 0, 1);
        let v1 = 0x1::type_name::get<T0>();
        assert!(0x2::table::contains<0x1::type_name::TypeName, StakeParameters>(&arg0.stake_parameters_by_token, v1), 3);
        let v2 = 0x2::table::borrow_mut<0x1::type_name::TypeName, StakeParameters>(&mut arg0.stake_parameters_by_token, v1);
        assert!(arg0.current_epoch == v2.epoch, 4);
        assert!(v2.total_staked + v0 <= v2.stake_limit, 6);
        v2.total_staked = v2.total_staked + v0;
        let v3 = 0x2::tx_context::sender(arg3);
        if (!0x2::table::contains<address, 0x2::table::Table<0x1::type_name::TypeName, StakeData>>(&arg0.stakes, v3)) {
            0x2::table::add<address, 0x2::table::Table<0x1::type_name::TypeName, StakeData>>(&mut arg0.stakes, v3, 0x2::table::new<0x1::type_name::TypeName, StakeData>(arg3));
        };
        let v4 = 0x2::table::borrow_mut<address, 0x2::table::Table<0x1::type_name::TypeName, StakeData>>(&mut arg0.stakes, v3);
        if (0x2::table::contains<0x1::type_name::TypeName, StakeData>(v4, v1)) {
            let v5 = 0x2::table::borrow_mut<0x1::type_name::TypeName, StakeData>(v4, v1);
            v5.staked_amount = v5.staked_amount + v0;
        } else {
            let v6 = StakeData{
                staked_amount            : v0,
                cooling_down_amount      : 0,
                cooldown_start_timestamp : 0,
            };
            0x2::table::add<0x1::type_name::TypeName, StakeData>(v4, v1, v6);
        };
        let v7 = get_or_create_balance_store<T0>(arg0);
        0x2::balance::join<T0>(v7, 0x2::coin::into_balance<T0>(arg2));
        check_invariant<T0>(arg0);
        let v8 = Stake{
            user   : v3,
            token  : v1,
            amount : v0,
        };
        0x2::event::emit<Stake>(v8);
    }

    public fun unstake<T0>(arg0: &mut DeUSDLPStakingManagement, arg1: &0xc1997c630ec588f8600efb6f983d509dc4c67b5aabc8bfd92e1d8d4bba22ec78::config::GlobalConfig, arg2: u64, arg3: &0x2::clock::Clock, arg4: &mut 0x2::tx_context::TxContext) {
        0xc1997c630ec588f8600efb6f983d509dc4c67b5aabc8bfd92e1d8d4bba22ec78::config::check_package_version(arg1);
        assert!(arg2 > 0, 1);
        let v0 = 0x1::type_name::get<T0>();
        let v1 = 0x2::tx_context::sender(arg4);
        assert!(0x2::table::contains<address, 0x2::table::Table<0x1::type_name::TypeName, StakeData>>(&arg0.stakes, v1), 2);
        let v2 = 0x2::table::borrow_mut<address, 0x2::table::Table<0x1::type_name::TypeName, StakeData>>(&mut arg0.stakes, v1);
        assert!(0x2::table::contains<0x1::type_name::TypeName, StakeData>(v2, v0), 2);
        let v3 = 0x2::table::borrow_mut<0x1::type_name::TypeName, StakeData>(v2, v0);
        assert!(v3.staked_amount >= arg2, 1);
        v3.staked_amount = v3.staked_amount - arg2;
        v3.cooling_down_amount = v3.cooling_down_amount + arg2;
        v3.cooldown_start_timestamp = 0xc1997c630ec588f8600efb6f983d509dc4c67b5aabc8bfd92e1d8d4bba22ec78::clock_utils::timestamp_seconds(arg3);
        let v4 = 0x2::table::borrow_mut<0x1::type_name::TypeName, StakeParameters>(&mut arg0.stake_parameters_by_token, v0);
        v4.total_staked = v4.total_staked - arg2;
        v4.total_cooling_down = v4.total_cooling_down + arg2;
        check_invariant<T0>(arg0);
        let v5 = Unstake{
            user   : v1,
            token  : v0,
            amount : arg2,
        };
        0x2::event::emit<Unstake>(v5);
    }

    public fun update_stake_parameters<T0>(arg0: &0xc1997c630ec588f8600efb6f983d509dc4c67b5aabc8bfd92e1d8d4bba22ec78::admin_cap::AdminCap, arg1: &mut DeUSDLPStakingManagement, arg2: &0xc1997c630ec588f8600efb6f983d509dc4c67b5aabc8bfd92e1d8d4bba22ec78::config::GlobalConfig, arg3: u8, arg4: u64, arg5: u64) {
        0xc1997c630ec588f8600efb6f983d509dc4c67b5aabc8bfd92e1d8d4bba22ec78::config::check_package_version(arg2);
        assert!(arg5 <= 7776000, 5);
        let v0 = 0x1::type_name::get<T0>();
        if (0x2::table::contains<0x1::type_name::TypeName, StakeParameters>(&arg1.stake_parameters_by_token, v0)) {
            let v1 = 0x2::table::borrow_mut<0x1::type_name::TypeName, StakeParameters>(&mut arg1.stake_parameters_by_token, v0);
            v1.epoch = arg3;
            v1.stake_limit = arg4;
            v1.cooldown = arg5;
        } else {
            let v2 = StakeParameters{
                epoch              : arg3,
                stake_limit        : arg4,
                cooldown           : arg5,
                total_staked       : 0,
                total_cooling_down : 0,
            };
            0x2::table::add<0x1::type_name::TypeName, StakeParameters>(&mut arg1.stake_parameters_by_token, v0, v2);
        };
        let v3 = StakeParametersUpdated{
            token       : v0,
            epoch       : arg3,
            stake_limit : arg4,
            cooldown    : arg5,
        };
        0x2::event::emit<StakeParametersUpdated>(v3);
    }

    public fun withdraw<T0>(arg0: &mut DeUSDLPStakingManagement, arg1: &0xc1997c630ec588f8600efb6f983d509dc4c67b5aabc8bfd92e1d8d4bba22ec78::config::GlobalConfig, arg2: u64, arg3: &0x2::clock::Clock, arg4: &mut 0x2::tx_context::TxContext) {
        0xc1997c630ec588f8600efb6f983d509dc4c67b5aabc8bfd92e1d8d4bba22ec78::config::check_package_version(arg1);
        assert!(arg2 > 0, 1);
        let v0 = 0x1::type_name::get<T0>();
        let v1 = 0x2::tx_context::sender(arg4);
        assert!(0x2::table::contains<address, 0x2::table::Table<0x1::type_name::TypeName, StakeData>>(&arg0.stakes, v1), 2);
        let v2 = 0x2::table::borrow_mut<address, 0x2::table::Table<0x1::type_name::TypeName, StakeData>>(&mut arg0.stakes, v1);
        assert!(0x2::table::contains<0x1::type_name::TypeName, StakeData>(v2, v0), 2);
        let v3 = 0x2::table::borrow_mut<0x1::type_name::TypeName, StakeData>(v2, v0);
        assert!(v3.cooling_down_amount >= arg2, 1);
        assert!(0xc1997c630ec588f8600efb6f983d509dc4c67b5aabc8bfd92e1d8d4bba22ec78::clock_utils::timestamp_seconds(arg3) >= v3.cooldown_start_timestamp + 0x2::table::borrow<0x1::type_name::TypeName, StakeParameters>(&arg0.stake_parameters_by_token, v0).cooldown, 7);
        v3.cooling_down_amount = v3.cooling_down_amount - arg2;
        let v4 = 0x2::table::borrow_mut<0x1::type_name::TypeName, StakeParameters>(&mut arg0.stake_parameters_by_token, v0);
        v4.total_cooling_down = v4.total_cooling_down - arg2;
        let v5 = get_or_create_balance_store<T0>(arg0);
        0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(0x2::coin::from_balance<T0>(0x2::balance::split<T0>(v5, arg2), arg4), v1);
        check_invariant<T0>(arg0);
        let v6 = Withdraw{
            user   : v1,
            token  : v0,
            amount : arg2,
        };
        0x2::event::emit<Withdraw>(v6);
    }

    // decompiled from Move bytecode v6
}

