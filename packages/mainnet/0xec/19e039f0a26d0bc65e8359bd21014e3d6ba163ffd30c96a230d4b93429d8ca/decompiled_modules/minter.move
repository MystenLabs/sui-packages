module 0xebd610a15f0caa02527f4544eaf56fb4655ef493e8654f44a14220e442245d2e::minter {
    struct AdminCap has store, key {
        id: 0x2::object::UID,
    }

    struct DistributeGovernorCap has store, key {
        id: 0x2::object::UID,
    }

    struct MINTER has drop {
        dummy_field: bool,
    }

    struct EventActivateMinter has copy, drop, store {
        activated_at: u64,
        active_period: u64,
        epoch_o_sail_type: 0x1::type_name::TypeName,
    }

    struct EventUpdateEpoch has copy, drop, store {
        new_period: u64,
        updated_at: u64,
        prev_prev_epoch_o_sail_emissions: u64,
        team_emissions: u64,
        finished_epoch_growth_rebase: u64,
        epoch_o_sail_type: 0x1::type_name::TypeName,
    }

    struct EventReviveGauge has copy, drop, store {
        id: 0x2::object::ID,
    }

    struct EventResetGauge has copy, drop, store {
        id: 0x2::object::ID,
        gauge_base_emissions: u64,
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

    struct EventStopEmission has copy, drop, store {
        dummy_field: bool,
    }

    struct EventResumeEmission has copy, drop, store {
        dummy_field: bool,
    }

    struct EventGrantAdmin has copy, drop, store {
        who: address,
        admin_cap: 0x2::object::ID,
    }

    struct EventRevokeAdmin has copy, drop, store {
        admin_cap: 0x2::object::ID,
    }

    struct EventGrantDistributeGovernor has copy, drop, store {
        who: address,
        distribute_governor_cap: 0x2::object::ID,
    }

    struct EventRevokeDistributeGovernor has copy, drop, store {
        distribute_governor_cap: 0x2::object::ID,
    }

    struct EventSetTreasuryCap has copy, drop, store {
        treasury_cap: 0x2::object::ID,
        token_type: 0x1::type_name::TypeName,
    }

    struct EventSetRebaseDistributorCap has copy, drop, store {
        rebase_distributor_cap: 0x2::object::ID,
    }

    struct EventSetDistributeCap has copy, drop, store {
        admin_cap: 0x2::object::ID,
        distribute_cap: 0x2::object::ID,
    }

    struct EventUpdateTeamEmissionRate has copy, drop, store {
        admin_cap: 0x2::object::ID,
        team_emission_rate: u64,
    }

    struct EventUpdateProtocolFeeRate has copy, drop, store {
        admin_cap: 0x2::object::ID,
        protocol_fee_rate: u64,
    }

    struct EventSetTeamWallet has copy, drop, store {
        admin_cap: 0x2::object::ID,
        team_wallet: address,
    }

    struct EventSetProtocolWallet has copy, drop, store {
        admin_cap: 0x2::object::ID,
        protocol_wallet: address,
    }

    struct EventSetOperationsWallet has copy, drop, store {
        admin_cap: 0x2::object::ID,
        operations_wallet: address,
    }

    struct EventDistributeProtocol has copy, drop, store {
        protocol_wallet: address,
        amount: u64,
        token_type: 0x1::type_name::TypeName,
    }

    struct EventDistributeOperations has copy, drop, store {
        operations_wallet: address,
        amount: u64,
        token_type: 0x1::type_name::TypeName,
    }

    struct EventDistributeExerciseFeeToReward has copy, drop, store {
        admin_cap_id: 0x2::object::ID,
        amount: u64,
        token_type: 0x1::type_name::TypeName,
    }

    struct EventGaugeCreated has copy, drop, store {
        id: 0x2::object::ID,
        pool_id: 0x2::object::ID,
        base_emissions: u64,
    }

    struct EventDistributeGauge has copy, drop, store {
        gauge_id: 0x2::object::ID,
        pool_id: 0x2::object::ID,
        o_sail_type: 0x1::type_name::TypeName,
        next_epoch_emissions_usd: u64,
        ended_epoch_o_sail_emission: u64,
    }

    struct EventIncreaseGaugeEmissions has copy, drop, store {
        gauge_id: 0x2::object::ID,
        pool_id: 0x2::object::ID,
        emissions_increase_usd: u64,
        o_sail_type: 0x1::type_name::TypeName,
    }

    struct EventNullGaugeEmissions has copy, drop, store {
        gauge_id: 0x2::object::ID,
        pool_id: 0x2::object::ID,
        rewards_nulled_usd: u64,
        new_gauge_epoch_emissions_usd: u64,
        new_total_epoch_emissions_usd: u64,
    }

    struct EventCreateLockFromOSail has copy, drop, store {
        o_sail_amount_in: u64,
        o_sail_type: 0x1::type_name::TypeName,
        sail_amount_to_lock: u64,
        o_sail_expired: bool,
        duration: u64,
        permanent: bool,
    }

    struct EventDepositOSailIntoLock has copy, drop, store {
        o_sail_amount_in: u64,
        o_sail_type: 0x1::type_name::TypeName,
        sail_amount_to_lock: u64,
        lock_id: 0x2::object::ID,
    }

    struct EventExerciseOSail has copy, drop, store {
        o_sail_amount_in: u64,
        sail_amount_out: u64,
        o_sail_type: 0x1::type_name::TypeName,
        exercise_fee_token_type: 0x1::type_name::TypeName,
        exercise_fee_amount: u64,
        protocol_fee_amount: u64,
        fee_to_distribute: u64,
    }

    struct EventWhitelistUSD has copy, drop, store {
        usd_type: 0x1::type_name::TypeName,
        whitelisted: bool,
    }

    struct EventSetOSailPriceAggregator has copy, drop, store {
        price_aggregator: 0x2::object::ID,
    }

    struct EventSetSailPriceAggregator has copy, drop, store {
        price_aggregator: 0x2::object::ID,
    }

    struct EventSetLiquidityUpdateCooldown has copy, drop, store {
        new_cooldown: u64,
    }

    struct EventSetEarlyWithdrawalPenaltyPercentage has copy, drop, store {
        new_penalty_percentage: u64,
    }

    struct EventScheduleTimeLockedMint has copy, drop, store {
        amount: u64,
        unlock_time: u64,
        is_osail: bool,
        token_type: 0x1::type_name::TypeName,
    }

    struct EventCancelTimeLockedMint has copy, drop, store {
        id: 0x2::object::ID,
        amount: u64,
        token_type: 0x1::type_name::TypeName,
        is_osail: bool,
    }

    struct EventMint has copy, drop, store {
        amount: u64,
        token_type: 0x1::type_name::TypeName,
        is_osail: bool,
    }

    struct EventBurn has copy, drop, store {
        amount: u64,
        token_type: 0x1::type_name::TypeName,
        is_osail: bool,
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

    struct EventClaimPositionReward has copy, drop, store {
        from: address,
        gauge_id: 0x2::object::ID,
        pool_id: 0x2::object::ID,
        position_id: 0x2::object::ID,
        amount: u64,
        growth_inside: u128,
        token: 0x1::type_name::TypeName,
    }

    struct Minter<phantom T0> has store, key {
        id: 0x2::object::UID,
        revoked_admins: 0x2::vec_set::VecSet<0x2::object::ID>,
        revoked_distribute_governors: 0x2::vec_set::VecSet<0x2::object::ID>,
        paused: bool,
        emission_stopped: bool,
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
        protocol_wallet: address,
        operations_wallet: address,
        rebase_distributor_cap: 0x1::option::Option<0xebd610a15f0caa02527f4544eaf56fb4655ef493e8654f44a14220e442245d2e::rebase_distributor_cap::RebaseDistributorCap>,
        distribute_cap: 0x1::option::Option<0xebd610a15f0caa02527f4544eaf56fb4655ef493e8654f44a14220e442245d2e::distribute_cap::DistributeCap>,
        whitelisted_usd: 0x2::vec_set::VecSet<0x1::type_name::TypeName>,
        exercise_fee_protocol_balances: 0x2::bag::Bag,
        exercise_fee_operations_balances: 0x2::bag::Bag,
        gauge_epoch_emissions_usd: 0x2::table::Table<0x2::object::ID, u64>,
        gauge_active_period: 0x2::table::Table<0x2::object::ID, u64>,
        gauge_epoch_count: 0x2::table::Table<0x2::object::ID, u64>,
        total_epoch_emissions_usd: 0x2::table::Table<u64, u64>,
        total_epoch_o_sail_emissions: 0x2::table::Table<u64, u64>,
        distribution_config: 0x2::object::ID,
        max_emission_change_ratio: u64,
        bag: 0x2::bag::Bag,
    }

    public fun total_supply<T0>(arg0: &Minter<T0>) : u64 {
        sail_total_supply<T0>(arg0) + arg0.o_sail_minted_supply
    }

    public fun set_early_withdrawal_penalty_percentage<T0>(arg0: &mut Minter<T0>, arg1: &AdminCap, arg2: &mut 0xebd610a15f0caa02527f4544eaf56fb4655ef493e8654f44a14220e442245d2e::distribution_config::DistributionConfig, arg3: u64) {
        0xebd610a15f0caa02527f4544eaf56fb4655ef493e8654f44a14220e442245d2e::distribution_config::checked_package_version(arg2);
        check_admin<T0>(arg0, arg1);
        assert!(is_valid_distribution_config<T0>(arg0, arg2), 869469108643585500);
        0xebd610a15f0caa02527f4544eaf56fb4655ef493e8654f44a14220e442245d2e::distribution_config::set_early_withdrawal_penalty_percentage(arg2, arg3);
        let v0 = EventSetEarlyWithdrawalPenaltyPercentage{new_penalty_percentage: arg3};
        0x2::event::emit<EventSetEarlyWithdrawalPenaltyPercentage>(v0);
    }

    public fun set_liquidity_update_cooldown<T0>(arg0: &mut Minter<T0>, arg1: &AdminCap, arg2: &mut 0xebd610a15f0caa02527f4544eaf56fb4655ef493e8654f44a14220e442245d2e::distribution_config::DistributionConfig, arg3: u64) {
        0xebd610a15f0caa02527f4544eaf56fb4655ef493e8654f44a14220e442245d2e::distribution_config::checked_package_version(arg2);
        check_admin<T0>(arg0, arg1);
        assert!(is_valid_distribution_config<T0>(arg0, arg2), 869469108643585500);
        0xebd610a15f0caa02527f4544eaf56fb4655ef493e8654f44a14220e442245d2e::distribution_config::set_liquidity_update_cooldown(arg2, arg3);
        let v0 = EventSetLiquidityUpdateCooldown{new_cooldown: arg3};
        0x2::event::emit<EventSetLiquidityUpdateCooldown>(v0);
    }

    public fun set_o_sail_price_aggregator<T0>(arg0: &mut Minter<T0>, arg1: &AdminCap, arg2: &mut 0xebd610a15f0caa02527f4544eaf56fb4655ef493e8654f44a14220e442245d2e::distribution_config::DistributionConfig, arg3: &0xc3c7e6eb7202e9fb0389a2f7542b91cc40e4f7a33c02554fec11c4c92f938ea3::aggregator::Aggregator) {
        0xebd610a15f0caa02527f4544eaf56fb4655ef493e8654f44a14220e442245d2e::distribution_config::checked_package_version(arg2);
        check_admin<T0>(arg0, arg1);
        assert!(is_valid_distribution_config<T0>(arg0, arg2), 615700294268918300);
        0xebd610a15f0caa02527f4544eaf56fb4655ef493e8654f44a14220e442245d2e::distribution_config::set_o_sail_price_aggregator(arg2, arg3);
        let v0 = EventSetOSailPriceAggregator{price_aggregator: 0x2::object::id<0xc3c7e6eb7202e9fb0389a2f7542b91cc40e4f7a33c02554fec11c4c92f938ea3::aggregator::Aggregator>(arg3)};
        0x2::event::emit<EventSetOSailPriceAggregator>(v0);
    }

    public fun set_sail_price_aggregator<T0>(arg0: &mut Minter<T0>, arg1: &AdminCap, arg2: &mut 0xebd610a15f0caa02527f4544eaf56fb4655ef493e8654f44a14220e442245d2e::distribution_config::DistributionConfig, arg3: &0xc3c7e6eb7202e9fb0389a2f7542b91cc40e4f7a33c02554fec11c4c92f938ea3::aggregator::Aggregator) {
        0xebd610a15f0caa02527f4544eaf56fb4655ef493e8654f44a14220e442245d2e::distribution_config::checked_package_version(arg2);
        check_admin<T0>(arg0, arg1);
        assert!(is_valid_distribution_config<T0>(arg0, arg2), 869469108643585500);
        0xebd610a15f0caa02527f4544eaf56fb4655ef493e8654f44a14220e442245d2e::distribution_config::set_sail_price_aggregator(arg2, arg3);
        let v0 = EventSetSailPriceAggregator{price_aggregator: 0x2::object::id<0xc3c7e6eb7202e9fb0389a2f7542b91cc40e4f7a33c02554fec11c4c92f938ea3::aggregator::Aggregator>(arg3)};
        0x2::event::emit<EventSetSailPriceAggregator>(v0);
    }

    public fun sync_o_sail_distribution_price<T0, T1, T2, T3, T4>(arg0: &mut Minter<T4>, arg1: &mut 0xebd610a15f0caa02527f4544eaf56fb4655ef493e8654f44a14220e442245d2e::distribution_config::DistributionConfig, arg2: &mut 0xebd610a15f0caa02527f4544eaf56fb4655ef493e8654f44a14220e442245d2e::gauge::Gauge<T0, T1>, arg3: &mut 0xaa3ae572fb09f157d7368ce22c6b7f33fde0fe74cba75ae9679af52088b57bb0::pool::Pool<T0, T1>, arg4: &mut 0x932133ea33d895f55693eb0949fe25c9007f1af976683fcbb30c32126b2aa9fb::price_monitor::PriceMonitor, arg5: &0xaa3ae572fb09f157d7368ce22c6b7f33fde0fe74cba75ae9679af52088b57bb0::pool::Pool<T2, T3>, arg6: &0xc3c7e6eb7202e9fb0389a2f7542b91cc40e4f7a33c02554fec11c4c92f938ea3::aggregator::Aggregator, arg7: &0x2::clock::Clock) {
        0xebd610a15f0caa02527f4544eaf56fb4655ef493e8654f44a14220e442245d2e::distribution_config::checked_package_version(arg1);
        assert!(gauge_distributed<T4>(arg0, 0x2::object::id<0xebd610a15f0caa02527f4544eaf56fb4655ef493e8654f44a14220e442245d2e::gauge::Gauge<T0, T1>>(arg2)), 243036335954370780);
        assert!(is_valid_distribution_config<T4>(arg0, arg1), 578889065004501400);
        assert!(is_active<T4>(arg0, arg7), 204872681976552500);
        assert!(!is_paused<T4>(arg0), 566083930742334200);
        assert!(!is_emission_stopped<T4>(arg0), 123456789012345678);
        assert!(0xebd610a15f0caa02527f4544eaf56fb4655ef493e8654f44a14220e442245d2e::distribution_config::is_valid_sail_price_aggregator(arg1, arg6), 48171994695305640);
        assert!(0x1::type_name::get<T2>() == 0x1::type_name::get<T4>() || 0x1::type_name::get<T3>() == 0x1::type_name::get<T4>(), 939179427939211244);
        let (v0, v1) = get_aggregator_price_without_decimals<T2, T3, T4>(arg0, arg4, arg5, arg6, arg7);
        if (v1) {
            return
        };
        0xebd610a15f0caa02527f4544eaf56fb4655ef493e8654f44a14220e442245d2e::gauge::sync_o_sail_distribution_price<T0, T1>(arg2, arg1, arg3, v0, arg7);
    }

    public fun activate<T0, T1>(arg0: &mut Minter<T0>, arg1: &mut 0xebd610a15f0caa02527f4544eaf56fb4655ef493e8654f44a14220e442245d2e::voter::Voter, arg2: &0xebd610a15f0caa02527f4544eaf56fb4655ef493e8654f44a14220e442245d2e::distribution_config::DistributionConfig, arg3: &AdminCap, arg4: &mut 0xebd610a15f0caa02527f4544eaf56fb4655ef493e8654f44a14220e442245d2e::rebase_distributor::RebaseDistributor<T0>, arg5: 0x2::coin::TreasuryCap<T1>, arg6: &0x2::coin::CoinMetadata<T1>, arg7: &0x2::clock::Clock, arg8: &mut 0x2::tx_context::TxContext) {
        0xebd610a15f0caa02527f4544eaf56fb4655ef493e8654f44a14220e442245d2e::distribution_config::checked_package_version(arg2);
        assert!(0x2::coin::get_decimals<T1>(arg6) == 0x61d3c07c67f6ebcc46c950a731dd263a0325fdfe03382e1bd50e4aba964f9e1c::common::sail_decimals(), 305250931597320450);
        activate_internal<T0, T1>(arg0, arg1, arg3, arg4, arg5, arg7, arg8);
    }

    fun activate_internal<T0, T1>(arg0: &mut Minter<T0>, arg1: &mut 0xebd610a15f0caa02527f4544eaf56fb4655ef493e8654f44a14220e442245d2e::voter::Voter, arg2: &AdminCap, arg3: &mut 0xebd610a15f0caa02527f4544eaf56fb4655ef493e8654f44a14220e442245d2e::rebase_distributor::RebaseDistributor<T0>, arg4: 0x2::coin::TreasuryCap<T1>, arg5: &0x2::clock::Clock, arg6: &mut 0x2::tx_context::TxContext) {
        check_admin<T0>(arg0, arg2);
        assert!(!is_paused<T0>(arg0), 996659030249798900);
        assert!(!is_active<T0>(arg0, arg5), 922337310630222234);
        0x2::object::id<0xebd610a15f0caa02527f4544eaf56fb4655ef493e8654f44a14220e442245d2e::rebase_distributor::RebaseDistributor<T0>>(arg3);
        assert!(0x1::option::is_some<0xebd610a15f0caa02527f4544eaf56fb4655ef493e8654f44a14220e442245d2e::rebase_distributor_cap::RebaseDistributorCap>(&arg0.rebase_distributor_cap), 922337311059823823);
        update_o_sail_token<T0, T1>(arg0, arg4, arg5);
        0xebd610a15f0caa02527f4544eaf56fb4655ef493e8654f44a14220e442245d2e::voter::notify_epoch_token<T1>(arg1, 0x1::option::borrow<0xebd610a15f0caa02527f4544eaf56fb4655ef493e8654f44a14220e442245d2e::distribute_cap::DistributeCap>(&arg0.distribute_cap), arg6);
        let v0 = 0x61d3c07c67f6ebcc46c950a731dd263a0325fdfe03382e1bd50e4aba964f9e1c::common::current_timestamp(arg5);
        arg0.activated_at = v0;
        arg0.active_period = 0x61d3c07c67f6ebcc46c950a731dd263a0325fdfe03382e1bd50e4aba964f9e1c::common::to_period(arg0.activated_at);
        arg0.last_epoch_update_time = v0;
        0xebd610a15f0caa02527f4544eaf56fb4655ef493e8654f44a14220e442245d2e::rebase_distributor::start<T0>(arg3, 0x1::option::borrow<0xebd610a15f0caa02527f4544eaf56fb4655ef493e8654f44a14220e442245d2e::rebase_distributor_cap::RebaseDistributorCap>(&arg0.rebase_distributor_cap), arg0.active_period, arg5);
        let v1 = EventActivateMinter{
            activated_at      : v0,
            active_period     : arg0.active_period,
            epoch_o_sail_type : 0x1::type_name::get<T1>(),
        };
        0x2::event::emit<EventActivateMinter>(v1);
    }

    public fun activated_at<T0>(arg0: &Minter<T0>) : u64 {
        arg0.activated_at
    }

    public fun active_period<T0>(arg0: &Minter<T0>) : u64 {
        arg0.active_period
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

    public fun borrow_whitelisted_usd<T0>(arg0: &Minter<T0>) : &0x2::vec_set::VecSet<0x1::type_name::TypeName> {
        &arg0.whitelisted_usd
    }

    fun burn_o_sail<T0, T1>(arg0: &mut Minter<T0>, arg1: 0x2::coin::Coin<T1>) : u64 {
        assert!(!is_paused<T0>(arg0), 947382564018592637);
        assert!(is_valid_o_sail_type<T0, T1>(arg0), 665869556650983200);
        let v0 = borrow_mut_o_sail_cap<T0, T1>(arg0);
        let v1 = 0x2::coin::burn<T1>(v0, arg1);
        arg0.o_sail_minted_supply = arg0.o_sail_minted_supply - v1;
        let v2 = EventBurn{
            amount     : v1,
            token_type : 0x1::type_name::get<T1>(),
            is_osail   : true,
        };
        0x2::event::emit<EventBurn>(v2);
        v1
    }

    public fun calculate_rebase_growth(arg0: u64, arg1: u64, arg2: u64) : u64 {
        if (arg1 == 0) {
            return 0
        };
        0x6b904ae739b2baad330aae14991abcd3b7354d3dc3db72507ed8dabeeb7a36de::full_math_u64::mul_div_ceil(0x6b904ae739b2baad330aae14991abcd3b7354d3dc3db72507ed8dabeeb7a36de::full_math_u64::mul_div_ceil(arg0, arg1 - arg2, arg1), arg1 - arg2, arg1) / 2
    }

    public fun cancel_o_sail_mint<T0>(arg0: &0xebd610a15f0caa02527f4544eaf56fb4655ef493e8654f44a14220e442245d2e::distribution_config::DistributionConfig, arg1: TimeLockedOSailMint<T0>) {
        0xebd610a15f0caa02527f4544eaf56fb4655ef493e8654f44a14220e442245d2e::distribution_config::checked_package_version(arg0);
        let TimeLockedOSailMint {
            id          : v0,
            amount      : v1,
            unlock_time : _,
        } = arg1;
        let v3 = v0;
        let v4 = EventCancelTimeLockedMint{
            id         : 0x2::object::uid_to_inner(&v3),
            amount     : v1,
            token_type : 0x1::type_name::get<T0>(),
            is_osail   : true,
        };
        0x2::event::emit<EventCancelTimeLockedMint>(v4);
        0x2::object::delete(v3);
    }

    public fun cancel_sail_mint<T0>(arg0: &Minter<T0>, arg1: TimeLockedSailMint) {
        let TimeLockedSailMint {
            id          : v0,
            amount      : v1,
            unlock_time : _,
        } = arg1;
        let v3 = v0;
        let v4 = EventCancelTimeLockedMint{
            id         : 0x2::object::uid_to_inner(&v3),
            amount     : v1,
            token_type : 0x1::type_name::get<T0>(),
            is_osail   : false,
        };
        0x2::event::emit<EventCancelTimeLockedMint>(v4);
        0x2::object::delete(v3);
    }

    public fun check_admin<T0>(arg0: &Minter<T0>, arg1: &AdminCap) {
        let v0 = 0x2::object::id<AdminCap>(arg1);
        assert!(!0x2::vec_set::contains<0x2::object::ID>(&arg0.revoked_admins, &v0), 922337280994888908);
    }

    public fun check_distribute_governor<T0>(arg0: &Minter<T0>, arg1: &DistributeGovernorCap) {
        let v0 = 0x2::object::id<DistributeGovernorCap>(arg1);
        assert!(!0x2::vec_set::contains<0x2::object::ID>(&arg0.revoked_distribute_governors, &v0), 369612027923601500);
    }

    public fun claim_unclaimed_o_sail<T0, T1, T2, T3>(arg0: &mut Minter<T2>, arg1: &0xebd610a15f0caa02527f4544eaf56fb4655ef493e8654f44a14220e442245d2e::distribution_config::DistributionConfig, arg2: &AdminCap, arg3: &mut 0xebd610a15f0caa02527f4544eaf56fb4655ef493e8654f44a14220e442245d2e::gauge::Gauge<T0, T1>, arg4: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<T3> {
        0xebd610a15f0caa02527f4544eaf56fb4655ef493e8654f44a14220e442245d2e::distribution_config::checked_package_version(arg1);
        check_admin<T2>(arg0, arg2);
        assert!(is_valid_epoch_token<T2, T3>(arg0), 934963468982192254);
        let v0 = 0xebd610a15f0caa02527f4544eaf56fb4655ef493e8654f44a14220e442245d2e::gauge::remove_unclaimed_o_sail<T0, T1>(arg3);
        if (v0 == 0) {
            return 0x2::coin::zero<T3>(arg4)
        };
        mint_o_sail<T2, T3>(arg0, v0, arg4)
    }

    public fun create<T0>(arg0: &0x2::package::Publisher, arg1: 0x1::option::Option<0x2::coin::TreasuryCap<T0>>, arg2: &0x2::coin::CoinMetadata<T0>, arg3: 0x2::object::ID, arg4: &mut 0x2::tx_context::TxContext) : (Minter<T0>, AdminCap) {
        assert!(0x2::coin::get_decimals<T0>(arg2) == 0x61d3c07c67f6ebcc46c950a731dd263a0325fdfe03382e1bd50e4aba964f9e1c::common::sail_decimals(), 744215000566210300);
        create_internal<T0>(arg0, arg1, arg3, arg4)
    }

    public fun create_gauge<T0, T1, T2>(arg0: &mut Minter<T2>, arg1: &mut 0xebd610a15f0caa02527f4544eaf56fb4655ef493e8654f44a14220e442245d2e::voter::Voter, arg2: &mut 0xebd610a15f0caa02527f4544eaf56fb4655ef493e8654f44a14220e442245d2e::distribution_config::DistributionConfig, arg3: &0x500636366963eb62bee705e420dacd6e3770447914043d7978deb49372401e::gauge_cap::CreateCap, arg4: &AdminCap, arg5: &0x61d3c07c67f6ebcc46c950a731dd263a0325fdfe03382e1bd50e4aba964f9e1c::voting_escrow::VotingEscrow<T2>, arg6: &mut 0xaa3ae572fb09f157d7368ce22c6b7f33fde0fe74cba75ae9679af52088b57bb0::pool::Pool<T0, T1>, arg7: u64, arg8: &0x2::clock::Clock, arg9: &mut 0x2::tx_context::TxContext) : 0xebd610a15f0caa02527f4544eaf56fb4655ef493e8654f44a14220e442245d2e::gauge::Gauge<T0, T1> {
        0xebd610a15f0caa02527f4544eaf56fb4655ef493e8654f44a14220e442245d2e::distribution_config::checked_package_version(arg2);
        assert!(!is_paused<T2>(arg0), 173400731963214500);
        check_admin<T2>(arg0, arg4);
        assert!(arg7 > 0, 676230237726862100);
        let v0 = 0xebd610a15f0caa02527f4544eaf56fb4655ef493e8654f44a14220e442245d2e::voter::create_gauge<T0, T1, T2>(arg1, arg2, arg3, 0x1::option::borrow<0xebd610a15f0caa02527f4544eaf56fb4655ef493e8654f44a14220e442245d2e::distribute_cap::DistributeCap>(&arg0.distribute_cap), arg5, arg6, arg8, arg9);
        let v1 = 0x2::object::id<0xebd610a15f0caa02527f4544eaf56fb4655ef493e8654f44a14220e442245d2e::gauge::Gauge<T0, T1>>(&v0);
        0x2::table::add<0x2::object::ID, u64>(&mut arg0.gauge_epoch_emissions_usd, v1, arg7);
        let v2 = EventGaugeCreated{
            id             : v1,
            pool_id        : 0x2::object::id<0xaa3ae572fb09f157d7368ce22c6b7f33fde0fe74cba75ae9679af52088b57bb0::pool::Pool<T0, T1>>(arg6),
            base_emissions : arg7,
        };
        0x2::event::emit<EventGaugeCreated>(v2);
        v0
    }

    fun create_internal<T0>(arg0: &0x2::package::Publisher, arg1: 0x1::option::Option<0x2::coin::TreasuryCap<T0>>, arg2: 0x2::object::ID, arg3: &mut 0x2::tx_context::TxContext) : (Minter<T0>, AdminCap) {
        assert!(0x2::package::from_module<MINTER>(arg0), 695309471293028100);
        let v0 = Minter<T0>{
            id                               : 0x2::object::new(arg3),
            revoked_admins                   : 0x2::vec_set::empty<0x2::object::ID>(),
            revoked_distribute_governors     : 0x2::vec_set::empty<0x2::object::ID>(),
            paused                           : false,
            emission_stopped                 : false,
            activated_at                     : 0,
            active_period                    : 0,
            current_epoch_o_sail             : 0x1::option::none<0x1::type_name::TypeName>(),
            last_epoch_update_time           : 0,
            sail_cap                         : arg1,
            o_sail_caps                      : 0x2::bag::new(arg3),
            o_sail_minted_supply             : 0,
            o_sail_expiry_dates              : 0x2::table::new<0x1::type_name::TypeName, u64>(arg3),
            team_emission_rate               : 0,
            protocol_fee_rate                : 1000,
            team_wallet                      : @0x0,
            protocol_wallet                  : @0x0,
            operations_wallet                : @0x0,
            rebase_distributor_cap           : 0x1::option::none<0xebd610a15f0caa02527f4544eaf56fb4655ef493e8654f44a14220e442245d2e::rebase_distributor_cap::RebaseDistributorCap>(),
            distribute_cap                   : 0x1::option::none<0xebd610a15f0caa02527f4544eaf56fb4655ef493e8654f44a14220e442245d2e::distribute_cap::DistributeCap>(),
            whitelisted_usd                  : 0x2::vec_set::empty<0x1::type_name::TypeName>(),
            exercise_fee_protocol_balances   : 0x2::bag::new(arg3),
            exercise_fee_operations_balances : 0x2::bag::new(arg3),
            gauge_epoch_emissions_usd        : 0x2::table::new<0x2::object::ID, u64>(arg3),
            gauge_active_period              : 0x2::table::new<0x2::object::ID, u64>(arg3),
            gauge_epoch_count                : 0x2::table::new<0x2::object::ID, u64>(arg3),
            total_epoch_emissions_usd        : 0x2::table::new<u64, u64>(arg3),
            total_epoch_o_sail_emissions     : 0x2::table::new<u64, u64>(arg3),
            distribution_config              : arg2,
            max_emission_change_ratio        : 20,
            bag                              : 0x2::bag::new(arg3),
        };
        let v1 = AdminCap{id: 0x2::object::new(arg3)};
        (v0, v1)
    }

    public fun create_lock_from_o_sail<T0, T1>(arg0: &mut Minter<T0>, arg1: &mut 0x61d3c07c67f6ebcc46c950a731dd263a0325fdfe03382e1bd50e4aba964f9e1c::voting_escrow::VotingEscrow<T0>, arg2: &0xebd610a15f0caa02527f4544eaf56fb4655ef493e8654f44a14220e442245d2e::distribution_config::DistributionConfig, arg3: 0x2::coin::Coin<T1>, arg4: u64, arg5: bool, arg6: &0x2::clock::Clock, arg7: &mut 0x2::tx_context::TxContext) {
        0xebd610a15f0caa02527f4544eaf56fb4655ef493e8654f44a14220e442245d2e::distribution_config::checked_package_version(arg2);
        assert!(!is_paused<T0>(arg0), 345260272869412100);
        assert!(is_valid_o_sail_type<T0, T1>(arg0), 916284390763921500);
        let v0 = 0x1::type_name::get<T1>();
        let v1 = 0x61d3c07c67f6ebcc46c950a731dd263a0325fdfe03382e1bd50e4aba964f9e1c::common::current_timestamp(arg6) >= *0x2::table::borrow<0x1::type_name::TypeName, u64>(&arg0.o_sail_expiry_dates, v0);
        let v2 = false;
        if (v1) {
            let v3 = arg5 || arg4 == 1456;
            v2 = v3;
        } else if (arg5) {
            v2 = true;
        } else {
            let v4 = 0;
            let v5 = vector[182, 728, 1456];
            while (v4 < 0x1::vector::length<u64>(&v5)) {
                if (*0x1::vector::borrow<u64>(&v5, v4) == arg4) {
                    v2 = true;
                    break
                };
                v4 = v4 + 1;
            };
        };
        assert!(v2, 68567430268160480);
        let v6 = if (arg5) {
            0x61d3c07c67f6ebcc46c950a731dd263a0325fdfe03382e1bd50e4aba964f9e1c::common::persent_denominator()
        } else {
            0x61d3c07c67f6ebcc46c950a731dd263a0325fdfe03382e1bd50e4aba964f9e1c::common::o_sail_discount() + 0x6b904ae739b2baad330aae14991abcd3b7354d3dc3db72507ed8dabeeb7a36de::full_math_u64::mul_div_floor(arg4 * 0x61d3c07c67f6ebcc46c950a731dd263a0325fdfe03382e1bd50e4aba964f9e1c::common::day(), 0x61d3c07c67f6ebcc46c950a731dd263a0325fdfe03382e1bd50e4aba964f9e1c::common::persent_denominator() - 0x61d3c07c67f6ebcc46c950a731dd263a0325fdfe03382e1bd50e4aba964f9e1c::common::o_sail_discount(), 0x61d3c07c67f6ebcc46c950a731dd263a0325fdfe03382e1bd50e4aba964f9e1c::common::max_lock_time())
        };
        let v7 = exercise_o_sail_free_internal<T0, T1>(arg0, arg3, v6, arg6, arg7);
        0x61d3c07c67f6ebcc46c950a731dd263a0325fdfe03382e1bd50e4aba964f9e1c::voting_escrow::create_lock<T0>(arg1, v7, arg4, arg5, arg6, arg7);
        let v8 = EventCreateLockFromOSail{
            o_sail_amount_in    : 0x2::coin::value<T1>(&arg3),
            o_sail_type         : v0,
            sail_amount_to_lock : 0x2::coin::value<T0>(&v7),
            o_sail_expired      : v1,
            duration            : arg4,
            permanent           : arg5,
        };
        0x2::event::emit<EventCreateLockFromOSail>(v8);
    }

    public fun deposit_o_sail_into_lock<T0, T1>(arg0: &mut Minter<T0>, arg1: &mut 0x61d3c07c67f6ebcc46c950a731dd263a0325fdfe03382e1bd50e4aba964f9e1c::voting_escrow::VotingEscrow<T0>, arg2: &0xebd610a15f0caa02527f4544eaf56fb4655ef493e8654f44a14220e442245d2e::distribution_config::DistributionConfig, arg3: &mut 0x61d3c07c67f6ebcc46c950a731dd263a0325fdfe03382e1bd50e4aba964f9e1c::voting_escrow::Lock, arg4: 0x2::coin::Coin<T1>, arg5: &0x2::clock::Clock, arg6: &mut 0x2::tx_context::TxContext) {
        0xebd610a15f0caa02527f4544eaf56fb4655ef493e8654f44a14220e442245d2e::distribution_config::checked_package_version(arg2);
        assert!(!is_paused<T0>(arg0), 817316631458528500);
        assert!(is_valid_o_sail_type<T0, T1>(arg0), 930930427300172700);
        let v0 = 0x2::object::id<0x61d3c07c67f6ebcc46c950a731dd263a0325fdfe03382e1bd50e4aba964f9e1c::voting_escrow::Lock>(arg3);
        let (v1, v2) = 0x61d3c07c67f6ebcc46c950a731dd263a0325fdfe03382e1bd50e4aba964f9e1c::voting_escrow::locked<T0>(arg1, v0);
        let v3 = v1;
        assert!(v2, 4573731802313574);
        assert!(0x61d3c07c67f6ebcc46c950a731dd263a0325fdfe03382e1bd50e4aba964f9e1c::voting_escrow::is_permanent(&v3), 240260341661373800);
        let v4 = 0x2::coin::value<T1>(&arg4);
        assert!(v4 > 0, 581468583996395500);
        let v5 = exercise_o_sail_free_internal<T0, T1>(arg0, arg4, 0x61d3c07c67f6ebcc46c950a731dd263a0325fdfe03382e1bd50e4aba964f9e1c::common::persent_denominator(), arg5, arg6);
        0x61d3c07c67f6ebcc46c950a731dd263a0325fdfe03382e1bd50e4aba964f9e1c::voting_escrow::deposit_for<T0>(arg1, arg3, v5, arg5, arg6);
        let v6 = EventDepositOSailIntoLock{
            o_sail_amount_in    : v4,
            o_sail_type         : 0x1::type_name::get<T1>(),
            sail_amount_to_lock : 0x2::coin::value<T0>(&v5),
            lock_id             : v0,
        };
        0x2::event::emit<EventDepositOSailIntoLock>(v6);
    }

    public fun distribute_exercise_fee_to_reward<T0, T1>(arg0: &mut Minter<T0>, arg1: &mut 0xebd610a15f0caa02527f4544eaf56fb4655ef493e8654f44a14220e442245d2e::voter::Voter, arg2: &AdminCap, arg3: &0xebd610a15f0caa02527f4544eaf56fb4655ef493e8654f44a14220e442245d2e::distribution_config::DistributionConfig, arg4: u64, arg5: &0x2::clock::Clock, arg6: &mut 0x2::tx_context::TxContext) {
        0xebd610a15f0caa02527f4544eaf56fb4655ef493e8654f44a14220e442245d2e::distribution_config::checked_package_version(arg3);
        assert!(!is_paused<T0>(arg0), 790727734853938600);
        check_admin<T0>(arg0, arg2);
        let v0 = 0x1::type_name::get<T1>();
        0xebd610a15f0caa02527f4544eaf56fb4655ef493e8654f44a14220e442245d2e::voter::notify_exercise_fee_reward_amount<T1>(arg1, 0x1::option::borrow<0xebd610a15f0caa02527f4544eaf56fb4655ef493e8654f44a14220e442245d2e::distribute_cap::DistributeCap>(&arg0.distribute_cap), 0x2::coin::from_balance<T1>(0x2::balance::split<T1>(0x2::bag::borrow_mut<0x1::type_name::TypeName, 0x2::balance::Balance<T1>>(&mut arg0.exercise_fee_operations_balances, v0), arg4), arg6), arg5, arg6);
        let v1 = EventDistributeExerciseFeeToReward{
            admin_cap_id : 0x2::object::id<AdminCap>(arg2),
            amount       : arg4,
            token_type   : v0,
        };
        0x2::event::emit<EventDistributeExerciseFeeToReward>(v1);
    }

    public fun distribute_gauge<T0, T1, T2, T3, T4, T5>(arg0: &mut Minter<T4>, arg1: &mut 0xebd610a15f0caa02527f4544eaf56fb4655ef493e8654f44a14220e442245d2e::voter::Voter, arg2: &DistributeGovernorCap, arg3: &0xebd610a15f0caa02527f4544eaf56fb4655ef493e8654f44a14220e442245d2e::distribution_config::DistributionConfig, arg4: &mut 0xebd610a15f0caa02527f4544eaf56fb4655ef493e8654f44a14220e442245d2e::gauge::Gauge<T0, T1>, arg5: &mut 0xaa3ae572fb09f157d7368ce22c6b7f33fde0fe74cba75ae9679af52088b57bb0::pool::Pool<T0, T1>, arg6: u64, arg7: &mut 0x932133ea33d895f55693eb0949fe25c9007f1af976683fcbb30c32126b2aa9fb::price_monitor::PriceMonitor, arg8: &0xaa3ae572fb09f157d7368ce22c6b7f33fde0fe74cba75ae9679af52088b57bb0::pool::Pool<T2, T3>, arg9: &0xc3c7e6eb7202e9fb0389a2f7542b91cc40e4f7a33c02554fec11c4c92f938ea3::aggregator::Aggregator, arg10: &0x2::clock::Clock, arg11: &mut 0x2::tx_context::TxContext) {
        0xebd610a15f0caa02527f4544eaf56fb4655ef493e8654f44a14220e442245d2e::distribution_config::checked_package_version(arg3);
        assert!(!is_paused<T4>(arg0), 383966743216827200);
        assert!(!is_emission_stopped<T4>(arg0), 123456789012345678);
        check_distribute_governor<T4>(arg0, arg2);
        assert!(is_active<T4>(arg0, arg10), 728194857362048571);
        assert!(is_valid_distribution_config<T4>(arg0, arg3), 540205746933504640);
        assert!(0xebd610a15f0caa02527f4544eaf56fb4655ef493e8654f44a14220e442245d2e::distribution_config::is_valid_sail_price_aggregator(arg3, arg9), 48171994695305640);
        assert!(0x1::type_name::get<T2>() == 0x1::type_name::get<T4>() || 0x1::type_name::get<T3>() == 0x1::type_name::get<T4>(), 939179427939211244);
        let (v0, v1) = get_aggregator_price_without_decimals<T2, T3, T4>(arg0, arg7, arg8, arg9, arg10);
        if (v1) {
            return
        };
        distribute_gauge_internal<T0, T1, T4, T5>(arg0, arg1, arg3, arg4, arg5, arg6, v0, arg10, arg11);
    }

    public fun distribute_gauge_for_sail_pool<T0, T1, T2, T3>(arg0: &mut Minter<T2>, arg1: &mut 0xebd610a15f0caa02527f4544eaf56fb4655ef493e8654f44a14220e442245d2e::voter::Voter, arg2: &DistributeGovernorCap, arg3: &0xebd610a15f0caa02527f4544eaf56fb4655ef493e8654f44a14220e442245d2e::distribution_config::DistributionConfig, arg4: &mut 0xebd610a15f0caa02527f4544eaf56fb4655ef493e8654f44a14220e442245d2e::gauge::Gauge<T0, T1>, arg5: &mut 0xaa3ae572fb09f157d7368ce22c6b7f33fde0fe74cba75ae9679af52088b57bb0::pool::Pool<T0, T1>, arg6: u64, arg7: &mut 0x932133ea33d895f55693eb0949fe25c9007f1af976683fcbb30c32126b2aa9fb::price_monitor::PriceMonitor, arg8: &0xc3c7e6eb7202e9fb0389a2f7542b91cc40e4f7a33c02554fec11c4c92f938ea3::aggregator::Aggregator, arg9: &0x2::clock::Clock, arg10: &mut 0x2::tx_context::TxContext) {
        0xebd610a15f0caa02527f4544eaf56fb4655ef493e8654f44a14220e442245d2e::distribution_config::checked_package_version(arg3);
        assert!(!is_paused<T2>(arg0), 383966743216827200);
        assert!(!is_emission_stopped<T2>(arg0), 123456789012345678);
        check_distribute_governor<T2>(arg0, arg2);
        assert!(is_active<T2>(arg0, arg9), 728194857362048571);
        assert!(is_valid_distribution_config<T2>(arg0, arg3), 540205746933504640);
        assert!(0xebd610a15f0caa02527f4544eaf56fb4655ef493e8654f44a14220e442245d2e::distribution_config::is_valid_sail_price_aggregator(arg3, arg8), 48171994695305640);
        assert!(0x1::type_name::get<T0>() == 0x1::type_name::get<T2>() || 0x1::type_name::get<T1>() == 0x1::type_name::get<T2>(), 939179427939211244);
        let (v0, v1) = get_aggregator_price_without_decimals<T0, T1, T2>(arg0, arg7, arg5, arg8, arg9);
        if (v1) {
            return
        };
        distribute_gauge_internal<T0, T1, T2, T3>(arg0, arg1, arg3, arg4, arg5, arg6, v0, arg9, arg10);
    }

    fun distribute_gauge_internal<T0, T1, T2, T3>(arg0: &mut Minter<T2>, arg1: &mut 0xebd610a15f0caa02527f4544eaf56fb4655ef493e8654f44a14220e442245d2e::voter::Voter, arg2: &0xebd610a15f0caa02527f4544eaf56fb4655ef493e8654f44a14220e442245d2e::distribution_config::DistributionConfig, arg3: &mut 0xebd610a15f0caa02527f4544eaf56fb4655ef493e8654f44a14220e442245d2e::gauge::Gauge<T0, T1>, arg4: &mut 0xaa3ae572fb09f157d7368ce22c6b7f33fde0fe74cba75ae9679af52088b57bb0::pool::Pool<T0, T1>, arg5: u64, arg6: u128, arg7: &0x2::clock::Clock, arg8: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x1::type_name::get<T3>();
        assert!(0x1::option::borrow<0x1::type_name::TypeName>(&arg0.current_epoch_o_sail) == &v0, 802874746577660900);
        let v1 = 0x2::object::id<0xebd610a15f0caa02527f4544eaf56fb4655ef493e8654f44a14220e442245d2e::gauge::Gauge<T0, T1>>(arg3);
        assert!(!0x2::table::contains<0x2::object::ID, u64>(&arg0.gauge_active_period, v1) || *0x2::table::borrow<0x2::object::ID, u64>(&arg0.gauge_active_period, v1) < arg0.active_period, 259145126193785820);
        assert!(0x2::table::contains<0x2::object::ID, u64>(&arg0.gauge_epoch_emissions_usd, v1), 764215244078886900);
        0xebd610a15f0caa02527f4544eaf56fb4655ef493e8654f44a14220e442245d2e::distribute_cap::validate_distribute_voter_id(0x1::option::borrow<0xebd610a15f0caa02527f4544eaf56fb4655ef493e8654f44a14220e442245d2e::distribute_cap::DistributeCap>(&arg0.distribute_cap), 0x2::object::id<0xebd610a15f0caa02527f4544eaf56fb4655ef493e8654f44a14220e442245d2e::voter::Voter>(arg1));
        let v2 = if (0x2::table::contains<0x2::object::ID, u64>(&arg0.gauge_epoch_count, v1)) {
            0x2::table::remove<0x2::object::ID, u64>(&mut arg0.gauge_epoch_count, v1)
        } else {
            0
        };
        let v3 = 0x2::table::remove<0x2::object::ID, u64>(&mut arg0.gauge_epoch_emissions_usd, v1);
        if (v2 == 0) {
            assert!(arg5 == v3, 671508139267645600);
        } else {
            assert!(arg5 > 0, 424941542236535500);
            if (v3 > arg5) {
                assert!(v3 <= arg0.max_emission_change_ratio * arg5, 95918619286974770);
            } else {
                assert!(arg5 <= arg0.max_emission_change_ratio * v3, 95918619286974770);
            };
        };
        let v4 = 0xebd610a15f0caa02527f4544eaf56fb4655ef493e8654f44a14220e442245d2e::voter::distribute_gauge<T0, T1, T3>(arg1, arg2, arg3, arg4, arg5, arg6, arg7, arg8);
        let v5 = if (0x2::table::contains<0x2::object::ID, u64>(&arg0.gauge_active_period, v1)) {
            0x2::table::remove<0x2::object::ID, u64>(&mut arg0.gauge_active_period, v1)
        } else {
            0
        };
        if (v5 > 0) {
            let v6 = if (0x2::table::contains<u64, u64>(&arg0.total_epoch_o_sail_emissions, v5)) {
                0x2::table::remove<u64, u64>(&mut arg0.total_epoch_o_sail_emissions, v5)
            } else {
                0
            };
            0x2::table::add<u64, u64>(&mut arg0.total_epoch_o_sail_emissions, v5, v6 + v4);
        } else {
            assert!(v4 == 0, 658460351931005700);
        };
        0x2::table::add<0x2::object::ID, u64>(&mut arg0.gauge_active_period, v1, arg0.active_period);
        0x2::table::add<0x2::object::ID, u64>(&mut arg0.gauge_epoch_emissions_usd, v1, arg5);
        0x2::table::add<0x2::object::ID, u64>(&mut arg0.gauge_epoch_count, v1, v2 + 1);
        let v7 = if (0x2::table::contains<u64, u64>(&arg0.total_epoch_emissions_usd, arg0.active_period)) {
            0x2::table::remove<u64, u64>(&mut arg0.total_epoch_emissions_usd, arg0.active_period)
        } else {
            0
        };
        0x2::table::add<u64, u64>(&mut arg0.total_epoch_emissions_usd, arg0.active_period, v7 + arg5);
        let v8 = EventDistributeGauge{
            gauge_id                    : v1,
            pool_id                     : 0x2::object::id<0xaa3ae572fb09f157d7368ce22c6b7f33fde0fe74cba75ae9679af52088b57bb0::pool::Pool<T0, T1>>(arg4),
            o_sail_type                 : v0,
            next_epoch_emissions_usd    : arg5,
            ended_epoch_o_sail_emission : v4,
        };
        0x2::event::emit<EventDistributeGauge>(v8);
    }

    public fun distribute_operations<T0, T1>(arg0: &mut Minter<T0>, arg1: &AdminCap, arg2: &0xebd610a15f0caa02527f4544eaf56fb4655ef493e8654f44a14220e442245d2e::distribution_config::DistributionConfig, arg3: &mut 0x2::tx_context::TxContext) {
        0xebd610a15f0caa02527f4544eaf56fb4655ef493e8654f44a14220e442245d2e::distribution_config::checked_package_version(arg2);
        assert!(!is_paused<T0>(arg0), 14616427533564292);
        check_admin<T0>(arg0, arg1);
        assert!(arg0.operations_wallet != @0x0, 390491624826283500);
        let v0 = 0x1::type_name::get<T1>();
        assert!(0x2::bag::contains<0x1::type_name::TypeName>(&arg0.exercise_fee_operations_balances, v0), 321746203850562500);
        let v1 = 0x2::bag::remove<0x1::type_name::TypeName, 0x2::balance::Balance<T1>>(&mut arg0.exercise_fee_operations_balances, v0);
        0x2::transfer::public_transfer<0x2::coin::Coin<T1>>(0x2::coin::from_balance<T1>(v1, arg3), arg0.operations_wallet);
        let v2 = EventDistributeOperations{
            operations_wallet : arg0.operations_wallet,
            amount            : 0x2::balance::value<T1>(&v1),
            token_type        : v0,
        };
        0x2::event::emit<EventDistributeOperations>(v2);
    }

    public fun distribute_protocol<T0, T1>(arg0: &mut Minter<T0>, arg1: &AdminCap, arg2: &0xebd610a15f0caa02527f4544eaf56fb4655ef493e8654f44a14220e442245d2e::distribution_config::DistributionConfig, arg3: &mut 0x2::tx_context::TxContext) {
        0xebd610a15f0caa02527f4544eaf56fb4655ef493e8654f44a14220e442245d2e::distribution_config::checked_package_version(arg2);
        assert!(!is_paused<T0>(arg0), 410768471077089800);
        check_admin<T0>(arg0, arg1);
        assert!(arg0.protocol_wallet != @0x0, 987893910474538100);
        let v0 = 0x1::type_name::get<T1>();
        assert!(0x2::bag::contains<0x1::type_name::TypeName>(&arg0.exercise_fee_protocol_balances, v0), 341757784748534300);
        let v1 = 0x2::bag::remove<0x1::type_name::TypeName, 0x2::balance::Balance<T1>>(&mut arg0.exercise_fee_protocol_balances, v0);
        0x2::transfer::public_transfer<0x2::coin::Coin<T1>>(0x2::coin::from_balance<T1>(v1, arg3), arg0.protocol_wallet);
        let v2 = EventDistributeProtocol{
            protocol_wallet : arg0.protocol_wallet,
            amount          : 0x2::balance::value<T1>(&v1),
            token_type      : v0,
        };
        0x2::event::emit<EventDistributeProtocol>(v2);
    }

    public fun earned_by_position<T0, T1, T2, T3>(arg0: &Minter<T2>, arg1: &0xebd610a15f0caa02527f4544eaf56fb4655ef493e8654f44a14220e442245d2e::gauge::Gauge<T0, T1>, arg2: &0xaa3ae572fb09f157d7368ce22c6b7f33fde0fe74cba75ae9679af52088b57bb0::pool::Pool<T0, T1>, arg3: 0x2::object::ID, arg4: &0x2::clock::Clock) : u64 {
        if (!is_valid_epoch_token<T2, T3>(arg0)) {
            return 0
        };
        0xebd610a15f0caa02527f4544eaf56fb4655ef493e8654f44a14220e442245d2e::gauge::earned<T0, T1>(arg1, arg2, arg3, arg4)
    }

    public fun earned_by_position_ids<T0, T1, T2, T3>(arg0: &Minter<T2>, arg1: &0xebd610a15f0caa02527f4544eaf56fb4655ef493e8654f44a14220e442245d2e::gauge::Gauge<T0, T1>, arg2: &0xaa3ae572fb09f157d7368ce22c6b7f33fde0fe74cba75ae9679af52088b57bb0::pool::Pool<T0, T1>, arg3: &vector<0x2::object::ID>, arg4: &0x2::clock::Clock) : u64 {
        if (!is_valid_epoch_token<T2, T3>(arg0)) {
            return 0
        };
        let v0 = 0;
        let v1 = 0;
        while (v0 < 0x1::vector::length<0x2::object::ID>(arg3)) {
            v1 = v1 + 0xebd610a15f0caa02527f4544eaf56fb4655ef493e8654f44a14220e442245d2e::gauge::earned<T0, T1>(arg1, arg2, *0x1::vector::borrow<0x2::object::ID>(arg3, v0), arg4);
            v0 = v0 + 1;
        };
        v1
    }

    public fun earned_by_staked_position<T0, T1, T2, T3>(arg0: &Minter<T2>, arg1: &0xebd610a15f0caa02527f4544eaf56fb4655ef493e8654f44a14220e442245d2e::gauge::Gauge<T0, T1>, arg2: &0xaa3ae572fb09f157d7368ce22c6b7f33fde0fe74cba75ae9679af52088b57bb0::pool::Pool<T0, T1>, arg3: &vector<0xebd610a15f0caa02527f4544eaf56fb4655ef493e8654f44a14220e442245d2e::gauge::StakedPosition>, arg4: &0x2::clock::Clock) : u64 {
        if (!is_valid_epoch_token<T2, T3>(arg0)) {
            return 0
        };
        let v0 = 0;
        let v1 = 0;
        while (v0 < 0x1::vector::length<0xebd610a15f0caa02527f4544eaf56fb4655ef493e8654f44a14220e442245d2e::gauge::StakedPosition>(arg3)) {
            v1 = v1 + 0xebd610a15f0caa02527f4544eaf56fb4655ef493e8654f44a14220e442245d2e::gauge::earned<T0, T1>(arg1, arg2, 0xebd610a15f0caa02527f4544eaf56fb4655ef493e8654f44a14220e442245d2e::gauge::position_id(0x1::vector::borrow<0xebd610a15f0caa02527f4544eaf56fb4655ef493e8654f44a14220e442245d2e::gauge::StakedPosition>(arg3, v0)), arg4);
            v0 = v0 + 1;
        };
        v1
    }

    public fun execute_o_sail_mint<T0, T1>(arg0: &mut Minter<T0>, arg1: &0xebd610a15f0caa02527f4544eaf56fb4655ef493e8654f44a14220e442245d2e::distribution_config::DistributionConfig, arg2: TimeLockedOSailMint<T1>, arg3: &0x2::clock::Clock, arg4: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<T1> {
        0xebd610a15f0caa02527f4544eaf56fb4655ef493e8654f44a14220e442245d2e::distribution_config::checked_package_version(arg1);
        assert!(!is_paused<T0>(arg0), 701790096846469900);
        assert!(is_valid_o_sail_type<T0, T1>(arg0), 656291036632650900);
        let TimeLockedOSailMint {
            id          : v0,
            amount      : v1,
            unlock_time : v2,
        } = arg2;
        0x2::object::delete(v0);
        assert!(v2 <= 0x2::clock::timestamp_ms(arg3), 151689484412189660);
        mint_o_sail<T0, T1>(arg0, v1, arg4)
    }

    public fun execute_sail_mint<T0>(arg0: &mut Minter<T0>, arg1: &0xebd610a15f0caa02527f4544eaf56fb4655ef493e8654f44a14220e442245d2e::distribution_config::DistributionConfig, arg2: TimeLockedSailMint, arg3: &0x2::clock::Clock, arg4: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<T0> {
        0xebd610a15f0caa02527f4544eaf56fb4655ef493e8654f44a14220e442245d2e::distribution_config::checked_package_version(arg1);
        assert!(!is_paused<T0>(arg0), 563287666418746940);
        let TimeLockedSailMint {
            id          : v0,
            amount      : v1,
            unlock_time : v2,
        } = arg2;
        0x2::object::delete(v0);
        assert!(v2 <= 0x2::clock::timestamp_ms(arg3), 163079933457922500);
        mint_sail<T0>(arg0, v1, arg4)
    }

    public fun exercise_fee_operations_balance<T0, T1>(arg0: &Minter<T0>) : u64 {
        let v0 = 0x1::type_name::get<T1>();
        if (0x2::bag::contains<0x1::type_name::TypeName>(&arg0.exercise_fee_operations_balances, v0)) {
            0x2::balance::value<T1>(0x2::bag::borrow<0x1::type_name::TypeName, 0x2::balance::Balance<T1>>(&arg0.exercise_fee_operations_balances, v0))
        } else {
            0
        }
    }

    public fun exercise_fee_protocol_balance<T0, T1>(arg0: &Minter<T0>) : u64 {
        let v0 = 0x1::type_name::get<T1>();
        if (0x2::bag::contains<0x1::type_name::TypeName>(&arg0.exercise_fee_protocol_balances, v0)) {
            0x2::balance::value<T1>(0x2::bag::borrow<0x1::type_name::TypeName, 0x2::balance::Balance<T1>>(&arg0.exercise_fee_protocol_balances, v0))
        } else {
            0
        }
    }

    public fun exercise_o_sail<T0, T1, T2, T3, T4>(arg0: &mut Minter<T2>, arg1: &0xebd610a15f0caa02527f4544eaf56fb4655ef493e8654f44a14220e442245d2e::distribution_config::DistributionConfig, arg2: &mut 0xebd610a15f0caa02527f4544eaf56fb4655ef493e8654f44a14220e442245d2e::voter::Voter, arg3: 0x2::coin::Coin<T4>, arg4: 0x2::coin::Coin<T3>, arg5: &0x2::coin::CoinMetadata<T3>, arg6: u64, arg7: &mut 0x932133ea33d895f55693eb0949fe25c9007f1af976683fcbb30c32126b2aa9fb::price_monitor::PriceMonitor, arg8: &0xaa3ae572fb09f157d7368ce22c6b7f33fde0fe74cba75ae9679af52088b57bb0::pool::Pool<T0, T1>, arg9: &0xc3c7e6eb7202e9fb0389a2f7542b91cc40e4f7a33c02554fec11c4c92f938ea3::aggregator::Aggregator, arg10: &0x2::clock::Clock, arg11: &mut 0x2::tx_context::TxContext) : (0x2::coin::Coin<T3>, 0x2::coin::Coin<T2>) {
        0xebd610a15f0caa02527f4544eaf56fb4655ef493e8654f44a14220e442245d2e::distribution_config::checked_package_version(arg1);
        assert!(!is_paused<T2>(arg0), 295847361920485736);
        assert!(!is_emission_stopped<T2>(arg0), 123456789012345678);
        assert!(is_valid_o_sail_type<T2, T4>(arg0), 320917362365364070);
        assert!(0x61d3c07c67f6ebcc46c950a731dd263a0325fdfe03382e1bd50e4aba964f9e1c::common::current_timestamp(arg10) < *0x2::table::borrow<0x1::type_name::TypeName, u64>(&arg0.o_sail_expiry_dates, 0x1::type_name::get<T4>()), 738843771743325200);
        assert!(is_valid_distribution_config<T2>(arg0, arg1), 156849871586365300);
        assert!(0xebd610a15f0caa02527f4544eaf56fb4655ef493e8654f44a14220e442245d2e::distribution_config::is_valid_sail_price_aggregator(arg1, arg9), 48171994695305640);
        assert!(is_whitelisted_usd<T2, T3>(arg0), 953914262470819500);
        assert!(0x1::type_name::get<T0>() == 0x1::type_name::get<T2>() || 0x1::type_name::get<T1>() == 0x1::type_name::get<T2>(), 939179427939211244);
        let (v0, v1) = get_aggregator_price<T0, T1, T3, T2>(arg0, arg7, arg8, arg5, arg9, arg10);
        if (v1) {
            0x2::transfer::public_transfer<0x2::coin::Coin<T4>>(arg3, 0x2::tx_context::sender(arg11));
            return (arg4, 0x2::coin::zero<T2>(arg11))
        };
        let v2 = exercise_o_sail_calc<T4>(&arg3, 0x61d3c07c67f6ebcc46c950a731dd263a0325fdfe03382e1bd50e4aba964f9e1c::common::o_sail_discount(), v0);
        assert!(0x2::coin::value<T3>(&arg4) >= arg6, 601485821599794400);
        assert!(arg6 >= v2, 490517942447480600);
        exercise_o_sail_process_payment<T2, T3, T4>(arg0, arg2, arg3, arg4, v2, arg10, arg11)
    }

    public fun exercise_o_sail_calc<T0>(arg0: &0x2::coin::Coin<T0>, arg1: u64, arg2: u128) : u64 {
        (0x6b904ae739b2baad330aae14991abcd3b7354d3dc3db72507ed8dabeeb7a36de::math_u128::checked_div_round(0x61d3c07c67f6ebcc46c950a731dd263a0325fdfe03382e1bd50e4aba964f9e1c::common::asset_q64_to_usd_q64(0x6b904ae739b2baad330aae14991abcd3b7354d3dc3db72507ed8dabeeb7a36de::full_math_u128::mul_div_ceil(((0x61d3c07c67f6ebcc46c950a731dd263a0325fdfe03382e1bd50e4aba964f9e1c::common::persent_denominator() - arg1) as u128), (0x2::coin::value<T0>(arg0) as u128) << 64, (0x61d3c07c67f6ebcc46c950a731dd263a0325fdfe03382e1bd50e4aba964f9e1c::common::persent_denominator() as u128)), arg2, true), 18446744073709551616, true) as u64)
    }

    fun exercise_o_sail_free_internal<T0, T1>(arg0: &mut Minter<T0>, arg1: 0x2::coin::Coin<T1>, arg2: u64, arg3: &0x2::clock::Clock, arg4: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<T0> {
        assert!(arg2 <= 0x61d3c07c67f6ebcc46c950a731dd263a0325fdfe03382e1bd50e4aba964f9e1c::common::persent_denominator(), 410835752553141860);
        burn_o_sail<T0, T1>(arg0, arg1);
        mint_sail<T0>(arg0, 0x6b904ae739b2baad330aae14991abcd3b7354d3dc3db72507ed8dabeeb7a36de::full_math_u64::mul_div_floor(0x2::coin::value<T1>(&arg1), arg2, 0x61d3c07c67f6ebcc46c950a731dd263a0325fdfe03382e1bd50e4aba964f9e1c::common::persent_denominator()), arg4)
    }

    fun exercise_o_sail_process_payment<T0, T1, T2>(arg0: &mut Minter<T0>, arg1: &mut 0xebd610a15f0caa02527f4544eaf56fb4655ef493e8654f44a14220e442245d2e::voter::Voter, arg2: 0x2::coin::Coin<T2>, arg3: 0x2::coin::Coin<T1>, arg4: u64, arg5: &0x2::clock::Clock, arg6: &mut 0x2::tx_context::TxContext) : (0x2::coin::Coin<T1>, 0x2::coin::Coin<T0>) {
        let v0 = 0x2::coin::value<T2>(&arg2);
        let v1 = 0x2::coin::split<T1>(&mut arg3, arg4, arg6);
        let v2 = 0x1::type_name::get<T1>();
        let v3 = 0;
        if (arg0.protocol_fee_rate > 0) {
            let v4 = 0x6b904ae739b2baad330aae14991abcd3b7354d3dc3db72507ed8dabeeb7a36de::full_math_u64::mul_div_floor(0x2::coin::value<T1>(&v1), arg0.protocol_fee_rate, 10000);
            v3 = v4;
            if (!0x2::bag::contains<0x1::type_name::TypeName>(&arg0.exercise_fee_protocol_balances, v2)) {
                0x2::bag::add<0x1::type_name::TypeName, 0x2::balance::Balance<T1>>(&mut arg0.exercise_fee_protocol_balances, v2, 0x2::balance::zero<T1>());
            };
            0x2::balance::join<T1>(0x2::bag::borrow_mut<0x1::type_name::TypeName, 0x2::balance::Balance<T1>>(&mut arg0.exercise_fee_protocol_balances, v2), 0x2::coin::into_balance<T1>(0x2::coin::split<T1>(&mut v1, v4, arg6)));
        };
        if (!0x2::bag::contains<0x1::type_name::TypeName>(&arg0.exercise_fee_operations_balances, v2)) {
            0x2::bag::add<0x1::type_name::TypeName, 0x2::balance::Balance<T1>>(&mut arg0.exercise_fee_operations_balances, v2, 0x2::balance::zero<T1>());
        };
        0x2::balance::join<T1>(0x2::bag::borrow_mut<0x1::type_name::TypeName, 0x2::balance::Balance<T1>>(&mut arg0.exercise_fee_operations_balances, v2), 0x2::coin::into_balance<T1>(v1));
        burn_o_sail<T0, T2>(arg0, arg2);
        let v5 = EventExerciseOSail{
            o_sail_amount_in        : v0,
            sail_amount_out         : v0,
            o_sail_type             : 0x1::type_name::get<T2>(),
            exercise_fee_token_type : 0x1::type_name::get<T1>(),
            exercise_fee_amount     : arg4,
            protocol_fee_amount     : v3,
            fee_to_distribute       : 0x2::coin::value<T1>(&v1),
        };
        0x2::event::emit<EventExerciseOSail>(v5);
        (arg3, mint_sail<T0>(arg0, v0, arg6))
    }

    public fun finalize_exercise_fee_weights<T0>(arg0: &mut Minter<T0>, arg1: &mut 0xebd610a15f0caa02527f4544eaf56fb4655ef493e8654f44a14220e442245d2e::voter::Voter, arg2: &0xebd610a15f0caa02527f4544eaf56fb4655ef493e8654f44a14220e442245d2e::distribution_config::DistributionConfig, arg3: &DistributeGovernorCap, arg4: u64, arg5: &0x2::clock::Clock, arg6: &mut 0x2::tx_context::TxContext) {
        0xebd610a15f0caa02527f4544eaf56fb4655ef493e8654f44a14220e442245d2e::distribution_config::checked_package_version(arg2);
        check_distribute_governor<T0>(arg0, arg3);
        0xebd610a15f0caa02527f4544eaf56fb4655ef493e8654f44a14220e442245d2e::voter::update_exercise_fee_weights(arg1, 0x1::option::borrow<0xebd610a15f0caa02527f4544eaf56fb4655ef493e8654f44a14220e442245d2e::distribute_cap::DistributeCap>(&arg0.distribute_cap), 0x1::vector::empty<u64>(), 0x1::vector::empty<0x2::object::ID>(), arg4, true, arg5, arg6);
    }

    public fun finalize_voted_weights<T0>(arg0: &mut Minter<T0>, arg1: &mut 0xebd610a15f0caa02527f4544eaf56fb4655ef493e8654f44a14220e442245d2e::voter::Voter, arg2: &0xebd610a15f0caa02527f4544eaf56fb4655ef493e8654f44a14220e442245d2e::distribution_config::DistributionConfig, arg3: &DistributeGovernorCap, arg4: 0x2::object::ID, arg5: u64, arg6: &0x2::clock::Clock, arg7: &mut 0x2::tx_context::TxContext) {
        0xebd610a15f0caa02527f4544eaf56fb4655ef493e8654f44a14220e442245d2e::distribution_config::checked_package_version(arg2);
        check_distribute_governor<T0>(arg0, arg3);
        0xebd610a15f0caa02527f4544eaf56fb4655ef493e8654f44a14220e442245d2e::voter::update_voted_weights(arg1, 0x1::option::borrow<0xebd610a15f0caa02527f4544eaf56fb4655ef493e8654f44a14220e442245d2e::distribute_cap::DistributeCap>(&arg0.distribute_cap), arg4, 0x1::vector::empty<u64>(), 0x1::vector::empty<0x2::object::ID>(), arg5, true, arg6, arg7);
    }

    public fun gauge_distributed<T0>(arg0: &Minter<T0>, arg1: 0x2::object::ID) : bool {
        let v0 = if (0x2::table::contains<0x2::object::ID, u64>(&arg0.gauge_active_period, arg1)) {
            *0x2::table::borrow<0x2::object::ID, u64>(&arg0.gauge_active_period, arg1)
        } else {
            0
        };
        if (v0 == 0 || arg0.active_period > v0) {
            return false
        };
        true
    }

    public fun gauge_epoch_emissions_usd<T0>(arg0: &Minter<T0>, arg1: 0x2::object::ID) : u64 {
        *0x2::table::borrow<0x2::object::ID, u64>(&arg0.gauge_epoch_emissions_usd, arg1)
    }

    fun get_aggregator_price<T0, T1, T2, T3>(arg0: &mut Minter<T3>, arg1: &mut 0x932133ea33d895f55693eb0949fe25c9007f1af976683fcbb30c32126b2aa9fb::price_monitor::PriceMonitor, arg2: &0xaa3ae572fb09f157d7368ce22c6b7f33fde0fe74cba75ae9679af52088b57bb0::pool::Pool<T0, T1>, arg3: &0x2::coin::CoinMetadata<T2>, arg4: &0xc3c7e6eb7202e9fb0389a2f7542b91cc40e4f7a33c02554fec11c4c92f938ea3::aggregator::Aggregator, arg5: &0x2::clock::Clock) : (u128, bool) {
        let (v0, v1) = get_aggregator_price_without_decimals<T0, T1, T3>(arg0, arg1, arg2, arg4, arg5);
        let v2 = v0;
        if (v1) {
            return (0, true)
        };
        let v3 = 0x61d3c07c67f6ebcc46c950a731dd263a0325fdfe03382e1bd50e4aba964f9e1c::common::sail_decimals();
        let v4 = 0x2::coin::get_decimals<T2>(arg3);
        if (v3 > v4) {
            v2 = 0x6b904ae739b2baad330aae14991abcd3b7354d3dc3db72507ed8dabeeb7a36de::full_math_u128::mul_div_floor(v0, 1, 0xc3c7e6eb7202e9fb0389a2f7542b91cc40e4f7a33c02554fec11c4c92f938ea3::decimal::pow_10(v3 - v4));
        } else if (v4 != v3) {
            v2 = v0 * 0xc3c7e6eb7202e9fb0389a2f7542b91cc40e4f7a33c02554fec11c4c92f938ea3::decimal::pow_10(v4 - v3);
        };
        (v2, false)
    }

    fun get_aggregator_price_without_decimals<T0, T1, T2>(arg0: &mut Minter<T2>, arg1: &mut 0x932133ea33d895f55693eb0949fe25c9007f1af976683fcbb30c32126b2aa9fb::price_monitor::PriceMonitor, arg2: &0xaa3ae572fb09f157d7368ce22c6b7f33fde0fe74cba75ae9679af52088b57bb0::pool::Pool<T0, T1>, arg3: &0xc3c7e6eb7202e9fb0389a2f7542b91cc40e4f7a33c02554fec11c4c92f938ea3::aggregator::Aggregator, arg4: &0x2::clock::Clock) : (u128, bool) {
        let v0 = 0x932133ea33d895f55693eb0949fe25c9007f1af976683fcbb30c32126b2aa9fb::price_monitor::validate_price<T0, T1, T2>(arg1, arg3, arg2, arg4);
        if (0x932133ea33d895f55693eb0949fe25c9007f1af976683fcbb30c32126b2aa9fb::price_monitor::get_escalation_activation(&v0)) {
            arg0.emission_stopped = true;
            let v1 = EventStopEmission{dummy_field: false};
            0x2::event::emit<EventStopEmission>(v1);
            return (0, true)
        };
        (0x932133ea33d895f55693eb0949fe25c9007f1af976683fcbb30c32126b2aa9fb::price_monitor::get_price_q64(&v0), false)
    }

    public fun get_multiple_position_rewards<T0, T1, T2, T3>(arg0: &mut Minter<T2>, arg1: &0xebd610a15f0caa02527f4544eaf56fb4655ef493e8654f44a14220e442245d2e::distribution_config::DistributionConfig, arg2: &mut 0xebd610a15f0caa02527f4544eaf56fb4655ef493e8654f44a14220e442245d2e::gauge::Gauge<T0, T1>, arg3: &mut 0xaa3ae572fb09f157d7368ce22c6b7f33fde0fe74cba75ae9679af52088b57bb0::pool::Pool<T0, T1>, arg4: &vector<0xebd610a15f0caa02527f4544eaf56fb4655ef493e8654f44a14220e442245d2e::gauge::StakedPosition>, arg5: &0x2::clock::Clock, arg6: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<T3> {
        0xebd610a15f0caa02527f4544eaf56fb4655ef493e8654f44a14220e442245d2e::distribution_config::checked_package_version(arg1);
        assert!(is_valid_epoch_token<T2, T3>(arg0), 785363146605424900);
        assert!(0x2::object::id<0xebd610a15f0caa02527f4544eaf56fb4655ef493e8654f44a14220e442245d2e::distribution_config::DistributionConfig>(arg1) == arg0.distribution_config, 695673975436220400);
        assert!(0xebd610a15f0caa02527f4544eaf56fb4655ef493e8654f44a14220e442245d2e::distribution_config::is_gauge_alive(arg1, 0x2::object::id<0xebd610a15f0caa02527f4544eaf56fb4655ef493e8654f44a14220e442245d2e::gauge::Gauge<T0, T1>>(arg2)), 993998734106655200);
        let v0 = 0;
        let v1 = 0;
        while (v0 < 0x1::vector::length<0xebd610a15f0caa02527f4544eaf56fb4655ef493e8654f44a14220e442245d2e::gauge::StakedPosition>(arg4)) {
            v1 = v1 + get_position_reward_internal<T0, T1, T3>(arg2, arg1, arg3, 0xebd610a15f0caa02527f4544eaf56fb4655ef493e8654f44a14220e442245d2e::gauge::position_id(0x1::vector::borrow<0xebd610a15f0caa02527f4544eaf56fb4655ef493e8654f44a14220e442245d2e::gauge::StakedPosition>(arg4, v0)), arg5, arg6);
            v0 = v0 + 1;
        };
        mint_o_sail<T2, T3>(arg0, v1, arg6)
    }

    public fun get_position_reward<T0, T1, T2, T3>(arg0: &mut Minter<T2>, arg1: &0xebd610a15f0caa02527f4544eaf56fb4655ef493e8654f44a14220e442245d2e::distribution_config::DistributionConfig, arg2: &mut 0xebd610a15f0caa02527f4544eaf56fb4655ef493e8654f44a14220e442245d2e::gauge::Gauge<T0, T1>, arg3: &mut 0xaa3ae572fb09f157d7368ce22c6b7f33fde0fe74cba75ae9679af52088b57bb0::pool::Pool<T0, T1>, arg4: &0xebd610a15f0caa02527f4544eaf56fb4655ef493e8654f44a14220e442245d2e::gauge::StakedPosition, arg5: &0x2::clock::Clock, arg6: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<T3> {
        0xebd610a15f0caa02527f4544eaf56fb4655ef493e8654f44a14220e442245d2e::distribution_config::checked_package_version(arg1);
        assert!(is_valid_epoch_token<T2, T3>(arg0), 779306294896264600);
        assert!(0x2::object::id<0xebd610a15f0caa02527f4544eaf56fb4655ef493e8654f44a14220e442245d2e::distribution_config::DistributionConfig>(arg1) == arg0.distribution_config, 695673975436220400);
        assert!(0xebd610a15f0caa02527f4544eaf56fb4655ef493e8654f44a14220e442245d2e::distribution_config::is_gauge_alive(arg1, 0x2::object::id<0xebd610a15f0caa02527f4544eaf56fb4655ef493e8654f44a14220e442245d2e::gauge::Gauge<T0, T1>>(arg2)), 993998734106655200);
        let v0 = get_position_reward_internal<T0, T1, T3>(arg2, arg1, arg3, 0xebd610a15f0caa02527f4544eaf56fb4655ef493e8654f44a14220e442245d2e::gauge::position_id(arg4), arg5, arg6);
        mint_o_sail<T2, T3>(arg0, v0, arg6)
    }

    fun get_position_reward_internal<T0, T1, T2>(arg0: &mut 0xebd610a15f0caa02527f4544eaf56fb4655ef493e8654f44a14220e442245d2e::gauge::Gauge<T0, T1>, arg1: &0xebd610a15f0caa02527f4544eaf56fb4655ef493e8654f44a14220e442245d2e::distribution_config::DistributionConfig, arg2: &mut 0xaa3ae572fb09f157d7368ce22c6b7f33fde0fe74cba75ae9679af52088b57bb0::pool::Pool<T0, T1>, arg3: 0x2::object::ID, arg4: &0x2::clock::Clock, arg5: &0x2::tx_context::TxContext) : u64 {
        let (v0, v1) = 0xebd610a15f0caa02527f4544eaf56fb4655ef493e8654f44a14220e442245d2e::gauge::update_reward_internal<T0, T1>(arg0, arg1, arg2, arg3, arg4, arg5);
        let v2 = EventClaimPositionReward{
            from          : 0x2::tx_context::sender(arg5),
            gauge_id      : 0x2::object::id<0xebd610a15f0caa02527f4544eaf56fb4655ef493e8654f44a14220e442245d2e::gauge::Gauge<T0, T1>>(arg0),
            pool_id       : 0x2::object::id<0xaa3ae572fb09f157d7368ce22c6b7f33fde0fe74cba75ae9679af52088b57bb0::pool::Pool<T0, T1>>(arg2),
            position_id   : arg3,
            amount        : v0,
            growth_inside : v1,
            token         : 0x1::type_name::get<T2>(),
        };
        0x2::event::emit<EventClaimPositionReward>(v2);
        v0
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

    public fun increase_gauge_emissions<T0, T1, T2, T3, T4>(arg0: &mut Minter<T4>, arg1: &0xebd610a15f0caa02527f4544eaf56fb4655ef493e8654f44a14220e442245d2e::voter::Voter, arg2: &0xebd610a15f0caa02527f4544eaf56fb4655ef493e8654f44a14220e442245d2e::distribution_config::DistributionConfig, arg3: &AdminCap, arg4: &mut 0xebd610a15f0caa02527f4544eaf56fb4655ef493e8654f44a14220e442245d2e::gauge::Gauge<T0, T1>, arg5: &mut 0xaa3ae572fb09f157d7368ce22c6b7f33fde0fe74cba75ae9679af52088b57bb0::pool::Pool<T0, T1>, arg6: u64, arg7: &mut 0x932133ea33d895f55693eb0949fe25c9007f1af976683fcbb30c32126b2aa9fb::price_monitor::PriceMonitor, arg8: &0xaa3ae572fb09f157d7368ce22c6b7f33fde0fe74cba75ae9679af52088b57bb0::pool::Pool<T2, T3>, arg9: &0xc3c7e6eb7202e9fb0389a2f7542b91cc40e4f7a33c02554fec11c4c92f938ea3::aggregator::Aggregator, arg10: &0x2::clock::Clock, arg11: &mut 0x2::tx_context::TxContext) {
        0xebd610a15f0caa02527f4544eaf56fb4655ef493e8654f44a14220e442245d2e::distribution_config::checked_package_version(arg2);
        check_admin<T4>(arg0, arg3);
        assert!(is_valid_distribution_config<T4>(arg0, arg2), 578889065004501400);
        assert!(is_active<T4>(arg0, arg10), 204872681976552500);
        assert!(!is_paused<T4>(arg0), 566083930742334200);
        assert!(!is_emission_stopped<T4>(arg0), 123456789012345678);
        assert!(0xebd610a15f0caa02527f4544eaf56fb4655ef493e8654f44a14220e442245d2e::distribution_config::is_valid_sail_price_aggregator(arg2, arg9), 371600893769831900);
        assert!(0x1::type_name::get<T2>() == 0x1::type_name::get<T4>() || 0x1::type_name::get<T3>() == 0x1::type_name::get<T4>(), 939179427939211244);
        let (v0, v1) = get_aggregator_price_without_decimals<T2, T3, T4>(arg0, arg7, arg8, arg9, arg10);
        if (v1) {
            return
        };
        increase_gauge_emissions_internal<T0, T1, T4>(arg0, arg1, arg2, arg4, arg5, arg6, v0, arg10, arg11);
    }

    public fun increase_gauge_emissions_for_sail_pool<T0, T1, T2>(arg0: &mut Minter<T2>, arg1: &0xebd610a15f0caa02527f4544eaf56fb4655ef493e8654f44a14220e442245d2e::voter::Voter, arg2: &0xebd610a15f0caa02527f4544eaf56fb4655ef493e8654f44a14220e442245d2e::distribution_config::DistributionConfig, arg3: &AdminCap, arg4: &mut 0xebd610a15f0caa02527f4544eaf56fb4655ef493e8654f44a14220e442245d2e::gauge::Gauge<T0, T1>, arg5: &mut 0xaa3ae572fb09f157d7368ce22c6b7f33fde0fe74cba75ae9679af52088b57bb0::pool::Pool<T0, T1>, arg6: u64, arg7: &mut 0x932133ea33d895f55693eb0949fe25c9007f1af976683fcbb30c32126b2aa9fb::price_monitor::PriceMonitor, arg8: &0xc3c7e6eb7202e9fb0389a2f7542b91cc40e4f7a33c02554fec11c4c92f938ea3::aggregator::Aggregator, arg9: &0x2::clock::Clock, arg10: &mut 0x2::tx_context::TxContext) {
        0xebd610a15f0caa02527f4544eaf56fb4655ef493e8654f44a14220e442245d2e::distribution_config::checked_package_version(arg2);
        check_admin<T2>(arg0, arg3);
        assert!(is_valid_distribution_config<T2>(arg0, arg2), 578889065004501400);
        assert!(is_active<T2>(arg0, arg9), 204872681976552500);
        assert!(!is_paused<T2>(arg0), 566083930742334200);
        assert!(!is_emission_stopped<T2>(arg0), 123456789012345678);
        assert!(0xebd610a15f0caa02527f4544eaf56fb4655ef493e8654f44a14220e442245d2e::distribution_config::is_valid_sail_price_aggregator(arg2, arg8), 371600893769831900);
        assert!(0x1::type_name::get<T0>() == 0x1::type_name::get<T2>() || 0x1::type_name::get<T1>() == 0x1::type_name::get<T2>(), 939179427939211244);
        let (v0, v1) = get_aggregator_price_without_decimals<T0, T1, T2>(arg0, arg7, arg5, arg8, arg9);
        if (v1) {
            return
        };
        increase_gauge_emissions_internal<T0, T1, T2>(arg0, arg1, arg2, arg4, arg5, arg6, v0, arg9, arg10);
    }

    fun increase_gauge_emissions_internal<T0, T1, T2>(arg0: &mut Minter<T2>, arg1: &0xebd610a15f0caa02527f4544eaf56fb4655ef493e8654f44a14220e442245d2e::voter::Voter, arg2: &0xebd610a15f0caa02527f4544eaf56fb4655ef493e8654f44a14220e442245d2e::distribution_config::DistributionConfig, arg3: &mut 0xebd610a15f0caa02527f4544eaf56fb4655ef493e8654f44a14220e442245d2e::gauge::Gauge<T0, T1>, arg4: &mut 0xaa3ae572fb09f157d7368ce22c6b7f33fde0fe74cba75ae9679af52088b57bb0::pool::Pool<T0, T1>, arg5: u64, arg6: u128, arg7: &0x2::clock::Clock, arg8: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::object::id<0xebd610a15f0caa02527f4544eaf56fb4655ef493e8654f44a14220e442245d2e::gauge::Gauge<T0, T1>>(arg3);
        assert!(gauge_distributed<T2>(arg0, v0), 243036335954370780);
        0xebd610a15f0caa02527f4544eaf56fb4655ef493e8654f44a14220e442245d2e::distribute_cap::validate_distribute_voter_id(0x1::option::borrow<0xebd610a15f0caa02527f4544eaf56fb4655ef493e8654f44a14220e442245d2e::distribute_cap::DistributeCap>(&arg0.distribute_cap), 0x2::object::id<0xebd610a15f0caa02527f4544eaf56fb4655ef493e8654f44a14220e442245d2e::voter::Voter>(arg1));
        0x2::table::add<0x2::object::ID, u64>(&mut arg0.gauge_epoch_emissions_usd, v0, 0x2::table::remove<0x2::object::ID, u64>(&mut arg0.gauge_epoch_emissions_usd, v0) + arg5);
        0x2::table::add<u64, u64>(&mut arg0.total_epoch_emissions_usd, arg0.active_period, 0x2::table::remove<u64, u64>(&mut arg0.total_epoch_emissions_usd, arg0.active_period) + arg5);
        0xebd610a15f0caa02527f4544eaf56fb4655ef493e8654f44a14220e442245d2e::voter::notify_gauge_reward_without_claim<T0, T1>(arg1, arg2, arg3, arg4, arg5, arg6, arg7, arg8);
        let v1 = EventIncreaseGaugeEmissions{
            gauge_id               : v0,
            pool_id                : 0x2::object::id<0xaa3ae572fb09f157d7368ce22c6b7f33fde0fe74cba75ae9679af52088b57bb0::pool::Pool<T0, T1>>(arg4),
            emissions_increase_usd : arg5,
            o_sail_type            : *0x1::option::borrow<0x1::type_name::TypeName>(&arg0.current_epoch_o_sail),
        };
        0x2::event::emit<EventIncreaseGaugeEmissions>(v1);
    }

    fun init(arg0: MINTER, arg1: &mut 0x2::tx_context::TxContext) {
        0x2::package::claim_and_keep<MINTER>(arg0, arg1);
    }

    public fun inject_voting_fee_reward<T0, T1>(arg0: &mut Minter<T0>, arg1: &mut 0xebd610a15f0caa02527f4544eaf56fb4655ef493e8654f44a14220e442245d2e::voter::Voter, arg2: &0xebd610a15f0caa02527f4544eaf56fb4655ef493e8654f44a14220e442245d2e::distribution_config::DistributionConfig, arg3: &DistributeGovernorCap, arg4: 0x2::object::ID, arg5: 0x2::coin::Coin<T1>, arg6: &0x2::clock::Clock, arg7: &mut 0x2::tx_context::TxContext) {
        0xebd610a15f0caa02527f4544eaf56fb4655ef493e8654f44a14220e442245d2e::distribution_config::checked_package_version(arg2);
        check_distribute_governor<T0>(arg0, arg3);
        0xebd610a15f0caa02527f4544eaf56fb4655ef493e8654f44a14220e442245d2e::voter::inject_voting_fee_reward<T1>(arg1, 0x1::option::borrow<0xebd610a15f0caa02527f4544eaf56fb4655ef493e8654f44a14220e442245d2e::distribute_cap::DistributeCap>(&arg0.distribute_cap), arg4, arg5, arg6, arg7);
    }

    public fun is_active<T0>(arg0: &Minter<T0>, arg1: &0x2::clock::Clock) : bool {
        arg0.activated_at > 0 && 0x61d3c07c67f6ebcc46c950a731dd263a0325fdfe03382e1bd50e4aba964f9e1c::common::current_period(arg1) >= arg0.active_period
    }

    public fun is_emission_stopped<T0>(arg0: &Minter<T0>) : bool {
        arg0.emission_stopped
    }

    public fun is_paused<T0>(arg0: &Minter<T0>) : bool {
        arg0.paused
    }

    public fun is_valid_distribution_config<T0>(arg0: &Minter<T0>, arg1: &0xebd610a15f0caa02527f4544eaf56fb4655ef493e8654f44a14220e442245d2e::distribution_config::DistributionConfig) : bool {
        arg0.distribution_config == 0x2::object::id<0xebd610a15f0caa02527f4544eaf56fb4655ef493e8654f44a14220e442245d2e::distribution_config::DistributionConfig>(arg1)
    }

    public fun is_valid_epoch_token<T0, T1>(arg0: &Minter<T0>) : bool {
        0x1::option::is_some<0x1::type_name::TypeName>(&arg0.current_epoch_o_sail) && *borrow_current_epoch_o_sail<T0>(arg0) == 0x1::type_name::get<T1>()
    }

    public fun is_valid_o_sail_type<T0, T1>(arg0: &Minter<T0>) : bool {
        0x2::table::contains<0x1::type_name::TypeName, u64>(&arg0.o_sail_expiry_dates, 0x1::type_name::get<T1>())
    }

    public fun is_whitelisted_usd<T0, T1>(arg0: &Minter<T0>) : bool {
        let v0 = 0x1::type_name::get<T1>();
        0x2::vec_set::contains<0x1::type_name::TypeName>(&arg0.whitelisted_usd, &v0)
    }

    public fun kill_gauge<T0>(arg0: &mut Minter<T0>, arg1: &mut 0xebd610a15f0caa02527f4544eaf56fb4655ef493e8654f44a14220e442245d2e::distribution_config::DistributionConfig, arg2: &0x61d3c07c67f6ebcc46c950a731dd263a0325fdfe03382e1bd50e4aba964f9e1c::emergency_council::EmergencyCouncilCap, arg3: 0x2::object::ID) {
        0xebd610a15f0caa02527f4544eaf56fb4655ef493e8654f44a14220e442245d2e::distribution_config::checked_package_version(arg1);
        0x61d3c07c67f6ebcc46c950a731dd263a0325fdfe03382e1bd50e4aba964f9e1c::emergency_council::validate_emergency_council_minter_id(arg2, 0x2::object::id<Minter<T0>>(arg0));
        assert!(is_valid_distribution_config<T0>(arg0, arg1), 401018599948013600);
        assert!(0xebd610a15f0caa02527f4544eaf56fb4655ef493e8654f44a14220e442245d2e::distribution_config::is_gauge_alive(arg1, arg3), 812297136203523100);
        let v0 = 0x1::vector::empty<0x2::object::ID>();
        0x1::vector::push_back<0x2::object::ID>(&mut v0, arg3);
        0xebd610a15f0caa02527f4544eaf56fb4655ef493e8654f44a14220e442245d2e::distribution_config::update_gauge_liveness(arg1, v0, false);
        let v1 = EventKillGauge{id: arg3};
        0x2::event::emit<EventKillGauge>(v1);
    }

    public fun last_epoch_update_time<T0>(arg0: &Minter<T0>) : u64 {
        arg0.last_epoch_update_time
    }

    fun mint_o_sail<T0, T1>(arg0: &mut Minter<T0>, arg1: u64, arg2: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<T1> {
        arg0.o_sail_minted_supply = arg0.o_sail_minted_supply + arg1;
        let v0 = EventMint{
            amount     : arg1,
            token_type : 0x1::type_name::get<T1>(),
            is_osail   : true,
        };
        0x2::event::emit<EventMint>(v0);
        0x2::coin::mint<T1>(borrow_mut_o_sail_cap<T0, T1>(arg0), arg1, arg2)
    }

    fun mint_sail<T0>(arg0: &mut Minter<T0>, arg1: u64, arg2: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<T0> {
        let v0 = EventMint{
            amount     : arg1,
            token_type : 0x1::type_name::get<T0>(),
            is_osail   : false,
        };
        0x2::event::emit<EventMint>(v0);
        0x2::coin::mint<T0>(0x1::option::borrow_mut<0x2::coin::TreasuryCap<T0>>(&mut arg0.sail_cap), arg1, arg2)
    }

    public fun notices() : (vector<u8>, vector<u8>) {
        (x"c2a92032303235204d65746162797465204c6162732c20496e632e2020416c6c205269676874732052657365727665642e", b"Patent pending - U.S. Patent Application No. 63/861,982")
    }

    public fun notify_exercise_fee_reward<T0, T1>(arg0: &mut Minter<T0>, arg1: &mut 0xebd610a15f0caa02527f4544eaf56fb4655ef493e8654f44a14220e442245d2e::voter::Voter, arg2: &0xebd610a15f0caa02527f4544eaf56fb4655ef493e8654f44a14220e442245d2e::distribution_config::DistributionConfig, arg3: &DistributeGovernorCap, arg4: 0x2::coin::Coin<T1>, arg5: &0x2::clock::Clock, arg6: &mut 0x2::tx_context::TxContext) {
        0xebd610a15f0caa02527f4544eaf56fb4655ef493e8654f44a14220e442245d2e::distribution_config::checked_package_version(arg2);
        check_distribute_governor<T0>(arg0, arg3);
        0xebd610a15f0caa02527f4544eaf56fb4655ef493e8654f44a14220e442245d2e::voter::notify_exercise_fee_reward_amount<T1>(arg1, 0x1::option::borrow<0xebd610a15f0caa02527f4544eaf56fb4655ef493e8654f44a14220e442245d2e::distribute_cap::DistributeCap>(&arg0.distribute_cap), arg4, arg5, arg6);
    }

    public fun null_exercise_fee_weights<T0>(arg0: &mut Minter<T0>, arg1: &mut 0xebd610a15f0caa02527f4544eaf56fb4655ef493e8654f44a14220e442245d2e::voter::Voter, arg2: &0xebd610a15f0caa02527f4544eaf56fb4655ef493e8654f44a14220e442245d2e::distribution_config::DistributionConfig, arg3: &DistributeGovernorCap, arg4: vector<0x2::object::ID>, arg5: u64, arg6: &0x2::clock::Clock, arg7: &mut 0x2::tx_context::TxContext) {
        0xebd610a15f0caa02527f4544eaf56fb4655ef493e8654f44a14220e442245d2e::distribution_config::checked_package_version(arg2);
        check_distribute_governor<T0>(arg0, arg3);
        let v0 = 0x1::vector::empty<u64>();
        let v1 = 0;
        while (v1 < 0x1::vector::length<0x2::object::ID>(&arg4)) {
            0x1::vector::push_back<u64>(&mut v0, 0);
            v1 = v1 + 1;
        };
        0xebd610a15f0caa02527f4544eaf56fb4655ef493e8654f44a14220e442245d2e::voter::update_exercise_fee_weights(arg1, 0x1::option::borrow<0xebd610a15f0caa02527f4544eaf56fb4655ef493e8654f44a14220e442245d2e::distribute_cap::DistributeCap>(&arg0.distribute_cap), v0, arg4, arg5, false, arg6, arg7);
    }

    public fun null_exercise_fee_weights_ignore_supply<T0>(arg0: &mut Minter<T0>, arg1: &mut 0xebd610a15f0caa02527f4544eaf56fb4655ef493e8654f44a14220e442245d2e::voter::Voter, arg2: &0xebd610a15f0caa02527f4544eaf56fb4655ef493e8654f44a14220e442245d2e::distribution_config::DistributionConfig, arg3: &DistributeGovernorCap, arg4: vector<0x2::object::ID>, arg5: u64, arg6: &0x2::clock::Clock, arg7: &mut 0x2::tx_context::TxContext) {
        0xebd610a15f0caa02527f4544eaf56fb4655ef493e8654f44a14220e442245d2e::distribution_config::checked_package_version(arg2);
        check_distribute_governor<T0>(arg0, arg3);
        let v0 = 0x1::vector::empty<u64>();
        let v1 = 0;
        while (v1 < 0x1::vector::length<0x2::object::ID>(&arg4)) {
            0x1::vector::push_back<u64>(&mut v0, 0);
            v1 = v1 + 1;
        };
        0xebd610a15f0caa02527f4544eaf56fb4655ef493e8654f44a14220e442245d2e::voter::update_exercise_fee_weights_ignore_supply(arg1, 0x1::option::borrow<0xebd610a15f0caa02527f4544eaf56fb4655ef493e8654f44a14220e442245d2e::distribute_cap::DistributeCap>(&arg0.distribute_cap), v0, arg4, arg5, arg6, arg7);
    }

    public fun null_gauge_emissions<T0, T1, T2, T3, T4>(arg0: &mut Minter<T4>, arg1: &0xebd610a15f0caa02527f4544eaf56fb4655ef493e8654f44a14220e442245d2e::voter::Voter, arg2: &0xebd610a15f0caa02527f4544eaf56fb4655ef493e8654f44a14220e442245d2e::distribution_config::DistributionConfig, arg3: &AdminCap, arg4: &mut 0xebd610a15f0caa02527f4544eaf56fb4655ef493e8654f44a14220e442245d2e::gauge::Gauge<T0, T1>, arg5: &mut 0xaa3ae572fb09f157d7368ce22c6b7f33fde0fe74cba75ae9679af52088b57bb0::pool::Pool<T0, T1>, arg6: &mut 0x932133ea33d895f55693eb0949fe25c9007f1af976683fcbb30c32126b2aa9fb::price_monitor::PriceMonitor, arg7: &0xaa3ae572fb09f157d7368ce22c6b7f33fde0fe74cba75ae9679af52088b57bb0::pool::Pool<T2, T3>, arg8: &0xc3c7e6eb7202e9fb0389a2f7542b91cc40e4f7a33c02554fec11c4c92f938ea3::aggregator::Aggregator, arg9: &0x2::clock::Clock, arg10: &mut 0x2::tx_context::TxContext) {
        0xebd610a15f0caa02527f4544eaf56fb4655ef493e8654f44a14220e442245d2e::distribution_config::checked_package_version(arg2);
        check_admin<T4>(arg0, arg3);
        assert!(is_valid_distribution_config<T4>(arg0, arg2), 999449428985169400);
        assert!(is_active<T4>(arg0, arg9), 331184800637416260);
        assert!(!is_paused<T4>(arg0), 822945392897831400);
        assert!(!is_emission_stopped<T4>(arg0), 123456789012345678);
        assert!(0xebd610a15f0caa02527f4544eaf56fb4655ef493e8654f44a14220e442245d2e::distribution_config::is_valid_sail_price_aggregator(arg2, arg8), 615720519320343900);
        assert!(0x1::type_name::get<T2>() == 0x1::type_name::get<T4>() || 0x1::type_name::get<T3>() == 0x1::type_name::get<T4>(), 939179427939211244);
        let (v0, v1) = get_aggregator_price_without_decimals<T2, T3, T4>(arg0, arg6, arg7, arg8, arg9);
        if (v1) {
            return
        };
        null_gauge_emissions_internal<T0, T1, T4>(arg0, arg1, arg2, arg4, arg5, v0, arg9, arg10);
    }

    public fun null_gauge_emissions_for_sail_pool<T0, T1, T2>(arg0: &mut Minter<T2>, arg1: &0xebd610a15f0caa02527f4544eaf56fb4655ef493e8654f44a14220e442245d2e::voter::Voter, arg2: &0xebd610a15f0caa02527f4544eaf56fb4655ef493e8654f44a14220e442245d2e::distribution_config::DistributionConfig, arg3: &AdminCap, arg4: &mut 0xebd610a15f0caa02527f4544eaf56fb4655ef493e8654f44a14220e442245d2e::gauge::Gauge<T0, T1>, arg5: &mut 0xaa3ae572fb09f157d7368ce22c6b7f33fde0fe74cba75ae9679af52088b57bb0::pool::Pool<T0, T1>, arg6: &mut 0x932133ea33d895f55693eb0949fe25c9007f1af976683fcbb30c32126b2aa9fb::price_monitor::PriceMonitor, arg7: &0xc3c7e6eb7202e9fb0389a2f7542b91cc40e4f7a33c02554fec11c4c92f938ea3::aggregator::Aggregator, arg8: &0x2::clock::Clock, arg9: &mut 0x2::tx_context::TxContext) {
        0xebd610a15f0caa02527f4544eaf56fb4655ef493e8654f44a14220e442245d2e::distribution_config::checked_package_version(arg2);
        check_admin<T2>(arg0, arg3);
        assert!(is_valid_distribution_config<T2>(arg0, arg2), 999449428985169400);
        assert!(is_active<T2>(arg0, arg8), 331184800637416260);
        assert!(!is_paused<T2>(arg0), 822945392897831400);
        assert!(!is_emission_stopped<T2>(arg0), 123456789012345678);
        assert!(0xebd610a15f0caa02527f4544eaf56fb4655ef493e8654f44a14220e442245d2e::distribution_config::is_valid_sail_price_aggregator(arg2, arg7), 615720519320343900);
        assert!(0x1::type_name::get<T0>() == 0x1::type_name::get<T2>() || 0x1::type_name::get<T1>() == 0x1::type_name::get<T2>(), 939179427939211244);
        let (v0, v1) = get_aggregator_price_without_decimals<T0, T1, T2>(arg0, arg6, arg5, arg7, arg8);
        if (v1) {
            return
        };
        null_gauge_emissions_internal<T0, T1, T2>(arg0, arg1, arg2, arg4, arg5, v0, arg8, arg9);
    }

    fun null_gauge_emissions_internal<T0, T1, T2>(arg0: &mut Minter<T2>, arg1: &0xebd610a15f0caa02527f4544eaf56fb4655ef493e8654f44a14220e442245d2e::voter::Voter, arg2: &0xebd610a15f0caa02527f4544eaf56fb4655ef493e8654f44a14220e442245d2e::distribution_config::DistributionConfig, arg3: &mut 0xebd610a15f0caa02527f4544eaf56fb4655ef493e8654f44a14220e442245d2e::gauge::Gauge<T0, T1>, arg4: &mut 0xaa3ae572fb09f157d7368ce22c6b7f33fde0fe74cba75ae9679af52088b57bb0::pool::Pool<T0, T1>, arg5: u128, arg6: &0x2::clock::Clock, arg7: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::object::id<0xebd610a15f0caa02527f4544eaf56fb4655ef493e8654f44a14220e442245d2e::gauge::Gauge<T0, T1>>(arg3);
        assert!(gauge_distributed<T2>(arg0, v0), 993690112178294400);
        0xebd610a15f0caa02527f4544eaf56fb4655ef493e8654f44a14220e442245d2e::distribute_cap::validate_distribute_voter_id(0x1::option::borrow<0xebd610a15f0caa02527f4544eaf56fb4655ef493e8654f44a14220e442245d2e::distribute_cap::DistributeCap>(&arg0.distribute_cap), 0x2::object::id<0xebd610a15f0caa02527f4544eaf56fb4655ef493e8654f44a14220e442245d2e::voter::Voter>(arg1));
        let v1 = 0xebd610a15f0caa02527f4544eaf56fb4655ef493e8654f44a14220e442245d2e::voter::null_gauge_rewards<T0, T1>(arg1, arg2, arg3, arg4, arg5, arg6, arg7);
        let v2 = 0x2::table::remove<0x2::object::ID, u64>(&mut arg0.gauge_epoch_emissions_usd, v0);
        assert!(v2 >= v1, 898366676764968400);
        let v3 = v2 - v1;
        0x2::table::add<0x2::object::ID, u64>(&mut arg0.gauge_epoch_emissions_usd, v0, v3);
        let v4 = 0x2::table::remove<u64, u64>(&mut arg0.total_epoch_emissions_usd, arg0.active_period);
        assert!(v4 >= v1, 608854472762321500);
        let v5 = v4 - v1;
        0x2::table::add<u64, u64>(&mut arg0.total_epoch_emissions_usd, arg0.active_period, v5);
        let v6 = EventNullGaugeEmissions{
            gauge_id                      : v0,
            pool_id                       : 0x2::object::id<0xaa3ae572fb09f157d7368ce22c6b7f33fde0fe74cba75ae9679af52088b57bb0::pool::Pool<T0, T1>>(arg4),
            rewards_nulled_usd            : v1,
            new_gauge_epoch_emissions_usd : v3,
            new_total_epoch_emissions_usd : v5,
        };
        0x2::event::emit<EventNullGaugeEmissions>(v6);
    }

    public fun o_sail_emissions_by_epoch<T0>(arg0: &Minter<T0>, arg1: u64) : u64 {
        if (0x2::table::contains<u64, u64>(&arg0.total_epoch_o_sail_emissions, arg1)) {
            *0x2::table::borrow<u64, u64>(&arg0.total_epoch_o_sail_emissions, arg1)
        } else {
            0
        }
    }

    public fun o_sail_epoch_emissions<T0>(arg0: &Minter<T0>, arg1: &0xebd610a15f0caa02527f4544eaf56fb4655ef493e8654f44a14220e442245d2e::distribution_config::DistributionConfig) : u64 {
        o_sail_emissions_by_epoch<T0>(arg0, arg0.active_period - 0x61d3c07c67f6ebcc46c950a731dd263a0325fdfe03382e1bd50e4aba964f9e1c::common::epoch())
    }

    public fun o_sail_minted_supply<T0>(arg0: &Minter<T0>) : u64 {
        arg0.o_sail_minted_supply
    }

    public fun pause<T0>(arg0: &mut Minter<T0>, arg1: &0xebd610a15f0caa02527f4544eaf56fb4655ef493e8654f44a14220e442245d2e::distribution_config::DistributionConfig, arg2: &AdminCap) {
        0xebd610a15f0caa02527f4544eaf56fb4655ef493e8654f44a14220e442245d2e::distribution_config::checked_package_version(arg1);
        check_admin<T0>(arg0, arg2);
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

    public fun reset_final_exercise_fee_weights<T0>(arg0: &mut Minter<T0>, arg1: &mut 0xebd610a15f0caa02527f4544eaf56fb4655ef493e8654f44a14220e442245d2e::voter::Voter, arg2: &0xebd610a15f0caa02527f4544eaf56fb4655ef493e8654f44a14220e442245d2e::distribution_config::DistributionConfig, arg3: &DistributeGovernorCap, arg4: u64, arg5: &mut 0x2::tx_context::TxContext) {
        0xebd610a15f0caa02527f4544eaf56fb4655ef493e8654f44a14220e442245d2e::distribution_config::checked_package_version(arg2);
        check_distribute_governor<T0>(arg0, arg3);
        0xebd610a15f0caa02527f4544eaf56fb4655ef493e8654f44a14220e442245d2e::voter::reset_final_exercise_fee_weights(arg1, 0x1::option::borrow<0xebd610a15f0caa02527f4544eaf56fb4655ef493e8654f44a14220e442245d2e::distribute_cap::DistributeCap>(&arg0.distribute_cap), arg4, arg5);
    }

    public fun reset_final_voted_weights<T0>(arg0: &mut Minter<T0>, arg1: &mut 0xebd610a15f0caa02527f4544eaf56fb4655ef493e8654f44a14220e442245d2e::voter::Voter, arg2: &0xebd610a15f0caa02527f4544eaf56fb4655ef493e8654f44a14220e442245d2e::distribution_config::DistributionConfig, arg3: &DistributeGovernorCap, arg4: 0x2::object::ID, arg5: u64, arg6: &mut 0x2::tx_context::TxContext) {
        0xebd610a15f0caa02527f4544eaf56fb4655ef493e8654f44a14220e442245d2e::distribution_config::checked_package_version(arg2);
        check_distribute_governor<T0>(arg0, arg3);
        0xebd610a15f0caa02527f4544eaf56fb4655ef493e8654f44a14220e442245d2e::voter::reset_final_voted_weights(arg1, 0x1::option::borrow<0xebd610a15f0caa02527f4544eaf56fb4655ef493e8654f44a14220e442245d2e::distribute_cap::DistributeCap>(&arg0.distribute_cap), arg4, arg5, arg6);
    }

    public fun reset_gauge<T0, T1, T2>(arg0: &mut Minter<T2>, arg1: &mut 0xebd610a15f0caa02527f4544eaf56fb4655ef493e8654f44a14220e442245d2e::distribution_config::DistributionConfig, arg2: &0x61d3c07c67f6ebcc46c950a731dd263a0325fdfe03382e1bd50e4aba964f9e1c::emergency_council::EmergencyCouncilCap, arg3: &mut 0xebd610a15f0caa02527f4544eaf56fb4655ef493e8654f44a14220e442245d2e::gauge::Gauge<T0, T1>, arg4: u64, arg5: &0x2::clock::Clock) {
        0xebd610a15f0caa02527f4544eaf56fb4655ef493e8654f44a14220e442245d2e::distribution_config::checked_package_version(arg1);
        0x61d3c07c67f6ebcc46c950a731dd263a0325fdfe03382e1bd50e4aba964f9e1c::emergency_council::validate_emergency_council_minter_id(arg2, 0x2::object::id<Minter<T2>>(arg0));
        assert!(!is_paused<T2>(arg0), 412179529765746000);
        assert!(is_active<T2>(arg0, arg5), 125563751493106940);
        assert!(arg4 > 0, 777730412186606000);
        assert!(is_valid_distribution_config<T2>(arg0, arg1), 726258387105137800);
        let v0 = 0x2::object::id<0xebd610a15f0caa02527f4544eaf56fb4655ef493e8654f44a14220e442245d2e::gauge::Gauge<T0, T1>>(arg3);
        assert!(!0xebd610a15f0caa02527f4544eaf56fb4655ef493e8654f44a14220e442245d2e::distribution_config::is_gauge_alive(arg1, v0), 452133119942522700);
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
        let v1 = EventResetGauge{
            id                   : v0,
            gauge_base_emissions : arg4,
        };
        0x2::event::emit<EventResetGauge>(v1);
    }

    public fun resume_emission<T0>(arg0: &mut Minter<T0>, arg1: &0xebd610a15f0caa02527f4544eaf56fb4655ef493e8654f44a14220e442245d2e::distribution_config::DistributionConfig, arg2: &AdminCap) {
        0xebd610a15f0caa02527f4544eaf56fb4655ef493e8654f44a14220e442245d2e::distribution_config::checked_package_version(arg1);
        check_admin<T0>(arg0, arg2);
        arg0.emission_stopped = false;
        let v0 = EventResumeEmission{dummy_field: false};
        0x2::event::emit<EventResumeEmission>(v0);
    }

    public fun revive_gauge<T0>(arg0: &mut Minter<T0>, arg1: &mut 0xebd610a15f0caa02527f4544eaf56fb4655ef493e8654f44a14220e442245d2e::distribution_config::DistributionConfig, arg2: &0x61d3c07c67f6ebcc46c950a731dd263a0325fdfe03382e1bd50e4aba964f9e1c::emergency_council::EmergencyCouncilCap, arg3: 0x2::object::ID) {
        0xebd610a15f0caa02527f4544eaf56fb4655ef493e8654f44a14220e442245d2e::distribution_config::checked_package_version(arg1);
        0x61d3c07c67f6ebcc46c950a731dd263a0325fdfe03382e1bd50e4aba964f9e1c::emergency_council::validate_emergency_council_minter_id(arg2, 0x2::object::id<Minter<T0>>(arg0));
        assert!(is_valid_distribution_config<T0>(arg0, arg1), 211832148784139800);
        assert!(!0xebd610a15f0caa02527f4544eaf56fb4655ef493e8654f44a14220e442245d2e::distribution_config::is_gauge_alive(arg1, arg3), 533150247921935500);
        assert!(0x2::table::contains<0x2::object::ID, u64>(&arg0.gauge_active_period, arg3) && *0x2::table::borrow<0x2::object::ID, u64>(&arg0.gauge_active_period, arg3) == arg0.active_period, 295306155667221200);
        revive_gauge_internal(arg1, arg3);
    }

    fun revive_gauge_internal(arg0: &mut 0xebd610a15f0caa02527f4544eaf56fb4655ef493e8654f44a14220e442245d2e::distribution_config::DistributionConfig, arg1: 0x2::object::ID) {
        let v0 = 0x1::vector::empty<0x2::object::ID>();
        0x1::vector::push_back<0x2::object::ID>(&mut v0, arg1);
        0xebd610a15f0caa02527f4544eaf56fb4655ef493e8654f44a14220e442245d2e::distribution_config::update_gauge_liveness(arg0, v0, true);
        let v1 = EventReviveGauge{id: arg1};
        0x2::event::emit<EventReviveGauge>(v1);
    }

    public fun revoke_admin<T0>(arg0: &mut Minter<T0>, arg1: &0x2::package::Publisher, arg2: 0x2::object::ID) {
        assert!(0x2::package::from_module<MINTER>(arg1), 729123415718822900);
        0x2::vec_set::insert<0x2::object::ID>(&mut arg0.revoked_admins, arg2);
        let v0 = EventRevokeAdmin{admin_cap: arg2};
        0x2::event::emit<EventRevokeAdmin>(v0);
    }

    public fun revoke_distribute_governor<T0>(arg0: &mut Minter<T0>, arg1: &0x2::package::Publisher, arg2: 0x2::object::ID) {
        assert!(0x2::package::from_module<MINTER>(arg1), 639606009071379600);
        0x2::vec_set::insert<0x2::object::ID>(&mut arg0.revoked_distribute_governors, arg2);
        let v0 = EventRevokeDistributeGovernor{distribute_governor_cap: arg2};
        0x2::event::emit<EventRevokeDistributeGovernor>(v0);
    }

    public fun sail_total_supply<T0>(arg0: &Minter<T0>) : u64 {
        0x2::coin::total_supply<T0>(0x1::option::borrow<0x2::coin::TreasuryCap<T0>>(&arg0.sail_cap))
    }

    public fun schedule_o_sail_mint<T0, T1>(arg0: &mut Minter<T0>, arg1: &0xebd610a15f0caa02527f4544eaf56fb4655ef493e8654f44a14220e442245d2e::distribution_config::DistributionConfig, arg2: &mut 0x2::package::Publisher, arg3: u64, arg4: &0x2::clock::Clock, arg5: &mut 0x2::tx_context::TxContext) : TimeLockedOSailMint<T1> {
        0xebd610a15f0caa02527f4544eaf56fb4655ef493e8654f44a14220e442245d2e::distribution_config::checked_package_version(arg1);
        assert!(0x2::package::from_module<MINTER>(arg2), 734928593233084000);
        assert!(!is_paused<T0>(arg0), 621003109924614900);
        assert!(is_valid_o_sail_type<T0, T1>(arg0), 348840174999730750);
        assert!(arg3 > 0, 424220271321603000);
        let v0 = 0x2::clock::timestamp_ms(arg4) + 86400000;
        let v1 = EventScheduleTimeLockedMint{
            amount      : arg3,
            unlock_time : v0,
            is_osail    : true,
            token_type  : 0x1::type_name::get<T1>(),
        };
        0x2::event::emit<EventScheduleTimeLockedMint>(v1);
        TimeLockedOSailMint<T1>{
            id          : 0x2::object::new(arg5),
            amount      : arg3,
            unlock_time : v0,
        }
    }

    public fun schedule_sail_mint<T0>(arg0: &mut Minter<T0>, arg1: &0xebd610a15f0caa02527f4544eaf56fb4655ef493e8654f44a14220e442245d2e::distribution_config::DistributionConfig, arg2: &mut 0x2::package::Publisher, arg3: u64, arg4: &0x2::clock::Clock, arg5: &mut 0x2::tx_context::TxContext) : TimeLockedSailMint {
        0xebd610a15f0caa02527f4544eaf56fb4655ef493e8654f44a14220e442245d2e::distribution_config::checked_package_version(arg1);
        assert!(0x2::package::from_module<MINTER>(arg2), 716204622969124700);
        assert!(!is_paused<T0>(arg0), 849544693573603300);
        assert!(arg3 > 0, 520351519384544260);
        let v0 = 0x2::clock::timestamp_ms(arg4) + 86400000;
        let v1 = EventScheduleTimeLockedMint{
            amount      : arg3,
            unlock_time : v0,
            is_osail    : false,
            token_type  : 0x1::type_name::get<T0>(),
        };
        0x2::event::emit<EventScheduleTimeLockedMint>(v1);
        TimeLockedSailMint{
            id          : 0x2::object::new(arg5),
            amount      : arg3,
            unlock_time : v0,
        }
    }

    public fun set_distribute_cap<T0>(arg0: &mut Minter<T0>, arg1: &AdminCap, arg2: &0xebd610a15f0caa02527f4544eaf56fb4655ef493e8654f44a14220e442245d2e::distribution_config::DistributionConfig, arg3: 0xebd610a15f0caa02527f4544eaf56fb4655ef493e8654f44a14220e442245d2e::distribute_cap::DistributeCap) {
        0xebd610a15f0caa02527f4544eaf56fb4655ef493e8654f44a14220e442245d2e::distribution_config::checked_package_version(arg2);
        assert!(!is_paused<T0>(arg0), 939345375978791600);
        check_admin<T0>(arg0, arg1);
        0x1::option::fill<0xebd610a15f0caa02527f4544eaf56fb4655ef493e8654f44a14220e442245d2e::distribute_cap::DistributeCap>(&mut arg0.distribute_cap, arg3);
        let v0 = EventSetDistributeCap{
            admin_cap      : 0x2::object::id<AdminCap>(arg1),
            distribute_cap : 0x2::object::id<0xebd610a15f0caa02527f4544eaf56fb4655ef493e8654f44a14220e442245d2e::distribute_cap::DistributeCap>(&arg3),
        };
        0x2::event::emit<EventSetDistributeCap>(v0);
    }

    public fun set_max_emission_change_ratio<T0>(arg0: &mut Minter<T0>, arg1: &0x2::package::Publisher, arg2: &0xebd610a15f0caa02527f4544eaf56fb4655ef493e8654f44a14220e442245d2e::distribution_config::DistributionConfig, arg3: u64) {
        0xebd610a15f0caa02527f4544eaf56fb4655ef493e8654f44a14220e442245d2e::distribution_config::checked_package_version(arg2);
        assert!(0x2::package::from_module<MINTER>(arg1), 716496543415068300);
        arg0.max_emission_change_ratio = arg3;
    }

    public fun set_operations_wallet<T0>(arg0: &mut Minter<T0>, arg1: &AdminCap, arg2: &0xebd610a15f0caa02527f4544eaf56fb4655ef493e8654f44a14220e442245d2e::distribution_config::DistributionConfig, arg3: address) {
        0xebd610a15f0caa02527f4544eaf56fb4655ef493e8654f44a14220e442245d2e::distribution_config::checked_package_version(arg2);
        check_admin<T0>(arg0, arg1);
        arg0.operations_wallet = arg3;
        let v0 = EventSetOperationsWallet{
            admin_cap         : 0x2::object::id<AdminCap>(arg1),
            operations_wallet : arg3,
        };
        0x2::event::emit<EventSetOperationsWallet>(v0);
    }

    public fun set_protocol_fee_rate<T0>(arg0: &mut Minter<T0>, arg1: &0xebd610a15f0caa02527f4544eaf56fb4655ef493e8654f44a14220e442245d2e::distribution_config::DistributionConfig, arg2: &AdminCap, arg3: u64) {
        0xebd610a15f0caa02527f4544eaf56fb4655ef493e8654f44a14220e442245d2e::distribution_config::checked_package_version(arg1);
        check_admin<T0>(arg0, arg2);
        assert!(!is_paused<T0>(arg0), 548722644715498500);
        assert!(arg3 <= 3000, 840171622736257200);
        arg0.protocol_fee_rate = arg3;
        let v0 = EventUpdateProtocolFeeRate{
            admin_cap         : 0x2::object::id<AdminCap>(arg2),
            protocol_fee_rate : arg3,
        };
        0x2::event::emit<EventUpdateProtocolFeeRate>(v0);
    }

    public fun set_protocol_wallet<T0>(arg0: &mut Minter<T0>, arg1: &AdminCap, arg2: &0xebd610a15f0caa02527f4544eaf56fb4655ef493e8654f44a14220e442245d2e::distribution_config::DistributionConfig, arg3: address) {
        0xebd610a15f0caa02527f4544eaf56fb4655ef493e8654f44a14220e442245d2e::distribution_config::checked_package_version(arg2);
        check_admin<T0>(arg0, arg1);
        arg0.protocol_wallet = arg3;
        let v0 = EventSetProtocolWallet{
            admin_cap       : 0x2::object::id<AdminCap>(arg1),
            protocol_wallet : arg3,
        };
        0x2::event::emit<EventSetProtocolWallet>(v0);
    }

    public fun set_rebase_distributor_cap<T0>(arg0: &mut Minter<T0>, arg1: &AdminCap, arg2: &0xebd610a15f0caa02527f4544eaf56fb4655ef493e8654f44a14220e442245d2e::distribution_config::DistributionConfig, arg3: 0xebd610a15f0caa02527f4544eaf56fb4655ef493e8654f44a14220e442245d2e::rebase_distributor_cap::RebaseDistributorCap) {
        0xebd610a15f0caa02527f4544eaf56fb4655ef493e8654f44a14220e442245d2e::distribution_config::checked_package_version(arg2);
        check_admin<T0>(arg0, arg1);
        0x1::option::fill<0xebd610a15f0caa02527f4544eaf56fb4655ef493e8654f44a14220e442245d2e::rebase_distributor_cap::RebaseDistributorCap>(&mut arg0.rebase_distributor_cap, arg3);
        let v0 = EventSetRebaseDistributorCap{rebase_distributor_cap: 0x2::object::id<0xebd610a15f0caa02527f4544eaf56fb4655ef493e8654f44a14220e442245d2e::rebase_distributor_cap::RebaseDistributorCap>(&arg3)};
        0x2::event::emit<EventSetRebaseDistributorCap>(v0);
    }

    public fun set_team_emission_rate<T0>(arg0: &mut Minter<T0>, arg1: &0xebd610a15f0caa02527f4544eaf56fb4655ef493e8654f44a14220e442245d2e::distribution_config::DistributionConfig, arg2: &AdminCap, arg3: u64) {
        0xebd610a15f0caa02527f4544eaf56fb4655ef493e8654f44a14220e442245d2e::distribution_config::checked_package_version(arg1);
        check_admin<T0>(arg0, arg2);
        assert!(!is_paused<T0>(arg0), 339140718471350200);
        assert!(arg3 <= 500, 922337292161803878);
        arg0.team_emission_rate = arg3;
        let v0 = EventUpdateTeamEmissionRate{
            admin_cap          : 0x2::object::id<AdminCap>(arg2),
            team_emission_rate : arg3,
        };
        0x2::event::emit<EventUpdateTeamEmissionRate>(v0);
    }

    public fun set_team_wallet<T0>(arg0: &mut Minter<T0>, arg1: &AdminCap, arg2: &0xebd610a15f0caa02527f4544eaf56fb4655ef493e8654f44a14220e442245d2e::distribution_config::DistributionConfig, arg3: address) {
        0xebd610a15f0caa02527f4544eaf56fb4655ef493e8654f44a14220e442245d2e::distribution_config::checked_package_version(arg2);
        check_admin<T0>(arg0, arg1);
        assert!(!is_paused<T0>(arg0), 587854778781893500);
        arg0.team_wallet = arg3;
        let v0 = EventSetTeamWallet{
            admin_cap   : 0x2::object::id<AdminCap>(arg1),
            team_wallet : arg3,
        };
        0x2::event::emit<EventSetTeamWallet>(v0);
    }

    public fun set_treasury_cap<T0>(arg0: &mut Minter<T0>, arg1: &0xebd610a15f0caa02527f4544eaf56fb4655ef493e8654f44a14220e442245d2e::distribution_config::DistributionConfig, arg2: &AdminCap, arg3: 0x2::coin::TreasuryCap<T0>, arg4: &0x2::coin::CoinMetadata<T0>) {
        0xebd610a15f0caa02527f4544eaf56fb4655ef493e8654f44a14220e442245d2e::distribution_config::checked_package_version(arg1);
        assert!(0x2::coin::get_decimals<T0>(arg4) == 0x61d3c07c67f6ebcc46c950a731dd263a0325fdfe03382e1bd50e4aba964f9e1c::common::sail_decimals(), 776365075387678700);
        set_treasury_cap_internal<T0>(arg0, arg2, arg3);
    }

    fun set_treasury_cap_internal<T0>(arg0: &mut Minter<T0>, arg1: &AdminCap, arg2: 0x2::coin::TreasuryCap<T0>) {
        assert!(!is_paused<T0>(arg0), 179209983522842700);
        check_admin<T0>(arg0, arg1);
        assert!(0x1::option::is_none<0x2::coin::TreasuryCap<T0>>(&arg0.sail_cap), 922337283142372556);
        0x1::option::fill<0x2::coin::TreasuryCap<T0>>(&mut arg0.sail_cap, arg2);
        let v0 = EventSetTreasuryCap{
            treasury_cap : 0x2::object::id<0x2::coin::TreasuryCap<T0>>(&arg2),
            token_type   : 0x1::type_name::get<T0>(),
        };
        0x2::event::emit<EventSetTreasuryCap>(v0);
    }

    public fun stop_emission<T0>(arg0: &mut Minter<T0>, arg1: &0xebd610a15f0caa02527f4544eaf56fb4655ef493e8654f44a14220e442245d2e::distribution_config::DistributionConfig, arg2: &AdminCap) {
        0xebd610a15f0caa02527f4544eaf56fb4655ef493e8654f44a14220e442245d2e::distribution_config::checked_package_version(arg1);
        check_admin<T0>(arg0, arg2);
        arg0.emission_stopped = true;
        let v0 = EventStopEmission{dummy_field: false};
        0x2::event::emit<EventStopEmission>(v0);
    }

    public fun sync_o_sail_distribution_price_for_sail_pool<T0, T1, T2>(arg0: &mut Minter<T2>, arg1: &mut 0xebd610a15f0caa02527f4544eaf56fb4655ef493e8654f44a14220e442245d2e::distribution_config::DistributionConfig, arg2: &mut 0xebd610a15f0caa02527f4544eaf56fb4655ef493e8654f44a14220e442245d2e::gauge::Gauge<T0, T1>, arg3: &mut 0xaa3ae572fb09f157d7368ce22c6b7f33fde0fe74cba75ae9679af52088b57bb0::pool::Pool<T0, T1>, arg4: &mut 0x932133ea33d895f55693eb0949fe25c9007f1af976683fcbb30c32126b2aa9fb::price_monitor::PriceMonitor, arg5: &0xc3c7e6eb7202e9fb0389a2f7542b91cc40e4f7a33c02554fec11c4c92f938ea3::aggregator::Aggregator, arg6: &0x2::clock::Clock) {
        0xebd610a15f0caa02527f4544eaf56fb4655ef493e8654f44a14220e442245d2e::distribution_config::checked_package_version(arg1);
        assert!(gauge_distributed<T2>(arg0, 0x2::object::id<0xebd610a15f0caa02527f4544eaf56fb4655ef493e8654f44a14220e442245d2e::gauge::Gauge<T0, T1>>(arg2)), 243036335954370780);
        assert!(is_valid_distribution_config<T2>(arg0, arg1), 578889065004501400);
        assert!(is_active<T2>(arg0, arg6), 204872681976552500);
        assert!(!is_paused<T2>(arg0), 566083930742334200);
        assert!(!is_emission_stopped<T2>(arg0), 123456789012345678);
        assert!(0xebd610a15f0caa02527f4544eaf56fb4655ef493e8654f44a14220e442245d2e::distribution_config::is_valid_sail_price_aggregator(arg1, arg5), 48171994695305640);
        assert!(0x1::type_name::get<T0>() == 0x1::type_name::get<T2>() || 0x1::type_name::get<T1>() == 0x1::type_name::get<T2>(), 939179427939211244);
        let (v0, v1) = get_aggregator_price_without_decimals<T0, T1, T2>(arg0, arg4, arg3, arg5, arg6);
        if (v1) {
            return
        };
        0xebd610a15f0caa02527f4544eaf56fb4655ef493e8654f44a14220e442245d2e::gauge::sync_o_sail_distribution_price<T0, T1>(arg2, arg1, arg3, v0, arg6);
    }

    public fun team_emission_rate<T0>(arg0: &Minter<T0>) : u64 {
        arg0.team_emission_rate
    }

    public fun unpause<T0>(arg0: &mut Minter<T0>, arg1: &0xebd610a15f0caa02527f4544eaf56fb4655ef493e8654f44a14220e442245d2e::distribution_config::DistributionConfig, arg2: &AdminCap) {
        0xebd610a15f0caa02527f4544eaf56fb4655ef493e8654f44a14220e442245d2e::distribution_config::checked_package_version(arg1);
        check_admin<T0>(arg0, arg2);
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
        0x2::table::add<0x1::type_name::TypeName, u64>(&mut arg0.o_sail_expiry_dates, v0, 0x61d3c07c67f6ebcc46c950a731dd263a0325fdfe03382e1bd50e4aba964f9e1c::common::current_period(arg2) + 0x61d3c07c67f6ebcc46c950a731dd263a0325fdfe03382e1bd50e4aba964f9e1c::common::o_sail_duration() + 0x61d3c07c67f6ebcc46c950a731dd263a0325fdfe03382e1bd50e4aba964f9e1c::common::epoch());
    }

    public fun update_period<T0, T1>(arg0: &mut Minter<T0>, arg1: &mut 0xebd610a15f0caa02527f4544eaf56fb4655ef493e8654f44a14220e442245d2e::voter::Voter, arg2: &0xebd610a15f0caa02527f4544eaf56fb4655ef493e8654f44a14220e442245d2e::distribution_config::DistributionConfig, arg3: &DistributeGovernorCap, arg4: &0x61d3c07c67f6ebcc46c950a731dd263a0325fdfe03382e1bd50e4aba964f9e1c::voting_escrow::VotingEscrow<T0>, arg5: &mut 0xebd610a15f0caa02527f4544eaf56fb4655ef493e8654f44a14220e442245d2e::rebase_distributor::RebaseDistributor<T0>, arg6: 0x2::coin::TreasuryCap<T1>, arg7: &0x2::coin::CoinMetadata<T1>, arg8: &0x2::clock::Clock, arg9: &mut 0x2::tx_context::TxContext) {
        0xebd610a15f0caa02527f4544eaf56fb4655ef493e8654f44a14220e442245d2e::distribution_config::checked_package_version(arg2);
        assert!(0x2::coin::get_decimals<T1>(arg7) == 0x61d3c07c67f6ebcc46c950a731dd263a0325fdfe03382e1bd50e4aba964f9e1c::common::sail_decimals(), 569106921639800800);
        update_period_internal<T0, T1>(arg0, arg1, arg2, arg3, arg4, arg5, arg6, arg8, arg9);
    }

    fun update_period_internal<T0, T1>(arg0: &mut Minter<T0>, arg1: &mut 0xebd610a15f0caa02527f4544eaf56fb4655ef493e8654f44a14220e442245d2e::voter::Voter, arg2: &0xebd610a15f0caa02527f4544eaf56fb4655ef493e8654f44a14220e442245d2e::distribution_config::DistributionConfig, arg3: &DistributeGovernorCap, arg4: &0x61d3c07c67f6ebcc46c950a731dd263a0325fdfe03382e1bd50e4aba964f9e1c::voting_escrow::VotingEscrow<T0>, arg5: &mut 0xebd610a15f0caa02527f4544eaf56fb4655ef493e8654f44a14220e442245d2e::rebase_distributor::RebaseDistributor<T0>, arg6: 0x2::coin::TreasuryCap<T1>, arg7: &0x2::clock::Clock, arg8: &mut 0x2::tx_context::TxContext) {
        assert!(!is_paused<T0>(arg0), 540422149172903100);
        check_distribute_governor<T0>(arg0, arg3);
        assert!(is_valid_distribution_config<T0>(arg0, arg2), 222427100417155840);
        assert!(is_active<T0>(arg0, arg7), 922337339406490010);
        let v0 = 0x61d3c07c67f6ebcc46c950a731dd263a0325fdfe03382e1bd50e4aba964f9e1c::common::current_timestamp(arg7);
        assert!(arg0.active_period + 0x61d3c07c67f6ebcc46c950a731dd263a0325fdfe03382e1bd50e4aba964f9e1c::common::epoch() < v0, 922337340695058843);
        assert!(0x1::option::is_some<0xebd610a15f0caa02527f4544eaf56fb4655ef493e8654f44a14220e442245d2e::rebase_distributor_cap::RebaseDistributorCap>(&arg0.rebase_distributor_cap), 493364785715856700);
        let v1 = o_sail_epoch_emissions<T0>(arg0, arg2);
        update_o_sail_token<T0, T1>(arg0, arg6, arg7);
        let v2 = 0;
        let v3 = 0;
        if (arg0.team_emission_rate > 0 && arg0.team_wallet != @0x0) {
            let v4 = 0x6b904ae739b2baad330aae14991abcd3b7354d3dc3db72507ed8dabeeb7a36de::full_math_u64::mul_div_floor(arg0.team_emission_rate, v2 + v1, 10000);
            v3 = v4;
            let v5 = mint_sail<T0>(arg0, v4, arg8);
            0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(v5, arg0.team_wallet);
        };
        0xebd610a15f0caa02527f4544eaf56fb4655ef493e8654f44a14220e442245d2e::voter::notify_epoch_token<T1>(arg1, 0x1::option::borrow<0xebd610a15f0caa02527f4544eaf56fb4655ef493e8654f44a14220e442245d2e::distribute_cap::DistributeCap>(&arg0.distribute_cap), arg8);
        arg0.active_period = 0x61d3c07c67f6ebcc46c950a731dd263a0325fdfe03382e1bd50e4aba964f9e1c::common::current_period(arg7);
        0xebd610a15f0caa02527f4544eaf56fb4655ef493e8654f44a14220e442245d2e::rebase_distributor::update_active_period<T0>(arg5, 0x1::option::borrow<0xebd610a15f0caa02527f4544eaf56fb4655ef493e8654f44a14220e442245d2e::rebase_distributor_cap::RebaseDistributorCap>(&arg0.rebase_distributor_cap), arg0.active_period);
        let v6 = EventUpdateEpoch{
            new_period                       : arg0.active_period,
            updated_at                       : v0,
            prev_prev_epoch_o_sail_emissions : v1,
            team_emissions                   : v3,
            finished_epoch_growth_rebase     : v2,
            epoch_o_sail_type                : 0x1::type_name::get<T1>(),
        };
        0x2::event::emit<EventUpdateEpoch>(v6);
    }

    public fun update_supply_exercise_fee_weights<T0>(arg0: &mut Minter<T0>, arg1: &mut 0xebd610a15f0caa02527f4544eaf56fb4655ef493e8654f44a14220e442245d2e::voter::Voter, arg2: &0xebd610a15f0caa02527f4544eaf56fb4655ef493e8654f44a14220e442245d2e::distribution_config::DistributionConfig, arg3: &DistributeGovernorCap, arg4: u64, arg5: u64, arg6: &0x2::clock::Clock, arg7: &mut 0x2::tx_context::TxContext) {
        0xebd610a15f0caa02527f4544eaf56fb4655ef493e8654f44a14220e442245d2e::distribution_config::checked_package_version(arg2);
        check_distribute_governor<T0>(arg0, arg3);
        0xebd610a15f0caa02527f4544eaf56fb4655ef493e8654f44a14220e442245d2e::voter::update_supply_exercise_fee_weights(arg1, 0x1::option::borrow<0xebd610a15f0caa02527f4544eaf56fb4655ef493e8654f44a14220e442245d2e::distribute_cap::DistributeCap>(&arg0.distribute_cap), arg4, arg5, arg6, arg7);
    }

    public fun update_supply_voted_weights<T0>(arg0: &mut Minter<T0>, arg1: &mut 0xebd610a15f0caa02527f4544eaf56fb4655ef493e8654f44a14220e442245d2e::voter::Voter, arg2: &0xebd610a15f0caa02527f4544eaf56fb4655ef493e8654f44a14220e442245d2e::distribution_config::DistributionConfig, arg3: &DistributeGovernorCap, arg4: 0x2::object::ID, arg5: u64, arg6: u64, arg7: &0x2::clock::Clock, arg8: &mut 0x2::tx_context::TxContext) {
        0xebd610a15f0caa02527f4544eaf56fb4655ef493e8654f44a14220e442245d2e::distribution_config::checked_package_version(arg2);
        check_distribute_governor<T0>(arg0, arg3);
        0xebd610a15f0caa02527f4544eaf56fb4655ef493e8654f44a14220e442245d2e::voter::update_supply_voted_weights(arg1, 0x1::option::borrow<0xebd610a15f0caa02527f4544eaf56fb4655ef493e8654f44a14220e442245d2e::distribute_cap::DistributeCap>(&arg0.distribute_cap), arg4, arg5, arg6, arg7, arg8);
    }

    public fun update_voted_weights<T0>(arg0: &mut Minter<T0>, arg1: &mut 0xebd610a15f0caa02527f4544eaf56fb4655ef493e8654f44a14220e442245d2e::voter::Voter, arg2: &0xebd610a15f0caa02527f4544eaf56fb4655ef493e8654f44a14220e442245d2e::distribution_config::DistributionConfig, arg3: &DistributeGovernorCap, arg4: 0x2::object::ID, arg5: vector<u64>, arg6: vector<0x2::object::ID>, arg7: u64, arg8: &0x2::clock::Clock, arg9: &mut 0x2::tx_context::TxContext) {
        0xebd610a15f0caa02527f4544eaf56fb4655ef493e8654f44a14220e442245d2e::distribution_config::checked_package_version(arg2);
        check_distribute_governor<T0>(arg0, arg3);
        0xebd610a15f0caa02527f4544eaf56fb4655ef493e8654f44a14220e442245d2e::voter::update_voted_weights(arg1, 0x1::option::borrow<0xebd610a15f0caa02527f4544eaf56fb4655ef493e8654f44a14220e442245d2e::distribute_cap::DistributeCap>(&arg0.distribute_cap), arg4, arg5, arg6, arg7, false, arg8, arg9);
    }

    public fun update_voted_weights_ignore_supply<T0>(arg0: &mut Minter<T0>, arg1: &mut 0xebd610a15f0caa02527f4544eaf56fb4655ef493e8654f44a14220e442245d2e::voter::Voter, arg2: &0xebd610a15f0caa02527f4544eaf56fb4655ef493e8654f44a14220e442245d2e::distribution_config::DistributionConfig, arg3: &DistributeGovernorCap, arg4: 0x2::object::ID, arg5: vector<u64>, arg6: vector<0x2::object::ID>, arg7: u64, arg8: &0x2::clock::Clock, arg9: &mut 0x2::tx_context::TxContext) {
        0xebd610a15f0caa02527f4544eaf56fb4655ef493e8654f44a14220e442245d2e::distribution_config::checked_package_version(arg2);
        check_distribute_governor<T0>(arg0, arg3);
        0xebd610a15f0caa02527f4544eaf56fb4655ef493e8654f44a14220e442245d2e::voter::update_voted_weights_ignore_supply(arg1, 0x1::option::borrow<0xebd610a15f0caa02527f4544eaf56fb4655ef493e8654f44a14220e442245d2e::distribute_cap::DistributeCap>(&arg0.distribute_cap), arg4, arg5, arg6, arg7, arg8, arg9);
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

    public fun whitelist_usd<T0, T1>(arg0: &mut Minter<T0>, arg1: &0xebd610a15f0caa02527f4544eaf56fb4655ef493e8654f44a14220e442245d2e::distribution_config::DistributionConfig, arg2: &AdminCap, arg3: bool) {
        0xebd610a15f0caa02527f4544eaf56fb4655ef493e8654f44a14220e442245d2e::distribution_config::checked_package_version(arg1);
        whitelist_usd_internal<T0, T1>(arg0, arg2, arg3);
    }

    fun whitelist_usd_internal<T0, T1>(arg0: &mut Minter<T0>, arg1: &AdminCap, arg2: bool) {
        assert!(!is_paused<T0>(arg0), 316161888154524900);
        check_admin<T0>(arg0, arg1);
        let v0 = 0x1::type_name::get<T1>();
        if (0x2::vec_set::contains<0x1::type_name::TypeName>(&arg0.whitelisted_usd, &v0)) {
            if (!arg2) {
                0x2::vec_set::remove<0x1::type_name::TypeName>(&mut arg0.whitelisted_usd, &v0);
            };
        } else if (arg2) {
            0x2::vec_set::insert<0x1::type_name::TypeName>(&mut arg0.whitelisted_usd, v0);
        };
        let v1 = EventWhitelistUSD{
            usd_type    : v0,
            whitelisted : arg2,
        };
        0x2::event::emit<EventWhitelistUSD>(v1);
    }

    // decompiled from Move bytecode v6
}

