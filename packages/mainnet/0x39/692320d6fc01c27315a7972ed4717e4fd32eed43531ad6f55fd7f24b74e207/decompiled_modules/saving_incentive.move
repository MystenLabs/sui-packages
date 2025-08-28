module 0x39692320d6fc01c27315a7972ed4717e4fd32eed43531ad6f55fd7f24b74e207::saving_incentive {
    struct SavingPoolIncentives has drop {
        dummy_field: bool,
    }

    struct Registry has key {
        id: 0x2::object::UID,
        reward_manager_ids: 0x2::vec_map::VecMap<0x1::type_name::TypeName, 0x2::object::ID>,
    }

    struct RewardManager<phantom T0> has store, key {
        id: 0x2::object::UID,
        rewarder_ids: 0x2::vec_set::VecSet<0x2::object::ID>,
    }

    struct StakeData<phantom T0> has store {
        unit: 0x665188033384920a5bb5dcfb2ef21f54b4568d08b431718b97e02e5c184b92cc::double::Double,
        reward: 0x2::balance::Balance<T0>,
    }

    struct RewarderKey<phantom T0> has copy, drop, store {
        dummy_field: bool,
    }

    struct Rewarder<phantom T0, phantom T1> has store, key {
        id: 0x2::object::UID,
        source: 0x2::balance::Balance<T1>,
        pool: 0x2::balance::Balance<T1>,
        flow_rate: 0x665188033384920a5bb5dcfb2ef21f54b4568d08b431718b97e02e5c184b92cc::double::Double,
        total_stake: u64,
        stake_table: 0x2::table::Table<address, StakeData<T1>>,
        unit: 0x665188033384920a5bb5dcfb2ef21f54b4568d08b431718b97e02e5c184b92cc::double::Double,
        last_update_timestamp: u64,
    }

    struct DepositResponseChecker<phantom T0> {
        rewarder_ids: 0x2::vec_set::VecSet<0x2::object::ID>,
        response: 0x872d08a70db3db498aa7853276acea8091fdd9871b2d86bc8dcb8524526df622::saving::DepositResponse<T0>,
    }

    struct WithdrawResponseChecker<phantom T0> {
        rewarder_ids: 0x2::vec_set::VecSet<0x2::object::ID>,
        response: 0x872d08a70db3db498aa7853276acea8091fdd9871b2d86bc8dcb8524526df622::saving::WithdrawResponse<T0>,
    }

    public fun account_exists<T0, T1>(arg0: &Rewarder<T0, T1>, arg1: address) : bool {
        0x2::table::contains<address, StakeData<T1>>(&arg0.stake_table, arg1)
    }

    public fun add_reward<T0, T1>(arg0: &mut RewardManager<T0>, arg1: &0xe14726c336e81b32328e92afc37345d159f5b550b09fa92bd43640cfdd0a0cfd::admin::AdminCap, arg2: &0x39692320d6fc01c27315a7972ed4717e4fd32eed43531ad6f55fd7f24b74e207::incentive_config::GlobalConfig, arg3: &0x872d08a70db3db498aa7853276acea8091fdd9871b2d86bc8dcb8524526df622::saving::SavingPool<T0>, arg4: u64, arg5: u64, arg6: u64, arg7: &0x2::clock::Clock, arg8: &mut 0x2::tx_context::TxContext) {
        0x39692320d6fc01c27315a7972ed4717e4fd32eed43531ad6f55fd7f24b74e207::incentive_config::assert_valid_package_version(arg2);
        if (arg6 < 0x2::clock::timestamp_ms(arg7)) {
            err_invalid_timestamp();
        };
        assert!(arg5 > 0, 301);
        let v0 = Rewarder<T0, T1>{
            id                    : 0x2::object::new(arg8),
            source                : 0x2::balance::zero<T1>(),
            pool                  : 0x2::balance::zero<T1>(),
            flow_rate             : 0x665188033384920a5bb5dcfb2ef21f54b4568d08b431718b97e02e5c184b92cc::double::from_fraction(arg4, arg5),
            total_stake           : 0x872d08a70db3db498aa7853276acea8091fdd9871b2d86bc8dcb8524526df622::saving::lp_supply<T0>(arg3),
            stake_table           : 0x2::table::new<address, StakeData<T1>>(arg8),
            unit                  : 0x665188033384920a5bb5dcfb2ef21f54b4568d08b431718b97e02e5c184b92cc::double::from(0),
            last_update_timestamp : arg6,
        };
        0x39692320d6fc01c27315a7972ed4717e4fd32eed43531ad6f55fd7f24b74e207::saving_incentive_events::emit_add_rewarder<T0, T1>(0x2::object::id<RewardManager<T0>>(arg0), 0x2::object::id<Rewarder<T0, T1>>(&v0));
        0x2::vec_set::insert<0x2::object::ID>(&mut arg0.rewarder_ids, 0x2::object::id<Rewarder<T0, T1>>(&v0));
        let v1 = RewarderKey<T1>{dummy_field: false};
        0x2::dynamic_field::add<RewarderKey<T1>, Rewarder<T0, T1>>(&mut arg0.id, v1, v0);
    }

    public fun claim<T0, T1>(arg0: &mut RewardManager<T0>, arg1: &0x39692320d6fc01c27315a7972ed4717e4fd32eed43531ad6f55fd7f24b74e207::incentive_config::GlobalConfig, arg2: &0x872d08a70db3db498aa7853276acea8091fdd9871b2d86bc8dcb8524526df622::saving::SavingPool<T0>, arg3: &0x665188033384920a5bb5dcfb2ef21f54b4568d08b431718b97e02e5c184b92cc::account::AccountRequest, arg4: &0x2::clock::Clock, arg5: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<T1> {
        0x39692320d6fc01c27315a7972ed4717e4fd32eed43531ad6f55fd7f24b74e207::incentive_config::assert_valid_package_version(arg1);
        let v0 = 0x665188033384920a5bb5dcfb2ef21f54b4568d08b431718b97e02e5c184b92cc::account::request_address(arg3);
        let v1 = 0x872d08a70db3db498aa7853276acea8091fdd9871b2d86bc8dcb8524526df622::saving::position_locker<T0>(arg2);
        if (0x2::vec_set::contains<address>(&v1, &v0)) {
            err_ongoing_action();
        };
        let v2 = get_rewarder_mut<T0, T1>(arg0);
        if (0x2::clock::timestamp_ms(arg4) < v2.last_update_timestamp) {
            return 0x2::coin::zero<T1>(arg5)
        };
        settle_pool_reward<T0, T1>(v2, arg4);
        settle_account_reward<T0, T1>(v2, v0, 0x872d08a70db3db498aa7853276acea8091fdd9871b2d86bc8dcb8524526df622::saving::lp_balance_of<T0>(arg2, v0), arg4);
        let v3 = 0x2::coin::from_balance<T1>(0x2::balance::withdraw_all<T1>(&mut 0x2::table::borrow_mut<address, StakeData<T1>>(&mut v2.stake_table, v0).reward), arg5);
        0x39692320d6fc01c27315a7972ed4717e4fd32eed43531ad6f55fd7f24b74e207::saving_incentive_events::emit_claim_reward<T0, T1>(0x39692320d6fc01c27315a7972ed4717e4fd32eed43531ad6f55fd7f24b74e207::memo::saving_pool(), 0x2::object::id<Rewarder<T0, T1>>(v2), v0, 0x2::coin::value<T1>(&v3));
        v3
    }

    public fun destroy_deposit_checker<T0>(arg0: DepositResponseChecker<T0>, arg1: &0x39692320d6fc01c27315a7972ed4717e4fd32eed43531ad6f55fd7f24b74e207::incentive_config::GlobalConfig) : 0x872d08a70db3db498aa7853276acea8091fdd9871b2d86bc8dcb8524526df622::saving::DepositResponse<T0> {
        0x39692320d6fc01c27315a7972ed4717e4fd32eed43531ad6f55fd7f24b74e207::incentive_config::assert_valid_package_version(arg1);
        let DepositResponseChecker {
            rewarder_ids : v0,
            response     : v1,
        } = arg0;
        let v2 = v1;
        let v3 = v0;
        if (!0x2::vec_set::is_empty<0x2::object::ID>(&v3)) {
            err_missing_rewarder_check();
        };
        let v4 = SavingPoolIncentives{dummy_field: false};
        0x872d08a70db3db498aa7853276acea8091fdd9871b2d86bc8dcb8524526df622::saving::add_deposit_witness<T0, SavingPoolIncentives>(&mut v2, v4);
        v2
    }

    public fun destroy_withdraw_checker<T0>(arg0: WithdrawResponseChecker<T0>, arg1: &0x39692320d6fc01c27315a7972ed4717e4fd32eed43531ad6f55fd7f24b74e207::incentive_config::GlobalConfig) : 0x872d08a70db3db498aa7853276acea8091fdd9871b2d86bc8dcb8524526df622::saving::WithdrawResponse<T0> {
        0x39692320d6fc01c27315a7972ed4717e4fd32eed43531ad6f55fd7f24b74e207::incentive_config::assert_valid_package_version(arg1);
        let WithdrawResponseChecker {
            rewarder_ids : v0,
            response     : v1,
        } = arg0;
        let v2 = v1;
        let v3 = v0;
        if (!0x2::vec_set::is_empty<0x2::object::ID>(&v3)) {
            err_missing_rewarder_check();
        };
        let v4 = SavingPoolIncentives{dummy_field: false};
        0x872d08a70db3db498aa7853276acea8091fdd9871b2d86bc8dcb8524526df622::saving::add_withdraw_witness<T0, SavingPoolIncentives>(&mut v2, v4);
        v2
    }

    fun err_incentive_already_start() {
        abort 304
    }

    fun err_invalid_reward() {
        abort 301
    }

    fun err_invalid_timestamp() {
        abort 303
    }

    fun err_missing_rewarder_check() {
        abort 302
    }

    fun err_ongoing_action() {
        abort 304
    }

    public fun get_rewarder<T0, T1>(arg0: &RewardManager<T0>) : &Rewarder<T0, T1> {
        let v0 = RewarderKey<T1>{dummy_field: false};
        0x2::dynamic_field::borrow<RewarderKey<T1>, Rewarder<T0, T1>>(&arg0.id, v0)
    }

    fun get_rewarder_mut<T0, T1>(arg0: &mut RewardManager<T0>) : &mut Rewarder<T0, T1> {
        let v0 = RewarderKey<T1>{dummy_field: false};
        0x2::dynamic_field::borrow_mut<RewarderKey<T1>, Rewarder<T0, T1>>(&mut arg0.id, v0)
    }

    fun init(arg0: &mut 0x2::tx_context::TxContext) {
        let v0 = Registry{
            id                 : 0x2::object::new(arg0),
            reward_manager_ids : 0x2::vec_map::empty<0x1::type_name::TypeName, 0x2::object::ID>(),
        };
        0x2::transfer::share_object<Registry>(v0);
    }

    public fun new_checker_for_deposit_action<T0>(arg0: &RewardManager<T0>, arg1: &0x39692320d6fc01c27315a7972ed4717e4fd32eed43531ad6f55fd7f24b74e207::incentive_config::GlobalConfig, arg2: 0x872d08a70db3db498aa7853276acea8091fdd9871b2d86bc8dcb8524526df622::saving::DepositResponse<T0>) : DepositResponseChecker<T0> {
        0x39692320d6fc01c27315a7972ed4717e4fd32eed43531ad6f55fd7f24b74e207::incentive_config::assert_valid_package_version(arg1);
        DepositResponseChecker<T0>{
            rewarder_ids : arg0.rewarder_ids,
            response     : arg2,
        }
    }

    public fun new_checker_for_withdraw_action<T0>(arg0: &RewardManager<T0>, arg1: &0x39692320d6fc01c27315a7972ed4717e4fd32eed43531ad6f55fd7f24b74e207::incentive_config::GlobalConfig, arg2: 0x872d08a70db3db498aa7853276acea8091fdd9871b2d86bc8dcb8524526df622::saving::WithdrawResponse<T0>) : WithdrawResponseChecker<T0> {
        0x39692320d6fc01c27315a7972ed4717e4fd32eed43531ad6f55fd7f24b74e207::incentive_config::assert_valid_package_version(arg1);
        WithdrawResponseChecker<T0>{
            rewarder_ids : arg0.rewarder_ids,
            response     : arg2,
        }
    }

    public fun new_reward_manager<T0>(arg0: &mut Registry, arg1: &0x39692320d6fc01c27315a7972ed4717e4fd32eed43531ad6f55fd7f24b74e207::incentive_config::GlobalConfig, arg2: &0xe14726c336e81b32328e92afc37345d159f5b550b09fa92bd43640cfdd0a0cfd::admin::AdminCap, arg3: &0x872d08a70db3db498aa7853276acea8091fdd9871b2d86bc8dcb8524526df622::saving::SavingPool<T0>, arg4: &mut 0x2::tx_context::TxContext) : RewardManager<T0> {
        0x39692320d6fc01c27315a7972ed4717e4fd32eed43531ad6f55fd7f24b74e207::incentive_config::assert_valid_package_version(arg1);
        let v0 = 0x2::object::new(arg4);
        0x39692320d6fc01c27315a7972ed4717e4fd32eed43531ad6f55fd7f24b74e207::saving_incentive_events::emit_create_saving_pool_reward_manager<T0>(0x2::object::uid_to_inner(&v0));
        0x2::vec_map::insert<0x1::type_name::TypeName, 0x2::object::ID>(&mut arg0.reward_manager_ids, 0x1::type_name::get<T0>(), 0x2::object::uid_to_inner(&v0));
        RewardManager<T0>{
            id           : v0,
            rewarder_ids : 0x2::vec_set::empty<0x2::object::ID>(),
        }
    }

    public fun new_reward_manager_and_share<T0>(arg0: &mut Registry, arg1: &0x39692320d6fc01c27315a7972ed4717e4fd32eed43531ad6f55fd7f24b74e207::incentive_config::GlobalConfig, arg2: &0xe14726c336e81b32328e92afc37345d159f5b550b09fa92bd43640cfdd0a0cfd::admin::AdminCap, arg3: &0x872d08a70db3db498aa7853276acea8091fdd9871b2d86bc8dcb8524526df622::saving::SavingPool<T0>, arg4: &mut 0x2::tx_context::TxContext) {
        0x2::transfer::public_share_object<RewardManager<T0>>(new_reward_manager<T0>(arg0, arg1, arg2, arg3, arg4));
    }

    public fun realtime_reward_amount<T0, T1>(arg0: &Rewarder<T0, T1>, arg1: &0x872d08a70db3db498aa7853276acea8091fdd9871b2d86bc8dcb8524526df622::saving::SavingPool<T0>, arg2: address, arg3: &0x2::clock::Clock) : u64 {
        let v0 = if (account_exists<T0, T1>(arg0, arg2)) {
            0x2::balance::value<T1>(&0x2::table::borrow<address, StakeData<T1>>(&arg0.stake_table, arg2).reward)
        } else {
            0
        };
        v0 + unsettled_reward_amount<T0, T1>(arg0, arg2, 0x872d08a70db3db498aa7853276acea8091fdd9871b2d86bc8dcb8524526df622::saving::lp_balance_of<T0>(arg1, arg2), arg3)
    }

    fun realtime_reward_release_and_unit<T0, T1>(arg0: &Rewarder<T0, T1>, arg1: &0x2::clock::Clock) : (u64, 0x665188033384920a5bb5dcfb2ef21f54b4568d08b431718b97e02e5c184b92cc::double::Double) {
        let v0 = 0x2::clock::timestamp_ms(arg1);
        let v1 = arg0.last_update_timestamp;
        if (v0 > v1 && arg0.total_stake > 0) {
            let v4 = 0x1::u64::min(0x665188033384920a5bb5dcfb2ef21f54b4568d08b431718b97e02e5c184b92cc::double::floor(0x665188033384920a5bb5dcfb2ef21f54b4568d08b431718b97e02e5c184b92cc::double::mul_u64(arg0.flow_rate, v0 - v1)), 0x2::balance::value<T1>(&arg0.source));
            (v4, 0x665188033384920a5bb5dcfb2ef21f54b4568d08b431718b97e02e5c184b92cc::double::add(arg0.unit, 0x665188033384920a5bb5dcfb2ef21f54b4568d08b431718b97e02e5c184b92cc::double::from_fraction(v4, arg0.total_stake)))
        } else {
            (0, arg0.unit)
        }
    }

    public fun reward_manager_ids(arg0: &Registry) : &0x2::vec_map::VecMap<0x1::type_name::TypeName, 0x2::object::ID> {
        &arg0.reward_manager_ids
    }

    public fun reward_of<T0, T1>(arg0: &Rewarder<T0, T1>, arg1: address) : u64 {
        0x2::balance::value<T1>(&0x2::table::borrow<address, StakeData<T1>>(&arg0.stake_table, arg1).reward)
    }

    public fun rewarder_flow_rate<T0, T1>(arg0: &Rewarder<T0, T1>) : 0x665188033384920a5bb5dcfb2ef21f54b4568d08b431718b97e02e5c184b92cc::double::Double {
        arg0.flow_rate
    }

    public fun rewarder_ids<T0>(arg0: &RewardManager<T0>) : &0x2::vec_set::VecSet<0x2::object::ID> {
        &arg0.rewarder_ids
    }

    public fun rewarder_last_update_timestamp<T0, T1>(arg0: &Rewarder<T0, T1>) : u64 {
        arg0.last_update_timestamp
    }

    public fun rewarder_pool<T0, T1>(arg0: &Rewarder<T0, T1>) : u64 {
        0x2::balance::value<T1>(&arg0.pool)
    }

    public fun rewarder_source<T0, T1>(arg0: &Rewarder<T0, T1>) : u64 {
        0x2::balance::value<T1>(&arg0.source)
    }

    public fun rewarder_stake_table<T0, T1>(arg0: &Rewarder<T0, T1>) : &0x2::table::Table<address, StakeData<T1>> {
        &arg0.stake_table
    }

    public fun rewarder_total_stake<T0, T1>(arg0: &Rewarder<T0, T1>) : u64 {
        arg0.total_stake
    }

    public fun rewarder_unit<T0, T1>(arg0: &Rewarder<T0, T1>) : 0x665188033384920a5bb5dcfb2ef21f54b4568d08b431718b97e02e5c184b92cc::double::Double {
        arg0.unit
    }

    fun settle_account_reward<T0, T1>(arg0: &mut Rewarder<T0, T1>, arg1: address, arg2: u64, arg3: &0x2::clock::Clock) : u64 {
        let v0 = 0x1::u64::min(unsettled_reward_amount<T0, T1>(arg0, arg1, arg2, arg3), 0x2::balance::value<T1>(&arg0.pool));
        let v1 = 0x2::balance::split<T1>(&mut arg0.pool, v0);
        if (account_exists<T0, T1>(arg0, arg1)) {
            let v3 = 0x2::table::borrow_mut<address, StakeData<T1>>(&mut arg0.stake_table, arg1);
            v3.unit = arg0.unit;
            0x2::balance::join<T1>(&mut v3.reward, v1);
            v0
        } else {
            let v4 = StakeData<T1>{
                unit   : arg0.unit,
                reward : v1,
            };
            0x2::table::add<address, StakeData<T1>>(&mut arg0.stake_table, arg1, v4);
            0x2::balance::value<T1>(&v1)
        }
    }

    fun settle_pool_reward<T0, T1>(arg0: &mut Rewarder<T0, T1>, arg1: &0x2::clock::Clock) {
        let (v0, v1) = realtime_reward_release_and_unit<T0, T1>(arg0, arg1);
        arg0.last_update_timestamp = 0x2::clock::timestamp_ms(arg1);
        arg0.unit = v1;
        0x2::balance::join<T1>(&mut arg0.pool, 0x2::balance::split<T1>(&mut arg0.source, v0));
    }

    public fun supply<T0, T1>(arg0: &mut RewardManager<T0>, arg1: 0x2::coin::Coin<T1>) {
        let v0 = get_rewarder_mut<T0, T1>(arg0);
        0x39692320d6fc01c27315a7972ed4717e4fd32eed43531ad6f55fd7f24b74e207::saving_incentive_events::emit_source_changed<T0, T1>(0x2::object::id<Rewarder<T0, T1>>(v0), 0x39692320d6fc01c27315a7972ed4717e4fd32eed43531ad6f55fd7f24b74e207::memo::saving_pool(), 0x2::coin::value<T1>(&arg1), true);
        0x2::balance::join<T1>(&mut v0.source, 0x2::coin::into_balance<T1>(arg1));
    }

    public fun unit_of<T0, T1>(arg0: &Rewarder<T0, T1>, arg1: address) : 0x665188033384920a5bb5dcfb2ef21f54b4568d08b431718b97e02e5c184b92cc::double::Double {
        0x2::table::borrow<address, StakeData<T1>>(&arg0.stake_table, arg1).unit
    }

    fun unsettled_reward_amount<T0, T1>(arg0: &Rewarder<T0, T1>, arg1: address, arg2: u64, arg3: &0x2::clock::Clock) : u64 {
        let (_, v1) = realtime_reward_release_and_unit<T0, T1>(arg0, arg3);
        let v2 = if (account_exists<T0, T1>(arg0, arg1)) {
            0x2::table::borrow<address, StakeData<T1>>(&arg0.stake_table, arg1).unit
        } else {
            0x665188033384920a5bb5dcfb2ef21f54b4568d08b431718b97e02e5c184b92cc::double::from(0)
        };
        0x665188033384920a5bb5dcfb2ef21f54b4568d08b431718b97e02e5c184b92cc::double::floor(0x665188033384920a5bb5dcfb2ef21f54b4568d08b431718b97e02e5c184b92cc::double::mul_u64(0x665188033384920a5bb5dcfb2ef21f54b4568d08b431718b97e02e5c184b92cc::double::sub(v1, v2), arg2))
    }

    public fun update_deposit_action<T0, T1>(arg0: &mut DepositResponseChecker<T0>, arg1: &0x39692320d6fc01c27315a7972ed4717e4fd32eed43531ad6f55fd7f24b74e207::incentive_config::GlobalConfig, arg2: &mut RewardManager<T0>, arg3: &0x872d08a70db3db498aa7853276acea8091fdd9871b2d86bc8dcb8524526df622::saving::SavingPool<T0>, arg4: &0x2::clock::Clock) {
        0x39692320d6fc01c27315a7972ed4717e4fd32eed43531ad6f55fd7f24b74e207::incentive_config::assert_valid_package_version(arg1);
        let v0 = get_rewarder_mut<T0, T1>(arg2);
        let v1 = 0x2::object::id<Rewarder<T0, T1>>(v0);
        if (!0x2::vec_set::contains<0x2::object::ID>(&arg0.rewarder_ids, &v1)) {
            err_invalid_reward();
        };
        if (0x2::clock::timestamp_ms(arg4) >= v0.last_update_timestamp) {
            settle_pool_reward<T0, T1>(v0, arg4);
            settle_account_reward<T0, T1>(v0, 0x872d08a70db3db498aa7853276acea8091fdd9871b2d86bc8dcb8524526df622::saving::deposit_response_account<T0>(&arg0.response), 0x872d08a70db3db498aa7853276acea8091fdd9871b2d86bc8dcb8524526df622::saving::deposit_response_prev_lp_balance<T0>(&arg0.response), arg4);
        };
        v0.total_stake = 0x872d08a70db3db498aa7853276acea8091fdd9871b2d86bc8dcb8524526df622::saving::lp_supply<T0>(arg3);
        0x2::vec_set::remove<0x2::object::ID>(&mut arg0.rewarder_ids, &v1);
    }

    public fun update_flow_rate<T0, T1>(arg0: &mut RewardManager<T0>, arg1: &0x39692320d6fc01c27315a7972ed4717e4fd32eed43531ad6f55fd7f24b74e207::incentive_config::GlobalConfig, arg2: &0x2::clock::Clock, arg3: u64, arg4: u64, arg5: &0x665188033384920a5bb5dcfb2ef21f54b4568d08b431718b97e02e5c184b92cc::account::AccountRequest) {
        0x39692320d6fc01c27315a7972ed4717e4fd32eed43531ad6f55fd7f24b74e207::incentive_config::assert_valid_package_version(arg1);
        0x39692320d6fc01c27315a7972ed4717e4fd32eed43531ad6f55fd7f24b74e207::incentive_config::assert_sender_is_manager(arg1, arg5);
        assert!(arg4 > 0, 301);
        let v0 = get_rewarder_mut<T0, T1>(arg0);
        settle_pool_reward<T0, T1>(v0, arg2);
        let v1 = 0x665188033384920a5bb5dcfb2ef21f54b4568d08b431718b97e02e5c184b92cc::double::from_fraction(arg3, arg4);
        0x39692320d6fc01c27315a7972ed4717e4fd32eed43531ad6f55fd7f24b74e207::saving_incentive_events::emit_flow_rate_changed<T0, T1>(0x39692320d6fc01c27315a7972ed4717e4fd32eed43531ad6f55fd7f24b74e207::memo::saving_pool(), 0x2::object::id<Rewarder<T0, T1>>(v0), 0x665188033384920a5bb5dcfb2ef21f54b4568d08b431718b97e02e5c184b92cc::double::to_scaled_val(v1));
        v0.flow_rate = v1;
    }

    public fun update_reward_timestamp<T0, T1>(arg0: &mut RewardManager<T0>, arg1: &0x39692320d6fc01c27315a7972ed4717e4fd32eed43531ad6f55fd7f24b74e207::incentive_config::GlobalConfig, arg2: &0x2::clock::Clock, arg3: u64, arg4: &0x665188033384920a5bb5dcfb2ef21f54b4568d08b431718b97e02e5c184b92cc::account::AccountRequest) {
        if (arg3 < 0x2::clock::timestamp_ms(arg2)) {
            err_invalid_timestamp();
        };
        0x39692320d6fc01c27315a7972ed4717e4fd32eed43531ad6f55fd7f24b74e207::incentive_config::assert_valid_package_version(arg1);
        0x39692320d6fc01c27315a7972ed4717e4fd32eed43531ad6f55fd7f24b74e207::incentive_config::assert_sender_is_manager(arg1, arg4);
        let v0 = get_rewarder_mut<T0, T1>(arg0);
        if (0x2::clock::timestamp_ms(arg2) >= v0.last_update_timestamp) {
            err_incentive_already_start();
        };
        settle_pool_reward<T0, T1>(v0, arg2);
        v0.last_update_timestamp = arg3;
        0x39692320d6fc01c27315a7972ed4717e4fd32eed43531ad6f55fd7f24b74e207::saving_incentive_events::emit_reward_timestamp_changed<T0, T1>(0x2::object::id<Rewarder<T0, T1>>(v0), 0x39692320d6fc01c27315a7972ed4717e4fd32eed43531ad6f55fd7f24b74e207::memo::saving_pool(), arg3);
    }

    public fun update_withdraw_action<T0, T1>(arg0: &mut WithdrawResponseChecker<T0>, arg1: &0x39692320d6fc01c27315a7972ed4717e4fd32eed43531ad6f55fd7f24b74e207::incentive_config::GlobalConfig, arg2: &mut RewardManager<T0>, arg3: &0x872d08a70db3db498aa7853276acea8091fdd9871b2d86bc8dcb8524526df622::saving::SavingPool<T0>, arg4: &0x2::clock::Clock) {
        0x39692320d6fc01c27315a7972ed4717e4fd32eed43531ad6f55fd7f24b74e207::incentive_config::assert_valid_package_version(arg1);
        let v0 = get_rewarder_mut<T0, T1>(arg2);
        let v1 = 0x2::object::id<Rewarder<T0, T1>>(v0);
        if (!0x2::vec_set::contains<0x2::object::ID>(&arg0.rewarder_ids, &v1)) {
            err_invalid_reward();
        };
        if (0x2::clock::timestamp_ms(arg4) >= v0.last_update_timestamp) {
            settle_pool_reward<T0, T1>(v0, arg4);
            settle_account_reward<T0, T1>(v0, 0x872d08a70db3db498aa7853276acea8091fdd9871b2d86bc8dcb8524526df622::saving::withdraw_response_account<T0>(&arg0.response), 0x872d08a70db3db498aa7853276acea8091fdd9871b2d86bc8dcb8524526df622::saving::withdraw_response_prev_lp_balance<T0>(&arg0.response), arg4);
        };
        v0.total_stake = 0x872d08a70db3db498aa7853276acea8091fdd9871b2d86bc8dcb8524526df622::saving::lp_supply<T0>(arg3);
        0x2::vec_set::remove<0x2::object::ID>(&mut arg0.rewarder_ids, &v1);
    }

    public fun withdraw_from_source<T0, T1>(arg0: &mut RewardManager<T0>, arg1: &0x39692320d6fc01c27315a7972ed4717e4fd32eed43531ad6f55fd7f24b74e207::incentive_config::GlobalConfig, arg2: &0xe14726c336e81b32328e92afc37345d159f5b550b09fa92bd43640cfdd0a0cfd::admin::AdminCap, arg3: &0x2::clock::Clock, arg4: u64, arg5: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<T1> {
        0x39692320d6fc01c27315a7972ed4717e4fd32eed43531ad6f55fd7f24b74e207::incentive_config::assert_valid_package_version(arg1);
        let v0 = get_rewarder_mut<T0, T1>(arg0);
        settle_pool_reward<T0, T1>(v0, arg3);
        0x39692320d6fc01c27315a7972ed4717e4fd32eed43531ad6f55fd7f24b74e207::saving_incentive_events::emit_source_changed<T0, T1>(0x2::object::id<Rewarder<T0, T1>>(v0), 0x39692320d6fc01c27315a7972ed4717e4fd32eed43531ad6f55fd7f24b74e207::memo::saving_pool(), arg4, false);
        0x2::coin::from_balance<T1>(0x2::balance::split<T1>(&mut v0.source, arg4), arg5)
    }

    // decompiled from Move bytecode v6
}

