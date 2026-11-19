module 0xa5cfafe6660a8bf37eedf1a09dba633048da374c30b835668473689668f9ef57::voucher {
    struct LedgerKey has copy, drop, store {
        dummy_field: bool,
    }

    struct Ledger has store {
        accounts: 0x2::table::Table<0x2::object::ID, VoucherBalance>,
        orders: 0x2::table::Table<u64, bool>,
        positions: 0x2::table::Table<u64, bool>,
        paused: bool,
        grant_budget: u64,
    }

    struct VoucherBalance has copy, drop, store {
        available: u64,
        reserved: u64,
    }

    public(friend) fun balance(arg0: &0x2::object::UID, arg1: 0x2::object::ID) : (u64, u64) {
        let v0 = LedgerKey{dummy_field: false};
        if (!0x2::dynamic_field::exists<LedgerKey>(arg0, v0)) {
            return (0, 0)
        };
        let v1 = LedgerKey{dummy_field: false};
        let v2 = 0x2::dynamic_field::borrow<LedgerKey, Ledger>(arg0, v1);
        if (!0x2::table::contains<0x2::object::ID, VoucherBalance>(&v2.accounts, arg1)) {
            return (0, 0)
        };
        let v3 = 0x2::table::borrow<0x2::object::ID, VoucherBalance>(&v2.accounts, arg1);
        (v3.available, v3.reserved)
    }

    public(friend) fun cash_payout(arg0: bool, arg1: u64, arg2: u64) : u64 {
        if (!arg0) {
            arg1
        } else if (arg1 > arg2) {
            arg1 - arg2
        } else {
            0
        }
    }

    public(friend) fun fill(arg0: &mut 0x2::object::UID, arg1: 0x2::object::ID, arg2: u64, arg3: u64, arg4: u64, arg5: u64) : (u64, u64) {
        let v0 = LedgerKey{dummy_field: false};
        let v1 = 0x2::dynamic_field::borrow_mut<LedgerKey, Ledger>(arg0, v0);
        0x2::table::remove<u64, bool>(&mut v1.orders, arg2);
        0x2::table::add<u64, bool>(&mut v1.positions, arg3, true);
        let v2 = 0x2::table::borrow_mut<0x2::object::ID, VoucherBalance>(&mut v1.accounts, arg1);
        v2.reserved = v2.reserved - arg4;
        v2.available = v2.available + arg4 - arg5;
        (v2.available, v2.reserved)
    }

    public(friend) fun grant(arg0: &mut 0x2::object::UID, arg1: 0x2::object::ID, arg2: u64) : (u64, u64, u64) {
        assert!(arg2 > 0, 4);
        let v0 = LedgerKey{dummy_field: false};
        assert!(0x2::dynamic_field::exists<LedgerKey>(arg0, v0), 5);
        let v1 = LedgerKey{dummy_field: false};
        let v2 = 0x2::dynamic_field::borrow_mut<LedgerKey, Ledger>(arg0, v1);
        assert!(v2.grant_budget >= arg2, 5);
        v2.grant_budget = v2.grant_budget - arg2;
        if (!0x2::table::contains<0x2::object::ID, VoucherBalance>(&v2.accounts, arg1)) {
            let v3 = VoucherBalance{
                available : 0,
                reserved  : 0,
            };
            0x2::table::add<0x2::object::ID, VoucherBalance>(&mut v2.accounts, arg1, v3);
        };
        let v4 = 0x2::table::borrow_mut<0x2::object::ID, VoucherBalance>(&mut v2.accounts, arg1);
        v4.available = v4.available + arg2;
        (v4.available, v4.reserved, v2.grant_budget)
    }

    public(friend) fun grant_budget(arg0: &0x2::object::UID) : u64 {
        let v0 = LedgerKey{dummy_field: false};
        if (!0x2::dynamic_field::exists<LedgerKey>(arg0, v0)) {
            return 0
        };
        let v1 = LedgerKey{dummy_field: false};
        0x2::dynamic_field::borrow<LedgerKey, Ledger>(arg0, v1).grant_budget
    }

    public(friend) fun is_voucher_order(arg0: &0x2::object::UID, arg1: u64) : bool {
        let v0 = LedgerKey{dummy_field: false};
        if (!0x2::dynamic_field::exists<LedgerKey>(arg0, v0)) {
            return false
        };
        let v1 = LedgerKey{dummy_field: false};
        0x2::table::contains<u64, bool>(&0x2::dynamic_field::borrow<LedgerKey, Ledger>(arg0, v1).orders, arg1)
    }

    public(friend) fun is_voucher_position(arg0: &0x2::object::UID, arg1: u64) : bool {
        let v0 = LedgerKey{dummy_field: false};
        if (!0x2::dynamic_field::exists<LedgerKey>(arg0, v0)) {
            return false
        };
        let v1 = LedgerKey{dummy_field: false};
        0x2::table::contains<u64, bool>(&0x2::dynamic_field::borrow<LedgerKey, Ledger>(arg0, v1).positions, arg1)
    }

    fun ledger_mut(arg0: &mut 0x2::object::UID, arg1: &mut 0x2::tx_context::TxContext) : &mut Ledger {
        let v0 = LedgerKey{dummy_field: false};
        if (!0x2::dynamic_field::exists<LedgerKey>(arg0, v0)) {
            let v1 = LedgerKey{dummy_field: false};
            let v2 = Ledger{
                accounts     : 0x2::table::new<0x2::object::ID, VoucherBalance>(arg1),
                orders       : 0x2::table::new<u64, bool>(arg1),
                positions    : 0x2::table::new<u64, bool>(arg1),
                paused       : false,
                grant_budget : 0,
            };
            0x2::dynamic_field::add<LedgerKey, Ledger>(arg0, v1, v2);
        };
        let v3 = LedgerKey{dummy_field: false};
        0x2::dynamic_field::borrow_mut<LedgerKey, Ledger>(arg0, v3)
    }

    public(friend) fun paused(arg0: &0x2::object::UID) : bool {
        let v0 = LedgerKey{dummy_field: false};
        if (!0x2::dynamic_field::exists<LedgerKey>(arg0, v0)) {
            return false
        };
        let v1 = LedgerKey{dummy_field: false};
        0x2::dynamic_field::borrow<LedgerKey, Ledger>(arg0, v1).paused
    }

    public(friend) fun release(arg0: &mut 0x2::object::UID, arg1: 0x2::object::ID, arg2: u64, arg3: u64) : (u64, u64) {
        let v0 = LedgerKey{dummy_field: false};
        let v1 = 0x2::dynamic_field::borrow_mut<LedgerKey, Ledger>(arg0, v0);
        0x2::table::remove<u64, bool>(&mut v1.orders, arg2);
        let v2 = 0x2::table::borrow_mut<0x2::object::ID, VoucherBalance>(&mut v1.accounts, arg1);
        v2.reserved = v2.reserved - arg3;
        v2.available = v2.available + arg3;
        (v2.available, v2.reserved)
    }

    public(friend) fun remove_position(arg0: &mut 0x2::object::UID, arg1: u64) {
        let v0 = LedgerKey{dummy_field: false};
        if (0x2::dynamic_field::exists<LedgerKey>(arg0, v0)) {
            let v1 = LedgerKey{dummy_field: false};
            let v2 = 0x2::dynamic_field::borrow_mut<LedgerKey, Ledger>(arg0, v1);
            if (0x2::table::contains<u64, bool>(&v2.positions, arg1)) {
                0x2::table::remove<u64, bool>(&mut v2.positions, arg1);
            };
        };
    }

    public(friend) fun reserve(arg0: &mut 0x2::object::UID, arg1: 0x2::object::ID, arg2: u64, arg3: u64) : (u64, u64) {
        assert!(arg3 > 0, 4);
        let v0 = LedgerKey{dummy_field: false};
        assert!(0x2::dynamic_field::exists<LedgerKey>(arg0, v0), 1);
        let v1 = LedgerKey{dummy_field: false};
        let v2 = 0x2::dynamic_field::borrow_mut<LedgerKey, Ledger>(arg0, v1);
        assert!(!v2.paused, 3);
        assert!(0x2::table::contains<0x2::object::ID, VoucherBalance>(&v2.accounts, arg1), 1);
        0x2::table::add<u64, bool>(&mut v2.orders, arg2, true);
        let v3 = 0x2::table::borrow_mut<0x2::object::ID, VoucherBalance>(&mut v2.accounts, arg1);
        assert!(v3.available >= arg3, 1);
        v3.available = v3.available - arg3;
        v3.reserved = v3.reserved + arg3;
        (v3.available, v3.reserved)
    }

    public(friend) fun restore(arg0: &mut 0x2::object::UID, arg1: 0x2::object::ID, arg2: u64) : (u64, u64) {
        let v0 = LedgerKey{dummy_field: false};
        let v1 = 0x2::dynamic_field::borrow_mut<LedgerKey, Ledger>(arg0, v0);
        if (!0x2::table::contains<0x2::object::ID, VoucherBalance>(&v1.accounts, arg1)) {
            let v2 = VoucherBalance{
                available : 0,
                reserved  : 0,
            };
            0x2::table::add<0x2::object::ID, VoucherBalance>(&mut v1.accounts, arg1, v2);
        };
        let v3 = 0x2::table::borrow_mut<0x2::object::ID, VoucherBalance>(&mut v1.accounts, arg1);
        v3.available = v3.available + arg2;
        (v3.available, v3.reserved)
    }

    public(friend) fun revoke(arg0: &mut 0x2::object::UID, arg1: 0x2::object::ID, arg2: u64) : (u64, u64) {
        assert!(arg2 > 0, 4);
        let v0 = LedgerKey{dummy_field: false};
        assert!(0x2::dynamic_field::exists<LedgerKey>(arg0, v0), 1);
        let v1 = LedgerKey{dummy_field: false};
        let v2 = 0x2::dynamic_field::borrow_mut<LedgerKey, Ledger>(arg0, v1);
        assert!(0x2::table::contains<0x2::object::ID, VoucherBalance>(&v2.accounts, arg1), 1);
        let v3 = 0x2::table::borrow_mut<0x2::object::ID, VoucherBalance>(&mut v2.accounts, arg1);
        assert!(v3.available >= arg2, 1);
        v3.available = v3.available - arg2;
        (v3.available, v3.reserved)
    }

    public(friend) fun set_grant_budget(arg0: &mut 0x2::object::UID, arg1: u64, arg2: &mut 0x2::tx_context::TxContext) {
        ledger_mut(arg0, arg2).grant_budget = arg1;
    }

    public(friend) fun set_paused(arg0: &mut 0x2::object::UID, arg1: bool, arg2: &mut 0x2::tx_context::TxContext) {
        ledger_mut(arg0, arg2).paused = arg1;
    }

    public(friend) fun split_position(arg0: &mut 0x2::object::UID, arg1: u64) {
        let v0 = LedgerKey{dummy_field: false};
        0x2::table::add<u64, bool>(&mut 0x2::dynamic_field::borrow_mut<LedgerKey, Ledger>(arg0, v0).positions, arg1, true);
    }

    // decompiled from Move bytecode v7
}

