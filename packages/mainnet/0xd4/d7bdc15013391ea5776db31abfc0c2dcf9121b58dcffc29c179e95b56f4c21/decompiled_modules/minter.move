module 0xd4d7bdc15013391ea5776db31abfc0c2dcf9121b58dcffc29c179e95b56f4c21::minter {
    struct AdminCap has store, key {
        id: 0x2::object::UID,
    }

    struct DistributeGovernorCap has store, key {
        id: 0x2::object::UID,
    }

    struct MINTER has drop {
        dummy_field: bool,
    }

    struct EventUpdateEpoch has copy, drop, store {
        new_period: u64,
        finished_epoch_emissions: u64,
        finished_epoch_growth_rebase: u64,
    }

    struct EventReviveGauge has copy, drop, store {
        id: 0x2::object::ID,
    }

    struct EventKillGauge has copy, drop, store {
        id: 0x2::object::ID,
    }

    struct EventPauseEmission has copy, drop, store {
        dummy_field: bool,
    }

    struct EventUnpauseEmission has copy, drop, store {
        dummy_field: bool,
    }

    struct EventGrantAdmin has copy, drop, store {
        who: address,
        admin_cap: 0x2::object::ID,
    }

    struct EventGrantDistributeGovernor has copy, drop, store {
        who: address,
        distribute_governor_cap: 0x2::object::ID,
    }

    struct EventDistributeGauge has copy, drop, store {
        gauge_id: 0x2::object::ID,
        pool_id: 0x2::object::ID,
        o_sail_type: 0x1::type_name::TypeName,
        next_epoch_emissions_usd: u64,
    }

    struct TimeLockedSailMint has store, key {
        id: 0x2::object::UID,
        amount: u64,
        unlock_time: u64,
    }

    struct TimeLockedOSailMint<phantom T0> has store, key {
        id: 0x2::object::UID,
        amount: u64,
        unlock_time: u64,
    }

    struct Minter<phantom T0> has store, key {
        id: 0x2::object::UID,
        revoked_admins: 0x2::vec_set::VecSet<0x2::object::ID>,
        revoked_distribute_governors: 0x2::vec_set::VecSet<0x2::object::ID>,
        paused: bool,
        activated_at: u64,
        active_period: u64,
        current_epoch_o_sail: 0x1::option::Option<0x1::type_name::TypeName>,
        last_epoch_update_time: u64,
        sail_cap: 0x1::option::Option<0x2::coin::TreasuryCap<T0>>,
        o_sail_caps: 0x2::bag::Bag,
        o_sail_minted_supply: u64,
        o_sail_expiry_dates: 0x2::table::Table<0x1::type_name::TypeName, u64>,
        team_emission_rate: u64,
        protocol_fee_rate: u64,
        team_wallet: address,
        reward_distributor_cap: 0x1::option::Option<0xd4d7bdc15013391ea5776db31abfc0c2dcf9121b58dcffc29c179e95b56f4c21::reward_distributor_cap::RewardDistributorCap>,
        distribute_cap: 0x1::option::Option<0xd4d7bdc15013391ea5776db31abfc0c2dcf9121b58dcffc29c179e95b56f4c21::distribute_cap::DistributeCap>,
        whitelisted_pools: 0x2::vec_set::VecSet<0x2::object::ID>,
        exercise_fee_team_balances: 0x2::bag::Bag,
        gauge_epoch_emissions_usd: 0x2::table::Table<0x2::object::ID, u64>,
        gauge_active_period: 0x2::table::Table<0x2::object::ID, u64>,
        gauge_epoch_count: 0x2::table::Table<0x2::object::ID, u64>,
        total_epoch_emissions_usd: 0x2::table::Table<u64, u64>,
        total_epoch_o_sail_emissions: 0x2::table::Table<u64, u64>,
        distribution_config: 0x2::object::ID,
    }

    public fun total_supply<T0>(arg0: &Minter<T0>) : u64 {
        sail_total_supply<T0>(arg0) + arg0.o_sail_minted_supply
    }

    public fun set_o_sail_price_aggregator<T0>(arg0: &mut Minter<T0>, arg1: &AdminCap, arg2: &mut 0xd4d7bdc15013391ea5776db31abfc0c2dcf9121b58dcffc29c179e95b56f4c21::distribution_config::DistributionConfig, arg3: &0xc3c7e6eb7202e9fb0389a2f7542b91cc40e4f7a33c02554fec11c4c92f938ea3::aggregator::Aggregator) {
        check_admin<T0>(arg0, arg1);
        assert!(is_valid_distribution_config<T0>(arg0, arg2), 615700294268918300);
        0xd4d7bdc15013391ea5776db31abfc0c2dcf9121b58dcffc29c179e95b56f4c21::distribution_config::set_o_sail_price_aggregator(arg2, arg3);
    }

    public fun activate<T0, T1>(arg0: &mut Minter<T0>, arg1: &mut 0xd4d7bdc15013391ea5776db31abfc0c2dcf9121b58dcffc29c179e95b56f4c21::voter::Voter, arg2: &AdminCap, arg3: &mut 0xd4d7bdc15013391ea5776db31abfc0c2dcf9121b58dcffc29c179e95b56f4c21::reward_distributor::RewardDistributor<T0>, arg4: 0x2::coin::TreasuryCap<T1>, arg5: &0x2::clock::Clock, arg6: &mut 0x2::tx_context::TxContext) {
        check_admin<T0>(arg0, arg2);
        assert!(!is_paused<T0>(arg0), 996659030249798900);
        assert!(!is_active<T0>(arg0, arg5), 922337310630222234);
        assert!(0x1::option::is_some<0xd4d7bdc15013391ea5776db31abfc0c2dcf9121b58dcffc29c179e95b56f4c21::reward_distributor_cap::RewardDistributorCap>(&arg0.reward_distributor_cap), 922337311059823823);
        update_o_sail_token<T0, T1>(arg0, arg4, arg5);
        0xd4d7bdc15013391ea5776db31abfc0c2dcf9121b58dcffc29c179e95b56f4c21::voter::notify_epoch_token<T1>(arg1, 0x1::option::borrow<0xd4d7bdc15013391ea5776db31abfc0c2dcf9121b58dcffc29c179e95b56f4c21::distribute_cap::DistributeCap>(&arg0.distribute_cap), arg6);
        let v0 = 0xd4d7bdc15013391ea5776db31abfc0c2dcf9121b58dcffc29c179e95b56f4c21::common::current_timestamp(arg5);
        arg0.activated_at = v0;
        arg0.active_period = 0xd4d7bdc15013391ea5776db31abfc0c2dcf9121b58dcffc29c179e95b56f4c21::common::to_period(arg0.activated_at);
        arg0.last_epoch_update_time = v0;
        0xd4d7bdc15013391ea5776db31abfc0c2dcf9121b58dcffc29c179e95b56f4c21::reward_distributor::start<T0>(arg3, 0x1::option::borrow<0xd4d7bdc15013391ea5776db31abfc0c2dcf9121b58dcffc29c179e95b56f4c21::reward_distributor_cap::RewardDistributorCap>(&arg0.reward_distributor_cap), arg0.active_period, arg5);
    }

    public fun activated_at<T0>(arg0: &Minter<T0>) : u64 {
        arg0.activated_at
    }

    public fun active_period<T0>(arg0: &Minter<T0>) : u64 {
        arg0.active_period
    }

    public fun all_gauges_distributed<T0>(arg0: &Minter<T0>, arg1: &0xd4d7bdc15013391ea5776db31abfc0c2dcf9121b58dcffc29c179e95b56f4c21::distribution_config::DistributionConfig) : bool {
        let v0 = 0x2::vec_set::keys<0x2::object::ID>(0xd4d7bdc15013391ea5776db31abfc0c2dcf9121b58dcffc29c179e95b56f4c21::distribution_config::borrow_alive_gauges(arg1));
        let v1 = 0;
        while (v1 < 0x1::vector::length<0x2::object::ID>(v0)) {
            let v2 = *0x1::vector::borrow<0x2::object::ID>(v0, v1);
            let v3 = if (0x2::table::contains<0x2::object::ID, u64>(&arg0.gauge_active_period, v2)) {
                *0x2::table::borrow<0x2::object::ID, u64>(&arg0.gauge_active_period, v2)
            } else {
                0
            };
            if (arg0.active_period > v3) {
                return false
            };
            v1 = v1 + 1;
        };
        true
    }

    public fun borrow_current_epoch_o_sail<T0>(arg0: &Minter<T0>) : &0x1::type_name::TypeName {
        0x1::option::borrow<0x1::type_name::TypeName>(&arg0.current_epoch_o_sail)
    }

    fun borrow_mut_o_sail_cap<T0, T1>(arg0: &mut Minter<T0>) : &mut 0x2::coin::TreasuryCap<T1> {
        0x2::bag::borrow_mut<0x1::type_name::TypeName, 0x2::coin::TreasuryCap<T1>>(&mut arg0.o_sail_caps, 0x1::type_name::get<T1>())
    }

    public fun borrow_o_sail_cap<T0, T1>(arg0: &Minter<T0>) : &0x2::coin::TreasuryCap<T1> {
        0x2::bag::borrow<0x1::type_name::TypeName, 0x2::coin::TreasuryCap<T1>>(&arg0.o_sail_caps, 0x1::type_name::get<T1>())
    }

    public fun borrow_pool_epoch_emissions_usd<T0>(arg0: &Minter<T0>) : &0x2::table::Table<0x2::object::ID, u64> {
        &arg0.gauge_epoch_emissions_usd
    }

    public fun borrow_whiteliste_pools<T0>(arg0: &Minter<T0>) : &0x2::vec_set::VecSet<0x2::object::ID> {
        &arg0.whitelisted_pools
    }

    public fun burn_o_sail<T0, T1>(arg0: &mut Minter<T0>, arg1: 0x2::coin::Coin<T1>) : u64 {
        assert!(!is_paused<T0>(arg0), 947382564018592637);
        assert!(is_valid_o_sail_type<T0, T1>(arg0), 665869556650983200);
        let v0 = borrow_mut_o_sail_cap<T0, T1>(arg0);
        let v1 = 0x2::coin::burn<T1>(v0, arg1);
        arg0.o_sail_minted_supply = arg0.o_sail_minted_supply - v1;
        v1
    }

    public fun burn_o_sail_balance<T0, T1>(arg0: &mut Minter<T0>, arg1: 0x2::balance::Balance<T1>, arg2: &mut 0x2::tx_context::TxContext) : u64 {
        burn_o_sail<T0, T1>(arg0, 0x2::coin::from_balance<T1>(arg1, arg2))
    }

    public fun calculate_next_pool_emissions(arg0: u64, arg1: u64, arg2: u64, arg3: u64, arg4: u64, arg5: u64, arg6: u64) : u64 {
        let v0 = if (arg2 > 0 && arg1 > 0) {
            0x4e212a95eb24d6273e334bf3460f675acd9e371691c4c824bc895e056fc4bae0::full_math_u128::mul_div_floor(0x4e212a95eb24d6273e334bf3460f675acd9e371691c4c824bc895e056fc4bae0::full_math_u128::mul_div_floor((arg4 as u128), 18446744073709551616, (arg3 as u128)), 18446744073709551616, 0x4e212a95eb24d6273e334bf3460f675acd9e371691c4c824bc895e056fc4bae0::full_math_u128::mul_div_floor((arg2 as u128), 18446744073709551616, (arg1 as u128)))
        } else {
            18446744073709551616
        };
        let v1 = (v0 + 0x4e212a95eb24d6273e334bf3460f675acd9e371691c4c824bc895e056fc4bae0::full_math_u128::mul_div_floor((arg6 as u128), 18446744073709551616, (arg5 as u128))) / 2;
        let v2 = v1;
        let v3 = max_emissions_change_q64();
        let v4 = min_emissions_change_q64();
        if (v1 > v3) {
            v2 = v3;
        };
        if (v2 < v4) {
            v2 = v4;
        };
        (0x4e212a95eb24d6273e334bf3460f675acd9e371691c4c824bc895e056fc4bae0::full_math_u128::mul_div_floor((arg0 as u128), v2, 18446744073709551616) as u64)
    }

    public fun calculate_rebase_growth(arg0: u64, arg1: u64, arg2: u64) : u64 {
        if (arg1 == 0) {
            return 0
        };
        0x4e212a95eb24d6273e334bf3460f675acd9e371691c4c824bc895e056fc4bae0::full_math_u64::mul_div_ceil(0x4e212a95eb24d6273e334bf3460f675acd9e371691c4c824bc895e056fc4bae0::full_math_u64::mul_div_ceil(arg0, arg1 - arg2, arg1), arg1 - arg2, arg1) / 2
    }

    public fun cancel_o_sail_mint<T0>(arg0: TimeLockedOSailMint<T0>) {
        let TimeLockedOSailMint {
            id          : v0,
            amount      : _,
            unlock_time : _,
        } = arg0;
        0x2::object::delete(v0);
    }

    public fun cancel_sail_mint(arg0: TimeLockedSailMint) {
        let TimeLockedSailMint {
            id          : v0,
            amount      : _,
            unlock_time : _,
        } = arg0;
        0x2::object::delete(v0);
    }

    public fun check_admin<T0>(arg0: &Minter<T0>, arg1: &AdminCap) {
        let v0 = 0x2::object::id<AdminCap>(arg1);
        assert!(!0x2::vec_set::contains<0x2::object::ID>(&arg0.revoked_admins, &v0), 922337280994888908);
    }

    public fun check_distribute_governor<T0>(arg0: &Minter<T0>, arg1: &DistributeGovernorCap) {
        let v0 = 0x2::object::id<DistributeGovernorCap>(arg1);
        assert!(!0x2::vec_set::contains<0x2::object::ID>(&arg0.revoked_distribute_governors, &v0), 369612027923601500);
    }

    public fun create<T0>(arg0: &0x2::package::Publisher, arg1: 0x1::option::Option<0x2::coin::TreasuryCap<T0>>, arg2: 0x2::object::ID, arg3: &mut 0x2::tx_context::TxContext) : (Minter<T0>, AdminCap) {
        assert!(0x2::package::from_module<MINTER>(arg0), 695309471293028100);
        let v0 = Minter<T0>{
            id                           : 0x2::object::new(arg3),
            revoked_admins               : 0x2::vec_set::empty<0x2::object::ID>(),
            revoked_distribute_governors : 0x2::vec_set::empty<0x2::object::ID>(),
            paused                       : false,
            activated_at                 : 0,
            active_period                : 0,
            current_epoch_o_sail         : 0x1::option::none<0x1::type_name::TypeName>(),
            last_epoch_update_time       : 0,
            sail_cap                     : arg1,
            o_sail_caps                  : 0x2::bag::new(arg3),
            o_sail_minted_supply         : 0,
            o_sail_expiry_dates          : 0x2::table::new<0x1::type_name::TypeName, u64>(arg3),
            team_emission_rate           : 500,
            protocol_fee_rate            : 500,
            team_wallet                  : @0x0,
            reward_distributor_cap       : 0x1::option::none<0xd4d7bdc15013391ea5776db31abfc0c2dcf9121b58dcffc29c179e95b56f4c21::reward_distributor_cap::RewardDistributorCap>(),
            distribute_cap               : 0x1::option::none<0xd4d7bdc15013391ea5776db31abfc0c2dcf9121b58dcffc29c179e95b56f4c21::distribute_cap::DistributeCap>(),
            whitelisted_pools            : 0x2::vec_set::empty<0x2::object::ID>(),
            exercise_fee_team_balances   : 0x2::bag::new(arg3),
            gauge_epoch_emissions_usd    : 0x2::table::new<0x2::object::ID, u64>(arg3),
            gauge_active_period          : 0x2::table::new<0x2::object::ID, u64>(arg3),
            gauge_epoch_count            : 0x2::table::new<0x2::object::ID, u64>(arg3),
            total_epoch_emissions_usd    : 0x2::table::new<u64, u64>(arg3),
            total_epoch_o_sail_emissions : 0x2::table::new<u64, u64>(arg3),
            distribution_config          : arg2,
        };
        let v1 = AdminCap{id: 0x2::object::new(arg3)};
        (v0, v1)
    }

    public fun create_gauge<T0, T1, T2>(arg0: &mut Minter<T2>, arg1: &mut 0xd4d7bdc15013391ea5776db31abfc0c2dcf9121b58dcffc29c179e95b56f4c21::voter::Voter, arg2: &mut 0xd4d7bdc15013391ea5776db31abfc0c2dcf9121b58dcffc29c179e95b56f4c21::distribution_config::DistributionConfig, arg3: &0x759fdf7bc2175c3dd078e16d4703ea5ef655cd055ff74eca9c516e6173c6b42e::gauge_cap::CreateCap, arg4: &AdminCap, arg5: &0xd4d7bdc15013391ea5776db31abfc0c2dcf9121b58dcffc29c179e95b56f4c21::voting_escrow::VotingEscrow<T2>, arg6: &mut 0xd9d2135d6efbbd95909338e5d1809c48854a35a2f95228ebf28d5fe0faf46234::pool::Pool<T0, T1>, arg7: u64, arg8: &0x2::clock::Clock, arg9: &mut 0x2::tx_context::TxContext) : 0xd4d7bdc15013391ea5776db31abfc0c2dcf9121b58dcffc29c179e95b56f4c21::gauge::Gauge<T0, T1> {
        assert!(!is_paused<T2>(arg0), 173400731963214500);
        check_admin<T2>(arg0, arg4);
        assert!(arg7 > 0, 676230237726862100);
        let v0 = 0xd4d7bdc15013391ea5776db31abfc0c2dcf9121b58dcffc29c179e95b56f4c21::voter::create_gauge<T0, T1, T2>(arg1, arg2, arg3, 0x1::option::borrow<0xd4d7bdc15013391ea5776db31abfc0c2dcf9121b58dcffc29c179e95b56f4c21::distribute_cap::DistributeCap>(&arg0.distribute_cap), arg5, arg6, arg8, arg9);
        0x2::table::add<0x2::object::ID, u64>(&mut arg0.gauge_epoch_emissions_usd, 0x2::object::id<0xd4d7bdc15013391ea5776db31abfc0c2dcf9121b58dcffc29c179e95b56f4c21::gauge::Gauge<T0, T1>>(&v0), arg7);
        v0
    }

    public fun create_lock_from_o_sail<T0, T1>(arg0: &mut Minter<T0>, arg1: &mut 0xd4d7bdc15013391ea5776db31abfc0c2dcf9121b58dcffc29c179e95b56f4c21::voting_escrow::VotingEscrow<T0>, arg2: 0x2::coin::Coin<T1>, arg3: u64, arg4: bool, arg5: &0x2::clock::Clock, arg6: &mut 0x2::tx_context::TxContext) {
        assert!(!is_paused<T0>(arg0), 345260272869412100);
        assert!(is_valid_o_sail_type<T0, T1>(arg0), 916284390763921500);
        let v0 = false;
        if (0xd4d7bdc15013391ea5776db31abfc0c2dcf9121b58dcffc29c179e95b56f4c21::common::current_timestamp(arg5) >= *0x2::table::borrow<0x1::type_name::TypeName, u64>(&arg0.o_sail_expiry_dates, 0x1::type_name::get<T1>())) {
            let v1 = arg4 || arg3 == 1456;
            v0 = v1;
        } else if (arg4) {
            v0 = true;
        } else {
            let v2 = 0;
            let v3 = vector[182, 728, 1456];
            while (v2 < 0x1::vector::length<u64>(&v3)) {
                if (*0x1::vector::borrow<u64>(&v3, v2) == arg3) {
                    v0 = true;
                    break
                };
                v2 = v2 + 1;
            };
        };
        assert!(v0, 68567430268160480);
        let v4 = if (arg4) {
            0xd4d7bdc15013391ea5776db31abfc0c2dcf9121b58dcffc29c179e95b56f4c21::common::persent_denominator()
        } else {
            0xd4d7bdc15013391ea5776db31abfc0c2dcf9121b58dcffc29c179e95b56f4c21::common::o_sail_discount() + 0x4e212a95eb24d6273e334bf3460f675acd9e371691c4c824bc895e056fc4bae0::full_math_u64::mul_div_floor(arg3 * 0xd4d7bdc15013391ea5776db31abfc0c2dcf9121b58dcffc29c179e95b56f4c21::common::day(), 0xd4d7bdc15013391ea5776db31abfc0c2dcf9121b58dcffc29c179e95b56f4c21::common::persent_denominator() - 0xd4d7bdc15013391ea5776db31abfc0c2dcf9121b58dcffc29c179e95b56f4c21::common::o_sail_discount(), 0xd4d7bdc15013391ea5776db31abfc0c2dcf9121b58dcffc29c179e95b56f4c21::common::max_lock_time())
        };
        let v5 = exercise_o_sail_free_internal<T0, T1>(arg0, arg2, v4, arg5, arg6);
        0xd4d7bdc15013391ea5776db31abfc0c2dcf9121b58dcffc29c179e95b56f4c21::voting_escrow::create_lock<T0>(arg1, v5, arg3, arg4, arg5, arg6);
    }

    public fun distribute_gauge<T0, T1, T2, T3>(arg0: &mut Minter<T2>, arg1: &mut 0xd4d7bdc15013391ea5776db31abfc0c2dcf9121b58dcffc29c179e95b56f4c21::voter::Voter, arg2: &DistributeGovernorCap, arg3: &0xd4d7bdc15013391ea5776db31abfc0c2dcf9121b58dcffc29c179e95b56f4c21::distribution_config::DistributionConfig, arg4: &mut 0xd4d7bdc15013391ea5776db31abfc0c2dcf9121b58dcffc29c179e95b56f4c21::gauge::Gauge<T0, T1>, arg5: &mut 0xd9d2135d6efbbd95909338e5d1809c48854a35a2f95228ebf28d5fe0faf46234::pool::Pool<T0, T1>, arg6: u64, arg7: u64, arg8: u64, arg9: u64, arg10: u64, arg11: u64, arg12: &0xc3c7e6eb7202e9fb0389a2f7542b91cc40e4f7a33c02554fec11c4c92f938ea3::aggregator::Aggregator, arg13: &0x2::clock::Clock, arg14: &mut 0x2::tx_context::TxContext) : u64 {
        assert!(!is_paused<T2>(arg0), 383966743216827200);
        check_distribute_governor<T2>(arg0, arg2);
        assert!(is_active<T2>(arg0, arg13), 728194857362048571);
        let v0 = 0x1::type_name::get<T3>();
        assert!(0x1::option::borrow<0x1::type_name::TypeName>(&arg0.current_epoch_o_sail) == &v0, 802874746577660900);
        let v1 = 0x2::object::id<0xd4d7bdc15013391ea5776db31abfc0c2dcf9121b58dcffc29c179e95b56f4c21::gauge::Gauge<T0, T1>>(arg4);
        assert!(!0x2::table::contains<0x2::object::ID, u64>(&arg0.gauge_active_period, v1) || *0x2::table::borrow<0x2::object::ID, u64>(&arg0.gauge_active_period, v1) < arg0.active_period, 259145126193785820);
        assert!(0x2::table::contains<0x2::object::ID, u64>(&arg0.gauge_epoch_emissions_usd, v1), 764215244078886900);
        assert!(is_valid_distribution_config<T2>(arg0, arg3), 540205746933504640);
        let v2 = if (0x2::table::contains<0x2::object::ID, u64>(&arg0.gauge_epoch_count, v1)) {
            0x2::table::remove<0x2::object::ID, u64>(&mut arg0.gauge_epoch_count, v1)
        } else {
            0
        };
        let v3 = v2 == 0;
        if (v3) {
            let v4 = if (arg6 == 0) {
                if (arg7 == 0) {
                    if (arg8 == 0) {
                        if (arg9 == 0) {
                            if (arg10 == 0) {
                                arg11 == 0
                            } else {
                                false
                            }
                        } else {
                            false
                        }
                    } else {
                        false
                    }
                } else {
                    false
                }
            } else {
                false
            };
            assert!(v4, 671508139267645600);
        } else {
            let v5 = if (arg8 > 0) {
                if (arg9 > 0) {
                    if (arg10 > 0) {
                        arg11 > 0
                    } else {
                        false
                    }
                } else {
                    false
                }
            } else {
                false
            };
            assert!(v5, 95918619286974770);
        };
        let v6 = if (v3) {
            0x2::table::remove<0x2::object::ID, u64>(&mut arg0.gauge_epoch_emissions_usd, v1)
        } else {
            calculate_next_pool_emissions(0x2::table::remove<0x2::object::ID, u64>(&mut arg0.gauge_epoch_emissions_usd, v1), arg6, arg7, arg8, arg9, arg10, arg11)
        };
        let v7 = if (0x2::table::contains<0x2::object::ID, u64>(&arg0.gauge_active_period, v1)) {
            0x2::table::remove<0x2::object::ID, u64>(&mut arg0.gauge_active_period, v1)
        } else {
            0
        };
        if (v7 > 0) {
            let v8 = if (0x2::table::contains<u64, u64>(&arg0.total_epoch_o_sail_emissions, v7)) {
                0x2::table::remove<u64, u64>(&mut arg0.total_epoch_o_sail_emissions, v7)
            } else {
                0
            };
            0x2::table::add<u64, u64>(&mut arg0.total_epoch_o_sail_emissions, v7, v8 + 0xd4d7bdc15013391ea5776db31abfc0c2dcf9121b58dcffc29c179e95b56f4c21::voter::distribute_gauge<T0, T1, T3>(arg1, 0x1::option::borrow<0xd4d7bdc15013391ea5776db31abfc0c2dcf9121b58dcffc29c179e95b56f4c21::distribute_cap::DistributeCap>(&arg0.distribute_cap), arg3, arg4, arg5, v6, arg12, arg13, arg14));
        } else {
            assert!(0xd4d7bdc15013391ea5776db31abfc0c2dcf9121b58dcffc29c179e95b56f4c21::voter::distribute_gauge<T0, T1, T3>(arg1, 0x1::option::borrow<0xd4d7bdc15013391ea5776db31abfc0c2dcf9121b58dcffc29c179e95b56f4c21::distribute_cap::DistributeCap>(&arg0.distribute_cap), arg3, arg4, arg5, v6, arg12, arg13, arg14) == 0, 658460351931005700);
        };
        0x2::table::add<0x2::object::ID, u64>(&mut arg0.gauge_active_period, v1, arg0.active_period);
        0x2::table::add<0x2::object::ID, u64>(&mut arg0.gauge_epoch_emissions_usd, v1, v6);
        0x2::table::add<0x2::object::ID, u64>(&mut arg0.gauge_epoch_count, v1, v2 + 1);
        let v9 = if (0x2::table::contains<u64, u64>(&arg0.total_epoch_emissions_usd, arg0.active_period)) {
            0x2::table::remove<u64, u64>(&mut arg0.total_epoch_emissions_usd, arg0.active_period)
        } else {
            0
        };
        0x2::table::add<u64, u64>(&mut arg0.total_epoch_emissions_usd, arg0.active_period, v9 + v6);
        let v10 = EventDistributeGauge{
            gauge_id                 : v1,
            pool_id                  : 0x2::object::id<0xd9d2135d6efbbd95909338e5d1809c48854a35a2f95228ebf28d5fe0faf46234::pool::Pool<T0, T1>>(arg5),
            o_sail_type              : v0,
            next_epoch_emissions_usd : v6,
        };
        0x2::event::emit<EventDistributeGauge>(v10);
        v6
    }

    public fun distribute_team<T0, T1>(arg0: &mut Minter<T0>, arg1: &mut 0x2::tx_context::TxContext) {
        assert!(!is_paused<T0>(arg0), 482957361048572639);
        assert!(arg0.team_wallet != @0x0, 798141442607710900);
        let v0 = 0x1::type_name::get<T1>();
        assert!(0x2::bag::contains<0x1::type_name::TypeName>(&arg0.exercise_fee_team_balances, v0), 962925679282177400);
        0x2::transfer::public_transfer<0x2::coin::Coin<T1>>(0x2::coin::from_balance<T1>(0x2::bag::remove<0x1::type_name::TypeName, 0x2::balance::Balance<T1>>(&mut arg0.exercise_fee_team_balances, v0), arg1), arg0.team_wallet);
    }

    public fun execute_o_sail_mint<T0, T1>(arg0: &mut Minter<T0>, arg1: TimeLockedOSailMint<T1>, arg2: &0x2::clock::Clock, arg3: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<T1> {
        assert!(!is_paused<T0>(arg0), 701790096846469900);
        assert!(is_valid_o_sail_type<T0, T1>(arg0), 656291036632650900);
        let TimeLockedOSailMint {
            id          : v0,
            amount      : v1,
            unlock_time : v2,
        } = arg1;
        0x2::object::delete(v0);
        assert!(v2 <= 0x2::clock::timestamp_ms(arg2), 151689484412189660);
        mint_o_sail<T0, T1>(arg0, v1, arg3)
    }

    public fun execute_sail_mint<T0>(arg0: &mut Minter<T0>, arg1: TimeLockedSailMint, arg2: &0x2::clock::Clock, arg3: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<T0> {
        assert!(!is_paused<T0>(arg0), 563287666418746940);
        let TimeLockedSailMint {
            id          : v0,
            amount      : v1,
            unlock_time : v2,
        } = arg1;
        0x2::object::delete(v0);
        assert!(v2 <= 0x2::clock::timestamp_ms(arg2), 163079933457922500);
        mint_sail<T0>(arg0, v1, arg3)
    }

    public fun exercise_o_sail_ab<T0, T1, T2>(arg0: &mut Minter<T0>, arg1: &mut 0xd4d7bdc15013391ea5776db31abfc0c2dcf9121b58dcffc29c179e95b56f4c21::voter::Voter, arg2: &0xd9d2135d6efbbd95909338e5d1809c48854a35a2f95228ebf28d5fe0faf46234::config::GlobalConfig, arg3: &mut 0xd9d2135d6efbbd95909338e5d1809c48854a35a2f95228ebf28d5fe0faf46234::pool::Pool<T1, T0>, arg4: 0x2::coin::Coin<T2>, arg5: 0x2::coin::Coin<T1>, arg6: u64, arg7: &0x2::clock::Clock, arg8: &mut 0x2::tx_context::TxContext) : (0x2::coin::Coin<T1>, 0x2::coin::Coin<T0>) {
        assert!(!is_paused<T0>(arg0), 295847361920485736);
        assert!(is_valid_o_sail_type<T0, T2>(arg0), 320917362365364070);
        assert!(0xd4d7bdc15013391ea5776db31abfc0c2dcf9121b58dcffc29c179e95b56f4c21::common::current_timestamp(arg7) < *0x2::table::borrow<0x1::type_name::TypeName, u64>(&arg0.o_sail_expiry_dates, 0x1::type_name::get<T2>()), 738843771743325200);
        assert!(is_whitelisted_pool<T0, T1, T0>(arg0, arg3), 221252400064791070);
        exercise_o_sail_ab_internal<T0, T1, T2>(arg0, arg1, arg3, arg4, 0xd4d7bdc15013391ea5776db31abfc0c2dcf9121b58dcffc29c179e95b56f4c21::common::o_sail_discount(), arg5, arg6, arg7, arg8)
    }

    fun exercise_o_sail_ab_internal<T0, T1, T2>(arg0: &mut Minter<T0>, arg1: &mut 0xd4d7bdc15013391ea5776db31abfc0c2dcf9121b58dcffc29c179e95b56f4c21::voter::Voter, arg2: &0xd9d2135d6efbbd95909338e5d1809c48854a35a2f95228ebf28d5fe0faf46234::pool::Pool<T1, T0>, arg3: 0x2::coin::Coin<T2>, arg4: u64, arg5: 0x2::coin::Coin<T1>, arg6: u64, arg7: &0x2::clock::Clock, arg8: &mut 0x2::tx_context::TxContext) : (0x2::coin::Coin<T1>, 0x2::coin::Coin<T0>) {
        let v0 = exercise_o_sail_calc<T2, T1, T0>(arg2, &arg3, arg4, true);
        assert!(arg6 >= v0, 490517942447480600);
        exercise_o_sail_process_payment<T0, T1, T2>(arg0, arg1, arg3, arg5, v0, arg7, arg8)
    }

    public fun exercise_o_sail_ba<T0, T1, T2>(arg0: &mut Minter<T0>, arg1: &mut 0xd4d7bdc15013391ea5776db31abfc0c2dcf9121b58dcffc29c179e95b56f4c21::voter::Voter, arg2: &0xd9d2135d6efbbd95909338e5d1809c48854a35a2f95228ebf28d5fe0faf46234::config::GlobalConfig, arg3: &mut 0xd9d2135d6efbbd95909338e5d1809c48854a35a2f95228ebf28d5fe0faf46234::pool::Pool<T0, T1>, arg4: 0x2::coin::Coin<T2>, arg5: 0x2::coin::Coin<T1>, arg6: u64, arg7: &0x2::clock::Clock, arg8: &mut 0x2::tx_context::TxContext) : (0x2::coin::Coin<T1>, 0x2::coin::Coin<T0>) {
        assert!(!is_paused<T0>(arg0), 618394857261038472);
        assert!(is_valid_o_sail_type<T0, T2>(arg0), 320917362365364070);
        assert!(0xd4d7bdc15013391ea5776db31abfc0c2dcf9121b58dcffc29c179e95b56f4c21::common::current_timestamp(arg7) < *0x2::table::borrow<0x1::type_name::TypeName, u64>(&arg0.o_sail_expiry_dates, 0x1::type_name::get<T2>()), 738843771743325200);
        assert!(is_whitelisted_pool<T0, T0, T1>(arg0, arg3), 221252400064791070);
        exercise_o_sail_ba_internal<T0, T1, T2>(arg0, arg1, arg3, arg4, 0xd4d7bdc15013391ea5776db31abfc0c2dcf9121b58dcffc29c179e95b56f4c21::common::o_sail_discount(), arg5, arg6, arg7, arg8)
    }

    fun exercise_o_sail_ba_internal<T0, T1, T2>(arg0: &mut Minter<T0>, arg1: &mut 0xd4d7bdc15013391ea5776db31abfc0c2dcf9121b58dcffc29c179e95b56f4c21::voter::Voter, arg2: &0xd9d2135d6efbbd95909338e5d1809c48854a35a2f95228ebf28d5fe0faf46234::pool::Pool<T0, T1>, arg3: 0x2::coin::Coin<T2>, arg4: u64, arg5: 0x2::coin::Coin<T1>, arg6: u64, arg7: &0x2::clock::Clock, arg8: &mut 0x2::tx_context::TxContext) : (0x2::coin::Coin<T1>, 0x2::coin::Coin<T0>) {
        let v0 = exercise_o_sail_calc<T2, T0, T1>(arg2, &arg3, arg4, false);
        assert!(arg6 >= v0, 490517942447480600);
        exercise_o_sail_process_payment<T0, T1, T2>(arg0, arg1, arg3, arg5, v0, arg7, arg8)
    }

    public fun exercise_o_sail_calc<T0, T1, T2>(arg0: &0xd9d2135d6efbbd95909338e5d1809c48854a35a2f95228ebf28d5fe0faf46234::pool::Pool<T1, T2>, arg1: &0x2::coin::Coin<T0>, arg2: u64, arg3: bool) : u64 {
        let v0 = (0xd9d2135d6efbbd95909338e5d1809c48854a35a2f95228ebf28d5fe0faf46234::pool::current_sqrt_price<T1, T2>(arg0) as u256);
        if (arg3) {
            ((((0x4e212a95eb24d6273e334bf3460f675acd9e371691c4c824bc895e056fc4bae0::full_math_u64::mul_div_floor(0xd4d7bdc15013391ea5776db31abfc0c2dcf9121b58dcffc29c179e95b56f4c21::common::persent_denominator() - arg2, 0x2::coin::value<T0>(arg1), 0xd4d7bdc15013391ea5776db31abfc0c2dcf9121b58dcffc29c179e95b56f4c21::common::persent_denominator()) as u256) << 128) / v0 * v0) as u64)
        } else {
            ((v0 * v0 * (0x4e212a95eb24d6273e334bf3460f675acd9e371691c4c824bc895e056fc4bae0::full_math_u64::mul_div_floor(0xd4d7bdc15013391ea5776db31abfc0c2dcf9121b58dcffc29c179e95b56f4c21::common::persent_denominator() - arg2, 0x2::coin::value<T0>(arg1), 0xd4d7bdc15013391ea5776db31abfc0c2dcf9121b58dcffc29c179e95b56f4c21::common::persent_denominator()) as u256) >> 128) as u64)
        }
    }

    fun exercise_o_sail_free_internal<T0, T1>(arg0: &mut Minter<T0>, arg1: 0x2::coin::Coin<T1>, arg2: u64, arg3: &0x2::clock::Clock, arg4: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<T0> {
        assert!(arg2 <= 0xd4d7bdc15013391ea5776db31abfc0c2dcf9121b58dcffc29c179e95b56f4c21::common::persent_denominator(), 410835752553141860);
        burn_o_sail<T0, T1>(arg0, arg1);
        mint_sail<T0>(arg0, 0x4e212a95eb24d6273e334bf3460f675acd9e371691c4c824bc895e056fc4bae0::full_math_u64::mul_div_floor(0x2::coin::value<T1>(&arg1), arg2, 0xd4d7bdc15013391ea5776db31abfc0c2dcf9121b58dcffc29c179e95b56f4c21::common::persent_denominator()), arg4)
    }

    fun exercise_o_sail_process_payment<T0, T1, T2>(arg0: &mut Minter<T0>, arg1: &mut 0xd4d7bdc15013391ea5776db31abfc0c2dcf9121b58dcffc29c179e95b56f4c21::voter::Voter, arg2: 0x2::coin::Coin<T2>, arg3: 0x2::coin::Coin<T1>, arg4: u64, arg5: &0x2::clock::Clock, arg6: &mut 0x2::tx_context::TxContext) : (0x2::coin::Coin<T1>, 0x2::coin::Coin<T0>) {
        let v0 = 0x2::coin::split<T1>(&mut arg3, arg4, arg6);
        if (arg0.protocol_fee_rate > 0 && arg0.team_wallet != @0x0) {
            let v1 = 0x1::type_name::get<T1>();
            if (!0x2::bag::contains<0x1::type_name::TypeName>(&arg0.exercise_fee_team_balances, v1)) {
                0x2::bag::add<0x1::type_name::TypeName, 0x2::balance::Balance<T1>>(&mut arg0.exercise_fee_team_balances, v1, 0x2::balance::zero<T1>());
            };
            0x2::balance::join<T1>(0x2::bag::borrow_mut<0x1::type_name::TypeName, 0x2::balance::Balance<T1>>(&mut arg0.exercise_fee_team_balances, v1), 0x2::coin::into_balance<T1>(0x2::coin::split<T1>(&mut v0, 0x4e212a95eb24d6273e334bf3460f675acd9e371691c4c824bc895e056fc4bae0::full_math_u64::mul_div_floor(0x2::coin::value<T1>(&v0), arg0.protocol_fee_rate, 10000), arg6)));
        };
        0xd4d7bdc15013391ea5776db31abfc0c2dcf9121b58dcffc29c179e95b56f4c21::voter::notify_exercise_fee_reward_amount<T1>(arg1, 0x1::option::borrow<0xd4d7bdc15013391ea5776db31abfc0c2dcf9121b58dcffc29c179e95b56f4c21::distribute_cap::DistributeCap>(&arg0.distribute_cap), v0, arg5, arg6);
        burn_o_sail<T0, T2>(arg0, arg2);
        (arg3, mint_sail<T0>(arg0, 0x2::coin::value<T2>(&arg2), arg6))
    }

    public fun get_multiple_position_rewards<T0, T1, T2, T3>(arg0: &mut Minter<T2>, arg1: &mut 0xd4d7bdc15013391ea5776db31abfc0c2dcf9121b58dcffc29c179e95b56f4c21::voter::Voter, arg2: &0xd4d7bdc15013391ea5776db31abfc0c2dcf9121b58dcffc29c179e95b56f4c21::distribution_config::DistributionConfig, arg3: &mut 0xd4d7bdc15013391ea5776db31abfc0c2dcf9121b58dcffc29c179e95b56f4c21::gauge::Gauge<T0, T1>, arg4: &mut 0xd9d2135d6efbbd95909338e5d1809c48854a35a2f95228ebf28d5fe0faf46234::pool::Pool<T0, T1>, arg5: &vector<0xd4d7bdc15013391ea5776db31abfc0c2dcf9121b58dcffc29c179e95b56f4c21::gauge::StakedPosition>, arg6: &0x2::clock::Clock, arg7: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<T3> {
        let v0 = 0x1::option::borrow<0xd4d7bdc15013391ea5776db31abfc0c2dcf9121b58dcffc29c179e95b56f4c21::distribute_cap::DistributeCap>(&arg0.distribute_cap);
        assert!(is_valid_o_sail_type<T2, T3>(arg0), 785363146605424900);
        let v1 = 0xd4d7bdc15013391ea5776db31abfc0c2dcf9121b58dcffc29c179e95b56f4c21::voter::get_multiple_position_rewards<T0, T1, T3>(arg1, v0, arg2, arg3, arg4, arg5, arg6, arg7);
        mint_o_sail<T2, T3>(arg0, v1, arg7)
    }

    public fun get_position_reward<T0, T1, T2, T3>(arg0: &mut Minter<T2>, arg1: &mut 0xd4d7bdc15013391ea5776db31abfc0c2dcf9121b58dcffc29c179e95b56f4c21::voter::Voter, arg2: &0xd4d7bdc15013391ea5776db31abfc0c2dcf9121b58dcffc29c179e95b56f4c21::distribution_config::DistributionConfig, arg3: &mut 0xd4d7bdc15013391ea5776db31abfc0c2dcf9121b58dcffc29c179e95b56f4c21::gauge::Gauge<T0, T1>, arg4: &mut 0xd9d2135d6efbbd95909338e5d1809c48854a35a2f95228ebf28d5fe0faf46234::pool::Pool<T0, T1>, arg5: &0xd4d7bdc15013391ea5776db31abfc0c2dcf9121b58dcffc29c179e95b56f4c21::gauge::StakedPosition, arg6: &0x2::clock::Clock, arg7: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<T3> {
        let v0 = 0x1::option::borrow<0xd4d7bdc15013391ea5776db31abfc0c2dcf9121b58dcffc29c179e95b56f4c21::distribute_cap::DistributeCap>(&arg0.distribute_cap);
        assert!(is_valid_o_sail_type<T2, T3>(arg0), 779306294896264600);
        let v1 = 0xd4d7bdc15013391ea5776db31abfc0c2dcf9121b58dcffc29c179e95b56f4c21::voter::get_position_reward<T0, T1, T3>(arg1, v0, arg2, arg3, arg4, arg5, arg6, arg7);
        mint_o_sail<T2, T3>(arg0, v1, arg7)
    }

    public fun grant_admin(arg0: &0x2::package::Publisher, arg1: address, arg2: &mut 0x2::tx_context::TxContext) {
        assert!(0x2::package::from_module<MINTER>(arg0), 198127851942335970);
        let v0 = AdminCap{id: 0x2::object::new(arg2)};
        let v1 = EventGrantAdmin{
            who       : arg1,
            admin_cap : 0x2::object::id<AdminCap>(&v0),
        };
        0x2::event::emit<EventGrantAdmin>(v1);
        0x2::transfer::transfer<AdminCap>(v0, arg1);
    }

    public fun grant_distribute_governor(arg0: &0x2::package::Publisher, arg1: address, arg2: &mut 0x2::tx_context::TxContext) {
        assert!(0x2::package::from_module<MINTER>(arg0), 49774594592309590);
        let v0 = DistributeGovernorCap{id: 0x2::object::new(arg2)};
        let v1 = EventGrantDistributeGovernor{
            who                     : arg1,
            distribute_governor_cap : 0x2::object::id<DistributeGovernorCap>(&v0),
        };
        0x2::event::emit<EventGrantDistributeGovernor>(v1);
        0x2::transfer::transfer<DistributeGovernorCap>(v0, arg1);
    }

    fun init(arg0: MINTER, arg1: &mut 0x2::tx_context::TxContext) {
        0x2::package::claim_and_keep<MINTER>(arg0, arg1);
    }

    public fun is_active<T0>(arg0: &Minter<T0>, arg1: &0x2::clock::Clock) : bool {
        arg0.activated_at > 0 && 0xd4d7bdc15013391ea5776db31abfc0c2dcf9121b58dcffc29c179e95b56f4c21::common::current_period(arg1) >= arg0.active_period
    }

    public fun is_paused<T0>(arg0: &Minter<T0>) : bool {
        arg0.paused
    }

    public fun is_valid_distribution_config<T0>(arg0: &Minter<T0>, arg1: &0xd4d7bdc15013391ea5776db31abfc0c2dcf9121b58dcffc29c179e95b56f4c21::distribution_config::DistributionConfig) : bool {
        arg0.distribution_config == 0x2::object::id<0xd4d7bdc15013391ea5776db31abfc0c2dcf9121b58dcffc29c179e95b56f4c21::distribution_config::DistributionConfig>(arg1)
    }

    public fun is_valid_epoch_token<T0, T1>(arg0: &Minter<T0>) : bool {
        *borrow_current_epoch_o_sail<T0>(arg0) == 0x1::type_name::get<T1>()
    }

    public fun is_valid_o_sail_type<T0, T1>(arg0: &Minter<T0>) : bool {
        0x2::table::contains<0x1::type_name::TypeName, u64>(&arg0.o_sail_expiry_dates, 0x1::type_name::get<T1>())
    }

    public fun is_whitelisted_pool<T0, T1, T2>(arg0: &Minter<T0>, arg1: &0xd9d2135d6efbbd95909338e5d1809c48854a35a2f95228ebf28d5fe0faf46234::pool::Pool<T1, T2>) : bool {
        let v0 = 0x2::object::id<0xd9d2135d6efbbd95909338e5d1809c48854a35a2f95228ebf28d5fe0faf46234::pool::Pool<T1, T2>>(arg1);
        0x2::vec_set::contains<0x2::object::ID>(&arg0.whitelisted_pools, &v0)
    }

    public fun kill_gauge<T0>(arg0: &mut Minter<T0>, arg1: &mut 0xd4d7bdc15013391ea5776db31abfc0c2dcf9121b58dcffc29c179e95b56f4c21::distribution_config::DistributionConfig, arg2: &0xd4d7bdc15013391ea5776db31abfc0c2dcf9121b58dcffc29c179e95b56f4c21::emergency_council::EmergencyCouncilCap, arg3: 0x2::object::ID) {
        0xd4d7bdc15013391ea5776db31abfc0c2dcf9121b58dcffc29c179e95b56f4c21::emergency_council::validate_emergency_council_minter_id(arg2, 0x2::object::id<Minter<T0>>(arg0));
        assert!(is_valid_distribution_config<T0>(arg0, arg1), 401018599948013600);
        assert!(0xd4d7bdc15013391ea5776db31abfc0c2dcf9121b58dcffc29c179e95b56f4c21::distribution_config::is_gauge_alive(arg1, arg3), 812297136203523100);
        let v0 = 0x1::vector::empty<0x2::object::ID>();
        0x1::vector::push_back<0x2::object::ID>(&mut v0, arg3);
        0xd4d7bdc15013391ea5776db31abfc0c2dcf9121b58dcffc29c179e95b56f4c21::distribution_config::update_gauge_liveness(arg1, v0, false);
        let v1 = EventKillGauge{id: arg3};
        0x2::event::emit<EventKillGauge>(v1);
    }

    public fun last_epoch_update_time<T0>(arg0: &Minter<T0>) : u64 {
        arg0.last_epoch_update_time
    }

    fun max_emissions_change_q64() : u128 {
        0x4e212a95eb24d6273e334bf3460f675acd9e371691c4c824bc895e056fc4bae0::full_math_u128::mul_div_floor((11000 as u128), 18446744073709551616, (10000 as u128))
    }

    fun min_emissions_change_q64() : u128 {
        0x4e212a95eb24d6273e334bf3460f675acd9e371691c4c824bc895e056fc4bae0::full_math_u128::mul_div_floor((9000 as u128), 18446744073709551616, (10000 as u128))
    }

    fun mint_o_sail<T0, T1>(arg0: &mut Minter<T0>, arg1: u64, arg2: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<T1> {
        arg0.o_sail_minted_supply = arg0.o_sail_minted_supply + arg1;
        0x2::coin::mint<T1>(borrow_mut_o_sail_cap<T0, T1>(arg0), arg1, arg2)
    }

    fun mint_sail<T0>(arg0: &mut Minter<T0>, arg1: u64, arg2: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<T0> {
        0x2::coin::mint<T0>(0x1::option::borrow_mut<0x2::coin::TreasuryCap<T0>>(&mut arg0.sail_cap), arg1, arg2)
    }

    public fun o_sail_emissions_by_epoch<T0>(arg0: &Minter<T0>, arg1: u64) : u64 {
        if (0x2::table::contains<u64, u64>(&arg0.total_epoch_o_sail_emissions, arg1)) {
            *0x2::table::borrow<u64, u64>(&arg0.total_epoch_o_sail_emissions, arg1)
        } else {
            0
        }
    }

    public fun o_sail_epoch_emissions<T0>(arg0: &Minter<T0>, arg1: &0xd4d7bdc15013391ea5776db31abfc0c2dcf9121b58dcffc29c179e95b56f4c21::distribution_config::DistributionConfig) : u64 {
        assert!(all_gauges_distributed<T0>(arg0, arg1), 371288980415980200);
        o_sail_emissions_by_epoch<T0>(arg0, arg0.active_period - 0xd4d7bdc15013391ea5776db31abfc0c2dcf9121b58dcffc29c179e95b56f4c21::common::epoch())
    }

    public fun o_sail_minted_supply<T0>(arg0: &Minter<T0>) : u64 {
        arg0.o_sail_minted_supply
    }

    public fun pause<T0>(arg0: &mut Minter<T0>, arg1: &AdminCap) {
        check_admin<T0>(arg0, arg1);
        arg0.paused = true;
        let v0 = EventPauseEmission{dummy_field: false};
        0x2::event::emit<EventPauseEmission>(v0);
    }

    public fun protocol_fee_rate<T0>(arg0: &Minter<T0>) : u64 {
        arg0.protocol_fee_rate
    }

    public fun rate_denom() : u64 {
        10000
    }

    public fun reset_gauge<T0, T1, T2>(arg0: &mut Minter<T2>, arg1: &mut 0xd4d7bdc15013391ea5776db31abfc0c2dcf9121b58dcffc29c179e95b56f4c21::distribution_config::DistributionConfig, arg2: &0xd4d7bdc15013391ea5776db31abfc0c2dcf9121b58dcffc29c179e95b56f4c21::emergency_council::EmergencyCouncilCap, arg3: &mut 0xd4d7bdc15013391ea5776db31abfc0c2dcf9121b58dcffc29c179e95b56f4c21::gauge::Gauge<T0, T1>, arg4: u64, arg5: &0x2::clock::Clock) {
        0xd4d7bdc15013391ea5776db31abfc0c2dcf9121b58dcffc29c179e95b56f4c21::emergency_council::validate_emergency_council_minter_id(arg2, 0x2::object::id<Minter<T2>>(arg0));
        assert!(!is_paused<T2>(arg0), 412179529765746000);
        assert!(is_active<T2>(arg0, arg5), 125563751493106940);
        assert!(arg4 > 0, 777730412186606000);
        assert!(is_valid_distribution_config<T2>(arg0, arg1), 726258387105137800);
        let v0 = 0x2::object::id<0xd4d7bdc15013391ea5776db31abfc0c2dcf9121b58dcffc29c179e95b56f4c21::gauge::Gauge<T0, T1>>(arg3);
        assert!(!0xd4d7bdc15013391ea5776db31abfc0c2dcf9121b58dcffc29c179e95b56f4c21::distribution_config::is_gauge_alive(arg1, v0), 452133119942522700);
        assert!(!0x2::table::contains<0x2::object::ID, u64>(&arg0.gauge_active_period, v0) || *0x2::table::borrow<0x2::object::ID, u64>(&arg0.gauge_active_period, v0) < arg0.active_period, 97456931979148290);
        if (0x2::table::contains<0x2::object::ID, u64>(&arg0.gauge_epoch_count, v0)) {
            0x2::table::remove<0x2::object::ID, u64>(&mut arg0.gauge_epoch_count, v0);
        };
        0x2::table::add<0x2::object::ID, u64>(&mut arg0.gauge_epoch_count, v0, 0);
        if (0x2::table::contains<0x2::object::ID, u64>(&arg0.gauge_epoch_emissions_usd, v0)) {
            0x2::table::remove<0x2::object::ID, u64>(&mut arg0.gauge_epoch_emissions_usd, v0);
        };
        0x2::table::add<0x2::object::ID, u64>(&mut arg0.gauge_epoch_emissions_usd, v0, arg4);
        revive_gauge_internal(arg1, v0);
    }

    public fun revive_gauge<T0>(arg0: &mut Minter<T0>, arg1: &mut 0xd4d7bdc15013391ea5776db31abfc0c2dcf9121b58dcffc29c179e95b56f4c21::distribution_config::DistributionConfig, arg2: &0xd4d7bdc15013391ea5776db31abfc0c2dcf9121b58dcffc29c179e95b56f4c21::emergency_council::EmergencyCouncilCap, arg3: 0x2::object::ID) {
        0xd4d7bdc15013391ea5776db31abfc0c2dcf9121b58dcffc29c179e95b56f4c21::emergency_council::validate_emergency_council_minter_id(arg2, 0x2::object::id<Minter<T0>>(arg0));
        assert!(is_valid_distribution_config<T0>(arg0, arg1), 211832148784139800);
        assert!(!0xd4d7bdc15013391ea5776db31abfc0c2dcf9121b58dcffc29c179e95b56f4c21::distribution_config::is_gauge_alive(arg1, arg3), 533150247921935500);
        assert!(0x2::table::contains<0x2::object::ID, u64>(&arg0.gauge_active_period, arg3) && *0x2::table::borrow<0x2::object::ID, u64>(&arg0.gauge_active_period, arg3) == arg0.active_period, 295306155667221200);
        revive_gauge_internal(arg1, arg3);
    }

    fun revive_gauge_internal(arg0: &mut 0xd4d7bdc15013391ea5776db31abfc0c2dcf9121b58dcffc29c179e95b56f4c21::distribution_config::DistributionConfig, arg1: 0x2::object::ID) {
        let v0 = 0x1::vector::empty<0x2::object::ID>();
        0x1::vector::push_back<0x2::object::ID>(&mut v0, arg1);
        0xd4d7bdc15013391ea5776db31abfc0c2dcf9121b58dcffc29c179e95b56f4c21::distribution_config::update_gauge_liveness(arg0, v0, true);
        let v1 = EventReviveGauge{id: arg1};
        0x2::event::emit<EventReviveGauge>(v1);
    }

    public fun revoke_admin<T0>(arg0: &mut Minter<T0>, arg1: &0x2::package::Publisher, arg2: 0x2::object::ID) {
        assert!(0x2::package::from_module<MINTER>(arg1), 729123415718822900);
        0x2::vec_set::insert<0x2::object::ID>(&mut arg0.revoked_admins, arg2);
    }

    public fun revoke_distribute_governor<T0>(arg0: &mut Minter<T0>, arg1: &0x2::package::Publisher, arg2: 0x2::object::ID) {
        assert!(0x2::package::from_module<MINTER>(arg1), 639606009071379600);
        0x2::vec_set::insert<0x2::object::ID>(&mut arg0.revoked_distribute_governors, arg2);
    }

    public fun sail_total_supply<T0>(arg0: &Minter<T0>) : u64 {
        0x2::coin::total_supply<T0>(0x1::option::borrow<0x2::coin::TreasuryCap<T0>>(&arg0.sail_cap))
    }

    public fun schedule_o_sail_mint<T0, T1>(arg0: &mut Minter<T0>, arg1: &mut 0x2::package::Publisher, arg2: u64, arg3: &0x2::clock::Clock, arg4: &mut 0x2::tx_context::TxContext) : TimeLockedOSailMint<T1> {
        assert!(0x2::package::from_module<MINTER>(arg1), 734928593233084000);
        assert!(!is_paused<T0>(arg0), 621003109924614900);
        assert!(is_valid_o_sail_type<T0, T1>(arg0), 348840174999730750);
        assert!(arg2 > 0, 424220271321603000);
        TimeLockedOSailMint<T1>{
            id          : 0x2::object::new(arg4),
            amount      : arg2,
            unlock_time : 0x2::clock::timestamp_ms(arg3) + 86400000,
        }
    }

    public fun schedule_sail_mint<T0>(arg0: &mut Minter<T0>, arg1: &mut 0x2::package::Publisher, arg2: u64, arg3: &0x2::clock::Clock, arg4: &mut 0x2::tx_context::TxContext) : TimeLockedSailMint {
        assert!(0x2::package::from_module<MINTER>(arg1), 716204622969124700);
        assert!(!is_paused<T0>(arg0), 849544693573603300);
        assert!(arg2 > 0, 520351519384544260);
        TimeLockedSailMint{
            id          : 0x2::object::new(arg4),
            amount      : arg2,
            unlock_time : 0x2::clock::timestamp_ms(arg3) + 86400000,
        }
    }

    public fun set_distribute_cap<T0>(arg0: &mut Minter<T0>, arg1: &AdminCap, arg2: 0xd4d7bdc15013391ea5776db31abfc0c2dcf9121b58dcffc29c179e95b56f4c21::distribute_cap::DistributeCap) {
        assert!(!is_paused<T0>(arg0), 939345375978791600);
        check_admin<T0>(arg0, arg1);
        0x1::option::fill<0xd4d7bdc15013391ea5776db31abfc0c2dcf9121b58dcffc29c179e95b56f4c21::distribute_cap::DistributeCap>(&mut arg0.distribute_cap, arg2);
    }

    public fun set_protocol_fee_rate<T0>(arg0: &mut Minter<T0>, arg1: &AdminCap, arg2: u64) {
        check_admin<T0>(arg0, arg1);
        assert!(!is_paused<T0>(arg0), 548722644715498500);
        assert!(arg2 <= 3000, 840171622736257200);
        arg0.protocol_fee_rate = arg2;
    }

    public fun set_reward_distributor_cap<T0>(arg0: &mut Minter<T0>, arg1: &AdminCap, arg2: 0xd4d7bdc15013391ea5776db31abfc0c2dcf9121b58dcffc29c179e95b56f4c21::reward_distributor_cap::RewardDistributorCap) {
        check_admin<T0>(arg0, arg1);
        0x1::option::fill<0xd4d7bdc15013391ea5776db31abfc0c2dcf9121b58dcffc29c179e95b56f4c21::reward_distributor_cap::RewardDistributorCap>(&mut arg0.reward_distributor_cap, arg2);
    }

    public fun set_team_emission_rate<T0>(arg0: &mut Minter<T0>, arg1: &AdminCap, arg2: u64) {
        check_admin<T0>(arg0, arg1);
        assert!(!is_paused<T0>(arg0), 339140718471350200);
        assert!(arg2 <= 500, 922337292161803878);
        arg0.team_emission_rate = arg2;
    }

    public fun set_team_wallet<T0>(arg0: &mut Minter<T0>, arg1: &AdminCap, arg2: address) {
        check_admin<T0>(arg0, arg1);
        assert!(!is_paused<T0>(arg0), 587854778781893500);
        arg0.team_wallet = arg2;
    }

    public fun set_treasury_cap<T0>(arg0: &mut Minter<T0>, arg1: &AdminCap, arg2: 0x2::coin::TreasuryCap<T0>) {
        assert!(!is_paused<T0>(arg0), 179209983522842700);
        check_admin<T0>(arg0, arg1);
        assert!(0x1::option::is_none<0x2::coin::TreasuryCap<T0>>(&arg0.sail_cap), 922337283142372556);
        0x1::option::fill<0x2::coin::TreasuryCap<T0>>(&mut arg0.sail_cap, arg2);
    }

    public fun team_emission_rate<T0>(arg0: &Minter<T0>) : u64 {
        arg0.team_emission_rate
    }

    public fun unpause<T0>(arg0: &mut Minter<T0>, arg1: &AdminCap) {
        check_admin<T0>(arg0, arg1);
        arg0.paused = false;
        let v0 = EventUnpauseEmission{dummy_field: false};
        0x2::event::emit<EventUnpauseEmission>(v0);
    }

    fun update_o_sail_token<T0, T1>(arg0: &mut Minter<T0>, arg1: 0x2::coin::TreasuryCap<T1>, arg2: &0x2::clock::Clock) {
        let v0 = 0x1::type_name::get<T1>();
        assert!(!0x2::bag::contains<0x1::type_name::TypeName>(&arg0.o_sail_caps, v0), 573264404146058900);
        0x1::option::swap_or_fill<0x1::type_name::TypeName>(&mut arg0.current_epoch_o_sail, v0);
        arg0.o_sail_minted_supply = arg0.o_sail_minted_supply + 0x2::coin::total_supply<T1>(&arg1);
        0x2::bag::add<0x1::type_name::TypeName, 0x2::coin::TreasuryCap<T1>>(&mut arg0.o_sail_caps, v0, arg1);
        0x2::table::add<0x1::type_name::TypeName, u64>(&mut arg0.o_sail_expiry_dates, v0, 0xd4d7bdc15013391ea5776db31abfc0c2dcf9121b58dcffc29c179e95b56f4c21::common::current_period(arg2) + 0xd4d7bdc15013391ea5776db31abfc0c2dcf9121b58dcffc29c179e95b56f4c21::common::o_sail_duration() + 0xd4d7bdc15013391ea5776db31abfc0c2dcf9121b58dcffc29c179e95b56f4c21::common::epoch());
    }

    public fun update_period<T0, T1>(arg0: &mut Minter<T0>, arg1: &mut 0xd4d7bdc15013391ea5776db31abfc0c2dcf9121b58dcffc29c179e95b56f4c21::voter::Voter, arg2: &0xd4d7bdc15013391ea5776db31abfc0c2dcf9121b58dcffc29c179e95b56f4c21::distribution_config::DistributionConfig, arg3: &DistributeGovernorCap, arg4: &0xd4d7bdc15013391ea5776db31abfc0c2dcf9121b58dcffc29c179e95b56f4c21::voting_escrow::VotingEscrow<T0>, arg5: &mut 0xd4d7bdc15013391ea5776db31abfc0c2dcf9121b58dcffc29c179e95b56f4c21::reward_distributor::RewardDistributor<T0>, arg6: 0x2::coin::TreasuryCap<T1>, arg7: &0x2::clock::Clock, arg8: &mut 0x2::tx_context::TxContext) {
        assert!(!is_paused<T0>(arg0), 540422149172903100);
        check_distribute_governor<T0>(arg0, arg3);
        assert!(is_valid_distribution_config<T0>(arg0, arg2), 222427100417155840);
        assert!(is_active<T0>(arg0, arg7), 922337339406490010);
        assert!(arg0.active_period + 0xd4d7bdc15013391ea5776db31abfc0c2dcf9121b58dcffc29c179e95b56f4c21::common::epoch() < 0xd4d7bdc15013391ea5776db31abfc0c2dcf9121b58dcffc29c179e95b56f4c21::common::current_timestamp(arg7), 922337340695058843);
        assert!(all_gauges_distributed<T0>(arg0, arg2), 150036217874985900);
        let v0 = o_sail_epoch_emissions<T0>(arg0, arg2);
        update_o_sail_token<T0, T1>(arg0, arg6, arg7);
        let v1 = calculate_rebase_growth(v0, total_supply<T0>(arg0), 0xd4d7bdc15013391ea5776db31abfc0c2dcf9121b58dcffc29c179e95b56f4c21::voting_escrow::total_locked<T0>(arg4));
        if (arg0.team_emission_rate > 0 && arg0.team_wallet != @0x0) {
            let v2 = 0x4e212a95eb24d6273e334bf3460f675acd9e371691c4c824bc895e056fc4bae0::full_math_u64::mul_div_floor(arg0.team_emission_rate, v1 + v0, 10000 - arg0.team_emission_rate);
            let v3 = mint_sail<T0>(arg0, v2, arg8);
            0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(v3, arg0.team_wallet);
        };
        if (v1 > 0) {
            let v4 = mint_sail<T0>(arg0, v1, arg8);
            0xd4d7bdc15013391ea5776db31abfc0c2dcf9121b58dcffc29c179e95b56f4c21::reward_distributor::checkpoint_token<T0>(arg5, 0x1::option::borrow<0xd4d7bdc15013391ea5776db31abfc0c2dcf9121b58dcffc29c179e95b56f4c21::reward_distributor_cap::RewardDistributorCap>(&arg0.reward_distributor_cap), v4, arg7);
        };
        0xd4d7bdc15013391ea5776db31abfc0c2dcf9121b58dcffc29c179e95b56f4c21::voter::notify_epoch_token<T1>(arg1, 0x1::option::borrow<0xd4d7bdc15013391ea5776db31abfc0c2dcf9121b58dcffc29c179e95b56f4c21::distribute_cap::DistributeCap>(&arg0.distribute_cap), arg8);
        arg0.active_period = 0xd4d7bdc15013391ea5776db31abfc0c2dcf9121b58dcffc29c179e95b56f4c21::common::current_period(arg7);
        0xd4d7bdc15013391ea5776db31abfc0c2dcf9121b58dcffc29c179e95b56f4c21::reward_distributor::update_active_period<T0>(arg5, 0x1::option::borrow<0xd4d7bdc15013391ea5776db31abfc0c2dcf9121b58dcffc29c179e95b56f4c21::reward_distributor_cap::RewardDistributorCap>(&arg0.reward_distributor_cap), arg0.active_period);
        let v5 = EventUpdateEpoch{
            new_period                   : arg0.active_period,
            finished_epoch_emissions     : v0,
            finished_epoch_growth_rebase : v1,
        };
        0x2::event::emit<EventUpdateEpoch>(v5);
    }

    public fun update_voted_weights<T0>(arg0: &mut Minter<T0>, arg1: &mut 0xd4d7bdc15013391ea5776db31abfc0c2dcf9121b58dcffc29c179e95b56f4c21::voter::Voter, arg2: &DistributeGovernorCap, arg3: 0x2::object::ID, arg4: vector<u64>, arg5: vector<0x2::object::ID>, arg6: u64, arg7: bool, arg8: &0x2::clock::Clock, arg9: &mut 0x2::tx_context::TxContext) {
        check_distribute_governor<T0>(arg0, arg2);
        0xd4d7bdc15013391ea5776db31abfc0c2dcf9121b58dcffc29c179e95b56f4c21::voter::update_voted_weights(arg1, 0x1::option::borrow<0xd4d7bdc15013391ea5776db31abfc0c2dcf9121b58dcffc29c179e95b56f4c21::distribute_cap::DistributeCap>(&arg0.distribute_cap), arg3, arg4, arg5, arg6, arg7, arg8, arg9);
    }

    public fun usd_emissions_by_epoch<T0>(arg0: &Minter<T0>, arg1: u64) : u64 {
        if (0x2::table::contains<u64, u64>(&arg0.total_epoch_emissions_usd, arg1)) {
            *0x2::table::borrow<u64, u64>(&arg0.total_epoch_emissions_usd, arg1)
        } else {
            0
        }
    }

    public fun usd_epoch_emissions<T0>(arg0: &Minter<T0>) : u64 {
        usd_emissions_by_epoch<T0>(arg0, arg0.active_period)
    }

    public fun whitelist_pool<T0, T1, T2>(arg0: &mut Minter<T0>, arg1: &AdminCap, arg2: &0xd9d2135d6efbbd95909338e5d1809c48854a35a2f95228ebf28d5fe0faf46234::pool::Pool<T1, T2>, arg3: bool) {
        assert!(!is_paused<T0>(arg0), 316161888154524900);
        check_admin<T0>(arg0, arg1);
        let v0 = 0x2::object::id<0xd9d2135d6efbbd95909338e5d1809c48854a35a2f95228ebf28d5fe0faf46234::pool::Pool<T1, T2>>(arg2);
        if (0x2::vec_set::contains<0x2::object::ID>(&arg0.whitelisted_pools, &v0)) {
            if (!arg3) {
                0x2::vec_set::remove<0x2::object::ID>(&mut arg0.whitelisted_pools, &v0);
            };
        } else if (arg3) {
            0x2::vec_set::insert<0x2::object::ID>(&mut arg0.whitelisted_pools, v0);
        };
    }

    // decompiled from Move bytecode v6
}

