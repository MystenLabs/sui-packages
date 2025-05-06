module 0x732c10d607f08d329b24b0b60fdd1c63b7a9ca2b06030332050fe713dc8f917f::lotto {
    struct Lotto has store {
        version: u64,
        ecology_rate: u64,
        day: 0x2::table::Table<u64, Pool>,
        week: 0x2::table::Table<u64, Pool>,
        month: 0x2::table::Table<u64, Pool>,
        quarter: 0x2::table::Table<u64, Pool>,
        year: 0x2::table::Table<u64, Pool>,
    }

    struct Time has drop {
        timestamp: u64,
        day: u64,
        week: u64,
        month: u64,
        quarter: u64,
        year: u64,
    }

    struct Pool has copy, drop, store {
        version: u64,
        score: u64,
        bonus: u64,
        bonus_balance: u64,
    }

    struct Item has copy, store {
        version: u64,
        numb: u64,
        open: u64,
        profit: u64,
        cur: u64,
        nxt: u64,
    }

    struct Activity has copy, store {
        version: u64,
        weight: u64,
        amount: u64,
        amount_month: u64,
        times: u64,
        times_month: u64,
        lst_time: u64,
        ini_time: u64,
    }

    struct Account has store {
        version: u64,
        invest_ratio: u64,
        profit_ratio: u64,
        day: Item,
        week: Item,
        month: Item,
        quarter: Item,
        year: Item,
        activity: Activity,
    }

    fun bonus_claim(arg0: &mut Item, arg1: &mut 0x2::table::Table<u64, Pool>) : u64 {
        if (arg0.open == 0) {
            return 0
        };
        if (0x2::table::contains<u64, Pool>(arg1, arg0.numb) == false) {
            return 0
        };
        let v0 = 0x2::table::borrow_mut<u64, Pool>(arg1, arg0.numb);
        v0.bonus_balance = v0.bonus_balance - arg0.open;
        arg0.open = 0;
        arg0.open
    }

    fun bonus_open(arg0: &mut Item, arg1: &mut 0x2::table::Table<u64, Pool>) : u64 {
        if (0x2::table::contains<u64, Pool>(arg1, arg0.numb) == false) {
            return 0
        };
        let v0 = 0x2::table::borrow_mut<u64, Pool>(arg1, arg0.numb);
        let v1 = v0.bonus * arg0.cur / v0.score;
        v0.bonus_balance = v0.bonus - v1;
        arg0.open = arg0.profit + v1;
        arg0.numb = arg0.numb + 1;
        arg0.cur = arg0.nxt;
        arg0.nxt = 0;
        v1
    }

    fun bonus_pool_update(arg0: u64, arg1: u64, arg2: u64, arg3: &mut 0x2::table::Table<u64, Pool>) {
        if (0x2::table::contains<u64, Pool>(arg3, arg0) == false) {
            let v0 = Pool{
                version       : 1,
                score         : arg1,
                bonus         : arg2,
                bonus_balance : arg2,
            };
            0x2::table::add<u64, Pool>(arg3, arg0, v0);
            return
        };
        let v1 = 0x2::table::borrow_mut<u64, Pool>(arg3, arg0);
        v1.score = v1.score + arg1;
        v1.bonus = v1.bonus + arg2;
        v1.bonus_balance = v1.bonus_balance + arg2;
    }

    fun calc_activity(arg0: &Activity) : u64 {
        let v0 = arg0.weight;
        let v1 = v0;
        if (arg0.times_month < 3) {
            v1 = 0x8743e742a4b838115d1552c4d4836e9c50e34c1f52e75f5c4c9c8a5bb0733f3d::utils::ratio_calc(v0, 3000);
        } else if (arg0.times_month < 30) {
            v1 = 0x8743e742a4b838115d1552c4d4836e9c50e34c1f52e75f5c4c9c8a5bb0733f3d::utils::ratio_calc(v0, 5000);
        } else if (arg0.times_month < 90) {
            v1 = 0x8743e742a4b838115d1552c4d4836e9c50e34c1f52e75f5c4c9c8a5bb0733f3d::utils::ratio_calc(v0, 7000);
        };
        if (arg0.amount_month < 500) {
            v1 = 0x8743e742a4b838115d1552c4d4836e9c50e34c1f52e75f5c4c9c8a5bb0733f3d::utils::ratio_calc(v1, 2000);
        } else if (arg0.amount_month < 2000) {
            v1 = 0x8743e742a4b838115d1552c4d4836e9c50e34c1f52e75f5c4c9c8a5bb0733f3d::utils::ratio_calc(v1, 3000);
        } else if (arg0.amount_month < 5000) {
            v1 = 0x8743e742a4b838115d1552c4d4836e9c50e34c1f52e75f5c4c9c8a5bb0733f3d::utils::ratio_calc(v1, 5000);
        } else if (arg0.amount_month < 10000) {
            v1 = 0x8743e742a4b838115d1552c4d4836e9c50e34c1f52e75f5c4c9c8a5bb0733f3d::utils::ratio_calc(v1, 7000);
        };
        if (v1 < 0) {
            v1 = 0;
        };
        v1
    }

    fun calc_month(arg0: u64) : u64 {
        arg0 / 86400000 / 30
    }

    fun calc_time(arg0: u64) : Time {
        let v0 = arg0 / 86400000;
        let v1 = v0 / 30;
        Time{
            timestamp : arg0,
            day       : v0,
            week      : v0 / 7,
            month     : v1,
            quarter   : v1 / 3,
            year      : v1 / 12,
        }
    }

    public(friend) fun claim(arg0: &mut Account, arg1: &mut Lotto, arg2: &mut 0x8743e742a4b838115d1552c4d4836e9c50e34c1f52e75f5c4c9c8a5bb0733f3d::lockable::Lockable) {
        let v0 = &mut arg0.day;
        let v1 = &mut arg1.day;
        let v2 = bonus_claim(v0, v1);
        let v3 = &mut arg0.week;
        let v4 = &mut arg1.week;
        let v5 = bonus_claim(v3, v4);
        let v6 = &mut arg0.month;
        let v7 = &mut arg1.month;
        let v8 = bonus_claim(v6, v7);
        let v9 = &mut arg0.quarter;
        let v10 = &mut arg1.quarter;
        let v11 = bonus_claim(v9, v10);
        let v12 = &mut arg0.year;
        let v13 = &mut arg1.year;
        let v14 = v2 + v5 + v8 + v11 + bonus_claim(v12, v13);
        if (v14 > 0) {
            0x8743e742a4b838115d1552c4d4836e9c50e34c1f52e75f5c4c9c8a5bb0733f3d::lockable::increase_available(arg2, v14);
        };
    }

    fun distribute_score_profit(arg0: &mut Lotto, arg1: &mut Account, arg2: u64, arg3: u64, arg4: &Time) {
        update_day(arg0, arg1, arg3 / 5, arg2, arg4);
        update_week(arg0, arg1, arg3 / 5, arg2, arg4);
        update_month(arg0, arg1, arg3 / 5, arg2, arg4);
        update_quarter(arg0, arg1, arg3 / 5, arg2, arg4);
        update_year(arg0, arg1, arg3 / 5, arg2, arg4);
    }

    fun do_check_and_reset_activity(arg0: u64, arg1: &mut Activity, arg2: &Time) {
        arg1.times = arg1.times + 1;
        arg1.amount = arg1.amount + arg0;
        arg1.lst_time = arg2.timestamp;
        if (arg2.month == calc_month(arg1.lst_time)) {
            arg1.times_month = arg1.times_month + 1;
            arg1.amount_month = arg1.amount_month + arg0;
            return
        };
        arg1.times_month = 1;
        arg1.amount_month = arg0;
        if (arg1.times_month == 0) {
            arg1.weight = 0;
            return
        };
        arg1.weight = 10000;
        if (arg1.times_month < 3) {
            arg1.weight = arg1.weight - 5000;
        } else if (arg1.times_month < 30) {
            arg1.weight = arg1.weight - 3000;
        } else if (arg1.times_month < 90) {
            arg1.weight = arg1.weight - 1000;
        };
        if (arg1.amount_month < 100) {
            arg1.weight = arg1.weight - 5000;
        } else if (arg1.amount_month < 1000) {
            arg1.weight = arg1.weight - 3000;
        } else if (arg1.amount_month < 3000) {
            arg1.weight = arg1.weight - 1000;
        };
    }

    fun get_current_time(arg0: &0x2::clock::Clock) : Time {
        calc_time(0x2::clock::timestamp_ms(arg0))
    }

    public(friend) fun new_account(arg0: u64, arg1: u64, arg2: u64) : Account {
        0x8743e742a4b838115d1552c4d4836e9c50e34c1f52e75f5c4c9c8a5bb0733f3d::utils::ratio_check(arg0);
        0x8743e742a4b838115d1552c4d4836e9c50e34c1f52e75f5c4c9c8a5bb0733f3d::utils::ratio_check(arg1);
        let v0 = Activity{
            version      : 1,
            weight       : 10000,
            amount       : 0,
            amount_month : 0,
            times        : 0,
            times_month  : 0,
            lst_time     : arg2,
            ini_time     : arg2,
        };
        Account{
            version      : 1,
            invest_ratio : arg0,
            profit_ratio : arg1,
            day          : new_item(),
            week         : new_item(),
            month        : new_item(),
            quarter      : new_item(),
            year         : new_item(),
            activity     : v0,
        }
    }

    fun new_item() : Item {
        Item{
            version : 1,
            numb    : 0,
            open    : 0,
            profit  : 0,
            cur     : 0,
            nxt     : 0,
        }
    }

    public(friend) fun new_lotto(arg0: u64, arg1: &mut 0x2::tx_context::TxContext) : Lotto {
        Lotto{
            version      : 1,
            ecology_rate : arg0,
            day          : 0x2::table::new<u64, Pool>(arg1),
            week         : 0x2::table::new<u64, Pool>(arg1),
            month        : 0x2::table::new<u64, Pool>(arg1),
            quarter      : 0x2::table::new<u64, Pool>(arg1),
            year         : 0x2::table::new<u64, Pool>(arg1),
        }
    }

    public(friend) fun set_acc_ratio(arg0: &mut Account, arg1: u64, arg2: u64) {
        arg0.invest_ratio = arg1;
        arg0.profit_ratio = arg2;
    }

    public(friend) fun set_lotto_ecology_rate(arg0: &mut Lotto, arg1: u64) {
        0x8743e742a4b838115d1552c4d4836e9c50e34c1f52e75f5c4c9c8a5bb0733f3d::utils::ratio_check(arg1);
        arg0.ecology_rate = arg1;
    }

    public(friend) fun trigger(arg0: &mut Lotto, arg1: &mut Account, arg2: &mut Account, arg3: &mut Account, arg4: u64, arg5: u64, arg6: &0x2::clock::Clock, arg7: &mut 0x2::tx_context::TxContext) {
        let v0 = get_current_time(arg6);
        let v1 = &mut arg2.activity;
        do_check_and_reset_activity(arg4, v1, &v0);
        let v2 = &mut arg3.activity;
        do_check_and_reset_activity(arg4, v2, &v0);
        let v3 = &mut arg1.activity;
        do_check_and_reset_activity(arg4, v3, &v0);
        let v4 = 0x8743e742a4b838115d1552c4d4836e9c50e34c1f52e75f5c4c9c8a5bb0733f3d::utils::ratio_calc(arg4, arg2.invest_ratio);
        assert!(v4 == arg5, 4040404);
        let v5 = v4 - 0x8743e742a4b838115d1552c4d4836e9c50e34c1f52e75f5c4c9c8a5bb0733f3d::utils::ratio_calc(v4, arg0.ecology_rate);
        let v6 = calc_activity(&arg3.activity);
        let v7 = 0x8743e742a4b838115d1552c4d4836e9c50e34c1f52e75f5c4c9c8a5bb0733f3d::utils::ratio_calc(0x8743e742a4b838115d1552c4d4836e9c50e34c1f52e75f5c4c9c8a5bb0733f3d::utils::ratio_calc(0x8743e742a4b838115d1552c4d4836e9c50e34c1f52e75f5c4c9c8a5bb0733f3d::utils::ratio_calc(v4, arg2.profit_ratio), calc_activity(&arg2.activity)), 1000);
        let v8 = 0x8743e742a4b838115d1552c4d4836e9c50e34c1f52e75f5c4c9c8a5bb0733f3d::utils::ratio_calc(0x8743e742a4b838115d1552c4d4836e9c50e34c1f52e75f5c4c9c8a5bb0733f3d::utils::ratio_calc(0x8743e742a4b838115d1552c4d4836e9c50e34c1f52e75f5c4c9c8a5bb0733f3d::utils::ratio_calc(v4, arg3.profit_ratio), v6), 100);
        let v9 = 0x8743e742a4b838115d1552c4d4836e9c50e34c1f52e75f5c4c9c8a5bb0733f3d::utils::ratio_calc(0x8743e742a4b838115d1552c4d4836e9c50e34c1f52e75f5c4c9c8a5bb0733f3d::utils::ratio_calc(v4, arg1.profit_ratio), calc_activity(&arg1.activity));
        let v10 = v5 / 10;
        let v11 = v5 / 10;
        let v12 = v5 / 10;
        let v13 = v5 / 10;
        let v14 = v5 / 10;
        let v15 = v5 / 10;
        let v16 = v5 / 10;
        let v17 = v5 / 10;
        let v18 = v5 / 10;
        let v19 = &mut arg0.day;
        bonus_pool_update(v0.day + 1, 0, v10, v19);
        let v20 = &mut arg0.day;
        bonus_pool_update(v0.day, 0, v11, v20);
        let v21 = &mut arg0.week;
        bonus_pool_update(v0.week + 1, 0, v12, v21);
        let v22 = &mut arg0.week;
        bonus_pool_update(v0.week, 0, v13, v22);
        let v23 = &mut arg0.month;
        bonus_pool_update(v0.month + 1, 0, v14, v23);
        let v24 = &mut arg0.month;
        bonus_pool_update(v0.month, 0, v15, v24);
        let v25 = &mut arg0.quarter;
        bonus_pool_update(v0.quarter + 1, 0, v16, v25);
        let v26 = &mut arg0.quarter;
        bonus_pool_update(v0.quarter, 0, v17, v26);
        let v27 = &mut arg0.year;
        bonus_pool_update(v0.year + 1, 0, v18, v27);
        let v28 = &mut arg0.year;
        bonus_pool_update(v0.year, 0, v5 - v10 - v11 - v12 - v13 - v14 - v15 - v16 - v17 - v18, v28);
        let v29 = 0x8743e742a4b838115d1552c4d4836e9c50e34c1f52e75f5c4c9c8a5bb0733f3d::utils::ratio_calc(0x8743e742a4b838115d1552c4d4836e9c50e34c1f52e75f5c4c9c8a5bb0733f3d::utils::ratio_calc(v4, v6), arg3.invest_ratio);
        distribute_score_profit(arg0, arg2, v4, v7, &v0);
        distribute_score_profit(arg0, arg3, v29, v8, &v0);
        distribute_score_profit(arg0, arg1, v4, v9, &v0);
    }

    fun update_day(arg0: &mut Lotto, arg1: &mut Account, arg2: u64, arg3: u64, arg4: &Time) {
        let v0 = arg3 * 101 / 100;
        if (arg1.day.numb == arg4.day) {
            arg1.day.cur = arg1.day.cur + arg3;
            arg1.day.nxt = arg1.day.nxt + v0;
            arg1.day.profit = arg1.day.profit + arg2;
        } else if (arg1.day.numb + 1 == arg4.day) {
            let v1 = &mut arg1.day;
            let v2 = &mut arg0.day;
            bonus_open(v1, v2);
            arg1.day.numb = arg4.day;
            arg1.day.cur = arg1.day.cur + arg3;
            arg1.day.nxt = arg1.day.nxt + v0;
            arg1.day.profit = arg1.day.profit + arg2;
        } else {
            arg1.day.numb = arg4.day;
            arg1.day.cur = arg3;
            arg1.day.nxt = v0;
            arg1.day.profit = arg2;
            arg1.day.open = 0;
        };
        let v3 = &mut arg0.day;
        bonus_pool_update(arg1.day.numb, arg3, 0, v3);
        let v4 = &mut arg0.day;
        bonus_pool_update(arg1.day.numb + 1, v0, 0, v4);
    }

    fun update_month(arg0: &mut Lotto, arg1: &mut Account, arg2: u64, arg3: u64, arg4: &Time) {
        let v0 = arg3 * (100 + (arg4.month + 1) * 30 - arg4.day) / 100;
        let v1 = arg3 * (100 + (arg4.month + 1) * 30 - arg4.day + 30) / 100;
        if (arg1.month.numb == arg4.month) {
            arg1.month.cur = arg1.month.cur + v0;
            arg1.month.nxt = arg1.month.nxt + v1;
            arg1.month.profit = arg1.month.profit + arg2;
        } else if (arg1.month.numb + 1 == arg4.month) {
            let v2 = &mut arg1.month;
            let v3 = &mut arg0.month;
            bonus_open(v2, v3);
            arg1.month.numb = arg4.month;
            arg1.month.cur = arg1.month.cur + v0;
            arg1.month.nxt = arg1.month.nxt + v1;
            arg1.month.profit = arg1.month.profit + arg2;
        } else {
            arg1.month.numb = arg4.month;
            arg1.month.cur = v0;
            arg1.month.nxt = v1;
            arg1.month.profit = arg2;
            arg1.month.open = 0;
        };
        let v4 = &mut arg0.month;
        bonus_pool_update(arg1.month.numb, v0, 0, v4);
        let v5 = &mut arg0.month;
        bonus_pool_update(arg1.month.numb + 1, v1, 0, v5);
    }

    fun update_quarter(arg0: &mut Lotto, arg1: &mut Account, arg2: u64, arg3: u64, arg4: &Time) {
        let v0 = arg3 * (100 + (arg4.quarter + 1) * 30 * 3 - arg4.day) / 100;
        let v1 = arg3 * (100 + (arg4.quarter + 1) * 30 * 3 - arg4.day + 30 * 3) / 100;
        if (arg1.quarter.numb == arg4.quarter) {
            arg1.quarter.cur = arg1.quarter.cur + v0;
            arg1.quarter.nxt = arg1.quarter.nxt + v1;
            arg1.quarter.profit = arg1.quarter.profit + arg2;
        } else if (arg1.quarter.numb + 1 == arg4.quarter) {
            let v2 = &mut arg1.quarter;
            let v3 = &mut arg0.quarter;
            bonus_open(v2, v3);
            arg1.quarter.numb = arg4.quarter;
            arg1.quarter.cur = arg1.quarter.cur + v0;
            arg1.quarter.nxt = arg1.quarter.nxt + v1;
            arg1.quarter.profit = arg1.quarter.profit + arg2;
        } else {
            arg1.quarter.numb = arg4.quarter;
            arg1.quarter.cur = v0;
            arg1.quarter.nxt = v1;
            arg1.quarter.profit = arg2;
            arg1.quarter.open = 0;
        };
        let v4 = &mut arg0.quarter;
        bonus_pool_update(arg1.quarter.numb, v0, 0, v4);
        let v5 = &mut arg0.quarter;
        bonus_pool_update(arg1.quarter.numb + 1, v1, 0, v5);
    }

    fun update_week(arg0: &mut Lotto, arg1: &mut Account, arg2: u64, arg3: u64, arg4: &Time) {
        let v0 = arg3 * (100 + (arg4.week + 1) * 7 - arg4.day) / 100;
        let v1 = arg3 * (100 + (arg4.week + 1) * 7 - arg4.day + 7) / 100;
        if (arg1.week.numb == arg4.week) {
            arg1.week.cur = arg1.week.cur + v0;
            arg1.week.nxt = arg1.week.nxt + v1;
            arg1.week.profit = arg1.week.profit + arg2;
        } else if (arg1.week.numb + 1 == arg4.week) {
            let v2 = &mut arg1.week;
            let v3 = &mut arg0.week;
            bonus_open(v2, v3);
            arg1.week.numb = arg4.week;
            arg1.week.cur = arg1.week.cur + v0;
            arg1.week.nxt = arg1.week.nxt + v1;
            arg1.week.profit = arg1.week.profit + arg2;
        } else {
            arg1.week.numb = arg4.week;
            arg1.week.cur = v0;
            arg1.week.nxt = v1;
            arg1.week.profit = arg2;
            arg1.week.open = 0;
        };
        let v4 = &mut arg0.week;
        bonus_pool_update(arg1.week.numb, v0, 0, v4);
        let v5 = &mut arg0.week;
        bonus_pool_update(arg1.week.numb + 1, v1, 0, v5);
    }

    fun update_year(arg0: &mut Lotto, arg1: &mut Account, arg2: u64, arg3: u64, arg4: &Time) {
        let v0 = arg3 * (100 + (arg4.year + 1) * 12 * 30 - arg4.day) / 100;
        let v1 = arg3 * (100 + (arg4.year + 1) * 12 * 30 - arg4.day + 12 * 30) / 100;
        if (arg1.year.numb == arg4.year) {
            arg1.year.cur = arg1.year.cur + v0;
            arg1.year.nxt = arg1.year.nxt + v1;
            arg1.year.profit = arg1.year.profit + arg2;
        } else if (arg1.year.numb + 1 == arg4.year) {
            let v2 = &mut arg1.year;
            let v3 = &mut arg0.year;
            bonus_open(v2, v3);
            arg1.year.numb = arg4.year;
            arg1.year.cur = arg1.year.cur + v0;
            arg1.year.nxt = arg1.year.nxt + v1;
            arg1.year.profit = arg1.year.profit + arg2;
        } else {
            arg1.year.numb = arg4.year;
            arg1.year.cur = v0;
            arg1.year.nxt = v1;
            arg1.year.profit = arg2;
            arg1.year.open = 0;
        };
        let v4 = &mut arg0.year;
        bonus_pool_update(arg1.year.numb, v0, 0, v4);
        let v5 = &mut arg0.year;
        bonus_pool_update(arg1.year.numb + 1, v1, 0, v5);
    }

    // decompiled from Move bytecode v6
}

