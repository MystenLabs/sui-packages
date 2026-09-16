module 0xaedb8c9a905a778e831aeb4928f660210a7a645925348a7c4ec1cb4a6a3fd16e::conviction {
    struct Ledger has store {
        book: 0xaedb8c9a905a778e831aeb4928f660210a7a645925348a7c4ec1cb4a6a3fd16e::weight_book::Book,
        marks: 0x2::table::Table<u64, Mark>,
        marked_day: u64,
        s0: u256,
        s1: u256,
    }

    struct Mark has copy, drop, store {
        s0: u256,
        s1: u256,
    }

    struct Account has copy, drop, store {
        settled_day: u64,
        scaled: u256,
    }

    public(friend) fun new(arg0: u64, arg1: &mut 0x2::tx_context::TxContext) : Ledger {
        Ledger{
            book       : 0xaedb8c9a905a778e831aeb4928f660210a7a645925348a7c4ec1cb4a6a3fd16e::weight_book::new(arg0, arg1),
            marks      : 0x2::table::new<u64, Mark>(arg1),
            marked_day : 0,
            s0         : 0,
            s1         : 0,
        }
    }

    fun at(arg0: &Ledger, arg1: u64) : (u256, u256) {
        if (arg0.marked_day == 0) {
            return (0, 0)
        };
        if (arg1 >= arg0.marked_day) {
            return (arg0.s0, arg0.s1)
        };
        if (0x2::table::contains<u64, Mark>(&arg0.marks, arg1)) {
            let v2 = 0x2::table::borrow<u64, Mark>(&arg0.marks, arg1);
            (v2.s0, v2.s1)
        } else {
            (0, 0)
        }
    }

    public(friend) fun catch_up(arg0: &mut Ledger, arg1: u64) {
        let v0 = 0;
        while (!0xaedb8c9a905a778e831aeb4928f660210a7a645925348a7c4ec1cb4a6a3fd16e::weight_book::advance(&mut arg0.book, arg1)) {
            let v1 = v0 + 1;
            v0 = v1;
            assert!(v1 < 64, 1);
        };
    }

    public fun claimable(arg0: &Ledger, arg1: &Account, arg2: &vector<0xaedb8c9a905a778e831aeb4928f660210a7a645925348a7c4ec1cb4a6a3fd16e::position::Lot>, arg3: &0xaedb8c9a905a778e831aeb4928f660210a7a645925348a7c4ec1cb4a6a3fd16e::locks::Lock) : u64 {
        let v0 = *arg1;
        let v1 = &mut v0;
        settle(arg0, v1, arg2, arg3);
        ((v0.scaled / 1000000000000000000000000) as u64)
    }

    public fun day_of(arg0: u64) : u64 {
        arg0 / 86400000
    }

    public(friend) fun empty_account() : Account {
        Account{
            settled_day : 0,
            scaled      : 0,
        }
    }

    public(friend) fun forfeit_half(arg0: &mut Account) : (u64, u64, u64) {
        0xaedb8c9a905a778e831aeb4928f660210a7a645925348a7c4ec1cb4a6a3fd16e::dividends::ragequit_forfeit(take(arg0))
    }

    public(friend) fun fund(arg0: &mut Ledger, arg1: u64, arg2: u64) : u64 {
        let v0 = day_of(arg2);
        catch_up(arg0, arg2);
        assert!(0xaedb8c9a905a778e831aeb4928f660210a7a645925348a7c4ec1cb4a6a3fd16e::weight_book::day(&arg0.book) == v0, 2);
        if (arg0.marked_day > 0) {
            assert!(v0 >= arg0.marked_day && v0 - arg0.marked_day <= 3660, 1);
            let v1 = arg0.marked_day + 1;
            while (v1 < v0) {
                let v2 = Mark{
                    s0 : arg0.s0,
                    s1 : arg0.s1,
                };
                0x2::table::add<u64, Mark>(&mut arg0.marks, v1, v2);
                v1 = v1 + 1;
            };
        };
        let v3 = 0xaedb8c9a905a778e831aeb4928f660210a7a645925348a7c4ec1cb4a6a3fd16e::weight_book::total(&arg0.book);
        if (v3 == 0 || arg1 == 0) {
            mark(arg0, v0);
            return 0
        };
        let v4 = (arg1 as u256) * 1000000000000000000000000 / v3;
        arg0.s0 = arg0.s0 + v4;
        arg0.s1 = arg0.s1 + (v0 as u256) * v4;
        mark(arg0, v0);
        arg1
    }

    public(friend) fun insert_position(arg0: &mut Ledger, arg1: &vector<0xaedb8c9a905a778e831aeb4928f660210a7a645925348a7c4ec1cb4a6a3fd16e::position::Lot>, arg2: &0xaedb8c9a905a778e831aeb4928f660210a7a645925348a7c4ec1cb4a6a3fd16e::locks::Lock, arg3: u64) {
        catch_up(arg0, arg3);
        let v0 = 0;
        while (v0 < 0x1::vector::length<0xaedb8c9a905a778e831aeb4928f660210a7a645925348a7c4ec1cb4a6a3fd16e::position::Lot>(arg1)) {
            let v1 = 0x1::vector::borrow<0xaedb8c9a905a778e831aeb4928f660210a7a645925348a7c4ec1cb4a6a3fd16e::position::Lot>(arg1, v0);
            0xaedb8c9a905a778e831aeb4928f660210a7a645925348a7c4ec1cb4a6a3fd16e::weight_book::insert_lot(&mut arg0.book, 0xaedb8c9a905a778e831aeb4928f660210a7a645925348a7c4ec1cb4a6a3fd16e::position::lot_amount(v1), 0xaedb8c9a905a778e831aeb4928f660210a7a645925348a7c4ec1cb4a6a3fd16e::position::lot_entry(v1), 0xaedb8c9a905a778e831aeb4928f660210a7a645925348a7c4ec1cb4a6a3fd16e::locks::unlock_ms(arg2), 0xaedb8c9a905a778e831aeb4928f660210a7a645925348a7c4ec1cb4a6a3fd16e::locks::multiplier_bps(arg2), arg3);
            v0 = v0 + 1;
        };
    }

    fun mark(arg0: &mut Ledger, arg1: u64) {
        if (0x2::table::contains<u64, Mark>(&arg0.marks, arg1)) {
            0x2::table::remove<u64, Mark>(&mut arg0.marks, arg1);
        };
        let v0 = Mark{
            s0 : arg0.s0,
            s1 : arg0.s1,
        };
        0x2::table::add<u64, Mark>(&mut arg0.marks, arg1, v0);
        if (arg1 > arg0.marked_day) {
            arg0.marked_day = arg1;
        };
    }

    public fun marked_day(arg0: &Ledger) : u64 {
        arg0.marked_day
    }

    public(friend) fun merge(arg0: &mut Account, arg1: Account) {
        assert!(arg0.settled_day == arg1.settled_day, 2);
        arg0.scaled = arg0.scaled + arg1.scaled;
    }

    public(friend) fun open(arg0: &Ledger) : Account {
        Account{
            settled_day : arg0.marked_day,
            scaled      : 0,
        }
    }

    public fun payable(arg0: &Account) : u64 {
        ((arg0.scaled / 1000000000000000000000000) as u64)
    }

    fun ramp(arg0: &Ledger, arg1: u256, arg2: u64, arg3: u64, arg4: u64) : u256 {
        if (arg1 == 0 || arg4 <= arg3) {
            return 0
        };
        let v0 = 0x1::u64::max(arg3, arg2);
        if (arg4 <= v0) {
            return 0
        };
        let v1 = arg2 + 30;
        let v2 = 0;
        let v3 = v2;
        let v4 = 0x1::u64::min(arg4, v1);
        if (v4 > v0) {
            let (v5, v6) = at(arg0, v0);
            let (v7, v8) = at(arg0, v4);
            v3 = v2 + v8 - v6 - (arg2 as u256) * (v7 - v5);
        };
        let v9 = 0x1::u64::max(v0, v1);
        if (arg4 > v9) {
            let (v10, _) = at(arg0, v9);
            let (v12, _) = at(arg0, arg4);
            v3 = v3 + 30 * (v12 - v10);
        };
        v3 * arg1
    }

    public(friend) fun remove_position(arg0: &mut Ledger, arg1: &vector<0xaedb8c9a905a778e831aeb4928f660210a7a645925348a7c4ec1cb4a6a3fd16e::position::Lot>, arg2: &0xaedb8c9a905a778e831aeb4928f660210a7a645925348a7c4ec1cb4a6a3fd16e::locks::Lock, arg3: u64) {
        catch_up(arg0, arg3);
        let v0 = 0;
        while (v0 < 0x1::vector::length<0xaedb8c9a905a778e831aeb4928f660210a7a645925348a7c4ec1cb4a6a3fd16e::position::Lot>(arg1)) {
            let v1 = 0x1::vector::borrow<0xaedb8c9a905a778e831aeb4928f660210a7a645925348a7c4ec1cb4a6a3fd16e::position::Lot>(arg1, v0);
            0xaedb8c9a905a778e831aeb4928f660210a7a645925348a7c4ec1cb4a6a3fd16e::weight_book::remove_lot(&mut arg0.book, 0xaedb8c9a905a778e831aeb4928f660210a7a645925348a7c4ec1cb4a6a3fd16e::position::lot_amount(v1), 0xaedb8c9a905a778e831aeb4928f660210a7a645925348a7c4ec1cb4a6a3fd16e::position::lot_entry(v1), 0xaedb8c9a905a778e831aeb4928f660210a7a645925348a7c4ec1cb4a6a3fd16e::locks::unlock_ms(arg2), 0xaedb8c9a905a778e831aeb4928f660210a7a645925348a7c4ec1cb4a6a3fd16e::locks::multiplier_bps(arg2), arg3);
            v0 = v0 + 1;
        };
    }

    public fun scale() : u256 {
        1000000000000000000000000
    }

    public fun scaled(arg0: &Account) : u256 {
        arg0.scaled
    }

    public(friend) fun settle(arg0: &Ledger, arg1: &mut Account, arg2: &vector<0xaedb8c9a905a778e831aeb4928f660210a7a645925348a7c4ec1cb4a6a3fd16e::position::Lot>, arg3: &0xaedb8c9a905a778e831aeb4928f660210a7a645925348a7c4ec1cb4a6a3fd16e::locks::Lock) {
        let v0 = arg0.marked_day;
        if (v0 <= arg1.settled_day) {
            return
        };
        let v1 = 0xaedb8c9a905a778e831aeb4928f660210a7a645925348a7c4ec1cb4a6a3fd16e::locks::multiplier_bps(arg3);
        let v2 = 0xaedb8c9a905a778e831aeb4928f660210a7a645925348a7c4ec1cb4a6a3fd16e::weight_book::ceil_day(0xaedb8c9a905a778e831aeb4928f660210a7a645925348a7c4ec1cb4a6a3fd16e::locks::unlock_ms(arg3));
        let v3 = arg1.settled_day;
        let v4 = 0;
        let v5 = 0;
        while (v5 < 0x1::vector::length<0xaedb8c9a905a778e831aeb4928f660210a7a645925348a7c4ec1cb4a6a3fd16e::position::Lot>(arg2)) {
            let v6 = 0x1::vector::borrow<0xaedb8c9a905a778e831aeb4928f660210a7a645925348a7c4ec1cb4a6a3fd16e::position::Lot>(arg2, v5);
            let v7 = (0xaedb8c9a905a778e831aeb4928f660210a7a645925348a7c4ec1cb4a6a3fd16e::position::lot_amount(v6) as u256);
            let v8 = 0xaedb8c9a905a778e831aeb4928f660210a7a645925348a7c4ec1cb4a6a3fd16e::weight_book::ceil_day(0xaedb8c9a905a778e831aeb4928f660210a7a645925348a7c4ec1cb4a6a3fd16e::position::lot_entry(v6));
            let v9 = v4 + ramp(arg0, v7 * 10000, v8, v3, v0);
            v4 = v9;
            if (v1 > 10000 && v2 > 0) {
                v4 = v9 + ramp(arg0, v7 * ((v1 - 10000) as u256), v8, v3, 0x1::u64::min(v0, v2 - 1));
            };
            v5 = v5 + 1;
        };
        arg1.scaled = arg1.scaled + v4;
        arg1.settled_day = v0;
    }

    public fun settled_day(arg0: &Account) : u64 {
        arg0.settled_day
    }

    public(friend) fun split(arg0: &mut Account, arg1: u64, arg2: u64) : Account {
        assert!(arg2 > 0 && arg1 <= arg2, 2);
        let v0 = arg0.scaled * (arg1 as u256) / (arg2 as u256);
        arg0.scaled = arg0.scaled - v0;
        Account{
            settled_day : arg0.settled_day,
            scaled      : v0,
        }
    }

    public(friend) fun take(arg0: &mut Account) : u64 {
        let v0 = arg0.scaled / 1000000000000000000000000;
        arg0.scaled = arg0.scaled - v0 * 1000000000000000000000000;
        (v0 as u64)
    }

    public fun total_weight(arg0: &Ledger) : u256 {
        0xaedb8c9a905a778e831aeb4928f660210a7a645925348a7c4ec1cb4a6a3fd16e::weight_book::total(&arg0.book)
    }

    // decompiled from Move bytecode v7
}

