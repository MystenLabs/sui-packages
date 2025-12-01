module 0x9581b290574fe0b79e69f45acf726684d511c5673348714098e953e5b16c23e4::vault {
    struct VaultAdminCap has key {
        id: 0x2::object::UID,
    }

    struct DepositLogKey has copy, drop, store {
        user: address,
        market_id: u64,
    }

    struct Market has store {
        collected_fee: u64,
        balance: u64,
        rewarded: bool,
    }

    struct Vault has key {
        id: 0x2::object::UID,
        balance: 0x2::balance::Balance<0xdba34672e30cb065b1f93e3ab55318768fd6fef66c15942c9f7cb846e2f900e7::usdc::USDC>,
        markets: 0x2::table::Table<u64, Market>,
        deposit_log: 0x2::table::Table<DepositLogKey, u64>,
    }

    struct Helper has key {
        id: 0x2::object::UID,
        market_entry_fee: 0x2::table::Table<u64, u64>,
    }

    public fun balance_of_market(arg0: &Vault, arg1: u64) : u64 {
        if (!0x2::table::contains<u64, Market>(&arg0.markets, arg1)) {
            0
        } else {
            0x2::table::borrow<u64, Market>(&arg0.markets, arg1).balance
        }
    }

    public fun collected_fee_of_market(arg0: &Vault, arg1: u64) : u64 {
        if (!0x2::table::contains<u64, Market>(&arg0.markets, arg1)) {
            0
        } else {
            0x2::table::borrow<u64, Market>(&arg0.markets, arg1).collected_fee
        }
    }

    public fun deposit(arg0: &mut Vault, arg1: &mut Helper, arg2: u64, arg3: 0x2::coin::Coin<0xdba34672e30cb065b1f93e3ab55318768fd6fef66c15942c9f7cb846e2f900e7::usdc::USDC>, arg4: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::coin::value<0xdba34672e30cb065b1f93e3ab55318768fd6fef66c15942c9f7cb846e2f900e7::usdc::USDC>(&arg3);
        assert!(0x2::table::contains<u64, u64>(&arg1.market_entry_fee, arg2), 2);
        assert!(v0 >= *0x2::table::borrow<u64, u64>(&arg1.market_entry_fee, arg2), 5);
        0x2::balance::join<0xdba34672e30cb065b1f93e3ab55318768fd6fef66c15942c9f7cb846e2f900e7::usdc::USDC>(&mut arg0.balance, 0x2::coin::into_balance<0xdba34672e30cb065b1f93e3ab55318768fd6fef66c15942c9f7cb846e2f900e7::usdc::USDC>(arg3));
        if (0x2::table::contains<u64, Market>(&arg0.markets, arg2)) {
            let v1 = 0x2::table::borrow_mut<u64, Market>(&mut arg0.markets, arg2);
            v1.collected_fee = v1.collected_fee + v0;
            v1.balance = v1.balance + v0;
        } else {
            let v2 = Market{
                collected_fee : v0,
                balance       : v0,
                rewarded      : false,
            };
            0x2::table::add<u64, Market>(&mut arg0.markets, arg2, v2);
        };
        let v3 = DepositLogKey{
            user      : 0x2::tx_context::sender(arg4),
            market_id : arg2,
        };
        assert!(!0x2::table::contains<DepositLogKey, u64>(&arg0.deposit_log, v3), 1);
        0x2::table::add<DepositLogKey, u64>(&mut arg0.deposit_log, v3, v0);
    }

    public fun distribute_rewards(arg0: &VaultAdminCap, arg1: &mut Vault, arg2: u64, arg3: vector<address>, arg4: vector<u64>, arg5: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x1::vector::length<address>(&arg3);
        assert!(v0 == 0x1::vector::length<u64>(&arg4), 0);
        assert!(0x2::table::contains<u64, Market>(&arg1.markets, arg2), 8);
        let v1 = 0;
        let v2 = 0;
        while (v1 < v0) {
            let v3 = *0x1::vector::borrow<u64>(&arg4, v1);
            handle_withdraw(arg1, *0x1::vector::borrow<address>(&arg3, v1), v3, arg5);
            v1 = v1 + 1;
            v2 = v2 + v3;
        };
        let v4 = 0x2::table::borrow_mut<u64, Market>(&mut arg1.markets, arg2);
        assert!(v4.balance >= v2, 6);
        v4.balance = v4.balance - v2;
        assert!(!v4.rewarded, 3);
        v4.rewarded = true;
    }

    fun handle_withdraw(arg0: &mut Vault, arg1: address, arg2: u64, arg3: &mut 0x2::tx_context::TxContext) {
        assert!(arg2 > 0, 7);
        assert!(0x2::balance::value<0xdba34672e30cb065b1f93e3ab55318768fd6fef66c15942c9f7cb846e2f900e7::usdc::USDC>(&arg0.balance) >= arg2, 6);
        0x2::transfer::public_transfer<0x2::coin::Coin<0xdba34672e30cb065b1f93e3ab55318768fd6fef66c15942c9f7cb846e2f900e7::usdc::USDC>>(0x2::coin::from_balance<0xdba34672e30cb065b1f93e3ab55318768fd6fef66c15942c9f7cb846e2f900e7::usdc::USDC>(0x2::balance::split<0xdba34672e30cb065b1f93e3ab55318768fd6fef66c15942c9f7cb846e2f900e7::usdc::USDC>(&mut arg0.balance, arg2), arg3), arg1);
    }

    public fun has_deposit_log(arg0: &Vault, arg1: address, arg2: u64) : bool {
        let v0 = DepositLogKey{
            user      : arg1,
            market_id : arg2,
        };
        0x2::table::contains<DepositLogKey, u64>(&arg0.deposit_log, v0)
    }

    fun init(arg0: &mut 0x2::tx_context::TxContext) {
        let v0 = VaultAdminCap{id: 0x2::object::new(arg0)};
        0x2::transfer::transfer<VaultAdminCap>(v0, 0x2::tx_context::sender(arg0));
        let v1 = Vault{
            id          : 0x2::object::new(arg0),
            balance     : 0x2::balance::zero<0xdba34672e30cb065b1f93e3ab55318768fd6fef66c15942c9f7cb846e2f900e7::usdc::USDC>(),
            markets     : 0x2::table::new<u64, Market>(arg0),
            deposit_log : 0x2::table::new<DepositLogKey, u64>(arg0),
        };
        0x2::transfer::share_object<Vault>(v1);
        let v2 = Helper{
            id               : 0x2::object::new(arg0),
            market_entry_fee : 0x2::table::new<u64, u64>(arg0),
        };
        0x2::transfer::share_object<Helper>(v2);
    }

    public fun notify_rewards(arg0: &VaultAdminCap, arg1: &mut Vault, arg2: u64, arg3: 0x2::coin::Coin<0xdba34672e30cb065b1f93e3ab55318768fd6fef66c15942c9f7cb846e2f900e7::usdc::USDC>) {
        let v0 = 0x2::coin::value<0xdba34672e30cb065b1f93e3ab55318768fd6fef66c15942c9f7cb846e2f900e7::usdc::USDC>(&arg3);
        assert!(v0 > 0, 7);
        assert!(0x2::table::contains<u64, Market>(&arg1.markets, arg2), 8);
        let v1 = 0x2::table::borrow_mut<u64, Market>(&mut arg1.markets, arg2);
        v1.balance = v1.balance + v0;
        0x2::balance::join<0xdba34672e30cb065b1f93e3ab55318768fd6fef66c15942c9f7cb846e2f900e7::usdc::USDC>(&mut arg1.balance, 0x2::coin::into_balance<0xdba34672e30cb065b1f93e3ab55318768fd6fef66c15942c9f7cb846e2f900e7::usdc::USDC>(arg3));
    }

    public fun set_market_entry_fee(arg0: &VaultAdminCap, arg1: &mut Helper, arg2: u64, arg3: u64) {
        assert!(arg3 > 0, 7);
        if (!0x2::table::contains<u64, u64>(&arg1.market_entry_fee, arg2)) {
            0x2::table::add<u64, u64>(&mut arg1.market_entry_fee, arg2, arg3);
        } else {
            *0x2::table::borrow_mut<u64, u64>(&mut arg1.market_entry_fee, arg2) = arg3;
        };
    }

    public entry fun transfer_admin_cap(arg0: VaultAdminCap, arg1: address) {
        0x2::transfer::transfer<VaultAdminCap>(arg0, arg1);
    }

    public fun withdraw(arg0: &VaultAdminCap, arg1: &mut Vault, arg2: u64, arg3: address, arg4: u64, arg5: &mut 0x2::tx_context::TxContext) {
        assert!(0x2::table::contains<u64, Market>(&arg1.markets, arg2), 8);
        assert!(0x2::table::borrow<u64, Market>(&arg1.markets, arg2).rewarded, 4);
        let v0 = 0x2::table::borrow_mut<u64, Market>(&mut arg1.markets, arg2);
        assert!(v0.balance >= arg4, 6);
        v0.balance = v0.balance - arg4;
        handle_withdraw(arg1, arg3, arg4, arg5);
    }

    // decompiled from Move bytecode v6
}

