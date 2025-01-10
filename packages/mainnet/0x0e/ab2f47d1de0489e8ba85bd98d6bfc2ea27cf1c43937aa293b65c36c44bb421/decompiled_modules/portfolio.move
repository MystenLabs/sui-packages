module 0xeab2f47d1de0489e8ba85bd98d6bfc2ea27cf1c43937aa293b65c36c44bb421::portfolio {
    struct Portfolio has store, key {
        id: 0x2::object::UID,
        wallets: 0x2::linked_table::LinkedTable<address, 0x2::linked_table::LinkedTable<0x1::ascii::String, 0xeab2f47d1de0489e8ba85bd98d6bfc2ea27cf1c43937aa293b65c36c44bb421::wallet::Wallet>>,
    }

    struct FetchAccountBalanceEvent has copy, drop, store {
        owner: address,
        account_name: 0x1::ascii::String,
        balance: 0xeab2f47d1de0489e8ba85bd98d6bfc2ea27cf1c43937aa293b65c36c44bb421::wallet::WalletBalance,
    }

    struct FetchCoinBalanceEvent has copy, drop, store {
        owner: address,
        account_name: 0x1::ascii::String,
        balance: 0xeab2f47d1de0489e8ba85bd98d6bfc2ea27cf1c43937aa293b65c36c44bb421::pocket::CoinBalance,
    }

    struct FetchPoolBalanceEvent has copy, drop, store {
        owner: address,
        account_name: 0x1::ascii::String,
        balance_a: 0xeab2f47d1de0489e8ba85bd98d6bfc2ea27cf1c43937aa293b65c36c44bb421::pocket::CoinBalance,
        balance_b: 0xeab2f47d1de0489e8ba85bd98d6bfc2ea27cf1c43937aa293b65c36c44bb421::pocket::CoinBalance,
    }

    struct FetchOwnersEvent has copy, drop, store {
        owners: vector<address>,
        total: u64,
    }

    struct FetchAccountsEvent has copy, drop, store {
        owner: address,
        accounts: vector<0x1::ascii::String>,
        total: u64,
    }

    struct FetchTvlEvent has copy, drop, store {
        balances: vector<0xeab2f47d1de0489e8ba85bd98d6bfc2ea27cf1c43937aa293b65c36c44bb421::pocket::CoinBalance>,
    }

    struct FetchAllBalanceEvent has copy, drop, store {
        balance: 0xeab2f47d1de0489e8ba85bd98d6bfc2ea27cf1c43937aa293b65c36c44bb421::wallet::WalletBalance,
    }

    public(friend) fun transfer<T0>(arg0: &mut Portfolio, arg1: address, arg2: 0x1::ascii::String, arg3: 0x1::ascii::String, arg4: 0x1::option::Option<u64>, arg5: &mut 0x2::tx_context::TxContext) {
        let v0 = withdraw<T0>(arg0, arg1, arg2, arg4);
        deposit<T0>(arg0, arg1, arg3, v0, arg5);
    }

    fun add_account_if_not_exist(arg0: &mut 0x2::linked_table::LinkedTable<0x1::ascii::String, 0xeab2f47d1de0489e8ba85bd98d6bfc2ea27cf1c43937aa293b65c36c44bb421::wallet::Wallet>, arg1: 0x1::ascii::String, arg2: &mut 0x2::tx_context::TxContext) {
        if (!0x2::linked_table::contains<0x1::ascii::String, 0xeab2f47d1de0489e8ba85bd98d6bfc2ea27cf1c43937aa293b65c36c44bb421::wallet::Wallet>(arg0, arg1)) {
            0x2::linked_table::push_back<0x1::ascii::String, 0xeab2f47d1de0489e8ba85bd98d6bfc2ea27cf1c43937aa293b65c36c44bb421::wallet::Wallet>(arg0, arg1, 0xeab2f47d1de0489e8ba85bd98d6bfc2ea27cf1c43937aa293b65c36c44bb421::wallet::new(arg2));
        };
    }

    fun add_owner_if_not_exist(arg0: &mut Portfolio, arg1: address, arg2: &mut 0x2::tx_context::TxContext) {
        if (!0x2::linked_table::contains<address, 0x2::linked_table::LinkedTable<0x1::ascii::String, 0xeab2f47d1de0489e8ba85bd98d6bfc2ea27cf1c43937aa293b65c36c44bb421::wallet::Wallet>>(&arg0.wallets, arg1)) {
            0x2::linked_table::push_back<address, 0x2::linked_table::LinkedTable<0x1::ascii::String, 0xeab2f47d1de0489e8ba85bd98d6bfc2ea27cf1c43937aa293b65c36c44bb421::wallet::Wallet>>(&mut arg0.wallets, arg1, 0x2::linked_table::new<0x1::ascii::String, 0xeab2f47d1de0489e8ba85bd98d6bfc2ea27cf1c43937aa293b65c36c44bb421::wallet::Wallet>(arg2));
        };
    }

    public(friend) fun apply_fee<T0>(arg0: &mut Portfolio, arg1: address, arg2: 0x1::ascii::String) {
        if (has_wallet(arg0, arg1, arg2)) {
            0xeab2f47d1de0489e8ba85bd98d6bfc2ea27cf1c43937aa293b65c36c44bb421::wallet::apply_fee<T0>(borrow_wallet_mut(arg0, arg1, arg2));
        };
    }

    public(friend) fun apply_reward<T0>(arg0: &mut Portfolio, arg1: address, arg2: 0x1::ascii::String) {
        if (has_wallet(arg0, arg1, arg2)) {
            0xeab2f47d1de0489e8ba85bd98d6bfc2ea27cf1c43937aa293b65c36c44bb421::wallet::apply_reward<T0>(borrow_wallet_mut(arg0, arg1, arg2));
        };
    }

    fun borrow_or_new_wallet_mut(arg0: &mut Portfolio, arg1: address, arg2: 0x1::ascii::String, arg3: &mut 0x2::tx_context::TxContext) : &mut 0xeab2f47d1de0489e8ba85bd98d6bfc2ea27cf1c43937aa293b65c36c44bb421::wallet::Wallet {
        add_owner_if_not_exist(arg0, arg1, arg3);
        let v0 = 0x2::linked_table::borrow_mut<address, 0x2::linked_table::LinkedTable<0x1::ascii::String, 0xeab2f47d1de0489e8ba85bd98d6bfc2ea27cf1c43937aa293b65c36c44bb421::wallet::Wallet>>(&mut arg0.wallets, arg1);
        add_account_if_not_exist(v0, arg2, arg3);
        0x2::linked_table::borrow_mut<0x1::ascii::String, 0xeab2f47d1de0489e8ba85bd98d6bfc2ea27cf1c43937aa293b65c36c44bb421::wallet::Wallet>(v0, arg2)
    }

    fun borrow_wallet(arg0: &Portfolio, arg1: address, arg2: 0x1::ascii::String) : &0xeab2f47d1de0489e8ba85bd98d6bfc2ea27cf1c43937aa293b65c36c44bb421::wallet::Wallet {
        0x2::linked_table::borrow<0x1::ascii::String, 0xeab2f47d1de0489e8ba85bd98d6bfc2ea27cf1c43937aa293b65c36c44bb421::wallet::Wallet>(0x2::linked_table::borrow<address, 0x2::linked_table::LinkedTable<0x1::ascii::String, 0xeab2f47d1de0489e8ba85bd98d6bfc2ea27cf1c43937aa293b65c36c44bb421::wallet::Wallet>>(&arg0.wallets, arg1), arg2)
    }

    fun borrow_wallet_mut(arg0: &mut Portfolio, arg1: address, arg2: 0x1::ascii::String) : &mut 0xeab2f47d1de0489e8ba85bd98d6bfc2ea27cf1c43937aa293b65c36c44bb421::wallet::Wallet {
        0x2::linked_table::borrow_mut<0x1::ascii::String, 0xeab2f47d1de0489e8ba85bd98d6bfc2ea27cf1c43937aa293b65c36c44bb421::wallet::Wallet>(0x2::linked_table::borrow_mut<address, 0x2::linked_table::LinkedTable<0x1::ascii::String, 0xeab2f47d1de0489e8ba85bd98d6bfc2ea27cf1c43937aa293b65c36c44bb421::wallet::Wallet>>(&mut arg0.wallets, arg1), arg2)
    }

    public(friend) fun claim<T0>(arg0: &mut Portfolio, arg1: address, arg2: 0x1::ascii::String, arg3: &mut 0x2::tx_context::TxContext) {
        if (has_wallet(arg0, arg1, arg2)) {
            0xeab2f47d1de0489e8ba85bd98d6bfc2ea27cf1c43937aa293b65c36c44bb421::wallet::claim<T0>(borrow_wallet_mut(arg0, arg1, arg2), arg1, arg3);
        };
    }

    public(friend) fun claim_all<T0>(arg0: &mut Portfolio, arg1: address, arg2: &mut 0x2::tx_context::TxContext) {
        if (0x2::linked_table::contains<address, 0x2::linked_table::LinkedTable<0x1::ascii::String, 0xeab2f47d1de0489e8ba85bd98d6bfc2ea27cf1c43937aa293b65c36c44bb421::wallet::Wallet>>(&arg0.wallets, arg1)) {
            let v0 = 0x2::linked_table::borrow_mut<address, 0x2::linked_table::LinkedTable<0x1::ascii::String, 0xeab2f47d1de0489e8ba85bd98d6bfc2ea27cf1c43937aa293b65c36c44bb421::wallet::Wallet>>(&mut arg0.wallets, arg1);
            let v1 = 0x2::linked_table::front<0x1::ascii::String, 0xeab2f47d1de0489e8ba85bd98d6bfc2ea27cf1c43937aa293b65c36c44bb421::wallet::Wallet>(v0);
            while (0x1::option::is_some<0x1::ascii::String>(v1)) {
                let v2 = *0x1::option::borrow<0x1::ascii::String>(v1);
                0xeab2f47d1de0489e8ba85bd98d6bfc2ea27cf1c43937aa293b65c36c44bb421::wallet::claim<T0>(0x2::linked_table::borrow_mut<0x1::ascii::String, 0xeab2f47d1de0489e8ba85bd98d6bfc2ea27cf1c43937aa293b65c36c44bb421::wallet::Wallet>(v0, v2), arg1, arg2);
                v1 = 0x2::linked_table::next<0x1::ascii::String, 0xeab2f47d1de0489e8ba85bd98d6bfc2ea27cf1c43937aa293b65c36c44bb421::wallet::Wallet>(v0, v2);
            };
        };
    }

    public(friend) fun claim_all_fee<T0>(arg0: &mut Portfolio, arg1: address, arg2: &mut 0x2::tx_context::TxContext) {
        if (0x2::linked_table::contains<address, 0x2::linked_table::LinkedTable<0x1::ascii::String, 0xeab2f47d1de0489e8ba85bd98d6bfc2ea27cf1c43937aa293b65c36c44bb421::wallet::Wallet>>(&arg0.wallets, arg1)) {
            let v0 = 0x2::linked_table::borrow_mut<address, 0x2::linked_table::LinkedTable<0x1::ascii::String, 0xeab2f47d1de0489e8ba85bd98d6bfc2ea27cf1c43937aa293b65c36c44bb421::wallet::Wallet>>(&mut arg0.wallets, arg1);
            let v1 = 0x2::linked_table::front<0x1::ascii::String, 0xeab2f47d1de0489e8ba85bd98d6bfc2ea27cf1c43937aa293b65c36c44bb421::wallet::Wallet>(v0);
            while (0x1::option::is_some<0x1::ascii::String>(v1)) {
                let v2 = *0x1::option::borrow<0x1::ascii::String>(v1);
                0xeab2f47d1de0489e8ba85bd98d6bfc2ea27cf1c43937aa293b65c36c44bb421::wallet::claim_fee<T0>(0x2::linked_table::borrow_mut<0x1::ascii::String, 0xeab2f47d1de0489e8ba85bd98d6bfc2ea27cf1c43937aa293b65c36c44bb421::wallet::Wallet>(v0, v2), arg1, arg2);
                v1 = 0x2::linked_table::next<0x1::ascii::String, 0xeab2f47d1de0489e8ba85bd98d6bfc2ea27cf1c43937aa293b65c36c44bb421::wallet::Wallet>(v0, v2);
            };
        };
    }

    public(friend) fun claim_all_reward<T0>(arg0: &mut Portfolio, arg1: address, arg2: &mut 0x2::tx_context::TxContext) {
        if (0x2::linked_table::contains<address, 0x2::linked_table::LinkedTable<0x1::ascii::String, 0xeab2f47d1de0489e8ba85bd98d6bfc2ea27cf1c43937aa293b65c36c44bb421::wallet::Wallet>>(&arg0.wallets, arg1)) {
            let v0 = 0x2::linked_table::borrow_mut<address, 0x2::linked_table::LinkedTable<0x1::ascii::String, 0xeab2f47d1de0489e8ba85bd98d6bfc2ea27cf1c43937aa293b65c36c44bb421::wallet::Wallet>>(&mut arg0.wallets, arg1);
            let v1 = 0x2::linked_table::front<0x1::ascii::String, 0xeab2f47d1de0489e8ba85bd98d6bfc2ea27cf1c43937aa293b65c36c44bb421::wallet::Wallet>(v0);
            while (0x1::option::is_some<0x1::ascii::String>(v1)) {
                let v2 = *0x1::option::borrow<0x1::ascii::String>(v1);
                0xeab2f47d1de0489e8ba85bd98d6bfc2ea27cf1c43937aa293b65c36c44bb421::wallet::claim_reward<T0>(0x2::linked_table::borrow_mut<0x1::ascii::String, 0xeab2f47d1de0489e8ba85bd98d6bfc2ea27cf1c43937aa293b65c36c44bb421::wallet::Wallet>(v0, v2), arg1, arg2);
                v1 = 0x2::linked_table::next<0x1::ascii::String, 0xeab2f47d1de0489e8ba85bd98d6bfc2ea27cf1c43937aa293b65c36c44bb421::wallet::Wallet>(v0, v2);
            };
        };
    }

    public(friend) fun claim_fee<T0>(arg0: &mut Portfolio, arg1: address, arg2: 0x1::ascii::String, arg3: &mut 0x2::tx_context::TxContext) {
        if (has_wallet(arg0, arg1, arg2)) {
            0xeab2f47d1de0489e8ba85bd98d6bfc2ea27cf1c43937aa293b65c36c44bb421::wallet::claim_fee<T0>(borrow_wallet_mut(arg0, arg1, arg2), arg1, arg3);
        };
    }

    public(friend) fun claim_reward<T0>(arg0: &mut Portfolio, arg1: address, arg2: 0x1::ascii::String, arg3: &mut 0x2::tx_context::TxContext) {
        if (has_wallet(arg0, arg1, arg2)) {
            0xeab2f47d1de0489e8ba85bd98d6bfc2ea27cf1c43937aa293b65c36c44bb421::wallet::claim_reward<T0>(borrow_wallet_mut(arg0, arg1, arg2), arg1, arg3);
        };
    }

    public fun cleanup(arg0: &mut Portfolio, arg1: address, arg2: 0x1::ascii::String) {
        if (has_wallet(arg0, arg1, arg2)) {
            let v0 = 0x2::linked_table::borrow_mut<address, 0x2::linked_table::LinkedTable<0x1::ascii::String, 0xeab2f47d1de0489e8ba85bd98d6bfc2ea27cf1c43937aa293b65c36c44bb421::wallet::Wallet>>(&mut arg0.wallets, arg1);
            if (0xeab2f47d1de0489e8ba85bd98d6bfc2ea27cf1c43937aa293b65c36c44bb421::wallet::is_empty(0x2::linked_table::borrow<0x1::ascii::String, 0xeab2f47d1de0489e8ba85bd98d6bfc2ea27cf1c43937aa293b65c36c44bb421::wallet::Wallet>(v0, arg2))) {
                0xeab2f47d1de0489e8ba85bd98d6bfc2ea27cf1c43937aa293b65c36c44bb421::wallet::destroy_empty(0x2::linked_table::remove<0x1::ascii::String, 0xeab2f47d1de0489e8ba85bd98d6bfc2ea27cf1c43937aa293b65c36c44bb421::wallet::Wallet>(v0, arg2));
            };
        };
    }

    public fun cleanup_all(arg0: &mut Portfolio) {
        let v0 = 0x2::linked_table::front<address, 0x2::linked_table::LinkedTable<0x1::ascii::String, 0xeab2f47d1de0489e8ba85bd98d6bfc2ea27cf1c43937aa293b65c36c44bb421::wallet::Wallet>>(&arg0.wallets);
        let v1 = 0x1::vector::empty<address>();
        while (0x1::option::is_some<address>(v0)) {
            let v2 = *0x1::option::borrow<address>(v0);
            let v3 = 0x2::linked_table::borrow_mut<address, 0x2::linked_table::LinkedTable<0x1::ascii::String, 0xeab2f47d1de0489e8ba85bd98d6bfc2ea27cf1c43937aa293b65c36c44bb421::wallet::Wallet>>(&mut arg0.wallets, v2);
            let v4 = 0x2::linked_table::front<0x1::ascii::String, 0xeab2f47d1de0489e8ba85bd98d6bfc2ea27cf1c43937aa293b65c36c44bb421::wallet::Wallet>(v3);
            let v5 = 0x1::vector::empty<0x1::ascii::String>();
            while (0x1::option::is_some<0x1::ascii::String>(v4)) {
                let v6 = *0x1::option::borrow<0x1::ascii::String>(v4);
                if (0xeab2f47d1de0489e8ba85bd98d6bfc2ea27cf1c43937aa293b65c36c44bb421::wallet::is_empty(0x2::linked_table::borrow_mut<0x1::ascii::String, 0xeab2f47d1de0489e8ba85bd98d6bfc2ea27cf1c43937aa293b65c36c44bb421::wallet::Wallet>(v3, v6))) {
                    0x1::vector::push_back<0x1::ascii::String>(&mut v5, v6);
                };
                v4 = 0x2::linked_table::next<0x1::ascii::String, 0xeab2f47d1de0489e8ba85bd98d6bfc2ea27cf1c43937aa293b65c36c44bb421::wallet::Wallet>(v3, v6);
            };
            let v7 = 0;
            while (v7 < 0x1::vector::length<0x1::ascii::String>(&v5)) {
                0xeab2f47d1de0489e8ba85bd98d6bfc2ea27cf1c43937aa293b65c36c44bb421::wallet::destroy_empty(0x2::linked_table::remove<0x1::ascii::String, 0xeab2f47d1de0489e8ba85bd98d6bfc2ea27cf1c43937aa293b65c36c44bb421::wallet::Wallet>(v3, *0x1::vector::borrow<0x1::ascii::String>(&v5, v7)));
                v7 = v7 + 1;
            };
            if (0x2::linked_table::is_empty<0x1::ascii::String, 0xeab2f47d1de0489e8ba85bd98d6bfc2ea27cf1c43937aa293b65c36c44bb421::wallet::Wallet>(v3)) {
                0x1::vector::push_back<address>(&mut v1, v2);
            };
            v0 = 0x2::linked_table::next<address, 0x2::linked_table::LinkedTable<0x1::ascii::String, 0xeab2f47d1de0489e8ba85bd98d6bfc2ea27cf1c43937aa293b65c36c44bb421::wallet::Wallet>>(&arg0.wallets, v2);
        };
        let v8 = 0;
        while (v8 < 0x1::vector::length<address>(&v1)) {
            0x2::linked_table::destroy_empty<0x1::ascii::String, 0xeab2f47d1de0489e8ba85bd98d6bfc2ea27cf1c43937aa293b65c36c44bb421::wallet::Wallet>(0x2::linked_table::remove<address, 0x2::linked_table::LinkedTable<0x1::ascii::String, 0xeab2f47d1de0489e8ba85bd98d6bfc2ea27cf1c43937aa293b65c36c44bb421::wallet::Wallet>>(&mut arg0.wallets, *0x1::vector::borrow<address>(&v1, v8)));
            v8 = v8 + 1;
        };
    }

    public(friend) fun deposit<T0>(arg0: &mut Portfolio, arg1: address, arg2: 0x1::ascii::String, arg3: 0x2::balance::Balance<T0>, arg4: &mut 0x2::tx_context::TxContext) {
        if (0x2::balance::value<T0>(&arg3) > 0) {
            0xeab2f47d1de0489e8ba85bd98d6bfc2ea27cf1c43937aa293b65c36c44bb421::wallet::deposit<T0>(borrow_or_new_wallet_mut(arg0, arg1, arg2, arg4), arg3);
        } else {
            0x2::balance::destroy_zero<T0>(arg3);
        };
    }

    public(friend) fun deposit_fee<T0>(arg0: &mut Portfolio, arg1: address, arg2: 0x1::ascii::String, arg3: 0x2::balance::Balance<T0>, arg4: &mut 0x2::tx_context::TxContext) {
        if (0x2::balance::value<T0>(&arg3) > 0) {
            0xeab2f47d1de0489e8ba85bd98d6bfc2ea27cf1c43937aa293b65c36c44bb421::wallet::deposit_fee<T0>(borrow_or_new_wallet_mut(arg0, arg1, arg2, arg4), arg3);
        } else {
            0x2::balance::destroy_zero<T0>(arg3);
        };
    }

    public(friend) fun deposit_reward<T0>(arg0: &mut Portfolio, arg1: address, arg2: 0x1::ascii::String, arg3: 0x2::balance::Balance<T0>, arg4: &mut 0x2::tx_context::TxContext) {
        if (0x2::balance::value<T0>(&arg3) > 0) {
            0xeab2f47d1de0489e8ba85bd98d6bfc2ea27cf1c43937aa293b65c36c44bb421::wallet::deposit_reward<T0>(borrow_or_new_wallet_mut(arg0, arg1, arg2, arg4), arg3);
        } else {
            0x2::balance::destroy_zero<T0>(arg3);
        };
    }

    public fun fetch_account_balance(arg0: &Portfolio, arg1: address, arg2: 0x1::ascii::String) {
        let v0 = FetchAccountBalanceEvent{
            owner        : arg1,
            account_name : arg2,
            balance      : get_account_balance(arg0, arg1, arg2),
        };
        0x2::event::emit<FetchAccountBalanceEvent>(v0);
    }

    public fun fetch_accounts(arg0: &Portfolio, arg1: address, arg2: 0x1::option::Option<u64>, arg3: 0x1::option::Option<u64>) {
        let (v0, v1) = get_accounts(arg0, arg1, arg2, arg3);
        let v2 = FetchAccountsEvent{
            owner    : arg1,
            accounts : v0,
            total    : v1,
        };
        0x2::event::emit<FetchAccountsEvent>(v2);
    }

    public fun fetch_all_balance(arg0: &Portfolio) {
        let v0 = FetchAllBalanceEvent{balance: get_all_balance(arg0)};
        0x2::event::emit<FetchAllBalanceEvent>(v0);
    }

    public fun fetch_coin_balance<T0>(arg0: &Portfolio, arg1: address, arg2: 0x1::ascii::String) {
        let v0 = FetchCoinBalanceEvent{
            owner        : arg1,
            account_name : arg2,
            balance      : get_coin_balance<T0>(arg0, arg1, arg2),
        };
        0x2::event::emit<FetchCoinBalanceEvent>(v0);
    }

    public fun fetch_owners(arg0: &mut Portfolio, arg1: 0x1::option::Option<u64>, arg2: 0x1::option::Option<u64>) {
        let (v0, v1) = get_owners(arg0, arg1, arg2);
        let v2 = FetchOwnersEvent{
            owners : v0,
            total  : v1,
        };
        0x2::event::emit<FetchOwnersEvent>(v2);
    }

    public fun fetch_pool_balance<T0, T1>(arg0: &Portfolio, arg1: address, arg2: 0x1::ascii::String) {
        let (v0, v1) = get_pool_balance<T0, T1>(arg0, arg1, arg2);
        let v2 = FetchPoolBalanceEvent{
            owner        : arg1,
            account_name : arg2,
            balance_a    : v0,
            balance_b    : v1,
        };
        0x2::event::emit<FetchPoolBalanceEvent>(v2);
    }

    public fun fetch_tvl(arg0: &Portfolio) {
        let v0 = FetchTvlEvent{balances: get_tvl(arg0)};
        0x2::event::emit<FetchTvlEvent>(v0);
    }

    public fun get_account_balance(arg0: &Portfolio, arg1: address, arg2: 0x1::ascii::String) : 0xeab2f47d1de0489e8ba85bd98d6bfc2ea27cf1c43937aa293b65c36c44bb421::wallet::WalletBalance {
        if (has_wallet(arg0, arg1, arg2)) {
            0xeab2f47d1de0489e8ba85bd98d6bfc2ea27cf1c43937aa293b65c36c44bb421::wallet::get_balance(borrow_wallet(arg0, arg1, arg2))
        } else {
            0xeab2f47d1de0489e8ba85bd98d6bfc2ea27cf1c43937aa293b65c36c44bb421::wallet::zero_balance()
        }
    }

    public fun get_accounts(arg0: &Portfolio, arg1: address, arg2: 0x1::option::Option<u64>, arg3: 0x1::option::Option<u64>) : (vector<0x1::ascii::String>, u64) {
        if (0x2::linked_table::contains<address, 0x2::linked_table::LinkedTable<0x1::ascii::String, 0xeab2f47d1de0489e8ba85bd98d6bfc2ea27cf1c43937aa293b65c36c44bb421::wallet::Wallet>>(&arg0.wallets, arg1)) {
            0xeab2f47d1de0489e8ba85bd98d6bfc2ea27cf1c43937aa293b65c36c44bb421::utils::linked_table_limit_keys<0x1::ascii::String, 0xeab2f47d1de0489e8ba85bd98d6bfc2ea27cf1c43937aa293b65c36c44bb421::wallet::Wallet>(0x2::linked_table::borrow<address, 0x2::linked_table::LinkedTable<0x1::ascii::String, 0xeab2f47d1de0489e8ba85bd98d6bfc2ea27cf1c43937aa293b65c36c44bb421::wallet::Wallet>>(&arg0.wallets, arg1), arg2, arg3)
        } else {
            (0x1::vector::empty<0x1::ascii::String>(), 0)
        }
    }

    public fun get_all_balance(arg0: &Portfolio) : 0xeab2f47d1de0489e8ba85bd98d6bfc2ea27cf1c43937aa293b65c36c44bb421::wallet::WalletBalance {
        let v0 = 0xeab2f47d1de0489e8ba85bd98d6bfc2ea27cf1c43937aa293b65c36c44bb421::wallet::zero_balance();
        let v1 = 0x2::linked_table::front<address, 0x2::linked_table::LinkedTable<0x1::ascii::String, 0xeab2f47d1de0489e8ba85bd98d6bfc2ea27cf1c43937aa293b65c36c44bb421::wallet::Wallet>>(&arg0.wallets);
        while (0x1::option::is_some<address>(v1)) {
            let v2 = *0x1::option::borrow<address>(v1);
            let v3 = 0x2::linked_table::borrow<address, 0x2::linked_table::LinkedTable<0x1::ascii::String, 0xeab2f47d1de0489e8ba85bd98d6bfc2ea27cf1c43937aa293b65c36c44bb421::wallet::Wallet>>(&arg0.wallets, v2);
            let v4 = 0x2::linked_table::front<0x1::ascii::String, 0xeab2f47d1de0489e8ba85bd98d6bfc2ea27cf1c43937aa293b65c36c44bb421::wallet::Wallet>(v3);
            while (0x1::option::is_some<0x1::ascii::String>(v4)) {
                let v5 = *0x1::option::borrow<0x1::ascii::String>(v4);
                v0 = 0xeab2f47d1de0489e8ba85bd98d6bfc2ea27cf1c43937aa293b65c36c44bb421::wallet::join_balances(v0, 0xeab2f47d1de0489e8ba85bd98d6bfc2ea27cf1c43937aa293b65c36c44bb421::wallet::get_balance(0x2::linked_table::borrow<0x1::ascii::String, 0xeab2f47d1de0489e8ba85bd98d6bfc2ea27cf1c43937aa293b65c36c44bb421::wallet::Wallet>(v3, v5)));
                v4 = 0x2::linked_table::next<0x1::ascii::String, 0xeab2f47d1de0489e8ba85bd98d6bfc2ea27cf1c43937aa293b65c36c44bb421::wallet::Wallet>(v3, v5);
            };
            v1 = 0x2::linked_table::next<address, 0x2::linked_table::LinkedTable<0x1::ascii::String, 0xeab2f47d1de0489e8ba85bd98d6bfc2ea27cf1c43937aa293b65c36c44bb421::wallet::Wallet>>(&arg0.wallets, v2);
        };
        v0
    }

    public fun get_amount<T0>(arg0: &Portfolio, arg1: address, arg2: 0x1::ascii::String) : u64 {
        if (has_wallet(arg0, arg1, arg2)) {
            0xeab2f47d1de0489e8ba85bd98d6bfc2ea27cf1c43937aa293b65c36c44bb421::wallet::get_coin_amount<T0>(borrow_wallet(arg0, arg1, arg2))
        } else {
            0
        }
    }

    public fun get_coin_balance<T0>(arg0: &Portfolio, arg1: address, arg2: 0x1::ascii::String) : 0xeab2f47d1de0489e8ba85bd98d6bfc2ea27cf1c43937aa293b65c36c44bb421::pocket::CoinBalance {
        if (has_wallet(arg0, arg1, arg2)) {
            0xeab2f47d1de0489e8ba85bd98d6bfc2ea27cf1c43937aa293b65c36c44bb421::wallet::get_coin_balance<T0>(borrow_wallet(arg0, arg1, arg2))
        } else {
            0xeab2f47d1de0489e8ba85bd98d6bfc2ea27cf1c43937aa293b65c36c44bb421::pocket::zero_balance<T0>()
        }
    }

    public fun get_owners(arg0: &Portfolio, arg1: 0x1::option::Option<u64>, arg2: 0x1::option::Option<u64>) : (vector<address>, u64) {
        0xeab2f47d1de0489e8ba85bd98d6bfc2ea27cf1c43937aa293b65c36c44bb421::utils::linked_table_limit_keys<address, 0x2::linked_table::LinkedTable<0x1::ascii::String, 0xeab2f47d1de0489e8ba85bd98d6bfc2ea27cf1c43937aa293b65c36c44bb421::wallet::Wallet>>(&arg0.wallets, arg1, arg2)
    }

    public fun get_pool_amounts<T0, T1>(arg0: &Portfolio, arg1: address, arg2: 0x1::ascii::String) : (u64, u64) {
        if (has_wallet(arg0, arg1, arg2)) {
            0xeab2f47d1de0489e8ba85bd98d6bfc2ea27cf1c43937aa293b65c36c44bb421::wallet::get_pool_amounts<T0, T1>(borrow_wallet(arg0, arg1, arg2))
        } else {
            (0, 0)
        }
    }

    public fun get_pool_balance<T0, T1>(arg0: &Portfolio, arg1: address, arg2: 0x1::ascii::String) : (0xeab2f47d1de0489e8ba85bd98d6bfc2ea27cf1c43937aa293b65c36c44bb421::pocket::CoinBalance, 0xeab2f47d1de0489e8ba85bd98d6bfc2ea27cf1c43937aa293b65c36c44bb421::pocket::CoinBalance) {
        if (has_wallet(arg0, arg1, arg2)) {
            0xeab2f47d1de0489e8ba85bd98d6bfc2ea27cf1c43937aa293b65c36c44bb421::wallet::get_pool_balance<T0, T1>(borrow_wallet(arg0, arg1, arg2))
        } else {
            (0xeab2f47d1de0489e8ba85bd98d6bfc2ea27cf1c43937aa293b65c36c44bb421::pocket::zero_balance<T0>(), 0xeab2f47d1de0489e8ba85bd98d6bfc2ea27cf1c43937aa293b65c36c44bb421::pocket::zero_balance<T1>())
        }
    }

    public fun get_tvl(arg0: &Portfolio) : vector<0xeab2f47d1de0489e8ba85bd98d6bfc2ea27cf1c43937aa293b65c36c44bb421::pocket::CoinBalance> {
        let v0 = 0x1::vector::empty<0xeab2f47d1de0489e8ba85bd98d6bfc2ea27cf1c43937aa293b65c36c44bb421::pocket::CoinBalance>();
        let v1 = 0x2::linked_table::front<address, 0x2::linked_table::LinkedTable<0x1::ascii::String, 0xeab2f47d1de0489e8ba85bd98d6bfc2ea27cf1c43937aa293b65c36c44bb421::wallet::Wallet>>(&arg0.wallets);
        while (0x1::option::is_some<address>(v1)) {
            let v2 = *0x1::option::borrow<address>(v1);
            let v3 = 0x2::linked_table::borrow<address, 0x2::linked_table::LinkedTable<0x1::ascii::String, 0xeab2f47d1de0489e8ba85bd98d6bfc2ea27cf1c43937aa293b65c36c44bb421::wallet::Wallet>>(&arg0.wallets, v2);
            let v4 = 0x2::linked_table::front<0x1::ascii::String, 0xeab2f47d1de0489e8ba85bd98d6bfc2ea27cf1c43937aa293b65c36c44bb421::wallet::Wallet>(v3);
            while (0x1::option::is_some<0x1::ascii::String>(v4)) {
                let v5 = *0x1::option::borrow<0x1::ascii::String>(v4);
                v0 = 0xeab2f47d1de0489e8ba85bd98d6bfc2ea27cf1c43937aa293b65c36c44bb421::pocket::join_balances(v0, 0xeab2f47d1de0489e8ba85bd98d6bfc2ea27cf1c43937aa293b65c36c44bb421::wallet::get_all_balances(0x2::linked_table::borrow<0x1::ascii::String, 0xeab2f47d1de0489e8ba85bd98d6bfc2ea27cf1c43937aa293b65c36c44bb421::wallet::Wallet>(v3, v5)));
                v4 = 0x2::linked_table::next<0x1::ascii::String, 0xeab2f47d1de0489e8ba85bd98d6bfc2ea27cf1c43937aa293b65c36c44bb421::wallet::Wallet>(v3, v5);
            };
            v1 = 0x2::linked_table::next<address, 0x2::linked_table::LinkedTable<0x1::ascii::String, 0xeab2f47d1de0489e8ba85bd98d6bfc2ea27cf1c43937aa293b65c36c44bb421::wallet::Wallet>>(&arg0.wallets, v2);
        };
        v0
    }

    fun has_wallet(arg0: &Portfolio, arg1: address, arg2: 0x1::ascii::String) : bool {
        0x2::linked_table::contains<address, 0x2::linked_table::LinkedTable<0x1::ascii::String, 0xeab2f47d1de0489e8ba85bd98d6bfc2ea27cf1c43937aa293b65c36c44bb421::wallet::Wallet>>(&arg0.wallets, arg1) && 0x2::linked_table::contains<0x1::ascii::String, 0xeab2f47d1de0489e8ba85bd98d6bfc2ea27cf1c43937aa293b65c36c44bb421::wallet::Wallet>(0x2::linked_table::borrow<address, 0x2::linked_table::LinkedTable<0x1::ascii::String, 0xeab2f47d1de0489e8ba85bd98d6bfc2ea27cf1c43937aa293b65c36c44bb421::wallet::Wallet>>(&arg0.wallets, arg1), arg2)
    }

    fun init(arg0: &mut 0x2::tx_context::TxContext) {
        let v0 = Portfolio{
            id      : 0x2::object::new(arg0),
            wallets : 0x2::linked_table::new<address, 0x2::linked_table::LinkedTable<0x1::ascii::String, 0xeab2f47d1de0489e8ba85bd98d6bfc2ea27cf1c43937aa293b65c36c44bb421::wallet::Wallet>>(arg0),
        };
        0x2::transfer::share_object<Portfolio>(v0);
    }

    public(friend) fun transfer_all<T0>(arg0: &mut Portfolio, arg1: address, arg2: 0x1::ascii::String, arg3: 0x1::ascii::String, arg4: &mut 0x2::tx_context::TxContext) {
        transfer<T0>(arg0, arg1, arg2, arg3, 0x1::option::none<u64>(), arg4);
        let v0 = withdraw_fee<T0>(arg0, arg1, arg2, 0x1::option::none<u64>());
        deposit_fee<T0>(arg0, arg1, arg3, v0, arg4);
        let v1 = withdraw_reward<T0>(arg0, arg1, arg2, 0x1::option::none<u64>());
        deposit_reward<T0>(arg0, arg1, arg3, v1, arg4);
    }

    public(friend) fun withdraw<T0>(arg0: &mut Portfolio, arg1: address, arg2: 0x1::ascii::String, arg3: 0x1::option::Option<u64>) : 0x2::balance::Balance<T0> {
        if (has_wallet(arg0, arg1, arg2)) {
            0xeab2f47d1de0489e8ba85bd98d6bfc2ea27cf1c43937aa293b65c36c44bb421::wallet::withdraw<T0>(borrow_wallet_mut(arg0, arg1, arg2), arg3)
        } else {
            0x2::balance::zero<T0>()
        }
    }

    public(friend) fun withdraw_fee<T0>(arg0: &mut Portfolio, arg1: address, arg2: 0x1::ascii::String, arg3: 0x1::option::Option<u64>) : 0x2::balance::Balance<T0> {
        if (has_wallet(arg0, arg1, arg2)) {
            0xeab2f47d1de0489e8ba85bd98d6bfc2ea27cf1c43937aa293b65c36c44bb421::wallet::withdraw_fee<T0>(borrow_wallet_mut(arg0, arg1, arg2), arg3)
        } else {
            0x2::balance::zero<T0>()
        }
    }

    public(friend) fun withdraw_reward<T0>(arg0: &mut Portfolio, arg1: address, arg2: 0x1::ascii::String, arg3: 0x1::option::Option<u64>) : 0x2::balance::Balance<T0> {
        if (has_wallet(arg0, arg1, arg2)) {
            0xeab2f47d1de0489e8ba85bd98d6bfc2ea27cf1c43937aa293b65c36c44bb421::wallet::withdraw_reward<T0>(borrow_wallet_mut(arg0, arg1, arg2), arg3)
        } else {
            0x2::balance::zero<T0>()
        }
    }

    // decompiled from Move bytecode v6
}

