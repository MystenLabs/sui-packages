module 0xb0091007dee3b8468b19e7ffa3beb27d1ffae4a6fc298f327f5188e1e3279163::limits {
    struct Observation has copy, drop, store {
        ms: u64,
        sqrt_price: u128,
    }

    struct Observations has store {
        points: vector<Observation>,
        next: u64,
        last_ms: u64,
    }

    struct Turnover has store {
        hours: vector<u64>,
        amounts: vector<u64>,
    }

    public fun above_premium(arg0: u128, arg1: u128, arg2: u64) : bool {
        sq(arg0) * (10000 as u256) >= sq(arg1) * ((10000 + arg2) as u256)
    }

    public fun add_turnover(arg0: &mut Turnover, arg1: u64, arg2: u64) {
        let v0 = arg1 / 3600000;
        let v1 = v0 % 24;
        if (*0x1::vector::borrow<u64>(&arg0.hours, v1) != v0) {
            *0x1::vector::borrow_mut<u64>(&mut arg0.hours, v1) = v0;
            *0x1::vector::borrow_mut<u64>(&mut arg0.amounts, v1) = 0;
        };
        let v2 = 0x1::vector::borrow_mut<u64>(&mut arg0.amounts, v1);
        *v2 = sat_add(*v2, arg2);
    }

    fun insert_sorted(arg0: &mut vector<u128>, arg1: u128) {
        0x1::vector::push_back<u128>(arg0, arg1);
        let v0 = 0x1::vector::length<u128>(arg0) - 1;
        while (v0 > 0 && *0x1::vector::borrow<u128>(arg0, v0 - 1) > arg1) {
            0x1::vector::swap<u128>(arg0, v0 - 1, v0);
            v0 = v0 - 1;
        };
    }

    public fun last_observation_ms(arg0: &Observations) : u64 {
        arg0.last_ms
    }

    fun median_all(arg0: &Observations) : u128 {
        let v0 = vector[];
        let v1 = 0x1::vector::length<Observation>(&arg0.points);
        let v2 = 0;
        while (v2 < v1) {
            let v3 = &mut v0;
            insert_sorted(v3, 0x1::vector::borrow<Observation>(&arg0.points, v2).sqrt_price);
            v2 = v2 + 1;
        };
        *0x1::vector::borrow<u128>(&v0, v1 / 2)
    }

    public fun min_observations() : u64 {
        10
    }

    public fun new_observations() : Observations {
        Observations{
            points  : 0x1::vector::empty<Observation>(),
            next    : 0,
            last_ms : 0,
        }
    }

    public fun new_turnover() : Turnover {
        let v0 = vector[];
        let v1 = vector[];
        let v2 = 0;
        while (v2 < 24) {
            0x1::vector::push_back<u64>(&mut v0, 18446744073709551615);
            0x1::vector::push_back<u64>(&mut v1, 0);
            v2 = v2 + 1;
        };
        Turnover{
            hours   : v0,
            amounts : v1,
        }
    }

    public fun observation_count(arg0: &Observations) : u64 {
        0x1::vector::length<Observation>(&arg0.points)
    }

    public fun observe(arg0: &mut Observations, arg1: u64, arg2: u128) : u128 {
        assert!(arg2 > 0, 302);
        assert!(arg0.last_ms == 0 || arg1 >= arg0.last_ms + 60000, 300);
        let v0 = if (0x1::vector::length<Observation>(&arg0.points) < 10) {
            arg2
        } else {
            let v1 = median_all(arg0);
            let v2 = v1 - v1 * 100 / (10000 as u128);
            let v3 = v1 + v1 * 100 / (10000 as u128);
            if (arg2 < v2) {
                v2
            } else if (arg2 > v3) {
                v3
            } else {
                arg2
            }
        };
        push(arg0, arg1, v0);
        v0
    }

    public fun observe_interval_ms() : u64 {
        60000
    }

    fun push(arg0: &mut Observations, arg1: u64, arg2: u128) {
        let v0 = Observation{
            ms         : arg1,
            sqrt_price : arg2,
        };
        if (0x1::vector::length<Observation>(&arg0.points) < 32) {
            0x1::vector::push_back<Observation>(&mut arg0.points, v0);
        } else {
            *0x1::vector::borrow_mut<Observation>(&mut arg0.points, arg0.next) = v0;
        };
        arg0.next = (arg0.next + 1) % 32;
        arg0.last_ms = arg1;
    }

    public fun ref_window_ms() : u64 {
        1800000
    }

    public fun reference(arg0: &Observations, arg1: u64) : u128 {
        let v0 = vector[];
        let v1 = 0;
        while (v1 < 0x1::vector::length<Observation>(&arg0.points)) {
            let v2 = 0x1::vector::borrow<Observation>(&arg0.points, v1);
            if (v2.ms + 1800000 >= arg1 && v2.ms <= arg1) {
                let v3 = &mut v0;
                insert_sorted(v3, v2.sqrt_price);
            };
            v1 = v1 + 1;
        };
        let v4 = 0x1::vector::length<u128>(&v0);
        assert!(v4 >= 10, 301);
        if (v4 % 2 == 1) {
            *0x1::vector::borrow<u128>(&v0, v4 / 2)
        } else {
            *0x1::vector::borrow<u128>(&v0, v4 / 2 - 1) / 2 + *0x1::vector::borrow<u128>(&v0, v4 / 2) / 2
        }
    }

    fun sat_add(arg0: u64, arg1: u64) : u64 {
        let v0 = (arg0 as u128) + (arg1 as u128);
        if (v0 > 18446744073709551615) {
            18446744073709551615
        } else {
            (v0 as u64)
        }
    }

    public fun seed(arg0: &mut Observations, arg1: u64, arg2: u128) {
        assert!(arg2 > 0, 302);
        let v0 = 0;
        while (v0 < 10) {
            push(arg0, arg1, arg2);
            v0 = v0 + 1;
        };
    }

    public fun side_ok(arg0: u128, arg1: u128, arg2: u128, arg3: bool, arg4: bool) : bool {
        arg4 && !arg3 && arg1 <= arg2 || arg3 && !arg4 && arg0 >= arg2 || arg0 <= arg2 && arg2 <= arg1
    }

    fun sq(arg0: u128) : u256 {
        (arg0 as u256) * (arg0 as u256)
    }

    public fun token_heavy(arg0: u64, arg1: u64, arg2: u64) : bool {
        let v0 = (arg0 as u128) + (arg1 as u128);
        v0 > 0 && (arg0 as u128) * (10000 as u128) > v0 * (arg2 as u128)
    }

    public fun token_value(arg0: u64, arg1: u128) : u64 {
        let v0 = (arg0 as u256) * sq(arg1) >> 128;
        if (v0 > 18446744073709551615) {
            18446744073709551615
        } else {
            (v0 as u64)
        }
    }

    public fun turnover(arg0: &Turnover, arg1: u64) : u64 {
        let v0 = arg1 / 3600000;
        let v1 = 0;
        let v2 = 0;
        while (v2 < 24) {
            let v3 = *0x1::vector::borrow<u64>(&arg0.hours, v2);
            if (v3 <= v0 && v3 + 24 > v0) {
                v1 = sat_add(v1, *0x1::vector::borrow<u64>(&arg0.amounts, v2));
            };
            v2 = v2 + 1;
        };
        v1
    }

    public fun turnover_ok(arg0: u64, arg1: u64, arg2: u64) : bool {
        (arg0 as u128) * (10000 as u128) <= (arg1 as u128) * (arg2 as u128)
    }

    public fun within_band(arg0: u128, arg1: u128, arg2: u128, arg3: u64, arg4: u64) : bool {
        let v0 = sq(arg2);
        if (arg0 < arg1) {
            if (sq(arg0) * (10000 as u256) >= v0 * (arg3 as u256)) {
                sq(arg1) * (10000 as u256) <= v0 * (arg4 as u256)
            } else {
                false
            }
        } else {
            false
        }
    }

    public fun within_deviation(arg0: u128, arg1: u128, arg2: u64) : bool {
        let v0 = sq(arg0);
        let v1 = sq(arg1);
        let v2 = if (v0 > v1) {
            v0 - v1
        } else {
            v1 - v0
        };
        v2 * (10000 as u256) <= v1 * (arg2 as u256)
    }

    // decompiled from Move bytecode v7
}

