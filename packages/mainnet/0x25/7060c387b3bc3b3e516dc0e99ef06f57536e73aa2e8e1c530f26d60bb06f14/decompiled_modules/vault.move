module 0x257060c387b3bc3b3e516dc0e99ef06f57536e73aa2e8e1c530f26d60bb06f14::vault {
    struct Vault has key {
        id: 0x2::object::UID,
        creator: address,
        balance: 0x2::balance::Balance<0x2::sui::SUI>,
        total_shares: u64,
        deployed_amount: u64,
        paused: bool,
        performance_fee_bps: u64,
        high_water_mark: u64,
        accrued_fees: 0x2::balance::Balance<0x2::sui::SUI>,
        total_profit: u64,
        total_loss: u64,
        profit_events: u64,
    }

    struct DepositReceipt has store, key {
        id: 0x2::object::UID,
        vault_id: 0x2::object::ID,
        shares: u64,
        deposited_amount: u64,
    }

    struct DepositEvent has copy, drop {
        vault_id: 0x2::object::ID,
        depositor: address,
        amount: u64,
        shares_minted: u64,
        total_shares: u64,
    }

    struct WithdrawEvent has copy, drop {
        vault_id: 0x2::object::ID,
        withdrawer: address,
        amount: u64,
        shares_burned: u64,
        total_shares: u64,
    }

    struct PerformanceEvent has copy, drop {
        vault_id: 0x2::object::ID,
        profit: u64,
        fee_taken: u64,
        new_high_water_mark: u64,
        nav_per_share: u64,
    }

    struct FeeWithdrawnEvent has copy, drop {
        vault_id: 0x2::object::ID,
        amount: u64,
        recipient: address,
    }

    public fun create_vault(arg0: &mut 0x2::tx_context::TxContext) {
        let v0 = Vault{
            id                  : 0x2::object::new(arg0),
            creator             : 0x2::tx_context::sender(arg0),
            balance             : 0x2::balance::zero<0x2::sui::SUI>(),
            total_shares        : 0,
            deployed_amount     : 0,
            paused              : false,
            performance_fee_bps : 1000,
            high_water_mark     : 1000000000,
            accrued_fees        : 0x2::balance::zero<0x2::sui::SUI>(),
            total_profit        : 0,
            total_loss          : 0,
            profit_events       : 0,
        };
        0x2::transfer::share_object<Vault>(v0);
    }

    public fun create_vault_with_fee(arg0: u64, arg1: &mut 0x2::tx_context::TxContext) {
        assert!(arg0 <= 5000, 5);
        let v0 = Vault{
            id                  : 0x2::object::new(arg1),
            creator             : 0x2::tx_context::sender(arg1),
            balance             : 0x2::balance::zero<0x2::sui::SUI>(),
            total_shares        : 0,
            deployed_amount     : 0,
            paused              : false,
            performance_fee_bps : arg0,
            high_water_mark     : 1000000000,
            accrued_fees        : 0x2::balance::zero<0x2::sui::SUI>(),
            total_profit        : 0,
            total_loss          : 0,
            profit_events       : 0,
        };
        0x2::transfer::share_object<Vault>(v0);
    }

    public fun deposit(arg0: &mut Vault, arg1: 0x2::coin::Coin<0x2::sui::SUI>, arg2: &mut 0x2::tx_context::TxContext) {
        assert!(!arg0.paused, 2);
        let v0 = 0x2::coin::value<0x2::sui::SUI>(&arg1);
        assert!(v0 > 0, 0);
        let v1 = 0x2::balance::value<0x2::sui::SUI>(&arg0.balance) + arg0.deployed_amount;
        let v2 = if (arg0.total_shares == 0 || v1 == 0) {
            v0
        } else {
            (((v0 as u128) * (arg0.total_shares as u128) / (v1 as u128)) as u64)
        };
        0x2::balance::join<0x2::sui::SUI>(&mut arg0.balance, 0x2::coin::into_balance<0x2::sui::SUI>(arg1));
        arg0.total_shares = arg0.total_shares + v2;
        let v3 = 0x2::object::id<Vault>(arg0);
        let v4 = DepositReceipt{
            id               : 0x2::object::new(arg2),
            vault_id         : v3,
            shares           : v2,
            deposited_amount : v0,
        };
        0x2::transfer::transfer<DepositReceipt>(v4, 0x2::tx_context::sender(arg2));
        let v5 = DepositEvent{
            vault_id      : v3,
            depositor     : 0x2::tx_context::sender(arg2),
            amount        : v0,
            shares_minted : v2,
            total_shares  : arg0.total_shares,
        };
        0x2::event::emit<DepositEvent>(v5);
    }

    public fun emergency_withdraw(arg0: &mut Vault, arg1: DepositReceipt, arg2: &mut 0x2::tx_context::TxContext) {
        let v0 = arg1.shares;
        assert!(v0 > 0, 3);
        let v1 = (((v0 as u128) * ((0x2::balance::value<0x2::sui::SUI>(&arg0.balance) + arg0.deployed_amount) as u128) / (arg0.total_shares as u128)) as u64);
        let v2 = 0x2::balance::value<0x2::sui::SUI>(&arg0.balance);
        let v3 = if (v1 > v2) {
            v2
        } else {
            v1
        };
        arg0.total_shares = arg0.total_shares - v0;
        let DepositReceipt {
            id               : v4,
            vault_id         : _,
            shares           : _,
            deposited_amount : _,
        } = arg1;
        0x2::object::delete(v4);
        0x2::transfer::public_transfer<0x2::coin::Coin<0x2::sui::SUI>>(0x2::coin::from_balance<0x2::sui::SUI>(0x2::balance::split<0x2::sui::SUI>(&mut arg0.balance, v3), arg2), 0x2::tx_context::sender(arg2));
        let v8 = WithdrawEvent{
            vault_id      : 0x2::object::id<Vault>(arg0),
            withdrawer    : 0x2::tx_context::sender(arg2),
            amount        : v3,
            shares_burned : v0,
            total_shares  : arg0.total_shares,
        };
        0x2::event::emit<WithdrawEvent>(v8);
    }

    public fun receipt_shares(arg0: &DepositReceipt) : u64 {
        arg0.shares
    }

    public fun receipt_vault_id(arg0: &DepositReceipt) : 0x2::object::ID {
        arg0.vault_id
    }

    public(friend) fun return_from_deployment(arg0: &mut Vault, arg1: 0x2::balance::Balance<0x2::sui::SUI>) {
        let v0 = 0x2::balance::value<0x2::sui::SUI>(&arg1);
        if (v0 > arg0.deployed_amount) {
            let v1 = v0 - arg0.deployed_amount;
            arg0.total_profit = arg0.total_profit + v1;
            arg0.profit_events = arg0.profit_events + 1;
            let v2 = (((v1 as u128) * (arg0.performance_fee_bps as u128) / (10000 as u128)) as u64);
            if (v2 > 0 && v2 < v0) {
                0x2::balance::join<0x2::sui::SUI>(&mut arg0.accrued_fees, 0x2::balance::split<0x2::sui::SUI>(&mut arg1, v2));
            };
            if (arg0.total_shares > 0) {
                let v3 = ((((0x2::balance::value<0x2::sui::SUI>(&arg0.balance) + 0x2::balance::value<0x2::sui::SUI>(&arg1)) as u128) * 1000000000 / (arg0.total_shares as u128)) as u64);
                if (v3 > arg0.high_water_mark) {
                    arg0.high_water_mark = v3;
                };
                let v4 = PerformanceEvent{
                    vault_id            : 0x2::object::id<Vault>(arg0),
                    profit              : v1,
                    fee_taken           : v2,
                    new_high_water_mark : arg0.high_water_mark,
                    nav_per_share       : v3,
                };
                0x2::event::emit<PerformanceEvent>(v4);
            };
            arg0.deployed_amount = 0;
        } else if (v0 < arg0.deployed_amount) {
            arg0.total_loss = arg0.total_loss + arg0.deployed_amount - v0;
            arg0.deployed_amount = arg0.deployed_amount - v0;
        } else {
            arg0.deployed_amount = arg0.deployed_amount - v0;
        };
        0x2::balance::join<0x2::sui::SUI>(&mut arg0.balance, arg1);
    }

    public(friend) fun set_paused(arg0: &mut Vault, arg1: bool) {
        arg0.paused = arg1;
    }

    public(friend) fun set_performance_fee(arg0: &mut Vault, arg1: u64) {
        assert!(arg1 <= 5000, 5);
        arg0.performance_fee_bps = arg1;
    }

    public fun vault_accrued_fees(arg0: &Vault) : u64 {
        0x2::balance::value<0x2::sui::SUI>(&arg0.accrued_fees)
    }

    public fun vault_balance(arg0: &Vault) : u64 {
        0x2::balance::value<0x2::sui::SUI>(&arg0.balance)
    }

    public fun vault_creator(arg0: &Vault) : address {
        arg0.creator
    }

    public fun vault_deployed_amount(arg0: &Vault) : u64 {
        arg0.deployed_amount
    }

    public fun vault_high_water_mark(arg0: &Vault) : u64 {
        arg0.high_water_mark
    }

    public fun vault_nav_per_share(arg0: &Vault) : u64 {
        if (arg0.total_shares == 0) {
            1000000000
        } else {
            ((((0x2::balance::value<0x2::sui::SUI>(&arg0.balance) + arg0.deployed_amount) as u128) * 1000000000 / (arg0.total_shares as u128)) as u64)
        }
    }

    public fun vault_paused(arg0: &Vault) : bool {
        arg0.paused
    }

    public fun vault_performance_fee_bps(arg0: &Vault) : u64 {
        arg0.performance_fee_bps
    }

    public fun vault_total_loss(arg0: &Vault) : u64 {
        arg0.total_loss
    }

    public fun vault_total_profit(arg0: &Vault) : u64 {
        arg0.total_profit
    }

    public fun vault_total_shares(arg0: &Vault) : u64 {
        arg0.total_shares
    }

    public fun vault_total_value(arg0: &Vault) : u64 {
        0x2::balance::value<0x2::sui::SUI>(&arg0.balance) + arg0.deployed_amount
    }

    public fun withdraw(arg0: &mut Vault, arg1: DepositReceipt, arg2: u64, arg3: &mut 0x2::tx_context::TxContext) {
        assert!(!arg0.paused, 2);
        assert!(arg2 > 0, 3);
        assert!(arg2 <= arg1.shares, 1);
        let v0 = (((arg2 as u128) * ((0x2::balance::value<0x2::sui::SUI>(&arg0.balance) + arg0.deployed_amount) as u128) / (arg0.total_shares as u128)) as u64);
        assert!(v0 <= 0x2::balance::value<0x2::sui::SUI>(&arg0.balance), 4);
        arg0.total_shares = arg0.total_shares - arg2;
        let v1 = 0x2::object::id<Vault>(arg0);
        let DepositReceipt {
            id               : v2,
            vault_id         : _,
            shares           : v4,
            deposited_amount : _,
        } = arg1;
        if (arg2 < v4) {
            let v6 = DepositReceipt{
                id               : 0x2::object::new(arg3),
                vault_id         : v1,
                shares           : v4 - arg2,
                deposited_amount : 0,
            };
            0x2::transfer::transfer<DepositReceipt>(v6, 0x2::tx_context::sender(arg3));
        };
        0x2::object::delete(v2);
        0x2::transfer::public_transfer<0x2::coin::Coin<0x2::sui::SUI>>(0x2::coin::from_balance<0x2::sui::SUI>(0x2::balance::split<0x2::sui::SUI>(&mut arg0.balance, v0), arg3), 0x2::tx_context::sender(arg3));
        let v7 = WithdrawEvent{
            vault_id      : v1,
            withdrawer    : 0x2::tx_context::sender(arg3),
            amount        : v0,
            shares_burned : arg2,
            total_shares  : arg0.total_shares,
        };
        0x2::event::emit<WithdrawEvent>(v7);
    }

    public(friend) fun withdraw_fees(arg0: &mut Vault, arg1: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<0x2::sui::SUI> {
        let v0 = 0x2::balance::withdraw_all<0x2::sui::SUI>(&mut arg0.accrued_fees);
        let v1 = FeeWithdrawnEvent{
            vault_id  : 0x2::object::id<Vault>(arg0),
            amount    : 0x2::balance::value<0x2::sui::SUI>(&v0),
            recipient : 0x2::tx_context::sender(arg1),
        };
        0x2::event::emit<FeeWithdrawnEvent>(v1);
        0x2::coin::from_balance<0x2::sui::SUI>(v0, arg1)
    }

    public(friend) fun withdraw_for_deployment(arg0: &mut Vault, arg1: u64) : 0x2::balance::Balance<0x2::sui::SUI> {
        arg0.deployed_amount = arg0.deployed_amount + arg1;
        0x2::balance::split<0x2::sui::SUI>(&mut arg0.balance, arg1)
    }

    // decompiled from Move bytecode v6
}

