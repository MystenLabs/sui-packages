module 0xb32983029b154a03c73c639b21bb767927a9d040f605f478f058925704786fdf::treasury_vault {
    struct TreasuryVault<phantom T0> has key {
        id: 0x2::object::UID,
        owner: address,
        account_id: 0x2::object::ID,
        available_balance: 0x2::balance::Balance<T0>,
        locked_balance: 0x2::balance::Balance<T0>,
        rake_balance: 0x2::balance::Balance<T0>,
    }

    struct VaultOpened has copy, drop {
        vault_id: 0x2::object::ID,
        owner: address,
        account_id: 0x2::object::ID,
    }

    struct Deposited has copy, drop {
        vault_id: 0x2::object::ID,
        owner: address,
        amount: u64,
        new_available: u64,
    }

    struct Withdrawn has copy, drop {
        vault_id: 0x2::object::ID,
        owner: address,
        amount: u64,
        new_available: u64,
    }

    struct FundsLocked has copy, drop {
        vault_id: 0x2::object::ID,
        table_id: 0x2::object::ID,
        amount: u64,
        new_available: u64,
        new_locked: u64,
    }

    struct FundsUnlocked has copy, drop {
        vault_id: 0x2::object::ID,
        table_id: 0x2::object::ID,
        amount: u64,
        new_available: u64,
        new_locked: u64,
    }

    struct RakeAccrued has copy, drop {
        vault_id: 0x2::object::ID,
        amount: u64,
        new_rake: u64,
    }

    struct RakeSwept has copy, drop {
        vault_id: 0x2::object::ID,
        amount: u64,
        new_rake: u64,
    }

    struct WithdrawalLedger<phantom T0> has store, key {
        id: 0x2::object::UID,
        owner: address,
        vault_id: 0x2::object::ID,
        total_deposited: u64,
        total_withdrawn_requested: u64,
        profit_fee_basis_charged: u64,
        total_fee_paid: u64,
    }

    struct WithdrawalLedgerOpened has copy, drop {
        ledger_id: 0x2::object::ID,
        owner: address,
        vault_id: 0x2::object::ID,
        coin_type: 0x1::type_name::TypeName,
    }

    struct VaultWithdrawn has copy, drop {
        vault_id: 0x2::object::ID,
        ledger_id: 0x2::object::ID,
        owner: address,
        coin_type: 0x1::type_name::TypeName,
        requested_amount: u64,
        principal_portion: u64,
        profit_fee_basis: u64,
        profit_fee_amount: u64,
        net_payout: u64,
        total_deposited: u64,
        total_withdrawn_requested_after: u64,
        profit_fee_basis_charged_after: u64,
        fee_bps_at_charge: u64,
    }

    struct ProfitWithdrawalFeeCharged has copy, drop {
        vault_id: 0x2::object::ID,
        fee_vault_id: 0x2::object::ID,
        owner: address,
        coin_type: 0x1::type_name::TypeName,
        profit_fee_basis: u64,
        profit_fee_amount: u64,
        fee_bps_at_charge: u64,
    }

    public fun owner<T0>(arg0: &TreasuryVault<T0>) : address {
        arg0.owner
    }

    public fun account_id<T0>(arg0: &TreasuryVault<T0>) : 0x2::object::ID {
        arg0.account_id
    }

    public(friend) fun accrue_rake<T0>(arg0: &mut TreasuryVault<T0>, arg1: 0x2::balance::Balance<T0>) {
        0x2::balance::join<T0>(&mut arg0.rake_balance, arg1);
        let v0 = RakeAccrued{
            vault_id : 0x2::object::id<TreasuryVault<T0>>(arg0),
            amount   : 0x2::balance::value<T0>(&arg1),
            new_rake : 0x2::balance::value<T0>(&arg0.rake_balance),
        };
        0x2::event::emit<RakeAccrued>(v0);
    }

    public fun available<T0>(arg0: &TreasuryVault<T0>) : u64 {
        0x2::balance::value<T0>(&arg0.available_balance)
    }

    public fun deposit<T0>(arg0: &mut TreasuryVault<T0>, arg1: 0x2::coin::Coin<T0>, arg2: &0x2::tx_context::TxContext) {
        assert!(arg0.owner == 0x2::tx_context::sender(arg2), 300);
        deposit_inner<T0>(arg0, arg1);
    }

    public(friend) fun deposit_balance<T0>(arg0: &mut TreasuryVault<T0>, arg1: 0x2::balance::Balance<T0>) {
        let v0 = 0x2::balance::value<T0>(&arg1);
        assert!(v0 > 0, 301);
        0x2::balance::join<T0>(&mut arg0.available_balance, arg1);
        let v1 = Deposited{
            vault_id      : 0x2::object::id<TreasuryVault<T0>>(arg0),
            owner         : arg0.owner,
            amount        : v0,
            new_available : 0x2::balance::value<T0>(&arg0.available_balance),
        };
        0x2::event::emit<Deposited>(v1);
    }

    fun deposit_inner<T0>(arg0: &mut TreasuryVault<T0>, arg1: 0x2::coin::Coin<T0>) {
        let v0 = 0x2::coin::value<T0>(&arg1);
        assert!(v0 > 0, 301);
        assert!(v0 <= 1000000000000, 305);
        0x2::balance::join<T0>(&mut arg0.available_balance, 0x2::coin::into_balance<T0>(arg1));
        let v1 = Deposited{
            vault_id      : 0x2::object::id<TreasuryVault<T0>>(arg0),
            owner         : arg0.owner,
            amount        : v0,
            new_available : 0x2::balance::value<T0>(&arg0.available_balance),
        };
        0x2::event::emit<Deposited>(v1);
    }

    public fun deposit_with_ledger<T0>(arg0: &mut TreasuryVault<T0>, arg1: &mut WithdrawalLedger<T0>, arg2: 0x2::coin::Coin<T0>, arg3: &0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg3);
        assert!(arg0.owner == v0, 300);
        assert!(arg1.owner == v0, 309);
        assert!(arg1.vault_id == 0x2::object::id<TreasuryVault<T0>>(arg0), 310);
        let v1 = 0x2::coin::value<T0>(&arg2);
        assert!(v1 > 0, 301);
        assert!(v1 <= 1000000000000, 305);
        0x2::balance::join<T0>(&mut arg0.available_balance, 0x2::coin::into_balance<T0>(arg2));
        arg1.total_deposited = arg1.total_deposited + v1;
        let v2 = Deposited{
            vault_id      : 0x2::object::id<TreasuryVault<T0>>(arg0),
            owner         : arg0.owner,
            amount        : v1,
            new_available : 0x2::balance::value<T0>(&arg0.available_balance),
        };
        0x2::event::emit<Deposited>(v2);
    }

    public(friend) fun extract_for_join<T0>(arg0: &mut TreasuryVault<T0>, arg1: u64, arg2: 0x2::object::ID) : 0x2::balance::Balance<T0> {
        assert!(arg1 > 0, 301);
        assert!(0x2::balance::value<T0>(&arg0.available_balance) >= arg1, 302);
        let v0 = FundsLocked{
            vault_id      : 0x2::object::id<TreasuryVault<T0>>(arg0),
            table_id      : arg2,
            amount        : arg1,
            new_available : 0x2::balance::value<T0>(&arg0.available_balance),
            new_locked    : 0x2::balance::value<T0>(&arg0.locked_balance),
        };
        0x2::event::emit<FundsLocked>(v0);
        0x2::balance::split<T0>(&mut arg0.available_balance, arg1)
    }

    public fun ledger_owner<T0>(arg0: &WithdrawalLedger<T0>) : address {
        arg0.owner
    }

    public fun ledger_profit_fee_basis_charged<T0>(arg0: &WithdrawalLedger<T0>) : u64 {
        arg0.profit_fee_basis_charged
    }

    public fun ledger_total_deposited<T0>(arg0: &WithdrawalLedger<T0>) : u64 {
        arg0.total_deposited
    }

    public fun ledger_total_fee_paid<T0>(arg0: &WithdrawalLedger<T0>) : u64 {
        arg0.total_fee_paid
    }

    public fun ledger_total_withdrawn_requested<T0>(arg0: &WithdrawalLedger<T0>) : u64 {
        arg0.total_withdrawn_requested
    }

    public fun ledger_vault_id<T0>(arg0: &WithdrawalLedger<T0>) : 0x2::object::ID {
        arg0.vault_id
    }

    public(friend) fun lock<T0>(arg0: &mut TreasuryVault<T0>, arg1: u64, arg2: 0x2::object::ID) {
        assert!(arg1 > 0, 301);
        assert!(0x2::balance::value<T0>(&arg0.available_balance) >= arg1, 302);
        0x2::balance::join<T0>(&mut arg0.locked_balance, 0x2::balance::split<T0>(&mut arg0.available_balance, arg1));
        let v0 = FundsLocked{
            vault_id      : 0x2::object::id<TreasuryVault<T0>>(arg0),
            table_id      : arg2,
            amount        : arg1,
            new_available : 0x2::balance::value<T0>(&arg0.available_balance),
            new_locked    : 0x2::balance::value<T0>(&arg0.locked_balance),
        };
        0x2::event::emit<FundsLocked>(v0);
    }

    public fun locked<T0>(arg0: &TreasuryVault<T0>) : u64 {
        0x2::balance::value<T0>(&arg0.locked_balance)
    }

    public fun onboard_and_deposit<T0>(arg0: &mut 0xb32983029b154a03c73c639b21bb767927a9d040f605f478f058925704786fdf::player_account::PlayerRegistry, arg1: 0x2::coin::Coin<T0>, arg2: &0x2::clock::Clock, arg3: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg3);
        let v1 = 0xb32983029b154a03c73c639b21bb767927a9d040f605f478f058925704786fdf::player_account::create_account_inner(arg0, b"", arg2, arg3);
        let v2 = &mut v1;
        let v3 = open_vault_inner<T0>(v2, arg3);
        let v4 = &mut v3;
        deposit_inner<T0>(v4, arg1);
        0xb32983029b154a03c73c639b21bb767927a9d040f605f478f058925704786fdf::player_account::give_account(v1, v0);
        0x2::transfer::transfer<TreasuryVault<T0>>(v3, v0);
    }

    public fun open_vault<T0>(arg0: &mut 0xb32983029b154a03c73c639b21bb767927a9d040f605f478f058925704786fdf::player_account::PlayerAccount, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = open_vault_inner<T0>(arg0, arg1);
        0x2::transfer::transfer<TreasuryVault<T0>>(v0, 0x2::tx_context::sender(arg1));
    }

    public fun open_vault_and_deposit<T0>(arg0: &mut 0xb32983029b154a03c73c639b21bb767927a9d040f605f478f058925704786fdf::player_account::PlayerAccount, arg1: 0x2::coin::Coin<T0>, arg2: &mut 0x2::tx_context::TxContext) {
        let v0 = open_vault_inner<T0>(arg0, arg2);
        let v1 = &mut v0;
        deposit_inner<T0>(v1, arg1);
        0x2::transfer::transfer<TreasuryVault<T0>>(v0, 0x2::tx_context::sender(arg2));
    }

    public(friend) fun open_vault_inner<T0>(arg0: &mut 0xb32983029b154a03c73c639b21bb767927a9d040f605f478f058925704786fdf::player_account::PlayerAccount, arg1: &mut 0x2::tx_context::TxContext) : TreasuryVault<T0> {
        let v0 = 0x2::tx_context::sender(arg1);
        assert!(0xb32983029b154a03c73c639b21bb767927a9d040f605f478f058925704786fdf::player_account::owner(arg0) == v0, 300);
        assert!(0xb32983029b154a03c73c639b21bb767927a9d040f605f478f058925704786fdf::player_account::is_active(arg0), 308);
        let v1 = TreasuryVault<T0>{
            id                : 0x2::object::new(arg1),
            owner             : v0,
            account_id        : 0x2::object::id<0xb32983029b154a03c73c639b21bb767927a9d040f605f478f058925704786fdf::player_account::PlayerAccount>(arg0),
            available_balance : 0x2::balance::zero<T0>(),
            locked_balance    : 0x2::balance::zero<T0>(),
            rake_balance      : 0x2::balance::zero<T0>(),
        };
        let v2 = 0x2::object::id<TreasuryVault<T0>>(&v1);
        0xb32983029b154a03c73c639b21bb767927a9d040f605f478f058925704786fdf::player_account::register_vault<T0>(arg0, v2);
        let v3 = VaultOpened{
            vault_id   : v2,
            owner      : v0,
            account_id : 0x2::object::id<0xb32983029b154a03c73c639b21bb767927a9d040f605f478f058925704786fdf::player_account::PlayerAccount>(arg0),
        };
        0x2::event::emit<VaultOpened>(v3);
        v1
    }

    public fun open_withdrawal_ledger<T0>(arg0: &0xb32983029b154a03c73c639b21bb767927a9d040f605f478f058925704786fdf::player_account::PlayerAccount, arg1: &TreasuryVault<T0>, arg2: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg2);
        assert!(0xb32983029b154a03c73c639b21bb767927a9d040f605f478f058925704786fdf::player_account::owner(arg0) == v0, 300);
        assert!(arg1.owner == v0, 300);
        let v1 = WithdrawalLedger<T0>{
            id                        : 0x2::object::new(arg2),
            owner                     : v0,
            vault_id                  : 0x2::object::id<TreasuryVault<T0>>(arg1),
            total_deposited           : 0,
            total_withdrawn_requested : 0,
            profit_fee_basis_charged  : 0,
            total_fee_paid            : 0,
        };
        let v2 = WithdrawalLedgerOpened{
            ledger_id : 0x2::object::id<WithdrawalLedger<T0>>(&v1),
            owner     : v0,
            vault_id  : 0x2::object::id<TreasuryVault<T0>>(arg1),
            coin_type : 0x1::type_name::with_defining_ids<T0>(),
        };
        0x2::event::emit<WithdrawalLedgerOpened>(v2);
        0x2::transfer::transfer<WithdrawalLedger<T0>>(v1, v0);
    }

    public fun rake<T0>(arg0: &TreasuryVault<T0>) : u64 {
        0x2::balance::value<T0>(&arg0.rake_balance)
    }

    fun sat_sub(arg0: u64, arg1: u64) : u64 {
        if (arg0 >= arg1) {
            arg0 - arg1
        } else {
            0
        }
    }

    public(friend) fun take_rake<T0>(arg0: &mut TreasuryVault<T0>, arg1: u64) : 0x2::balance::Balance<T0> {
        assert!(arg1 > 0, 301);
        assert!(0x2::balance::value<T0>(&arg0.rake_balance) >= arg1, 304);
        let v0 = RakeSwept{
            vault_id : 0x2::object::id<TreasuryVault<T0>>(arg0),
            amount   : arg1,
            new_rake : 0x2::balance::value<T0>(&arg0.rake_balance),
        };
        0x2::event::emit<RakeSwept>(v0);
        0x2::balance::split<T0>(&mut arg0.rake_balance, arg1)
    }

    public(friend) fun unlock<T0>(arg0: &mut TreasuryVault<T0>, arg1: u64, arg2: 0x2::object::ID) {
        assert!(arg1 > 0, 301);
        assert!(0x2::balance::value<T0>(&arg0.locked_balance) >= arg1, 303);
        0x2::balance::join<T0>(&mut arg0.available_balance, 0x2::balance::split<T0>(&mut arg0.locked_balance, arg1));
        let v0 = FundsUnlocked{
            vault_id      : 0x2::object::id<TreasuryVault<T0>>(arg0),
            table_id      : arg2,
            amount        : arg1,
            new_available : 0x2::balance::value<T0>(&arg0.available_balance),
            new_locked    : 0x2::balance::value<T0>(&arg0.locked_balance),
        };
        0x2::event::emit<FundsUnlocked>(v0);
    }

    public fun withdraw<T0>(arg0: &mut TreasuryVault<T0>, arg1: u64, arg2: &mut 0x2::tx_context::TxContext) {
        assert!(arg0.owner == 0x2::tx_context::sender(arg2), 300);
        assert!(arg1 > 0, 301);
        assert!(arg1 <= 1000000000000, 306);
        assert!(0x2::balance::value<T0>(&arg0.available_balance) >= arg1, 302);
        let v0 = arg0.owner;
        0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(0x2::coin::take<T0>(&mut arg0.available_balance, arg1, arg2), v0);
        let v1 = Withdrawn{
            vault_id      : 0x2::object::id<TreasuryVault<T0>>(arg0),
            owner         : v0,
            amount        : arg1,
            new_available : 0x2::balance::value<T0>(&arg0.available_balance),
        };
        0x2::event::emit<Withdrawn>(v1);
    }

    public fun withdraw_with_fee<T0>(arg0: &mut TreasuryVault<T0>, arg1: &mut 0xb32983029b154a03c73c639b21bb767927a9d040f605f478f058925704786fdf::platform_fee_vault::PlatformFeeVault<T0>, arg2: &mut WithdrawalLedger<T0>, arg3: u64, arg4: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg4);
        assert!(arg0.owner == v0, 300);
        assert!(arg2.owner == v0, 309);
        assert!(arg2.vault_id == 0x2::object::id<TreasuryVault<T0>>(arg0), 310);
        assert!(arg3 > 0, 301);
        assert!(arg3 <= 1000000000000, 306);
        assert!(0x2::balance::value<T0>(&arg0.available_balance) >= arg3, 302);
        let v1 = sat_sub(sat_sub(arg2.total_withdrawn_requested + arg3, arg2.total_deposited), arg2.profit_fee_basis_charged);
        let v2 = 0xb32983029b154a03c73c639b21bb767927a9d040f605f478f058925704786fdf::platform_fee_vault::fee_bps<T0>(arg1);
        let v3 = (((v1 as u128) * (v2 as u128) / 10000) as u64);
        let v4 = 0x2::balance::split<T0>(&mut arg0.available_balance, arg3);
        if (v3 > 0) {
            0xb32983029b154a03c73c639b21bb767927a9d040f605f478f058925704786fdf::platform_fee_vault::accept_fee<T0>(arg1, 0x2::balance::split<T0>(&mut v4, v3));
            let v5 = ProfitWithdrawalFeeCharged{
                vault_id          : 0x2::object::id<TreasuryVault<T0>>(arg0),
                fee_vault_id      : 0x2::object::id<0xb32983029b154a03c73c639b21bb767927a9d040f605f478f058925704786fdf::platform_fee_vault::PlatformFeeVault<T0>>(arg1),
                owner             : v0,
                coin_type         : 0x1::type_name::with_defining_ids<T0>(),
                profit_fee_basis  : v1,
                profit_fee_amount : v3,
                fee_bps_at_charge : v2,
            };
            0x2::event::emit<ProfitWithdrawalFeeCharged>(v5);
        };
        0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(0x2::coin::from_balance<T0>(v4, arg4), v0);
        arg2.total_withdrawn_requested = arg2.total_withdrawn_requested + arg3;
        arg2.profit_fee_basis_charged = arg2.profit_fee_basis_charged + v1;
        arg2.total_fee_paid = arg2.total_fee_paid + v3;
        let v6 = VaultWithdrawn{
            vault_id                        : 0x2::object::id<TreasuryVault<T0>>(arg0),
            ledger_id                       : 0x2::object::id<WithdrawalLedger<T0>>(arg2),
            owner                           : v0,
            coin_type                       : 0x1::type_name::with_defining_ids<T0>(),
            requested_amount                : arg3,
            principal_portion               : arg3 - v1,
            profit_fee_basis                : v1,
            profit_fee_amount               : v3,
            net_payout                      : arg3 - v3,
            total_deposited                 : arg2.total_deposited,
            total_withdrawn_requested_after : arg2.total_withdrawn_requested,
            profit_fee_basis_charged_after  : arg2.profit_fee_basis_charged,
            fee_bps_at_charge               : v2,
        };
        0x2::event::emit<VaultWithdrawn>(v6);
    }

    // decompiled from Move bytecode v7
}

