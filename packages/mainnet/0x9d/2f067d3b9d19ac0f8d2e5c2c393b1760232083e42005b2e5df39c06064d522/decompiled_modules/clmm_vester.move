module 0x9d2f067d3b9d19ac0f8d2e5c2c393b1760232083e42005b2e5df39c06064d522::clmm_vester {
    struct ClmmVester has key {
        id: 0x2::object::UID,
        balance: 0x2::balance::Balance<0x6864a6f921804860930db6ddbe2e16acdf8504495ea7481637a1c8b9a8fe54b::cetus::CETUS>,
        global_vesting_periods: vector<GlobalVestingPeriod>,
        positions: 0x2::table::Table<0x2::object::ID, PositionVesting>,
        total_value: u64,
        total_cetus_amount: u64,
        redeemed_amount: u64,
        start_time: u64,
    }

    struct GlobalVestingPeriod has copy, drop, store {
        period: u16,
        release_time: u64,
        percentage: u64,
        redeemed_amount: u64,
    }

    struct PositionVesting has copy, drop, store {
        position_id: 0x2::object::ID,
        cetus_amount: u64,
        redeemed_amount: u64,
        coin_a: 0x1::type_name::TypeName,
        coin_b: 0x1::type_name::TypeName,
        impaired_a: u64,
        impaired_b: u64,
        period_details: vector<PeriodDetail>,
        is_paused: bool,
    }

    struct PeriodDetail has copy, drop, store {
        period: u64,
        cetus_amount: u64,
        is_redeemed: bool,
    }

    struct CreateEvent has copy, drop, store {
        clmm_vester_id: 0x2::object::ID,
        total_value: u64,
        total_cetus_amount: u64,
        start_time: u64,
        coin_type: 0x1::type_name::TypeName,
    }

    struct DepositEvent has copy, drop, store {
        clmm_vester_id: 0x2::object::ID,
        amount: u64,
    }

    struct PauseEvent has copy, drop, store {
        clmm_vester_id: 0x2::object::ID,
        position_id: 0x2::object::ID,
    }

    struct RedeemEvent has copy, drop, store {
        clmm_vester_id: 0x2::object::ID,
        position_id: 0x2::object::ID,
        period: u16,
        amount: u64,
    }

    struct GetPositionsVestingEvent has copy, drop, store {
        position_vestings: vector<PositionVesting>,
    }

    public fun borrow_position_vesting(arg0: &ClmmVester, arg1: 0x2::object::ID) : PositionVesting {
        *0x2::table::borrow<0x2::object::ID, PositionVesting>(&arg0.positions, arg1)
    }

    public fun calculate_cut_liquidity(arg0: u128, arg1: u64) : u128 {
        ((((arg0 as u256) * (arg1 as u256) + (1000000 as u256) - 1) / (1000000 as u256)) as u128)
    }

    public fun create(arg0: &0x9d2f067d3b9d19ac0f8d2e5c2c393b1760232083e42005b2e5df39c06064d522::versioned::Versioned, arg1: &0x9d2f067d3b9d19ac0f8d2e5c2c393b1760232083e42005b2e5df39c06064d522::admin_cap::AdminCap, arg2: vector<u64>, arg3: vector<u64>, arg4: u64, arg5: u64, arg6: &mut 0x2::tx_context::TxContext) {
        0x9d2f067d3b9d19ac0f8d2e5c2c393b1760232083e42005b2e5df39c06064d522::versioned::check_version(arg0);
        assert!(0x1::vector::length<u64>(&arg2) == 0x1::vector::length<u64>(&arg3), 0x9d2f067d3b9d19ac0f8d2e5c2c393b1760232083e42005b2e5df39c06064d522::errors::vesting_period_not_match());
        let v0 = 0x1::vector::empty<GlobalVestingPeriod>();
        let v1 = 0;
        let v2 = 0;
        while (v2 < 0x1::vector::length<u64>(&arg2)) {
            if (v2 > 0) {
                assert!(*0x1::vector::borrow<u64>(&arg2, v2) > *0x1::vector::borrow<u64>(&arg2, v2 - 1), 0x9d2f067d3b9d19ac0f8d2e5c2c393b1760232083e42005b2e5df39c06064d522::errors::release_time_error());
            };
            v1 = v1 + *0x1::vector::borrow<u64>(&arg3, v2);
            let v3 = GlobalVestingPeriod{
                period          : (v2 as u16),
                release_time    : *0x1::vector::borrow<u64>(&arg2, v2),
                percentage      : *0x1::vector::borrow<u64>(&arg3, v2),
                redeemed_amount : 0,
            };
            0x1::vector::push_back<GlobalVestingPeriod>(&mut v0, v3);
            v2 = v2 + 1;
        };
        assert!(v1 == 10000, 0x9d2f067d3b9d19ac0f8d2e5c2c393b1760232083e42005b2e5df39c06064d522::errors::percentage_not_equal());
        let v4 = *0x1::vector::borrow<u64>(&arg2, 0);
        let v5 = ClmmVester{
            id                     : 0x2::object::new(arg6),
            balance                : 0x2::balance::zero<0x6864a6f921804860930db6ddbe2e16acdf8504495ea7481637a1c8b9a8fe54b::cetus::CETUS>(),
            global_vesting_periods : v0,
            positions              : 0x2::table::new<0x2::object::ID, PositionVesting>(arg6),
            total_value            : arg4,
            total_cetus_amount     : arg5,
            redeemed_amount        : 0,
            start_time             : v4,
        };
        let v6 = CreateEvent{
            clmm_vester_id     : 0x2::object::id<ClmmVester>(&v5),
            total_value        : arg4,
            total_cetus_amount : arg5,
            start_time         : v4,
            coin_type          : 0x1::type_name::get<0x6864a6f921804860930db6ddbe2e16acdf8504495ea7481637a1c8b9a8fe54b::cetus::CETUS>(),
        };
        0x2::event::emit<CreateEvent>(v6);
        0x2::transfer::share_object<ClmmVester>(v5);
    }

    public fun deposit(arg0: &0x9d2f067d3b9d19ac0f8d2e5c2c393b1760232083e42005b2e5df39c06064d522::versioned::Versioned, arg1: &mut ClmmVester, arg2: &mut 0x2::coin::Coin<0x6864a6f921804860930db6ddbe2e16acdf8504495ea7481637a1c8b9a8fe54b::cetus::CETUS>, arg3: u64, arg4: &mut 0x2::tx_context::TxContext) {
        0x9d2f067d3b9d19ac0f8d2e5c2c393b1760232083e42005b2e5df39c06064d522::versioned::check_version(arg0);
        assert!(0x2::coin::value<0x6864a6f921804860930db6ddbe2e16acdf8504495ea7481637a1c8b9a8fe54b::cetus::CETUS>(arg2) >= arg3, 0x9d2f067d3b9d19ac0f8d2e5c2c393b1760232083e42005b2e5df39c06064d522::errors::balance_not_enough());
        0x2::coin::put<0x6864a6f921804860930db6ddbe2e16acdf8504495ea7481637a1c8b9a8fe54b::cetus::CETUS>(&mut arg1.balance, 0x2::coin::split<0x6864a6f921804860930db6ddbe2e16acdf8504495ea7481637a1c8b9a8fe54b::cetus::CETUS>(arg2, arg3, arg4));
        let v0 = DepositEvent{
            clmm_vester_id : 0x2::object::id<ClmmVester>(arg1),
            amount         : arg3,
        };
        0x2::event::emit<DepositEvent>(v0);
    }

    public fun detail_period(arg0: &PeriodDetail) : u64 {
        arg0.period
    }

    fun gen_position_vesting<T0, T1>(arg0: &ClmmVester, arg1: &0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T0, T1>, arg2: 0x2::object::ID) : PositionVesting {
        let v0 = 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::position_liquidity_snapshot<T0, T1>(arg1);
        let v1 = 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::position_snapshot::remove_percent(v0);
        let v2 = 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::get_position_snapshot_by_position_id<T0, T1>(arg1, arg2);
        let (v3, v4) = 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::position_snapshot::tick_range(&v2);
        let (v5, v6) = 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::clmm_math::get_amount_by_liquidity(v3, v4, 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::tick_math::get_tick_at_sqrt_price(0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::position_snapshot::current_sqrt_price(v0)), 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::position_snapshot::current_sqrt_price(v0), calculate_cut_liquidity(0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::position_snapshot::liquidity(&v2), v1), false);
        let v7 = (0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::position_snapshot::value_cut(&v2) as u128) * (arg0.total_cetus_amount as u128) / (arg0.total_value as u128);
        let v8 = 0x1::vector::empty<PeriodDetail>();
        let v9 = 0;
        let v10 = (v7 as u64);
        while (v9 < 0x1::vector::length<GlobalVestingPeriod>(&arg0.global_vesting_periods)) {
            let v11 = if (v9 == 0x1::vector::length<GlobalVestingPeriod>(&arg0.global_vesting_periods) - 1) {
                v10
            } else {
                (((v7 as u128) * (0x1::vector::borrow<GlobalVestingPeriod>(&arg0.global_vesting_periods, v9).percentage as u128) / (10000 as u128)) as u64)
            };
            v10 = v10 - v11;
            let v12 = PeriodDetail{
                period       : (v9 as u64),
                cetus_amount : v11,
                is_redeemed  : false,
            };
            0x1::vector::push_back<PeriodDetail>(&mut v8, v12);
            v9 = v9 + 1;
        };
        PositionVesting{
            position_id     : arg2,
            cetus_amount    : (v7 as u64),
            redeemed_amount : 0,
            coin_a          : 0x1::type_name::get<T0>(),
            coin_b          : 0x1::type_name::get<T1>(),
            impaired_a      : v5,
            impaired_b      : v6,
            period_details  : v8,
            is_paused       : false,
        }
    }

    public fun get_position_vesting<T0, T1>(arg0: &ClmmVester, arg1: &0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T0, T1>, arg2: 0x2::object::ID) : PositionVesting {
        if (0x2::table::contains<0x2::object::ID, PositionVesting>(&arg0.positions, arg2)) {
            *0x2::table::borrow<0x2::object::ID, PositionVesting>(&arg0.positions, arg2)
        } else {
            gen_position_vesting<T0, T1>(arg0, arg1, arg2)
        }
    }

    public fun get_positions_vesting<T0, T1>(arg0: &ClmmVester, arg1: &0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T0, T1>, arg2: vector<0x2::object::ID>) : vector<PositionVesting> {
        let v0 = 0x1::vector::empty<PositionVesting>();
        let v1 = 0;
        while (v1 < 0x1::vector::length<0x2::object::ID>(&arg2)) {
            let v2 = *0x1::vector::borrow<0x2::object::ID>(&arg2, v1);
            if (!0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::is_attacked_position<T0, T1>(arg1, v2)) {
                v1 = v1 + 1;
                continue
            };
            if (0x2::table::contains<0x2::object::ID, PositionVesting>(&arg0.positions, v2)) {
                0x1::vector::push_back<PositionVesting>(&mut v0, *0x2::table::borrow<0x2::object::ID, PositionVesting>(&arg0.positions, v2));
            } else {
                0x1::vector::push_back<PositionVesting>(&mut v0, gen_position_vesting<T0, T1>(arg0, arg1, v2));
            };
            v1 = v1 + 1;
        };
        let v3 = GetPositionsVestingEvent{position_vestings: v0};
        0x2::event::emit<GetPositionsVestingEvent>(v3);
        v0
    }

    public fun global_vesting_periods(arg0: &ClmmVester) : vector<GlobalVestingPeriod> {
        arg0.global_vesting_periods
    }

    public fun impaired_ab(arg0: &PositionVesting) : (u64, u64) {
        (arg0.impaired_a, arg0.impaired_b)
    }

    fun init_position_vesting<T0, T1>(arg0: &mut ClmmVester, arg1: &0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T0, T1>, arg2: 0x2::object::ID) {
        0x2::table::add<0x2::object::ID, PositionVesting>(&mut arg0.positions, arg2, gen_position_vesting<T0, T1>(arg0, arg1, arg2));
    }

    public fun is_paused(arg0: &PositionVesting) : bool {
        arg0.is_paused
    }

    public fun is_redeemed(arg0: &PeriodDetail) : bool {
        arg0.is_redeemed
    }

    public entry fun pause<T0, T1>(arg0: &mut ClmmVester, arg1: &0x9d2f067d3b9d19ac0f8d2e5c2c393b1760232083e42005b2e5df39c06064d522::versioned::Versioned, arg2: &0x9d2f067d3b9d19ac0f8d2e5c2c393b1760232083e42005b2e5df39c06064d522::admin_cap::AdminCap, arg3: &0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T0, T1>, arg4: 0x2::object::ID) {
        0x9d2f067d3b9d19ac0f8d2e5c2c393b1760232083e42005b2e5df39c06064d522::versioned::check_version(arg1);
        if (!0x2::table::contains<0x2::object::ID, PositionVesting>(&arg0.positions, arg4)) {
            init_position_vesting<T0, T1>(arg0, arg3, arg4);
        };
        0x2::table::borrow_mut<0x2::object::ID, PositionVesting>(&mut arg0.positions, arg4).is_paused = true;
        let v0 = PauseEvent{
            clmm_vester_id : 0x2::object::id<ClmmVester>(arg0),
            position_id    : arg4,
        };
        0x2::event::emit<PauseEvent>(v0);
    }

    public fun percentage(arg0: &GlobalVestingPeriod) : u64 {
        arg0.percentage
    }

    public fun period(arg0: &GlobalVestingPeriod) : u16 {
        arg0.period
    }

    public fun period_cetus_amount(arg0: &PeriodDetail) : u64 {
        arg0.cetus_amount
    }

    public fun position_cetus_amount(arg0: &PositionVesting) : u64 {
        arg0.cetus_amount
    }

    public fun position_id(arg0: &PositionVesting) : 0x2::object::ID {
        arg0.position_id
    }

    public fun position_is_paused(arg0: &PositionVesting) : bool {
        arg0.is_paused
    }

    public fun position_period_details(arg0: &PositionVesting) : vector<PeriodDetail> {
        arg0.period_details
    }

    public fun position_redeemed_amount(arg0: &PositionVesting) : u64 {
        arg0.redeemed_amount
    }

    public fun redeem<T0, T1>(arg0: &0x9d2f067d3b9d19ac0f8d2e5c2c393b1760232083e42005b2e5df39c06064d522::versioned::Versioned, arg1: &mut ClmmVester, arg2: &0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T0, T1>, arg3: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::position::Position, arg4: u16, arg5: &0x2::clock::Clock) : 0x2::balance::Balance<0x6864a6f921804860930db6ddbe2e16acdf8504495ea7481637a1c8b9a8fe54b::cetus::CETUS> {
        0x9d2f067d3b9d19ac0f8d2e5c2c393b1760232083e42005b2e5df39c06064d522::versioned::check_version(arg0);
        let v0 = 0x2::object::id<0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::position::Position>(arg3);
        assert!(0x2::object::id<0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T0, T1>>(arg2) == 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::position::pool_id(arg3), 0x9d2f067d3b9d19ac0f8d2e5c2c393b1760232083e42005b2e5df39c06064d522::errors::pool_not_match());
        assert!(0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::is_attacked_position<T0, T1>(arg2, v0), 0x9d2f067d3b9d19ac0f8d2e5c2c393b1760232083e42005b2e5df39c06064d522::errors::not_attacked_position());
        if (!0x2::table::contains<0x2::object::ID, PositionVesting>(&arg1.positions, v0)) {
            init_position_vesting<T0, T1>(arg1, arg2, v0);
        };
        let v1 = 0x2::table::borrow_mut<0x2::object::ID, PositionVesting>(&mut arg1.positions, v0);
        assert!(!v1.is_paused, 0x9d2f067d3b9d19ac0f8d2e5c2c393b1760232083e42005b2e5df39c06064d522::errors::vesting_paused());
        assert!((arg4 as u64) < 0x1::vector::length<PeriodDetail>(&v1.period_details), 0x9d2f067d3b9d19ac0f8d2e5c2c393b1760232083e42005b2e5df39c06064d522::errors::period_illegal());
        let v2 = *0x1::vector::borrow<GlobalVestingPeriod>(&arg1.global_vesting_periods, (arg4 as u64));
        assert!(0x2::clock::timestamp_ms(arg5) / 1000 >= v2.release_time, 0x9d2f067d3b9d19ac0f8d2e5c2c393b1760232083e42005b2e5df39c06064d522::errors::lock_time_not_end());
        let v3 = 0x1::vector::borrow_mut<PeriodDetail>(&mut v1.period_details, (arg4 as u64));
        assert!(!v3.is_redeemed, 0x9d2f067d3b9d19ac0f8d2e5c2c393b1760232083e42005b2e5df39c06064d522::errors::already_redeemed());
        v3.is_redeemed = true;
        let v4 = v3.cetus_amount;
        v1.redeemed_amount = v1.redeemed_amount + v4;
        let v5 = 0x1::vector::borrow_mut<GlobalVestingPeriod>(&mut arg1.global_vesting_periods, (arg4 as u64));
        v5.redeemed_amount = v5.redeemed_amount + v4;
        arg1.redeemed_amount = arg1.redeemed_amount + v4;
        assert!(0x2::balance::value<0x6864a6f921804860930db6ddbe2e16acdf8504495ea7481637a1c8b9a8fe54b::cetus::CETUS>(&arg1.balance) >= v4, 0x9d2f067d3b9d19ac0f8d2e5c2c393b1760232083e42005b2e5df39c06064d522::errors::balance_not_enough());
        let v6 = RedeemEvent{
            clmm_vester_id : 0x2::object::id<ClmmVester>(arg1),
            position_id    : 0x2::object::id<0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::position::Position>(arg3),
            period         : arg4,
            amount         : v4,
        };
        0x2::event::emit<RedeemEvent>(v6);
        0x2::balance::split<0x6864a6f921804860930db6ddbe2e16acdf8504495ea7481637a1c8b9a8fe54b::cetus::CETUS>(&mut arg1.balance, v4)
    }

    public fun release_time(arg0: &GlobalVestingPeriod) : u64 {
        arg0.release_time
    }

    public fun start_time(arg0: &ClmmVester) : u64 {
        arg0.start_time
    }

    public fun total_cetus_amount(arg0: &ClmmVester) : u64 {
        arg0.total_cetus_amount
    }

    public fun total_value(arg0: &ClmmVester) : u64 {
        arg0.total_value
    }

    // decompiled from Move bytecode v6
}

