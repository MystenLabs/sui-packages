module 0x10e6186356a5588e8a06e368809b0d08bfeaa4d067c252082c9d7785c911295d::funding_reserve {
    struct Key has copy, drop, store {
        dummy_field: bool,
    }

    struct Sample has copy, drop, store {
        at: u64,
        rate: u256,
    }

    struct State has drop, store {
        samples: vector<Sample>,
        frequency_ms: u64,
        manual_floor: u64,
        ready: bool,
        target: u64,
        alarm: u64,
        updated_ms: u64,
    }

    struct Status has copy, drop {
        pool: 0x2::object::ID,
        ready: bool,
        target: u64,
        manual_floor: u64,
        protected: u64,
        alarm_target: u64,
        below_alarm: bool,
        updated_ms: u64,
        funding_updated_ms: u64,
        sample_count: u64,
    }

    public fun buffer(arg0: &Status) : u64 {
        arg0.protected
    }

    public(friend) fun emit_status(arg0: Status) {
        0x2::event::emit<Status>(arg0);
    }

    fun in_band(arg0: u64, arg1: u64, arg2: u64) : bool {
        (arg0 as u128) * 10000 >= (arg1 as u128) * ((10000 - arg2) as u128) && (arg0 as u128) * 10000 <= (arg1 as u128) * ((10000 + arg2) as u128)
    }

    fun multiply_up(arg0: u256, arg1: u256, arg2: u256) : (bool, u256) {
        if (arg2 == 0 || arg1 > 0 && arg0 > 115792089237316195423570985008687907853269984665640564039457584007913129639935 / arg1) {
            return (false, 0)
        };
        let v0 = arg0 * arg1;
        let v1 = if (v0 % arg2 > 0) {
            1
        } else {
            0
        };
        (true, v0 / arg2 + v1)
    }

    public(friend) fun no_exposure(arg0: &mut 0x2::object::UID, arg1: u64, arg2: u64, arg3: &0x2::clock::Clock) : Status {
        let v0 = Key{dummy_field: false};
        if (!0x2::dynamic_field::exists<Key>(arg0, v0)) {
            let v1 = Key{dummy_field: false};
            let v2 = State{
                samples      : 0x1::vector::empty<Sample>(),
                frequency_ms : 0,
                manual_floor : arg2,
                ready        : true,
                target       : 0,
                alarm        : 0,
                updated_ms   : 0x2::clock::timestamp_ms(arg3),
            };
            0x2::dynamic_field::add<Key, State>(arg0, v1, v2);
        } else {
            let v3 = Key{dummy_field: false};
            let v4 = 0x2::dynamic_field::borrow_mut<Key, State>(arg0, v3);
            v4.ready = true;
            v4.target = 0;
            v4.alarm = 0;
            v4.updated_ms = 0x2::clock::timestamp_ms(arg3);
        };
        status(arg0, arg1)
    }

    fun positive_delta(arg0: u256, arg1: u256) : u256 {
        if (arg0 >= 57896044618658097711785492504343953926634992332820282019728792003956564819968 && arg1 < 57896044618658097711785492504343953926634992332820282019728792003956564819968) {
            return 0
        };
        if (arg0 < 57896044618658097711785492504343953926634992332820282019728792003956564819968 && arg1 >= 57896044618658097711785492504343953926634992332820282019728792003956564819968) {
            let v0 = 115792089237316195423570985008687907853269984665640564039457584007913129639935 - arg1 + 1;
            return if (arg0 > 115792089237316195423570985008687907853269984665640564039457584007913129639935 - v0) {
                115792089237316195423570985008687907853269984665640564039457584007913129639935
            } else {
                arg0 + v0
            }
        };
        if (arg0 > arg1) {
            arg0 - arg1
        } else {
            0
        }
    }

    public(friend) fun project(arg0: u256, arg1: u64, arg2: u256, arg3: u64, arg4: u64, arg5: u256, arg6: u256, arg7: u64) : (bool, u64) {
        let v0 = if (arg1 > 0) {
            if (arg7 > 0) {
                if (arg5 > 0) {
                    if (arg5 < 57896044618658097711785492504343953926634992332820282019728792003956564819968) {
                        if (arg6 > 0) {
                            if (arg3 <= arg4) {
                                arg2 < 57896044618658097711785492504343953926634992332820282019728792003956564819968
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
        assert!(v0, 1);
        let v1 = if (arg0 == 0) {
            true
        } else if (arg2 == 0) {
            true
        } else {
            arg3 == 0
        };
        if (v1) {
            return (true, 0)
        };
        if (arg4 == 0) {
            return (false, 0)
        };
        let (v2, v3) = multiply_up(arg0, arg2, 1000000000000000000);
        if (!v2) {
            return (false, 0)
        };
        let (v4, v5) = multiply_up(v3, (arg3 as u256), (arg4 as u256));
        if (!v4) {
            return (false, 0)
        };
        let (v6, v7) = multiply_up(v5, (arg7 as u256) * (86400000 as u256), (arg1 as u256));
        if (!v6) {
            return (false, 0)
        };
        let (v8, v9) = multiply_up(v7, 1000000000000000000, arg5);
        if (!v8) {
            return (false, 0)
        };
        let v10 = if (v9 % arg6 > 0) {
            1
        } else {
            0
        };
        let v11 = v9 / arg6 + v10;
        if (v11 > (18446744073709551615 as u256)) {
            (false, 0)
        } else {
            (true, (v11 as u64))
        }
    }

    fun protected(arg0: &State, arg1: u64) : u64 {
        let v0 = if (arg0.ready) {
            arg0.target
        } else {
            arg1
        };
        0x1::u64::max(arg0.manual_floor, v0)
    }

    public fun ready(arg0: &Status) : bool {
        arg0.ready
    }

    public(friend) fun set_floor(arg0: &mut 0x2::object::UID, arg1: u64, arg2: u64) : u64 {
        let v0 = Key{dummy_field: false};
        if (!0x2::dynamic_field::exists<Key>(arg0, v0)) {
            return arg1
        };
        let v1 = Key{dummy_field: false};
        let v2 = 0x2::dynamic_field::borrow_mut<Key, State>(arg0, v1);
        v2.manual_floor = arg1;
        protected(v2, arg2)
    }

    public(friend) fun status(arg0: &0x2::object::UID, arg1: u64) : Status {
        let v0 = Key{dummy_field: false};
        if (!0x2::dynamic_field::exists<Key>(arg0, v0)) {
            return Status{
                pool               : 0x2::object::uid_to_inner(arg0),
                ready              : false,
                target             : 0,
                manual_floor       : 0,
                protected          : arg1,
                alarm_target       : 0,
                below_alarm        : false,
                updated_ms         : 0,
                funding_updated_ms : 0,
                sample_count       : 0,
            }
        };
        let v1 = Key{dummy_field: false};
        let v2 = 0x2::dynamic_field::borrow<Key, State>(arg0, v1);
        let v3 = v2.ready && arg1 < v2.alarm;
        let v4 = if (0x1::vector::is_empty<Sample>(&v2.samples)) {
            0
        } else {
            0x1::vector::borrow<Sample>(&v2.samples, 0x1::vector::length<Sample>(&v2.samples) - 1).at
        };
        Status{
            pool               : 0x2::object::uid_to_inner(arg0),
            ready              : v2.ready,
            target             : v2.target,
            manual_floor       : v2.manual_floor,
            protected          : protected(v2, arg1),
            alarm_target       : v2.alarm,
            below_alarm        : v3,
            updated_ms         : v2.updated_ms,
            funding_updated_ms : v4,
            sample_count       : 0x1::vector::length<Sample>(&v2.samples),
        }
    }

    public(friend) fun update(arg0: &mut 0x2::object::UID, arg1: &0x10e6186356a5588e8a06e368809b0d08bfeaa4d067c252082c9d7785c911295d::funding_rules::Rules, arg2: u256, arg3: u64, arg4: u64, arg5: u256, arg6: u64, arg7: u64, arg8: u256, arg9: u256, arg10: u64, arg11: u64, arg12: &0x2::clock::Clock) : Status {
        let v0 = if (arg4 > 0) {
            if (arg4 <= 86400000) {
                if (arg3 <= 0x2::clock::timestamp_ms(arg12)) {
                    arg6 <= arg7
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
        let (_, _, v3, v4, v5) = 0x10e6186356a5588e8a06e368809b0d08bfeaa4d067c252082c9d7785c911295d::funding_rules::values(arg1);
        let v6 = Key{dummy_field: false};
        if (!0x2::dynamic_field::exists<Key>(arg0, v6)) {
            let v7 = Key{dummy_field: false};
            let v8 = State{
                samples      : 0x1::vector::empty<Sample>(),
                frequency_ms : arg4,
                manual_floor : arg11,
                ready        : false,
                target       : 0,
                alarm        : 0,
                updated_ms   : 0,
            };
            0x2::dynamic_field::add<Key, State>(arg0, v7, v8);
        };
        let v9 = Key{dummy_field: false};
        let v10 = 0x2::dynamic_field::borrow_mut<Key, State>(arg0, v9);
        if (v10.frequency_ms != arg4) {
            v10.samples = 0x1::vector::empty<Sample>();
            v10.frequency_ms = arg4;
        };
        if (!0x1::vector::is_empty<Sample>(&v10.samples)) {
            let v11 = *0x1::vector::borrow<Sample>(&v10.samples, 0x1::vector::length<Sample>(&v10.samples) - 1);
            assert!(arg3 >= v11.at, 2);
            if (arg3 == v11.at) {
                assert!(arg2 == v11.rate, 2);
            } else if (!in_band(arg3 - v11.at, arg4, v4)) {
                v10.samples = 0x1::vector::empty<Sample>();
            };
        };
        if (0x1::vector::is_empty<Sample>(&v10.samples) || 0x1::vector::borrow<Sample>(&v10.samples, 0x1::vector::length<Sample>(&v10.samples) - 1).at != arg3) {
            let v12 = Sample{
                at   : arg3,
                rate : arg2,
            };
            0x1::vector::push_back<Sample>(&mut v10.samples, v12);
        };
        let v13 = true;
        let v14 = 1;
        while (v14 < 0x1::vector::length<Sample>(&v10.samples)) {
            if (!in_band(0x1::vector::borrow<Sample>(&v10.samples, v14).at - 0x1::vector::borrow<Sample>(&v10.samples, v14 - 1).at, arg4, v4)) {
                v13 = false;
            };
            v14 = v14 + 1;
        };
        if (!v13) {
            let v15 = 0x1::vector::empty<Sample>();
            0x1::vector::push_back<Sample>(&mut v15, *0x1::vector::borrow<Sample>(&v10.samples, 0x1::vector::length<Sample>(&v10.samples) - 1));
            v10.samples = v15;
        };
        while (0x1::vector::length<Sample>(&v10.samples) > 2 && (0x1::vector::length<Sample>(&v10.samples) > 256 || arg3 - 0x1::vector::borrow<Sample>(&v10.samples, 0).at > v3 + v5)) {
            0x1::vector::remove<Sample>(&mut v10.samples, 0);
        };
        v10.ready = false;
        v10.target = 0;
        v10.alarm = 0;
        v10.updated_ms = 0x2::clock::timestamp_ms(arg12);
        if (arg6 == 0 || arg5 == 0) {
            v10.ready = true;
        } else if (0x1::vector::length<Sample>(&v10.samples) >= 2 && 0x2::clock::timestamp_ms(arg12) - arg3 <= arg4 + v5) {
            let v16 = *0x1::vector::borrow<Sample>(&v10.samples, 0x1::vector::length<Sample>(&v10.samples) - 1);
            let v17 = *0x1::vector::borrow<Sample>(&v10.samples, 0x1::vector::length<Sample>(&v10.samples) - 2);
            let v18 = *0x1::vector::borrow<Sample>(&v10.samples, 0);
            let v19 = positive_delta(v16.rate, v17.rate);
            let v20 = v16.at - v17.at;
            let v21 = positive_delta(v16.rate, v18.rate);
            let v22 = v16.at - v18.at;
            let (v23, v24, _, _, _) = 0x10e6186356a5588e8a06e368809b0d08bfeaa4d067c252082c9d7785c911295d::funding_rules::values(arg1);
            let (v28, v29) = project(v19, v20, arg5, arg6, arg7, arg8, arg9, v23);
            let (v30, v31) = project(v21, v22, arg5, arg6, arg7, arg8, arg9, v23);
            let (v32, v33) = project(v19, v20, arg5, arg6, arg7, arg8, arg9, v24);
            let (v34, v35) = project(v21, v22, arg5, arg6, arg7, arg8, arg9, v24);
            let v36 = if (v28) {
                if (v30) {
                    if (v32) {
                        v34
                    } else {
                        false
                    }
                } else {
                    false
                }
            } else {
                false
            };
            if (v36) {
                v10.ready = true;
                v10.target = 0x1::u64::max(v29, v31);
                v10.alarm = 0x1::u64::max(v33, v35);
            };
        };
        status(arg0, arg10)
    }

    // decompiled from Move bytecode v7
}

