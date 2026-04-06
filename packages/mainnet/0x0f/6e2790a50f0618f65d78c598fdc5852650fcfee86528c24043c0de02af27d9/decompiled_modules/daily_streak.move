module 0xf6e2790a50f0618f65d78c598fdc5852650fcfee86528c24043c0de02af27d9::daily_streak {
    struct DailyStreak has copy, drop, store {
        dummy_field: bool,
    }

    struct DailyStreakRegistryKey has copy, drop, store {
        dummy_field: bool,
    }

    struct DailyStreakRegistry has store, key {
        id: 0x2::object::UID,
        version_set: 0x2::vec_set::VecSet<u64>,
        is_enabled: bool,
        default_daily_usd_stake_threshhold: 0xbde37abf904292a57b279a9299ff508b7b55620db1f193771498c6c3d0ea2a6::float::Float,
        one_day_streak_freeze_usd_price: 0xbde37abf904292a57b279a9299ff508b7b55620db1f193771498c6c3d0ea2a6::float::Float,
        max_number_of_freezes_per_player: u64,
        streak_repair_usd_price: 0xbde37abf904292a57b279a9299ff508b7b55620db1f193771498c6c3d0ea2a6::float::Float,
        max_delay_to_repair_streak_ms: u64,
    }

    struct UserDailyStreakKey has copy, drop, store {
        pos0: address,
    }

    struct UserDailyStreakData has store, key {
        id: 0x2::object::UID,
        current_streak: u64,
        number_of_freezes: u64,
        last_time_new_streak_timestamp_ms: u64,
        last_stake_timestamp_ms: u64,
        total_stake_since_last_cycle_usd: 0xbde37abf904292a57b279a9299ff508b7b55620db1f193771498c6c3d0ea2a6::float::Float,
        last_streak_repair_timestamp_ms: u64,
        pending_streak_before_break: u64,
        pending_broken_since_ms: u64,
    }

    struct DailyStreakRegistryEditedEvent has copy, drop {
        is_enabled: bool,
        default_daily_usd_stake_threshhold: 0xbde37abf904292a57b279a9299ff508b7b55620db1f193771498c6c3d0ea2a6::float::Float,
        one_day_streak_freeze_usd_price: 0xbde37abf904292a57b279a9299ff508b7b55620db1f193771498c6c3d0ea2a6::float::Float,
        max_number_of_freezes_per_player: u64,
        streak_repair_usd_price: 0xbde37abf904292a57b279a9299ff508b7b55620db1f193771498c6c3d0ea2a6::float::Float,
        max_delay_to_repair_streak_ms: u64,
    }

    struct DailyStreakRegistryVersionChangedEvent has copy, drop {
        version_number: u64,
        is_added: bool,
    }

    struct DailyStreakSettledEvent has copy, drop {
        player: address,
        now_ms: u64,
        cycle_start_ms: u64,
        cycle_end_ms: u64,
        stake_threshold_usd: 0xbde37abf904292a57b279a9299ff508b7b55620db1f193771498c6c3d0ea2a6::float::Float,
        stake_usd_added: 0xbde37abf904292a57b279a9299ff508b7b55620db1f193771498c6c3d0ea2a6::float::Float,
        stake_usd_before: 0xbde37abf904292a57b279a9299ff508b7b55620db1f193771498c6c3d0ea2a6::float::Float,
        stake_usd_after: 0xbde37abf904292a57b279a9299ff508b7b55620db1f193771498c6c3d0ea2a6::float::Float,
        is_new_cycle: bool,
        streak_before: u64,
        freezes_before: u64,
        anchor_cycle_end_ms: u64,
        missed_cycles: u64,
        freezes_used: u64,
        broke_previous_streak: bool,
        broken_since_ms: u64,
        completed_cycle: bool,
        cleared_pending_streak_before_break: u64,
        cleared_pending_broken_since_ms: u64,
        current_streak: u64,
        number_of_freezes: u64,
        last_time_new_streak_timestamp_ms: u64,
        last_streak_repair_timestamp_ms: u64,
        pending_streak_before_break: u64,
        pending_broken_since_ms: u64,
    }

    struct DailyStreakFreezesPurchasedEvent has copy, drop {
        player: address,
        now_ms: u64,
        cycle_start_ms: u64,
        cycle_end_ms: u64,
        bought_freezes: u64,
        freezes_before: u64,
        freezes_after: u64,
        gap_anchor_cycle_end_ms: u64,
        gap_missed_cycles: u64,
        gap_freezes_used: u64,
        dollar_coin: 0x1::type_name::TypeName,
        dollar_coin_amount: u64,
        usd_cost: 0xbde37abf904292a57b279a9299ff508b7b55620db1f193771498c6c3d0ea2a6::float::Float,
        usd_price: 0xbde37abf904292a57b279a9299ff508b7b55620db1f193771498c6c3d0ea2a6::float::Float,
        current_streak: u64,
        last_time_new_streak_timestamp_ms: u64,
        last_streak_repair_timestamp_ms: u64,
    }

    struct DailyStreakRepairedEvent has copy, drop {
        player: address,
        now_ms: u64,
        cycle_start_ms: u64,
        cycle_end_ms: u64,
        had_pending_broken: bool,
        streak_before_break: u64,
        broken_since_ms: u64,
        freezes_before: u64,
        freezes_after: u64,
        dollar_coin: 0x1::type_name::TypeName,
        dollar_coin_amount: u64,
        usd_cost: 0xbde37abf904292a57b279a9299ff508b7b55620db1f193771498c6c3d0ea2a6::float::Float,
        usd_price: 0xbde37abf904292a57b279a9299ff508b7b55620db1f193771498c6c3d0ea2a6::float::Float,
        current_streak: u64,
        last_time_new_streak_timestamp_ms: u64,
        last_streak_repair_timestamp_ms: u64,
    }

    public fun admin_add_version(arg0: &mut 0xbde37abf904292a57b279a9299ff508b7b55620db1f193771498c6c3d0ea2a6::sweethouse::SweetHouse, arg1: &0xbde37abf904292a57b279a9299ff508b7b55620db1f193771498c6c3d0ea2a6::core::AdminCap, arg2: u64) {
        let v0 = borrow_daily_streak_registry_mut_unchecked(arg0);
        if (!0x2::vec_set::contains<u64>(&v0.version_set, &arg2)) {
            0x2::vec_set::insert<u64>(&mut v0.version_set, arg2);
            let v1 = DailyStreakRegistryVersionChangedEvent{
                version_number : arg2,
                is_added       : true,
            };
            0x2::event::emit<DailyStreakRegistryVersionChangedEvent>(v1);
        };
    }

    public fun admin_create_daily_streak_registry(arg0: &mut 0xbde37abf904292a57b279a9299ff508b7b55620db1f193771498c6c3d0ea2a6::sweethouse::SweetHouse, arg1: &0xbde37abf904292a57b279a9299ff508b7b55620db1f193771498c6c3d0ea2a6::core::AdminCap, arg2: &mut 0x2::tx_context::TxContext) {
        create_daily_streak_registry_internal(arg0, arg2);
    }

    public fun admin_edit_daily_streak_registry(arg0: &mut 0xbde37abf904292a57b279a9299ff508b7b55620db1f193771498c6c3d0ea2a6::sweethouse::SweetHouse, arg1: &0xbde37abf904292a57b279a9299ff508b7b55620db1f193771498c6c3d0ea2a6::core::AdminCap, arg2: bool, arg3: 0xbde37abf904292a57b279a9299ff508b7b55620db1f193771498c6c3d0ea2a6::float::Float, arg4: 0xbde37abf904292a57b279a9299ff508b7b55620db1f193771498c6c3d0ea2a6::float::Float, arg5: u64, arg6: 0xbde37abf904292a57b279a9299ff508b7b55620db1f193771498c6c3d0ea2a6::float::Float, arg7: u64) {
        edit_daily_streak_registry_internal(arg0, arg2, arg3, arg4, arg5, arg6, arg7);
    }

    public fun admin_give_streak_freezes(arg0: &mut 0xbde37abf904292a57b279a9299ff508b7b55620db1f193771498c6c3d0ea2a6::sweethouse::SweetHouse, arg1: &0xbde37abf904292a57b279a9299ff508b7b55620db1f193771498c6c3d0ea2a6::core::AdminCap, arg2: address, arg3: u64, arg4: &0x2::clock::Clock, arg5: &mut 0x2::tx_context::TxContext) {
        let (_, v1, v2, v3, v4, v5, v6, v7, v8, v9, v10, v11) = buy_streak_freezes_internal(arg0, arg2, arg3, arg4, arg5);
        emit_streak_freezes_purchased_event_internal(arg2, v1, v2, v3, arg3, v4, v5, v6, v7, v8, 0xbde37abf904292a57b279a9299ff508b7b55620db1f193771498c6c3d0ea2a6::sweethouse::get_dollar_coin_type(arg0), 0, 0xbde37abf904292a57b279a9299ff508b7b55620db1f193771498c6c3d0ea2a6::float::zero(), 0xbde37abf904292a57b279a9299ff508b7b55620db1f193771498c6c3d0ea2a6::float::zero(), v9, v10, v11);
    }

    public fun admin_remove_version(arg0: &mut 0xbde37abf904292a57b279a9299ff508b7b55620db1f193771498c6c3d0ea2a6::sweethouse::SweetHouse, arg1: &0xbde37abf904292a57b279a9299ff508b7b55620db1f193771498c6c3d0ea2a6::core::AdminCap, arg2: u64) {
        let v0 = borrow_daily_streak_registry_mut_unchecked(arg0);
        remove_version_internal(v0, arg2);
    }

    public fun admin_repair_daily_streak_for_player(arg0: &mut 0xbde37abf904292a57b279a9299ff508b7b55620db1f193771498c6c3d0ea2a6::sweethouse::SweetHouse, arg1: &0xbde37abf904292a57b279a9299ff508b7b55620db1f193771498c6c3d0ea2a6::core::AdminCap, arg2: address, arg3: &0x2::clock::Clock, arg4: &mut 0x2::tx_context::TxContext) {
        let (_, v1, v2, v3, v4, v5, v6, v7, v8, v9, v10, v11) = repair_daily_streak_internal(arg0, arg2, arg3, arg4);
        emit_streak_repaired_event_internal(arg2, v1, v2, v3, v4, v5, v6, v7, v8, 0xbde37abf904292a57b279a9299ff508b7b55620db1f193771498c6c3d0ea2a6::sweethouse::get_dollar_coin_type(arg0), 0, 0xbde37abf904292a57b279a9299ff508b7b55620db1f193771498c6c3d0ea2a6::float::zero(), 0xbde37abf904292a57b279a9299ff508b7b55620db1f193771498c6c3d0ea2a6::float::zero(), v9, v10, v11);
    }

    fun anchor_cycle_end_ms_from_offset(arg0: &DailyStreakRegistry, arg1: u64) : u64 {
        let (_, v1) = current_cycle_window(arg0, arg1);
        v1
    }

    fun anchor_ms_from_timestamps(arg0: u64, arg1: u64) : u64 {
        0x1::u64::max(arg0, arg1)
    }

    fun assert_valid_version(arg0: &DailyStreakRegistry) {
        let v0 = package_version();
        assert!(0x2::vec_set::contains<u64>(&arg0.version_set, &v0), 13838718226413256727);
    }

    public fun borrow_daily_streak_registry(arg0: &0xbde37abf904292a57b279a9299ff508b7b55620db1f193771498c6c3d0ea2a6::sweethouse::SweetHouse) : &DailyStreakRegistry {
        let v0 = borrow_daily_streak_registry_unchecked(arg0);
        assert_valid_version(v0);
        v0
    }

    fun borrow_daily_streak_registry_mut(arg0: &mut 0xbde37abf904292a57b279a9299ff508b7b55620db1f193771498c6c3d0ea2a6::sweethouse::SweetHouse) : &mut DailyStreakRegistry {
        let v0 = borrow_daily_streak_registry_mut_unchecked(arg0);
        assert_valid_version(v0);
        v0
    }

    fun borrow_daily_streak_registry_mut_unchecked(arg0: &mut 0xbde37abf904292a57b279a9299ff508b7b55620db1f193771498c6c3d0ea2a6::sweethouse::SweetHouse) : &mut DailyStreakRegistry {
        let v0 = DailyStreak{dummy_field: false};
        let v1 = DailyStreakRegistryKey{dummy_field: false};
        0xbde37abf904292a57b279a9299ff508b7b55620db1f193771498c6c3d0ea2a6::sweethouse::operator_borrow_operator_dof_mut<DailyStreak, DailyStreakRegistryKey, DailyStreakRegistry>(arg0, v0, v1)
    }

    fun borrow_daily_streak_registry_unchecked(arg0: &0xbde37abf904292a57b279a9299ff508b7b55620db1f193771498c6c3d0ea2a6::sweethouse::SweetHouse) : &DailyStreakRegistry {
        let v0 = DailyStreakRegistryKey{dummy_field: false};
        0xbde37abf904292a57b279a9299ff508b7b55620db1f193771498c6c3d0ea2a6::sweethouse::borrow_operator_dof<DailyStreak, DailyStreakRegistryKey, DailyStreakRegistry>(arg0, v0)
    }

    public fun borrow_user_daily_streak_data(arg0: &DailyStreakRegistry, arg1: address) : &UserDailyStreakData {
        assert_valid_version(arg0);
        let v0 = UserDailyStreakKey{pos0: arg1};
        assert!(0x2::dynamic_object_field::exists_<UserDailyStreakKey>(&arg0.id, v0), 13837592463944843279);
        let v1 = UserDailyStreakKey{pos0: arg1};
        0x2::dynamic_object_field::borrow<UserDailyStreakKey, UserDailyStreakData>(&arg0.id, v1)
    }

    fun borrow_user_daily_streak_data_mut(arg0: &mut DailyStreakRegistry, arg1: address) : &mut UserDailyStreakData {
        let v0 = UserDailyStreakKey{pos0: arg1};
        assert!(0x2::dynamic_object_field::exists_<UserDailyStreakKey>(&arg0.id, v0), 13837592674398240783);
        let v1 = UserDailyStreakKey{pos0: arg1};
        0x2::dynamic_object_field::borrow_mut<UserDailyStreakKey, UserDailyStreakData>(&mut arg0.id, v1)
    }

    fun broken_since_ms_from_anchor(arg0: &DailyStreakRegistry, arg1: u64, arg2: u64) : u64 {
        let v0 = cycle_end_ms_from_start(anchor_cycle_end_ms_from_offset(arg0, arg1));
        while (arg2 > 0) {
            v0 = cycle_end_ms_from_start(v0);
            arg2 = arg2 - 1;
        };
        v0
    }

    public fun buy_streak_freezes<T0>(arg0: &mut 0xbde37abf904292a57b279a9299ff508b7b55620db1f193771498c6c3d0ea2a6::sweethouse::SweetHouse, arg1: &mut 0x2::coin::Coin<T0>, arg2: u64, arg3: &0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::price_info::PriceInfoObject, arg4: &0x2::clock::Clock, arg5: &mut 0x2::tx_context::TxContext) {
        let v0 = 0xbde37abf904292a57b279a9299ff508b7b55620db1f193771498c6c3d0ea2a6::sweethouse::get_coin_decimals<T0>(arg0);
        let v1 = 0x2::tx_context::sender(arg5);
        let v2 = 0x1::type_name::with_defining_ids<T0>();
        assert!(0xbde37abf904292a57b279a9299ff508b7b55620db1f193771498c6c3d0ea2a6::sweethouse::get_dollar_coin_type(arg0) == v2, 13837032258475261963);
        let (v3, v4, v5, v6, v7, v8, v9, v10, v11, v12, v13, v14) = buy_streak_freezes_internal(arg0, v1, arg2, arg4, arg5);
        let v15 = 0xbde37abf904292a57b279a9299ff508b7b55620db1f193771498c6c3d0ea2a6::float::mul(v3, 0xbde37abf904292a57b279a9299ff508b7b55620db1f193771498c6c3d0ea2a6::float::from_u64(arg2));
        let (v16, v17) = quote_dollar_coin_amount_for_usd_cost(arg0, v2, arg3, arg4, v15, v0);
        0xbde37abf904292a57b279a9299ff508b7b55620db1f193771498c6c3d0ea2a6::sweethouse::deposit_private_pool<T0>(arg0, 0x2::coin::split<T0>(arg1, v17, arg5));
        emit_streak_freezes_purchased_event_internal(v1, v4, v5, v6, arg2, v7, v8, v9, v10, v11, v2, v17, v15, v16, v12, v13, v14);
    }

    fun buy_streak_freezes_internal(arg0: &mut 0xbde37abf904292a57b279a9299ff508b7b55620db1f193771498c6c3d0ea2a6::sweethouse::SweetHouse, arg1: address, arg2: u64, arg3: &0x2::clock::Clock, arg4: &mut 0x2::tx_context::TxContext) : (0xbde37abf904292a57b279a9299ff508b7b55620db1f193771498c6c3d0ea2a6::float::Float, u64, u64, u64, u64, u64, u64, u64, u64, u64, u64, u64) {
        assert!(arg2 > 0, 13838157058871001107);
        let v0 = 0x2::clock::timestamp_ms(arg3);
        let v1 = borrow_daily_streak_registry_mut(arg0);
        if (!v1.is_enabled) {
            abort 13835342395002060801
        };
        create_empty_user_data_if_not_exists(v1, arg1, arg4);
        let v2 = v1.one_day_streak_freeze_usd_price;
        let v3 = v1.default_daily_usd_stake_threshhold;
        let (v4, v5) = current_cycle_window(v1, v0);
        let v6 = v1.max_delay_to_repair_streak_ms;
        let v7 = borrow_user_daily_streak_data_mut(v1, arg1);
        let v8 = v7.current_streak;
        let v9 = v7.number_of_freezes;
        let v10 = v7.pending_streak_before_break;
        let v11 = v7.pending_broken_since_ms;
        let v12 = if (v7.last_stake_timestamp_ms >= v4) {
            v7.total_stake_since_last_cycle_usd
        } else {
            0xbde37abf904292a57b279a9299ff508b7b55620db1f193771498c6c3d0ea2a6::float::zero()
        };
        if (v10 > 0) {
            assert!(v11 + v6 < v0, 13837875957556314129);
            let v13 = borrow_daily_streak_registry_mut(arg0);
            let v14 = borrow_user_daily_streak_data_mut(v13, arg1);
            reset_user_state_for_new_streak(v14);
            let v15 = DailyStreakSettledEvent{
                player                              : arg1,
                now_ms                              : v0,
                cycle_start_ms                      : v4,
                cycle_end_ms                        : v5,
                stake_threshold_usd                 : v3,
                stake_usd_added                     : 0xbde37abf904292a57b279a9299ff508b7b55620db1f193771498c6c3d0ea2a6::float::zero(),
                stake_usd_before                    : v12,
                stake_usd_after                     : 0xbde37abf904292a57b279a9299ff508b7b55620db1f193771498c6c3d0ea2a6::float::zero(),
                is_new_cycle                        : false,
                streak_before                       : v8,
                freezes_before                      : v9,
                anchor_cycle_end_ms                 : 0,
                missed_cycles                       : 0,
                freezes_used                        : 0,
                broke_previous_streak               : false,
                broken_since_ms                     : 0,
                completed_cycle                     : false,
                cleared_pending_streak_before_break : v10,
                cleared_pending_broken_since_ms     : v11,
                current_streak                      : v14.current_streak,
                number_of_freezes                   : v14.number_of_freezes,
                last_time_new_streak_timestamp_ms   : v14.last_time_new_streak_timestamp_ms,
                last_streak_repair_timestamp_ms     : v14.last_streak_repair_timestamp_ms,
                pending_streak_before_break         : v14.pending_streak_before_break,
                pending_broken_since_ms             : v14.pending_broken_since_ms,
            };
            0x2::event::emit<DailyStreakSettledEvent>(v15);
        } else if (v8 > 0) {
            let v16 = anchor_ms_from_timestamps(v7.last_time_new_streak_timestamp_ms, v7.last_streak_repair_timestamp_ms);
            let v17 = anchor_cycle_end_ms_from_offset(borrow_daily_streak_registry(arg0), v16);
            let v18 = missed_cycles_since_anchor(borrow_daily_streak_registry(arg0), v4, v16);
            if (v18 > v9) {
                let v19 = broken_since_ms_from_anchor(borrow_daily_streak_registry(arg0), v16, v9);
                assert!(v19 + v6 < v0, 13837876189484548113);
                let v20 = borrow_daily_streak_registry_mut(arg0);
                let v21 = borrow_user_daily_streak_data_mut(v20, arg1);
                reset_user_state_for_new_streak(v21);
                let v22 = DailyStreakSettledEvent{
                    player                              : arg1,
                    now_ms                              : v0,
                    cycle_start_ms                      : v4,
                    cycle_end_ms                        : v5,
                    stake_threshold_usd                 : v3,
                    stake_usd_added                     : 0xbde37abf904292a57b279a9299ff508b7b55620db1f193771498c6c3d0ea2a6::float::zero(),
                    stake_usd_before                    : v12,
                    stake_usd_after                     : 0xbde37abf904292a57b279a9299ff508b7b55620db1f193771498c6c3d0ea2a6::float::zero(),
                    is_new_cycle                        : false,
                    streak_before                       : v8,
                    freezes_before                      : v9,
                    anchor_cycle_end_ms                 : v17,
                    missed_cycles                       : v18,
                    freezes_used                        : v9,
                    broke_previous_streak               : true,
                    broken_since_ms                     : v19,
                    completed_cycle                     : false,
                    cleared_pending_streak_before_break : 0,
                    cleared_pending_broken_since_ms     : 0,
                    current_streak                      : v21.current_streak,
                    number_of_freezes                   : v21.number_of_freezes,
                    last_time_new_streak_timestamp_ms   : v21.last_time_new_streak_timestamp_ms,
                    last_streak_repair_timestamp_ms     : v21.last_streak_repair_timestamp_ms,
                    pending_streak_before_break         : v21.pending_streak_before_break,
                    pending_broken_since_ms             : v21.pending_broken_since_ms,
                };
                0x2::event::emit<DailyStreakSettledEvent>(v22);
            };
        };
        let v23 = borrow_daily_streak_registry_mut(arg0);
        let v24 = borrow_user_daily_streak_data(v23, arg1);
        let v25 = v24.current_streak;
        let v26 = v24.number_of_freezes;
        let v27 = v24.last_time_new_streak_timestamp_ms;
        let v28 = v24.last_streak_repair_timestamp_ms;
        let v29 = 0;
        let v30 = 0;
        let v31 = 0;
        if (v25 > 0) {
            let v32 = anchor_ms_from_timestamps(v27, v28);
            let v33 = missed_cycles_since_anchor(v23, v4, v32);
            v30 = v33;
            if (v33 > 0) {
                v31 = v33;
                v29 = anchor_cycle_end_ms_from_offset(v23, v32);
                if (v33 > v26) {
                    abort 13837876412822847505
                };
            };
        };
        let v34 = v26 - v31;
        let v35 = v34 + arg2;
        assert!(v35 <= v23.max_number_of_freezes_per_player, 13835906118049857541);
        let v36 = if (v31 > 0 && v4 > 0) {
            v4 - 1
        } else if (v31 > 0) {
            0
        } else {
            v28
        };
        let v37 = borrow_user_daily_streak_data_mut(v23, arg1);
        if (v31 > 0) {
            v37.last_streak_repair_timestamp_ms = v36;
        };
        v37.number_of_freezes = v35;
        (v2, v0, v4, v5, v34, v35, v29, v30, v31, v25, v27, v36)
    }

    fun create_daily_streak_registry_internal(arg0: &mut 0xbde37abf904292a57b279a9299ff508b7b55620db1f193771498c6c3d0ea2a6::sweethouse::SweetHouse, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = true;
        let v1 = 0xbde37abf904292a57b279a9299ff508b7b55620db1f193771498c6c3d0ea2a6::float::from_u64(50);
        let v2 = 0xbde37abf904292a57b279a9299ff508b7b55620db1f193771498c6c3d0ea2a6::float::div(0xbde37abf904292a57b279a9299ff508b7b55620db1f193771498c6c3d0ea2a6::float::from_u64(5), 0xbde37abf904292a57b279a9299ff508b7b55620db1f193771498c6c3d0ea2a6::float::from_u64(10));
        let v3 = 2;
        let v4 = 0xbde37abf904292a57b279a9299ff508b7b55620db1f193771498c6c3d0ea2a6::float::from_u64(5);
        let v5 = 2 * 86400000;
        let v6 = DailyStreakRegistry{
            id                                 : 0x2::object::new(arg1),
            version_set                        : 0x2::vec_set::singleton<u64>(0),
            is_enabled                         : v0,
            default_daily_usd_stake_threshhold : v1,
            one_day_streak_freeze_usd_price    : v2,
            max_number_of_freezes_per_player   : v3,
            streak_repair_usd_price            : v4,
            max_delay_to_repair_streak_ms      : v5,
        };
        let v7 = DailyStreak{dummy_field: false};
        let v8 = DailyStreakRegistryKey{dummy_field: false};
        0xbde37abf904292a57b279a9299ff508b7b55620db1f193771498c6c3d0ea2a6::sweethouse::operator_add_operator_dof<DailyStreak, DailyStreakRegistryKey, DailyStreakRegistry>(arg0, v7, v8, v6);
        let v9 = DailyStreakRegistryEditedEvent{
            is_enabled                         : v0,
            default_daily_usd_stake_threshhold : v1,
            one_day_streak_freeze_usd_price    : v2,
            max_number_of_freezes_per_player   : v3,
            streak_repair_usd_price            : v4,
            max_delay_to_repair_streak_ms      : v5,
        };
        0x2::event::emit<DailyStreakRegistryEditedEvent>(v9);
    }

    fun create_empty_user_data_if_not_exists(arg0: &mut DailyStreakRegistry, arg1: address, arg2: &mut 0x2::tx_context::TxContext) {
        let v0 = UserDailyStreakKey{pos0: arg1};
        if (!0x2::dynamic_object_field::exists_<UserDailyStreakKey>(&arg0.id, v0)) {
            let v1 = UserDailyStreakData{
                id                                : 0x2::object::new(arg2),
                current_streak                    : 0,
                number_of_freezes                 : 0,
                last_time_new_streak_timestamp_ms : 0,
                last_stake_timestamp_ms           : 0,
                total_stake_since_last_cycle_usd  : 0xbde37abf904292a57b279a9299ff508b7b55620db1f193771498c6c3d0ea2a6::float::zero(),
                last_streak_repair_timestamp_ms   : 0,
                pending_streak_before_break       : 0,
                pending_broken_since_ms           : 0,
            };
            let v2 = UserDailyStreakKey{pos0: arg1};
            0x2::dynamic_object_field::add<UserDailyStreakKey, UserDailyStreakData>(&mut arg0.id, v2, v1);
        };
    }

    fun current_cycle_window(arg0: &DailyStreakRegistry, arg1: u64) : (u64, u64) {
        let v0 = cycle_start_ms_from_offset(arg1, 0);
        (v0, cycle_end_ms_from_start(v0))
    }

    fun cycle_end_ms_from_start(arg0: u64) : u64 {
        arg0 + 86400000
    }

    fun cycle_start_ms_from_offset(arg0: u64, arg1: u64) : u64 {
        let v0 = arg0 / 86400000 * 86400000 + arg1;
        if (arg0 < v0) {
            v0 - 86400000
        } else {
            v0
        }
    }

    fun edit_daily_streak_registry_internal(arg0: &mut 0xbde37abf904292a57b279a9299ff508b7b55620db1f193771498c6c3d0ea2a6::sweethouse::SweetHouse, arg1: bool, arg2: 0xbde37abf904292a57b279a9299ff508b7b55620db1f193771498c6c3d0ea2a6::float::Float, arg3: 0xbde37abf904292a57b279a9299ff508b7b55620db1f193771498c6c3d0ea2a6::float::Float, arg4: u64, arg5: 0xbde37abf904292a57b279a9299ff508b7b55620db1f193771498c6c3d0ea2a6::float::Float, arg6: u64) {
        assert!(!0xbde37abf904292a57b279a9299ff508b7b55620db1f193771498c6c3d0ea2a6::float::is_negative(&arg2), 13838437958322225173);
        assert!(!0xbde37abf904292a57b279a9299ff508b7b55620db1f193771498c6c3d0ea2a6::float::is_negative(&arg3), 13838437962617192469);
        assert!(!0xbde37abf904292a57b279a9299ff508b7b55620db1f193771498c6c3d0ea2a6::float::is_negative(&arg5), 13838437966912159765);
        let v0 = borrow_daily_streak_registry_mut(arg0);
        v0.is_enabled = arg1;
        v0.default_daily_usd_stake_threshhold = arg2;
        v0.one_day_streak_freeze_usd_price = arg3;
        v0.max_number_of_freezes_per_player = arg4;
        v0.streak_repair_usd_price = arg5;
        v0.max_delay_to_repair_streak_ms = arg6;
        let v1 = DailyStreakRegistryEditedEvent{
            is_enabled                         : arg1,
            default_daily_usd_stake_threshhold : arg2,
            one_day_streak_freeze_usd_price    : arg3,
            max_number_of_freezes_per_player   : arg4,
            streak_repair_usd_price            : arg5,
            max_delay_to_repair_streak_ms      : arg6,
        };
        0x2::event::emit<DailyStreakRegistryEditedEvent>(v1);
    }

    fun emit_streak_freezes_purchased_event_internal(arg0: address, arg1: u64, arg2: u64, arg3: u64, arg4: u64, arg5: u64, arg6: u64, arg7: u64, arg8: u64, arg9: u64, arg10: 0x1::type_name::TypeName, arg11: u64, arg12: 0xbde37abf904292a57b279a9299ff508b7b55620db1f193771498c6c3d0ea2a6::float::Float, arg13: 0xbde37abf904292a57b279a9299ff508b7b55620db1f193771498c6c3d0ea2a6::float::Float, arg14: u64, arg15: u64, arg16: u64) {
        let v0 = DailyStreakFreezesPurchasedEvent{
            player                            : arg0,
            now_ms                            : arg1,
            cycle_start_ms                    : arg2,
            cycle_end_ms                      : arg3,
            bought_freezes                    : arg4,
            freezes_before                    : arg5,
            freezes_after                     : arg6,
            gap_anchor_cycle_end_ms           : arg7,
            gap_missed_cycles                 : arg8,
            gap_freezes_used                  : arg9,
            dollar_coin                       : arg10,
            dollar_coin_amount                : arg11,
            usd_cost                          : arg12,
            usd_price                         : arg13,
            current_streak                    : arg14,
            last_time_new_streak_timestamp_ms : arg15,
            last_streak_repair_timestamp_ms   : arg16,
        };
        0x2::event::emit<DailyStreakFreezesPurchasedEvent>(v0);
    }

    fun emit_streak_repaired_event_internal(arg0: address, arg1: u64, arg2: u64, arg3: u64, arg4: bool, arg5: u64, arg6: u64, arg7: u64, arg8: u64, arg9: 0x1::type_name::TypeName, arg10: u64, arg11: 0xbde37abf904292a57b279a9299ff508b7b55620db1f193771498c6c3d0ea2a6::float::Float, arg12: 0xbde37abf904292a57b279a9299ff508b7b55620db1f193771498c6c3d0ea2a6::float::Float, arg13: u64, arg14: u64, arg15: u64) {
        let v0 = DailyStreakRepairedEvent{
            player                            : arg0,
            now_ms                            : arg1,
            cycle_start_ms                    : arg2,
            cycle_end_ms                      : arg3,
            had_pending_broken                : arg4,
            streak_before_break               : arg5,
            broken_since_ms                   : arg6,
            freezes_before                    : arg7,
            freezes_after                     : arg8,
            dollar_coin                       : arg9,
            dollar_coin_amount                : arg10,
            usd_cost                          : arg11,
            usd_price                         : arg12,
            current_streak                    : arg13,
            last_time_new_streak_timestamp_ms : arg14,
            last_streak_repair_timestamp_ms   : arg15,
        };
        0x2::event::emit<DailyStreakRepairedEvent>(v0);
    }

    public fun manager_create_daily_streak_registry(arg0: &mut 0xbde37abf904292a57b279a9299ff508b7b55620db1f193771498c6c3d0ea2a6::sweethouse::SweetHouse, arg1: &0xbde37abf904292a57b279a9299ff508b7b55620db1f193771498c6c3d0ea2a6::core::ManagerRegistry, arg2: &mut 0x2::tx_context::TxContext) {
        0xbde37abf904292a57b279a9299ff508b7b55620db1f193771498c6c3d0ea2a6::core::assert_is_manager<DailyStreak>(arg1, 0x2::tx_context::sender(arg2));
        create_daily_streak_registry_internal(arg0, arg2);
    }

    public fun manager_edit_daily_streak_registry(arg0: &mut 0xbde37abf904292a57b279a9299ff508b7b55620db1f193771498c6c3d0ea2a6::sweethouse::SweetHouse, arg1: &0xbde37abf904292a57b279a9299ff508b7b55620db1f193771498c6c3d0ea2a6::core::ManagerRegistry, arg2: bool, arg3: 0xbde37abf904292a57b279a9299ff508b7b55620db1f193771498c6c3d0ea2a6::float::Float, arg4: 0xbde37abf904292a57b279a9299ff508b7b55620db1f193771498c6c3d0ea2a6::float::Float, arg5: u64, arg6: 0xbde37abf904292a57b279a9299ff508b7b55620db1f193771498c6c3d0ea2a6::float::Float, arg7: u64, arg8: &mut 0x2::tx_context::TxContext) {
        0xbde37abf904292a57b279a9299ff508b7b55620db1f193771498c6c3d0ea2a6::core::assert_is_manager<DailyStreak>(arg1, 0x2::tx_context::sender(arg8));
        edit_daily_streak_registry_internal(arg0, arg2, arg3, arg4, arg5, arg6, arg7);
    }

    public fun manager_give_streak_freezes(arg0: &mut 0xbde37abf904292a57b279a9299ff508b7b55620db1f193771498c6c3d0ea2a6::sweethouse::SweetHouse, arg1: &0xbde37abf904292a57b279a9299ff508b7b55620db1f193771498c6c3d0ea2a6::core::ManagerRegistry, arg2: address, arg3: u64, arg4: &0x2::clock::Clock, arg5: &mut 0x2::tx_context::TxContext) {
        0xbde37abf904292a57b279a9299ff508b7b55620db1f193771498c6c3d0ea2a6::core::assert_is_manager<DailyStreak>(arg1, 0x2::tx_context::sender(arg5));
        let (_, v1, v2, v3, v4, v5, v6, v7, v8, v9, v10, v11) = buy_streak_freezes_internal(arg0, arg2, arg3, arg4, arg5);
        emit_streak_freezes_purchased_event_internal(arg2, v1, v2, v3, arg3, v4, v5, v6, v7, v8, 0xbde37abf904292a57b279a9299ff508b7b55620db1f193771498c6c3d0ea2a6::sweethouse::get_dollar_coin_type(arg0), 0, 0xbde37abf904292a57b279a9299ff508b7b55620db1f193771498c6c3d0ea2a6::float::zero(), 0xbde37abf904292a57b279a9299ff508b7b55620db1f193771498c6c3d0ea2a6::float::zero(), v9, v10, v11);
    }

    public fun manager_remove_version(arg0: &mut 0xbde37abf904292a57b279a9299ff508b7b55620db1f193771498c6c3d0ea2a6::sweethouse::SweetHouse, arg1: &0xbde37abf904292a57b279a9299ff508b7b55620db1f193771498c6c3d0ea2a6::core::ManagerRegistry, arg2: u64, arg3: &mut 0x2::tx_context::TxContext) {
        0xbde37abf904292a57b279a9299ff508b7b55620db1f193771498c6c3d0ea2a6::core::assert_is_manager<DailyStreak>(arg1, 0x2::tx_context::sender(arg3));
        let v0 = borrow_daily_streak_registry_mut_unchecked(arg0);
        remove_version_internal(v0, arg2);
    }

    public fun manager_repair_daily_streak_for_player(arg0: &mut 0xbde37abf904292a57b279a9299ff508b7b55620db1f193771498c6c3d0ea2a6::sweethouse::SweetHouse, arg1: &0xbde37abf904292a57b279a9299ff508b7b55620db1f193771498c6c3d0ea2a6::core::ManagerRegistry, arg2: address, arg3: &0x2::clock::Clock, arg4: &mut 0x2::tx_context::TxContext) {
        0xbde37abf904292a57b279a9299ff508b7b55620db1f193771498c6c3d0ea2a6::core::assert_is_manager<DailyStreak>(arg1, 0x2::tx_context::sender(arg4));
        let (_, v1, v2, v3, v4, v5, v6, v7, v8, v9, v10, v11) = repair_daily_streak_internal(arg0, arg2, arg3, arg4);
        emit_streak_repaired_event_internal(arg2, v1, v2, v3, v4, v5, v6, v7, v8, 0xbde37abf904292a57b279a9299ff508b7b55620db1f193771498c6c3d0ea2a6::sweethouse::get_dollar_coin_type(arg0), 0, 0xbde37abf904292a57b279a9299ff508b7b55620db1f193771498c6c3d0ea2a6::float::zero(), 0xbde37abf904292a57b279a9299ff508b7b55620db1f193771498c6c3d0ea2a6::float::zero(), v9, v10, v11);
    }

    fun missed_cycles_since_anchor(arg0: &DailyStreakRegistry, arg1: u64, arg2: u64) : u64 {
        let v0 = anchor_cycle_end_ms_from_offset(arg0, arg2);
        if (arg1 <= v0) {
            0
        } else {
            let v2 = arg1 - v0;
            if (v2 % 86400000 == 0) {
                v2 / 86400000
            } else {
                v2 / 86400000 + 1
            }
        }
    }

    fun package_version() : u64 {
        0
    }

    fun quote_dollar_coin_amount_for_usd_cost(arg0: &0xbde37abf904292a57b279a9299ff508b7b55620db1f193771498c6c3d0ea2a6::sweethouse::SweetHouse, arg1: 0x1::type_name::TypeName, arg2: &0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::price_info::PriceInfoObject, arg3: &0x2::clock::Clock, arg4: 0xbde37abf904292a57b279a9299ff508b7b55620db1f193771498c6c3d0ea2a6::float::Float, arg5: u8) : (0xbde37abf904292a57b279a9299ff508b7b55620db1f193771498c6c3d0ea2a6::float::Float, u64) {
        let (v0, v1, _) = 0xbde37abf904292a57b279a9299ff508b7b55620db1f193771498c6c3d0ea2a6::oracle::get_checked_usd_price(arg0, arg1, arg2, arg3);
        let v3 = 0xbde37abf904292a57b279a9299ff508b7b55620db1f193771498c6c3d0ea2a6::float::div(arg4, 0xbde37abf904292a57b279a9299ff508b7b55620db1f193771498c6c3d0ea2a6::oracle::price_lower_bound(v0, v1));
        let v4 = 0xbde37abf904292a57b279a9299ff508b7b55620db1f193771498c6c3d0ea2a6::float::floor_to_u64(0xbde37abf904292a57b279a9299ff508b7b55620db1f193771498c6c3d0ea2a6::float::mul(v3, 0xbde37abf904292a57b279a9299ff508b7b55620db1f193771498c6c3d0ea2a6::float::from_u64(0xbde37abf904292a57b279a9299ff508b7b55620db1f193771498c6c3d0ea2a6::math::pow_u64(10, (arg5 as u64)))));
        if (0xbde37abf904292a57b279a9299ff508b7b55620db1f193771498c6c3d0ea2a6::float::is_positive(&v3) && v4 == 0) {
            abort 13835622912201195523
        };
        (v0, v4)
    }

    public fun read_and_sync_user_daily_streak_state(arg0: &mut 0xbde37abf904292a57b279a9299ff508b7b55620db1f193771498c6c3d0ea2a6::sweethouse::SweetHouse, arg1: address, arg2: &0x2::clock::Clock, arg3: &mut 0x2::tx_context::TxContext) : (u64, u64, bool, 0xbde37abf904292a57b279a9299ff508b7b55620db1f193771498c6c3d0ea2a6::float::Float, bool) {
        let v0 = 0x2::clock::timestamp_ms(arg2);
        let v1 = borrow_daily_streak_registry_mut(arg0);
        if (!v1.is_enabled) {
            abort 13835345435838906369
        };
        create_empty_user_data_if_not_exists(v1, arg1, arg3);
        let v2 = v1.max_delay_to_repair_streak_ms;
        let v3 = v1.default_daily_usd_stake_threshhold;
        let (v4, v5) = current_cycle_window(v1, v0);
        let v6 = borrow_user_daily_streak_data(v1, arg1);
        let v7 = v6.current_streak;
        let v8 = v6.number_of_freezes;
        let v9 = v6.last_time_new_streak_timestamp_ms;
        let v10 = v6.pending_streak_before_break;
        let v11 = v6.pending_broken_since_ms;
        let v12 = v9 > 0 && v9 >= v4;
        let v13 = if (v6.last_stake_timestamp_ms >= v4) {
            v6.total_stake_since_last_cycle_usd
        } else {
            0xbde37abf904292a57b279a9299ff508b7b55620db1f193771498c6c3d0ea2a6::float::zero()
        };
        if (v10 > 0) {
            if (v11 + v2 < v0) {
                let v14 = borrow_user_daily_streak_data_mut(v1, arg1);
                v14.pending_streak_before_break = 0;
                v14.pending_broken_since_ms = 0;
                let v15 = DailyStreakSettledEvent{
                    player                              : arg1,
                    now_ms                              : v0,
                    cycle_start_ms                      : v4,
                    cycle_end_ms                        : v5,
                    stake_threshold_usd                 : v3,
                    stake_usd_added                     : 0xbde37abf904292a57b279a9299ff508b7b55620db1f193771498c6c3d0ea2a6::float::zero(),
                    stake_usd_before                    : v13,
                    stake_usd_after                     : v13,
                    is_new_cycle                        : false,
                    streak_before                       : v7,
                    freezes_before                      : v8,
                    anchor_cycle_end_ms                 : 0,
                    missed_cycles                       : 0,
                    freezes_used                        : 0,
                    broke_previous_streak               : false,
                    broken_since_ms                     : 0,
                    completed_cycle                     : false,
                    cleared_pending_streak_before_break : v10,
                    cleared_pending_broken_since_ms     : v11,
                    current_streak                      : v14.current_streak,
                    number_of_freezes                   : v14.number_of_freezes,
                    last_time_new_streak_timestamp_ms   : v14.last_time_new_streak_timestamp_ms,
                    last_streak_repair_timestamp_ms     : v14.last_streak_repair_timestamp_ms,
                    pending_streak_before_break         : 0,
                    pending_broken_since_ms             : 0,
                };
                0x2::event::emit<DailyStreakSettledEvent>(v15);
                return (0, v8, v12, v13, false)
            };
            return (v10, 0, v12, v13, true)
        };
        if (v7 == 0 && v9 == 0) {
            return (0, v8, v12, v13, false)
        };
        let v16 = anchor_ms_from_timestamps(v9, v6.last_streak_repair_timestamp_ms);
        let v17 = missed_cycles_since_anchor(v1, v4, v16);
        if (v7 > 0 && v17 <= v8) {
            return (v7, v8 - v17, v12, v13, false)
        };
        let v18 = broken_since_ms_from_anchor(v1, v16, v8);
        if (v18 + v2 < v0) {
            return (0, 0, v12, v13, false)
        };
        if (v18 > v0) {
            return (v7, v8, v12, v13, false)
        };
        (v7, 0, v12, v13, v7 > 0)
    }

    fun remove_version_internal(arg0: &mut DailyStreakRegistry, arg1: u64) {
        assert!(0x2::vec_set::contains<u64>(&arg0.version_set, &arg1), 13838999950498201625);
        0x2::vec_set::remove<u64>(&mut arg0.version_set, &arg1);
        let v0 = DailyStreakRegistryVersionChangedEvent{
            version_number : arg1,
            is_added       : false,
        };
        0x2::event::emit<DailyStreakRegistryVersionChangedEvent>(v0);
    }

    public fun repair_daily_streak<T0>(arg0: &mut 0xbde37abf904292a57b279a9299ff508b7b55620db1f193771498c6c3d0ea2a6::sweethouse::SweetHouse, arg1: &mut 0x2::coin::Coin<T0>, arg2: &0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::price_info::PriceInfoObject, arg3: &0x2::clock::Clock, arg4: &mut 0x2::tx_context::TxContext) {
        let v0 = 0xbde37abf904292a57b279a9299ff508b7b55620db1f193771498c6c3d0ea2a6::sweethouse::get_coin_decimals<T0>(arg0);
        let v1 = 0x2::tx_context::sender(arg4);
        let v2 = 0x1::type_name::with_defining_ids<T0>();
        assert!(0xbde37abf904292a57b279a9299ff508b7b55620db1f193771498c6c3d0ea2a6::sweethouse::get_dollar_coin_type(arg0) == v2, 13837033615684927499);
        let (v3, v4, v5, v6, v7, v8, v9, v10, v11, v12, v13, v14) = repair_daily_streak_internal(arg0, v1, arg3, arg4);
        let (v15, v16) = quote_dollar_coin_amount_for_usd_cost(arg0, v2, arg2, arg3, v3, v0);
        0xbde37abf904292a57b279a9299ff508b7b55620db1f193771498c6c3d0ea2a6::sweethouse::deposit_private_pool<T0>(arg0, 0x2::coin::split<T0>(arg1, v16, arg4));
        emit_streak_repaired_event_internal(v1, v4, v5, v6, v7, v8, v9, v10, v11, v2, v16, v3, v15, v12, v13, v14);
    }

    fun repair_daily_streak_internal(arg0: &mut 0xbde37abf904292a57b279a9299ff508b7b55620db1f193771498c6c3d0ea2a6::sweethouse::SweetHouse, arg1: address, arg2: &0x2::clock::Clock, arg3: &mut 0x2::tx_context::TxContext) : (0xbde37abf904292a57b279a9299ff508b7b55620db1f193771498c6c3d0ea2a6::float::Float, u64, u64, u64, bool, u64, u64, u64, u64, u64, u64, u64) {
        let v0 = 0x2::clock::timestamp_ms(arg2);
        let v1 = borrow_daily_streak_registry_mut(arg0);
        if (!v1.is_enabled) {
            abort 13835344332032311297
        };
        create_empty_user_data_if_not_exists(v1, arg1, arg3);
        let v2 = v1.streak_repair_usd_price;
        let (v3, v4) = current_cycle_window(v1, v0);
        let v5 = borrow_user_daily_streak_data(v1, arg1);
        let v6 = v5.pending_streak_before_break > 0;
        let (v7, v8) = if (v6) {
            (v5.pending_broken_since_ms, v5.pending_streak_before_break)
        } else {
            (broken_since_ms_from_anchor(v1, anchor_ms_from_timestamps(v5.last_time_new_streak_timestamp_ms, v5.last_streak_repair_timestamp_ms), v5.number_of_freezes), v5.current_streak)
        };
        if (v8 == 0) {
            abort 13836188868631986183
        };
        if (v7 + v1.max_delay_to_repair_streak_ms < v0) {
            abort 13836470347903795209
        };
        if (v7 > v0) {
            abort 13837314777129156621
        };
        let v9 = borrow_daily_streak_registry_mut(arg0);
        let v10 = borrow_user_daily_streak_data_mut(v9, arg1);
        if (v6) {
            v10.current_streak = v10.pending_streak_before_break;
            v10.pending_streak_before_break = 0;
            v10.pending_broken_since_ms = 0;
        };
        v10.number_of_freezes = 0;
        v10.last_streak_repair_timestamp_ms = v0;
        if (v10.last_time_new_streak_timestamp_ms < v3) {
            v10.current_streak = v10.current_streak + 1;
            v10.last_time_new_streak_timestamp_ms = v0;
        };
        (v2, v0, v3, v4, v6, v8, v7, v10.number_of_freezes, v10.number_of_freezes, v10.current_streak, v10.last_time_new_streak_timestamp_ms, v10.last_streak_repair_timestamp_ms)
    }

    fun reset_user_state_for_new_streak(arg0: &mut UserDailyStreakData) {
        arg0.current_streak = 0;
        arg0.number_of_freezes = 0;
        arg0.last_time_new_streak_timestamp_ms = 0;
        arg0.last_stake_timestamp_ms = 0;
        arg0.total_stake_since_last_cycle_usd = 0xbde37abf904292a57b279a9299ff508b7b55620db1f193771498c6c3d0ea2a6::float::zero();
        arg0.last_streak_repair_timestamp_ms = 0;
        arg0.pending_streak_before_break = 0;
        arg0.pending_broken_since_ms = 0;
    }

    public fun settle_daily_streak<T0, T1: drop>(arg0: &mut 0xbde37abf904292a57b279a9299ff508b7b55620db1f193771498c6c3d0ea2a6::sweethouse::SweetHouse, arg1: &0xbde37abf904292a57b279a9299ff508b7b55620db1f193771498c6c3d0ea2a6::core::StakeTicket<T0, T1>, arg2: &0x2::clock::Clock, arg3: &mut 0x2::tx_context::TxContext) {
        let v0 = borrow_daily_streak_registry_mut(arg0);
        let v1 = 0x2::clock::timestamp_ms(arg2);
        if (!v0.is_enabled) {
            return
        };
        let v2 = 0xbde37abf904292a57b279a9299ff508b7b55620db1f193771498c6c3d0ea2a6::core::get_total_stake_usd_value_if_exists<T0, T1>(arg1);
        let v3 = 0xbde37abf904292a57b279a9299ff508b7b55620db1f193771498c6c3d0ea2a6::core::get_player<T0, T1>(arg1);
        create_empty_user_data_if_not_exists(v0, v3, arg3);
        let (v4, v5) = current_cycle_window(v0, v1);
        let v6 = v0.default_daily_usd_stake_threshhold;
        let v7 = borrow_user_daily_streak_data(v0, v3);
        let v8 = v7.current_streak;
        let v9 = v7.number_of_freezes;
        let v10 = v7.last_time_new_streak_timestamp_ms;
        let v11 = v7.total_stake_since_last_cycle_usd;
        let v12 = v7.last_streak_repair_timestamp_ms;
        let v13 = 0;
        let v14 = 0;
        let v15 = 0;
        let v16 = false;
        let v17 = 0;
        let v18 = false;
        let v19 = v7.last_stake_timestamp_ms < v4;
        let v20 = if (v19) {
            0xbde37abf904292a57b279a9299ff508b7b55620db1f193771498c6c3d0ea2a6::float::zero()
        } else {
            v11
        };
        let v21 = if (v19) {
            v2
        } else {
            0xbde37abf904292a57b279a9299ff508b7b55620db1f193771498c6c3d0ea2a6::float::add(v11, v2)
        };
        let v22 = v21;
        let v23 = v8;
        let v24 = v9;
        let v25 = v10;
        let v26 = v12;
        let v27 = v7.pending_streak_before_break;
        let v28 = v7.pending_broken_since_ms;
        if (v19 && v8 > 0) {
            let v29 = anchor_ms_from_timestamps(v10, v12);
            let v30 = missed_cycles_since_anchor(v0, v4, v29);
            v14 = v30;
            v13 = anchor_cycle_end_ms_from_offset(v0, v29);
            if (v30 <= v9) {
                v15 = v30;
                v24 = v9 - v30;
                if (v30 > 0) {
                    let v31 = if (v4 > 0) {
                        v4 - 1
                    } else {
                        0
                    };
                    v26 = v31;
                };
            } else {
                v16 = true;
                v15 = v9;
                let v32 = broken_since_ms_from_anchor(v0, v29, v9);
                v17 = v32;
                v27 = v8;
                v28 = v32;
                v23 = 0;
                v24 = 0;
            };
        };
        if (v10 < v4) {
            if (0xbde37abf904292a57b279a9299ff508b7b55620db1f193771498c6c3d0ea2a6::float::gte(&v22, &v6)) {
                v23 = v23 + 1;
                v25 = v1;
                if (v27 > 0) {
                    v27 = 0;
                    v28 = 0;
                };
                v18 = true;
            };
        };
        let v33 = borrow_user_daily_streak_data_mut(v0, v3);
        v33.total_stake_since_last_cycle_usd = v22;
        v33.current_streak = v23;
        v33.number_of_freezes = v24;
        v33.last_time_new_streak_timestamp_ms = v25;
        v33.last_streak_repair_timestamp_ms = v26;
        v33.pending_streak_before_break = v27;
        v33.pending_broken_since_ms = v28;
        v33.last_stake_timestamp_ms = v1;
        let v34 = DailyStreakSettledEvent{
            player                              : v3,
            now_ms                              : v1,
            cycle_start_ms                      : v4,
            cycle_end_ms                        : v5,
            stake_threshold_usd                 : v6,
            stake_usd_added                     : v2,
            stake_usd_before                    : v20,
            stake_usd_after                     : v33.total_stake_since_last_cycle_usd,
            is_new_cycle                        : v19,
            streak_before                       : v8,
            freezes_before                      : v9,
            anchor_cycle_end_ms                 : v13,
            missed_cycles                       : v14,
            freezes_used                        : v15,
            broke_previous_streak               : v16,
            broken_since_ms                     : v17,
            completed_cycle                     : v18,
            cleared_pending_streak_before_break : 0,
            cleared_pending_broken_since_ms     : 0,
            current_streak                      : v33.current_streak,
            number_of_freezes                   : v33.number_of_freezes,
            last_time_new_streak_timestamp_ms   : v33.last_time_new_streak_timestamp_ms,
            last_streak_repair_timestamp_ms     : v33.last_streak_repair_timestamp_ms,
            pending_streak_before_break         : v33.pending_streak_before_break,
            pending_broken_since_ms             : v33.pending_broken_since_ms,
        };
        0x2::event::emit<DailyStreakSettledEvent>(v34);
    }

    // decompiled from Move bytecode v6
}

