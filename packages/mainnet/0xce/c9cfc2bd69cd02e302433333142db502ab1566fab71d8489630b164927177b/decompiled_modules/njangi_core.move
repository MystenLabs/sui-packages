module 0xcec9cfc2bd69cd02e302433333142db502ab1566fab71d8489630b164927177b::njangi_core {
    struct UsdAmounts has drop, store {
        contribution_amount: u64,
        security_deposit: u64,
        target_amount: 0x1::option::Option<u64>,
    }

    public fun adjust_decimals(arg0: u64, arg1: u8, arg2: u8) : u64 {
        if (arg1 == arg2) {
            return arg0
        };
        if (arg1 < arg2) {
            let v1 = 1;
            let v2 = 0;
            while (v2 < ((arg2 - arg1) as u64)) {
                v1 = v1 * 10;
                v2 = v2 + 1;
            };
            arg0 * v1
        } else {
            let v3 = 1;
            let v4 = 0;
            while (v4 < ((arg1 - arg2) as u64)) {
                v3 = v3 * 10;
                v4 = v4 + 1;
            };
            arg0 / v3
        }
    }

    public fun assert_admin(arg0: address, arg1: address) {
        assert!(arg0 == arg1, 7);
    }

    public fun calculate_next_payout_time(arg0: u64, arg1: u64, arg2: u64) : u64 {
        let (v0, v1, v2) = timestamp_to_date(arg2);
        let v3 = get_day_ms(arg2);
        if (arg0 == 0) {
            let v5 = get_weekday(arg2);
            let v6 = if (arg1 > v5) {
                ((arg1 - v5) as u64)
            } else if (arg1 < v5 || arg1 == v5 && v3 > 0) {
                ((7 - v5 + arg1) as u64)
            } else {
                0
            };
            if (v6 == 0 && v3 > 0) {
                arg2 + 604800000 - v3
            } else {
                arg2 + v6 * 86400000 - v3
            }
        } else if (arg0 == 1) {
            let v7 = v1;
            let v8 = v0;
            if (v2 > arg1 || v2 == arg1 && v3 > 0) {
                let v9 = v1 + 1;
                v7 = v9;
                if (v9 > 12) {
                    v7 = 1;
                    v8 = v0 + 1;
                };
            };
            date_to_timestamp(v8, v7, arg1)
        } else if (arg0 == 3) {
            let v10 = get_weekday(arg2);
            let v11 = if (arg1 > v10) {
                ((arg1 - v10) as u64)
            } else if (arg1 < v10 || arg1 == v10 && v3 > 0) {
                ((7 - v10 + arg1) as u64)
            } else {
                0
            };
            if (v11 == 0 && v3 == 0) {
                arg2
            } else if (arg1 <= v10) {
                arg2 + v11 * 86400000 - v3 + 1209600000
            } else {
                arg2 + v11 * 86400000 - v3
            }
        } else {
            let v12 = v0;
            let v13 = if (v2 > arg1 || v2 == arg1 && v3 > 0) {
                let v14 = v1 + 3;
                let v13 = v14;
                if (v14 > 12) {
                    v13 = v14 - 12;
                    v12 = v0 + 1;
                };
                v13
            } else {
                let v15 = v1 + 3 - (v1 - 1) % 3;
                let v13 = v15;
                if (v15 > 12) {
                    v13 = v15 - 12;
                    v12 = v0 + 1;
                };
                v13
            };
            date_to_timestamp(v12, v13, arg1)
        }
    }

    public fun create_usd_amounts(arg0: u64, arg1: u64, arg2: 0x1::option::Option<u64>) : UsdAmounts {
        UsdAmounts{
            contribution_amount : arg0,
            security_deposit    : arg1,
            target_amount       : arg2,
        }
    }

    public fun custody_op_deposit() : u8 {
        0
    }

    public fun custody_op_payout() : u8 {
        2
    }

    public fun custody_op_stablecoin_deposit() : u8 {
        3
    }

    public fun custody_op_withdrawal() : u8 {
        1
    }

    public fun date_to_timestamp(arg0: u64, arg1: u64, arg2: u64) : u64 {
        let v0 = 0;
        let v1 = 1970;
        while (v1 < arg0) {
            let v2 = if (is_leap_year(v1)) {
                366
            } else {
                365
            };
            v0 = v0 + v2;
            v1 = v1 + 1;
        };
        let v3 = vector[31, 28, 31, 30, 31, 30, 31, 31, 30, 31, 30, 31];
        if (is_leap_year(arg0)) {
            *0x1::vector::borrow_mut<u64>(&mut v3, 1) = 29;
        };
        let v4 = 1;
        while (v4 < arg1) {
            v0 = v0 + *0x1::vector::borrow<u64>(&v3, v4 - 1);
            v4 = v4 + 1;
        };
        (v0 + arg2 - 1) * 86400000
    }

    public fun days_in_month() : u64 {
        28
    }

    public fun days_in_week() : u64 {
        7
    }

    public fun decimal_scaling() : u64 {
        1000000000
    }

    public fun from_decimals(arg0: u64) : u64 {
        arg0 / 1000000000
    }

    public fun get_day_ms(arg0: u64) : u64 {
        arg0 % 86400000
    }

    public fun get_day_of_month(arg0: u64) : u64 {
        let (_, _, v2) = timestamp_to_date(arg0);
        v2
    }

    public fun get_day_of_quarter(arg0: u64) : u64 {
        let (v0, v1, v2) = timestamp_to_date(arg0);
        let v3 = 0;
        let v4 = vector[31, 28, 31, 30, 31, 30, 31, 31, 30, 31, 30, 31];
        if (is_leap_year(v0)) {
            *0x1::vector::borrow_mut<u64>(&mut v4, 1) = 29;
        };
        let v5 = (v1 - 1) / 3 * 3 + 1;
        while (v5 < v1) {
            v3 = v3 + *0x1::vector::borrow<u64>(&v4, v5 - 1);
            v5 = v5 + 1;
        };
        v3 + v2
    }

    public fun get_max_members() : u64 {
        20
    }

    public fun get_min_members() : u64 {
        3
    }

    public fun get_sample_addresses() : vector<address> {
        let v0 = 0x1::vector::empty<address>();
        0x1::vector::push_back<address>(&mut v0, @0x1);
        v0
    }

    public fun get_usd_contribution_amount(arg0: &UsdAmounts) : u64 {
        arg0.contribution_amount
    }

    public fun get_usd_security_deposit(arg0: &UsdAmounts) : u64 {
        arg0.security_deposit
    }

    public fun get_usd_target_amount(arg0: &UsdAmounts) : 0x1::option::Option<u64> {
        arg0.target_amount
    }

    public fun get_weekday(arg0: u64) : u64 {
        (arg0 / 86400000 + 3) % 7
    }

    public fun is_leap_year(arg0: u64) : bool {
        arg0 % 400 == 0 || arg0 % 100 == 0 && false || arg0 % 4 == 0
    }

    public fun is_valid_cycle_day(arg0: u64, arg1: u64) : bool {
        arg0 == 0 && arg1 < 7 || arg0 == 3 && arg1 < 7 || arg0 == 1 && arg1 > 0 && arg1 <= 28 || arg1 > 0 && arg1 <= 28
    }

    public fun member_status_active() : u8 {
        0
    }

    public fun member_status_exited() : u8 {
        3
    }

    public fun member_status_pending() : u8 {
        1
    }

    public fun member_status_suspended() : u8 {
        2
    }

    public fun milestone_type_monetary() : u8 {
        0
    }

    public fun milestone_type_time() : u8 {
        1
    }

    public fun min_security_deposit(arg0: u64) : u64 {
        arg0 / 2
    }

    public fun ms_per_bi_week() : u64 {
        1209600000
    }

    public fun ms_per_day() : u64 {
        86400000
    }

    public fun ms_per_month() : u64 {
        2419200000
    }

    public fun ms_per_week() : u64 {
        604800000
    }

    public fun sui_decimals() : u8 {
        9
    }

    public fun timestamp_to_date(arg0: u64) : (u64, u64, u64) {
        let v0 = arg0 / 86400000;
        let v1 = 1970;
        let v2 = 1;
        loop {
            let v3 = if (is_leap_year(v1)) {
                366
            } else {
                365
            };
            if (v0 >= v3) {
                v0 = v0 - v3;
                v1 = v1 + 1;
            } else {
                break
            };
        };
        let v4 = vector[31, 28, 31, 30, 31, 30, 31, 31, 30, 31, 30, 31];
        if (is_leap_year(v1)) {
            *0x1::vector::borrow_mut<u64>(&mut v4, 1) = 29;
        };
        while (v2 <= 12) {
            let v5 = *0x1::vector::borrow<u64>(&v4, v2 - 1);
            if (v0 >= v5) {
                v0 = v0 - v5;
                v2 = v2 + 1;
            } else {
                break
            };
        };
        (v1, v2, v0 + 1)
    }

    public fun to_decimals(arg0: u64) : u64 {
        if (arg0 > 18446744073) {
            18446744073000000000
        } else {
            arg0 * 1000000000
        }
    }

    public fun usdc_decimals() : u8 {
        6
    }

    // decompiled from Move bytecode v6
}

