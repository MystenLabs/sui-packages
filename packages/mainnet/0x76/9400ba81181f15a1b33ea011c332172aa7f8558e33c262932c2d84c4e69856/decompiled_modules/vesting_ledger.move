module 0x1ef4c0b20340b8c6a59438204467ca71e1e7cbe918526f9c2c6c5444517cd5ca::vesting_ledger {
    struct AccountEntry has store {
        epoch: u64,
        balance: u64,
    }

    struct Account<phantom T0> has store, key {
        id: 0x2::object::UID,
        instant_balance: u64,
        total: 0x2::balance::Balance<T0>,
        entries: vector<AccountEntry>,
    }

    struct VestingLedger<phantom T0> has store, key {
        id: 0x2::object::UID,
        period: u64,
        initial_penalty: u64,
        accounts: 0x2::object_table::ObjectTable<address, Account<T0>>,
    }

    public(friend) fun available_balance<T0>(arg0: &VestingLedger<T0>, arg1: address, arg2: u64) : u64 {
        if (!0x2::object_table::contains<address, Account<T0>>(&arg0.accounts, arg1)) {
            return 0
        };
        let v0 = 0x2::object_table::borrow<address, Account<T0>>(&arg0.accounts, arg1);
        let v1 = v0.instant_balance;
        let v2 = 0;
        while (v2 < 0x1::vector::length<AccountEntry>(&v0.entries)) {
            v1 = v1 + claimable(0x1::vector::borrow<AccountEntry>(&v0.entries, v2), arg0.initial_penalty, arg2, arg0.period);
            v2 = v2 + 1;
        };
        v1
    }

    public(friend) fun claim<T0>(arg0: &mut VestingLedger<T0>, arg1: address, arg2: u64, arg3: u64, arg4: &mut 0x2::tx_context::TxContext) : (0x2::coin::Coin<T0>, 0x2::coin::Coin<T0>) {
        assert!(arg2 > 0, 1);
        let v0 = 0x2::object_table::borrow_mut<address, Account<T0>>(&mut arg0.accounts, arg1);
        let v1 = 0x2::coin::take<T0>(&mut v0.total, arg2, arg4);
        let v2 = if (arg2 <= v0.instant_balance) {
            arg2
        } else {
            v0.instant_balance
        };
        v0.instant_balance = v0.instant_balance - v2;
        arg2 = arg2 - v2;
        let v3 = 0;
        let v4 = 0;
        while (v3 < 0x1::vector::length<AccountEntry>(&v0.entries) && arg2 > 0) {
            let v5 = 0x1::vector::borrow_mut<AccountEntry>(&mut v0.entries, v3);
            let (v6, v7) = claim_entry(v5, arg2, arg0.initial_penalty, arg3, arg0.period);
            v4 = v4 + v7;
            arg2 = arg2 - v6;
            v3 = v3 + 1;
        };
        (v1, 0x2::coin::take<T0>(&mut v0.total, v4, arg4))
    }

    public(friend) fun claim_entry(arg0: &mut AccountEntry, arg1: u64, arg2: u64, arg3: u64, arg4: u64) : (u64, u64) {
        assert!(arg0.balance <= 3000000000000000000, 31337);
        assert!(arg2 <= 10000000000, 31337);
        let v0 = 0x1::u64::min(arg3 - arg0.epoch, arg4);
        assert!(v0 <= 1800, 31337);
        assert!(arg4 <= 1800, 31337);
        let v1 = 0x1::u64::min(arg1, claimable(arg0, arg2, arg3, arg4));
        let v2 = 10000000000 * (arg4 as u128);
        let v3 = (((v1 as u128) * v2) as u128) / (v2 - (arg2 as u128) * ((arg4 as u128) - (v0 as u128))) - (v1 as u128);
        arg0.balance = arg0.balance - v1 - (v3 as u64);
        (v1, (v3 as u64))
    }

    public(friend) fun claimable(arg0: &AccountEntry, arg1: u64, arg2: u64, arg3: u64) : u64 {
        let v0 = 10000000000 * (arg3 as u128);
        let v1 = (arg1 as u128) * ((arg3 as u128) - (0x1::u64::min(arg2 - arg0.epoch, arg3) as u128));
        assert!(v1 <= v0, 31337);
        (((arg0.balance as u128) * (v0 - v1) / v0) as u64)
    }

    public(friend) fun create<T0>(arg0: u64, arg1: u64, arg2: &mut 0x2::tx_context::TxContext) : VestingLedger<T0> {
        VestingLedger<T0>{
            id              : 0x2::object::new(arg2),
            period          : arg0,
            initial_penalty : arg1,
            accounts        : 0x2::object_table::new<address, Account<T0>>(arg2),
        }
    }

    public(friend) fun lock<T0>(arg0: &mut VestingLedger<T0>, arg1: address, arg2: 0x2::coin::Coin<T0>, arg3: u64, arg4: &mut 0x2::tx_context::TxContext) {
        let v0 = arg0.period;
        let v1 = user_mut<T0>(arg0, arg1, arg4);
        0x2::coin::put<T0>(&mut v1.total, arg2);
        prune_epochs<T0>(v1, arg3, v0);
        let v2 = 0x1::vector::length<AccountEntry>(&v1.entries);
        if (v2 > 0) {
            let v3 = 0x1::vector::borrow_mut<AccountEntry>(&mut v1.entries, v2 - 1);
            if (v3.epoch == arg3) {
                v3.balance = v3.balance + 0x2::coin::value<T0>(&arg2);
                return
            };
        };
        let v4 = AccountEntry{
            epoch   : arg3,
            balance : 0x2::coin::value<T0>(&arg2),
        };
        0x1::vector::push_back<AccountEntry>(&mut v1.entries, v4);
    }

    fun prune_epochs<T0>(arg0: &mut Account<T0>, arg1: u64, arg2: u64) {
        let v0 = 0;
        let v1 = 0;
        let v2 = 0x1::vector::length<AccountEntry>(&arg0.entries);
        while (v1 < v2) {
            let v3 = 0x1::vector::borrow<AccountEntry>(&arg0.entries, v1);
            if (v3.balance > 0 && arg1 < v3.epoch + arg2) {
                if (v1 != v0) {
                    0x1::vector::swap<AccountEntry>(&mut arg0.entries, v1, v0);
                };
                v0 = v0 + 1;
            };
            v1 = v1 + 1;
        };
        let v4 = v2 - v0;
        while (v4 > 0) {
            let AccountEntry {
                epoch   : _,
                balance : v6,
            } = 0x1::vector::pop_back<AccountEntry>(&mut arg0.entries);
            arg0.instant_balance = arg0.instant_balance + v6;
            v4 = v4 - 1;
        };
    }

    public(friend) fun set_initial_penalty<T0>(arg0: &mut VestingLedger<T0>, arg1: u64) {
        arg0.initial_penalty = arg1;
    }

    public(friend) fun set_vesting_period<T0>(arg0: &mut VestingLedger<T0>, arg1: u64) {
        arg0.period = arg1;
    }

    fun user_mut<T0>(arg0: &mut VestingLedger<T0>, arg1: address, arg2: &mut 0x2::tx_context::TxContext) : &mut Account<T0> {
        if (!0x2::object_table::contains<address, Account<T0>>(&arg0.accounts, arg1)) {
            let v0 = Account<T0>{
                id              : 0x2::object::new(arg2),
                instant_balance : 0,
                total           : 0x2::balance::zero<T0>(),
                entries         : 0x1::vector::empty<AccountEntry>(),
            };
            0x2::object_table::add<address, Account<T0>>(&mut arg0.accounts, arg1, v0);
        };
        0x2::object_table::borrow_mut<address, Account<T0>>(&mut arg0.accounts, arg1)
    }

    // decompiled from Move bytecode v6
}

