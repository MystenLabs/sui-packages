module 0x8693449d700bd745fbf712cf39769f1fde4d70fac6d42373160c1da0762d5f37::resolver {
    struct Observer has drop, store {
        account: address,
        trust_weight_ppm: u64,
        last_sequence: u64,
        observed_at_ms: u64,
        fair_price_e9: u64,
        markup_1s_direction: u8,
        markup_1s_bps_e9: u64,
        markup_3s_direction: u8,
        markup_3s_bps_e9: u64,
        impact_ppm: u64,
    }

    struct Aggregate has copy, drop, store {
        updated_at_ms: u64,
        fair_price_e9: u64,
        markup_1s_direction: u8,
        markup_1s_bps_e9: u64,
        markup_3s_direction: u8,
        markup_3s_bps_e9: u64,
        objective_direction: u8,
        objective_bps_e9: u64,
        total_weight_ppm: u64,
        active_observers: u64,
    }

    struct Reducer has key {
        id: 0x2::object::UID,
        admin: address,
        decay_grace_ms: u64,
        decay_window_ms: u64,
        objective_1s_weight_ppm: u64,
        observers: vector<Observer>,
        aggregate: Aggregate,
        update_count: u64,
    }

    struct ReducerCreated has copy, drop {
        reducer_id: 0x2::object::ID,
        admin: address,
        decay_grace_ms: u64,
        decay_window_ms: u64,
        objective_1s_weight_ppm: u64,
    }

    struct ObserverRegistered has copy, drop {
        reducer_id: 0x2::object::ID,
        account: address,
        trust_weight_ppm: u64,
    }

    struct AggregateUpdated has copy, drop {
        reducer_id: 0x2::object::ID,
        update_count: u64,
        updated_at_ms: u64,
        fair_price_e9: u64,
        markup_1s_direction: u8,
        markup_1s_bps_e9: u64,
        markup_3s_direction: u8,
        markup_3s_bps_e9: u64,
        objective_direction: u8,
        objective_bps_e9: u64,
        total_weight_ppm: u64,
        active_observers: u64,
    }

    public fun id(arg0: &Reducer) : 0x2::object::ID {
        0x2::object::id<Reducer>(arg0)
    }

    fun new(arg0: address, arg1: u64, arg2: u64, arg3: u64, arg4: &mut 0x2::tx_context::TxContext) : Reducer {
        let v0 = if (arg2 > 0) {
            if (arg2 <= 60000) {
                if (arg1 < arg2) {
                    arg3 <= 1000000
                } else {
                    false
                }
            } else {
                false
            }
        } else {
            false
        };
        assert!(v0, 1);
        Reducer{
            id                      : 0x2::object::new(arg4),
            admin                   : arg0,
            decay_grace_ms          : arg1,
            decay_window_ms         : arg2,
            objective_1s_weight_ppm : arg3,
            observers               : 0x1::vector::empty<Observer>(),
            aggregate               : empty_aggregate(),
            update_count            : 0,
        }
    }

    fun add_directed(arg0: u8, arg1: u64, arg2: u128, arg3: &mut u128, arg4: &mut u128) {
        if (arg0 == 1) {
            *arg3 = *arg3 + (arg1 as u128) * arg2;
        } else if (arg0 == 2) {
            *arg4 = *arg4 + (arg1 as u128) * arg2;
        };
    }

    public fun aggregate_fair(arg0: &Reducer) : u64 {
        arg0.aggregate.fair_price_e9
    }

    public fun aggregate_markups(arg0: &Reducer) : (u8, u64, u8, u64) {
        (arg0.aggregate.markup_1s_direction, arg0.aggregate.markup_1s_bps_e9, arg0.aggregate.markup_3s_direction, arg0.aggregate.markup_3s_bps_e9)
    }

    public fun aggregate_objective(arg0: &Reducer) : (u8, u64) {
        (arg0.aggregate.objective_direction, arg0.aggregate.objective_bps_e9)
    }

    public fun aggregate_target_prices(arg0: &Reducer) : (u64, u64, u64) {
        let v0 = &arg0.aggregate;
        (target_price(v0.fair_price_e9, v0.markup_1s_direction, v0.markup_1s_bps_e9), target_price(v0.fair_price_e9, v0.markup_3s_direction, v0.markup_3s_bps_e9), target_price(v0.fair_price_e9, v0.objective_direction, v0.objective_bps_e9))
    }

    public fun aggregate_weight(arg0: &Reducer) : (u64, u64) {
        (arg0.aggregate.total_weight_ppm, arg0.aggregate.active_observers)
    }

    public fun create(arg0: u64, arg1: u64, arg2: u64, arg3: address, arg4: u64, arg5: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg5);
        let v1 = new(v0, arg0, arg1, arg2, arg5);
        let v2 = &mut v1;
        register_observer_internal(v2, arg3, arg4);
        let v3 = ReducerCreated{
            reducer_id              : 0x2::object::id<Reducer>(&v1),
            admin                   : v1.admin,
            decay_grace_ms          : arg0,
            decay_window_ms         : arg1,
            objective_1s_weight_ppm : arg2,
        };
        0x2::event::emit<ReducerCreated>(v3);
        0x2::transfer::share_object<Reducer>(v1);
    }

    fun decay_factor_ppm(arg0: u64, arg1: u64, arg2: u64) : u64 {
        if (arg0 <= arg1) {
            1000000
        } else if (arg0 >= arg2) {
            0
        } else {
            (arg2 - arg0) * 1000000 / (arg2 - arg1)
        }
    }

    fun directed_average(arg0: u128, arg1: u128, arg2: u128) : (u8, u64) {
        if (arg0 > arg1) {
            (1, (((arg0 - arg1) / arg2) as u64))
        } else if (arg1 > arg0) {
            (2, (((arg1 - arg0) / arg2) as u64))
        } else {
            (0, 0)
        }
    }

    public fun direction_down() : u8 {
        2
    }

    public fun direction_flat() : u8 {
        0
    }

    public fun direction_up() : u8 {
        1
    }

    fun effective_weight(arg0: u64, arg1: u64, arg2: u64) : u64 {
        (((arg0 as u128) * (arg1 as u128) / (1000000 as u128) * (arg2 as u128) / (1000000 as u128)) as u64)
    }

    fun emit_aggregate(arg0: &Reducer) {
        let v0 = &arg0.aggregate;
        let v1 = AggregateUpdated{
            reducer_id          : 0x2::object::id<Reducer>(arg0),
            update_count        : arg0.update_count,
            updated_at_ms       : v0.updated_at_ms,
            fair_price_e9       : v0.fair_price_e9,
            markup_1s_direction : v0.markup_1s_direction,
            markup_1s_bps_e9    : v0.markup_1s_bps_e9,
            markup_3s_direction : v0.markup_3s_direction,
            markup_3s_bps_e9    : v0.markup_3s_bps_e9,
            objective_direction : v0.objective_direction,
            objective_bps_e9    : v0.objective_bps_e9,
            total_weight_ppm    : v0.total_weight_ppm,
            active_observers    : v0.active_observers,
        };
        0x2::event::emit<AggregateUpdated>(v1);
    }

    fun empty_aggregate() : Aggregate {
        Aggregate{
            updated_at_ms       : 0,
            fair_price_e9       : 0,
            markup_1s_direction : 0,
            markup_1s_bps_e9    : 0,
            markup_3s_direction : 0,
            markup_3s_bps_e9    : 0,
            objective_direction : 0,
            objective_bps_e9    : 0,
            total_weight_ppm    : 0,
            active_observers    : 0,
        }
    }

    fun min_u128_to_u64(arg0: u128) : u64 {
        if (arg0 > 18446744073709551615) {
            18446744073709551615
        } else {
            (arg0 as u64)
        }
    }

    fun objective(arg0: u8, arg1: u64, arg2: u8, arg3: u64, arg4: u64) : (u8, u64) {
        let v0 = 0;
        let v1 = 0;
        let v2 = &mut v0;
        let v3 = &mut v1;
        add_directed(arg0, arg1, (arg4 as u128), v2, v3);
        let v4 = &mut v0;
        let v5 = &mut v1;
        add_directed(arg2, arg3, ((1000000 - arg4) as u128), v4, v5);
        if (v0 > v1) {
            (1, (((v0 - v1) / (1000000 as u128)) as u64))
        } else if (v1 > v0) {
            (2, (((v1 - v0) / (1000000 as u128)) as u64))
        } else {
            (0, 0)
        }
    }

    public fun observer_count(arg0: &Reducer) : u64 {
        0x1::vector::length<Observer>(&arg0.observers)
    }

    fun observer_index(arg0: &vector<Observer>, arg1: address) : (bool, u64) {
        let v0 = 0;
        while (v0 < 0x1::vector::length<Observer>(arg0)) {
            if (0x1::vector::borrow<Observer>(arg0, v0).account == arg1) {
                return (true, v0)
            };
            v0 = v0 + 1;
        };
        (false, 0)
    }

    public fun ppm() : u64 {
        1000000
    }

    fun reduce(arg0: &Reducer, arg1: u64) : Aggregate {
        let v0 = 0;
        let v1 = 0;
        let v2 = 0;
        let v3 = 0;
        let v4 = 0;
        let v5 = 0;
        let v6 = 0;
        let v7 = 0;
        while (v7 < 0x1::vector::length<Observer>(&arg0.observers)) {
            let v8 = 0x1::vector::borrow<Observer>(&arg0.observers, v7);
            if (v8.last_sequence > 0 && v8.observed_at_ms <= arg1) {
                let v9 = effective_weight(v8.trust_weight_ppm, v8.impact_ppm, decay_factor_ppm(arg1 - v8.observed_at_ms, arg0.decay_grace_ms, arg0.decay_window_ms));
                if (v9 > 0) {
                    let v10 = (v9 as u128);
                    v0 = v0 + v10;
                    v1 = v1 + (v8.fair_price_e9 as u128) * v10;
                    let v11 = &mut v2;
                    let v12 = &mut v3;
                    add_directed(v8.markup_1s_direction, v8.markup_1s_bps_e9, v10, v11, v12);
                    let v13 = &mut v4;
                    let v14 = &mut v5;
                    add_directed(v8.markup_3s_direction, v8.markup_3s_bps_e9, v10, v13, v14);
                    v6 = v6 + 1;
                };
            };
            v7 = v7 + 1;
        };
        if (v0 == 0) {
            let v15 = empty_aggregate();
            v15.updated_at_ms = arg1;
            return v15
        };
        let (v16, v17) = directed_average(v2, v3, v0);
        let (v18, v19) = directed_average(v4, v5, v0);
        let (v20, v21) = objective(v16, v17, v18, v19, arg0.objective_1s_weight_ppm);
        Aggregate{
            updated_at_ms       : arg1,
            fair_price_e9       : ((v1 / v0) as u64),
            markup_1s_direction : v16,
            markup_1s_bps_e9    : v17,
            markup_3s_direction : v18,
            markup_3s_bps_e9    : v19,
            objective_direction : v20,
            objective_bps_e9    : v21,
            total_weight_ppm    : min_u128_to_u64(v0),
            active_observers    : v6,
        }
    }

    public fun register_observer(arg0: &mut Reducer, arg1: address, arg2: u64, arg3: &0x2::tx_context::TxContext) {
        assert!(0x2::tx_context::sender(arg3) == arg0.admin, 0);
        register_observer_internal(arg0, arg1, arg2);
    }

    fun register_observer_internal(arg0: &mut Reducer, arg1: address, arg2: u64) {
        let v0 = if (arg1 != @0x0) {
            if (arg2 > 0) {
                if (arg2 <= 1000000) {
                    0x1::vector::length<Observer>(&arg0.observers) < 32
                } else {
                    false
                }
            } else {
                false
            }
        } else {
            false
        };
        assert!(v0, 1);
        let (v1, _) = observer_index(&arg0.observers, arg1);
        assert!(!v1, 2);
        let v3 = Observer{
            account             : arg1,
            trust_weight_ppm    : arg2,
            last_sequence       : 0,
            observed_at_ms      : 0,
            fair_price_e9       : 0,
            markup_1s_direction : 0,
            markup_1s_bps_e9    : 0,
            markup_3s_direction : 0,
            markup_3s_bps_e9    : 0,
            impact_ppm          : 0,
        };
        0x1::vector::push_back<Observer>(&mut arg0.observers, v3);
        let v4 = ObserverRegistered{
            reducer_id       : 0x2::object::id<Reducer>(arg0),
            account          : arg1,
            trust_weight_ppm : arg2,
        };
        0x2::event::emit<ObserverRegistered>(v4);
    }

    public fun submit_observation(arg0: &mut Reducer, arg1: u64, arg2: u64, arg3: u64, arg4: u8, arg5: u64, arg6: u8, arg7: u64, arg8: u64, arg9: &0x2::clock::Clock, arg10: &0x2::tx_context::TxContext) {
        submit_observation_at(arg0, 0x2::tx_context::sender(arg10), arg1, arg2, arg3, arg4, arg5, arg6, arg7, arg8, 0x2::clock::timestamp_ms(arg9));
    }

    fun submit_observation_at(arg0: &mut Reducer, arg1: address, arg2: u64, arg3: u64, arg4: u64, arg5: u8, arg6: u64, arg7: u8, arg8: u64, arg9: u64, arg10: u64) {
        validate_observation(arg2, arg3, arg4, arg5, arg6, arg7, arg8, arg9);
        assert!(arg3 <= arg10, 7);
        assert!(arg10 - arg3 <= arg0.decay_window_ms, 8);
        let (v0, v1) = observer_index(&arg0.observers, arg1);
        assert!(v0, 3);
        let v2 = 0x1::vector::borrow_mut<Observer>(&mut arg0.observers, v1);
        assert!(v2.last_sequence == 0 || arg2 > v2.last_sequence && arg3 > v2.observed_at_ms, 5);
        v2.last_sequence = arg2;
        v2.observed_at_ms = arg3;
        v2.fair_price_e9 = arg4;
        v2.markup_1s_direction = arg5;
        v2.markup_1s_bps_e9 = arg6;
        v2.markup_3s_direction = arg7;
        v2.markup_3s_bps_e9 = arg8;
        v2.impact_ppm = arg9;
        arg0.aggregate = reduce(arg0, arg10);
        arg0.update_count = arg0.update_count + 1;
        emit_aggregate(arg0);
    }

    fun target_price(arg0: u64, arg1: u8, arg2: u64) : u64 {
        let v0 = (arg0 as u128) * (arg2 as u128) / 10000000000000;
        if (arg1 == 1) {
            (((arg0 as u128) + v0) as u64)
        } else if (arg1 == 2) {
            if (v0 >= (arg0 as u128)) {
                0
            } else {
                (((arg0 as u128) - v0) as u64)
            }
        } else {
            arg0
        }
    }

    public fun update_count(arg0: &Reducer) : u64 {
        arg0.update_count
    }

    fun valid_directed_value(arg0: u8, arg1: u64) : bool {
        arg0 == 0 && arg1 == 0 || arg0 != 0 && arg1 > 0
    }

    fun valid_direction(arg0: u8) : bool {
        arg0 <= 2
    }

    fun validate_observation(arg0: u64, arg1: u64, arg2: u64, arg3: u8, arg4: u64, arg5: u8, arg6: u64, arg7: u64) {
        let v0 = if (arg0 > 0) {
            if (arg1 > 0) {
                if (arg2 > 0) {
                    if (valid_direction(arg3)) {
                        if (valid_direction(arg5)) {
                            if (valid_directed_value(arg3, arg4)) {
                                if (valid_directed_value(arg5, arg6)) {
                                    if (arg4 <= 100000000000) {
                                        if (arg6 <= 100000000000) {
                                            if (arg7 > 0) {
                                                arg7 <= 1000000
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
            }
        } else {
            false
        };
        assert!(v0, 6);
    }

    // decompiled from Move bytecode v6
}

