module 0xe65ffa58a77385e0393fc9bebfdc07d648f53453599e139d095ac138b3c6704c::IDO {
    struct IDO<phantom T0> has store, key {
        id: 0x2::object::UID,
        whitelist_start_time: u64,
        whitelist_end_time: u64,
        subscription_start_time: u64,
        subscription_end_time: u64,
        whitelist_claim_time: u64,
        subscription_claim_time: u64,
        soft_cap: u64,
        hard_cap: u64,
        min_commit: u64,
        max_commit: u64,
        wl_rate: u128,
        subscription_rate: u128,
        owner: address,
        whitelisted_addresses: vector<address>,
        whitelist_funded_amount: u64,
        subscription_funded_amount: u64,
        balance: 0x2::balance::Balance<T0>,
        sui_balance: 0x2::balance::Balance<0x2::sui::SUI>,
        account_deposited_wl_table: 0x2::table::Table<address, u128>,
        account_deposited_sub_table: 0x2::table::Table<address, u128>,
        status: u64,
    }

    struct IDOAdminCap has store, key {
        id: 0x2::object::UID,
    }

    struct WhitelistCommitEvent has copy, drop {
        sender: address,
        amount: u64,
    }

    struct SubscriptionCommitEvent has copy, drop {
        sender: address,
        amount: u64,
    }

    struct WhitelistClaimEvent has copy, drop {
        sender: address,
        received: u128,
    }

    struct SubscriptionClaimEvent has copy, drop {
        sender: address,
        received: u128,
    }

    public entry fun claim_subscription<T0>(arg0: &mut IDO<T0>, arg1: &0x2::clock::Clock, arg2: &mut 0x2::tx_context::TxContext) {
        assert!(0x2::clock::timestamp_ms(arg1) >= arg0.subscription_claim_time, 7);
        let v0 = 0x2::table::borrow_mut<address, u128>(&mut arg0.account_deposited_sub_table, 0x2::tx_context::sender(arg2));
        if (arg0.whitelist_funded_amount + arg0.subscription_funded_amount <= arg0.hard_cap) {
            let v1 = *v0 * 20000 * 1000000000 / 1000 * 1000000000;
            0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(0x2::coin::from_balance<T0>(0x2::balance::split<T0>(&mut arg0.balance, (v1 as u64)), arg2), 0x2::tx_context::sender(arg2));
            let v2 = SubscriptionClaimEvent{
                sender   : 0x2::tx_context::sender(arg2),
                received : v1,
            };
            0x2::event::emit<SubscriptionClaimEvent>(v2);
        } else {
            let v3 = *v0 * 20000 * (2000000000 as u128) * 1000000000 / (arg0.subscription_funded_amount as u128) * 1000 * 1000000000;
            0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(0x2::coin::from_balance<T0>(0x2::balance::split<T0>(&mut arg0.balance, (v3 as u64)), arg2), 0x2::tx_context::sender(arg2));
            0x2::transfer::public_transfer<0x2::coin::Coin<0x2::sui::SUI>>(0x2::coin::from_balance<0x2::sui::SUI>(0x2::balance::split<0x2::sui::SUI>(&mut arg0.sui_balance, ((*v0 - *v0 * (2000000000 as u128) / (arg0.subscription_funded_amount as u128)) as u64)), arg2), 0x2::tx_context::sender(arg2));
            let v4 = SubscriptionClaimEvent{
                sender   : 0x2::tx_context::sender(arg2),
                received : v3,
            };
            0x2::event::emit<SubscriptionClaimEvent>(v4);
        };
        *v0 = 0;
    }

    public entry fun claim_whitelist<T0>(arg0: &mut IDO<T0>, arg1: &0x2::clock::Clock, arg2: &mut 0x2::tx_context::TxContext) {
        assert!(0x2::clock::timestamp_ms(arg1) >= arg0.whitelist_claim_time, 7);
        let v0 = 0x2::table::borrow_mut<address, u128>(&mut arg0.account_deposited_wl_table, 0x2::tx_context::sender(arg2));
        let v1 = *v0 * 20000 * 1000000000 / 1000 * 1000000000;
        *v0 = 0;
        0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(0x2::coin::from_balance<T0>(0x2::balance::split<T0>(&mut arg0.balance, (v1 as u64)), arg2), 0x2::tx_context::sender(arg2));
        let v2 = WhitelistClaimEvent{
            sender   : 0x2::tx_context::sender(arg2),
            received : v1,
        };
        0x2::event::emit<WhitelistClaimEvent>(v2);
    }

    public entry fun commit_subscription<T0>(arg0: &mut IDO<T0>, arg1: vector<0x2::coin::Coin<0x2::sui::SUI>>, arg2: u64, arg3: &0x2::clock::Clock, arg4: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg4);
        assert!(arg0.whitelist_funded_amount != arg0.hard_cap, 3);
        let (v1, v2) = split_coin_vec<0x2::sui::SUI>(arg1, arg2, arg4);
        let v3 = v1;
        let v4 = 0x2::clock::timestamp_ms(arg3);
        assert!(v4 >= arg0.subscription_start_time && v4 <= arg0.subscription_end_time, 2);
        let v5 = 0x2::coin::value<0x2::sui::SUI>(&v3);
        if (!0x2::table::contains<address, u128>(&mut arg0.account_deposited_sub_table, v0)) {
            0x2::table::add<address, u128>(&mut arg0.account_deposited_sub_table, v0, (v5 as u128));
        } else {
            let v6 = 0x2::table::borrow_mut<address, u128>(&mut arg0.account_deposited_sub_table, v0);
            *v6 = *v6 + (v5 as u128);
        };
        arg0.subscription_funded_amount = arg0.subscription_funded_amount + v5;
        0x2::balance::join<0x2::sui::SUI>(&mut arg0.sui_balance, 0x2::coin::into_balance<0x2::sui::SUI>(v3));
        0x2::transfer::public_transfer<0x2::coin::Coin<0x2::sui::SUI>>(v2, 0x2::tx_context::sender(arg4));
        let v7 = SubscriptionCommitEvent{
            sender : 0x2::tx_context::sender(arg4),
            amount : v5,
        };
        0x2::event::emit<SubscriptionCommitEvent>(v7);
    }

    public entry fun commit_whitelist<T0>(arg0: &mut IDO<T0>, arg1: vector<0x2::coin::Coin<0x2::sui::SUI>>, arg2: u64, arg3: &0x2::clock::Clock, arg4: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg4);
        assert!(is_whitelisted<T0>(arg0, v0), 1);
        assert!(arg0.whitelist_funded_amount != arg0.hard_cap, 3);
        let v1 = false;
        if (arg0.whitelist_funded_amount + arg2 > arg0.hard_cap) {
            arg2 = arg0.hard_cap - arg0.whitelist_funded_amount;
            v1 = true;
        };
        let (v2, v3) = split_coin_vec<0x2::sui::SUI>(arg1, arg2, arg4);
        let v4 = v2;
        let v5 = 0x2::clock::timestamp_ms(arg3);
        assert!(v5 >= arg0.whitelist_start_time && v5 <= arg0.whitelist_end_time, 2);
        let v6 = 0x2::coin::value<0x2::sui::SUI>(&v4);
        arg0.whitelist_funded_amount = arg0.whitelist_funded_amount + v6;
        if (!0x2::table::contains<address, u128>(&mut arg0.account_deposited_wl_table, v0)) {
            if (!v1) {
                assert!(v6 >= arg0.min_commit, 5);
            };
            assert!(v6 <= arg0.max_commit, 6);
            0x2::table::add<address, u128>(&mut arg0.account_deposited_wl_table, v0, (v6 as u128));
        } else {
            let v7 = 0x2::table::borrow_mut<address, u128>(&mut arg0.account_deposited_wl_table, v0);
            assert!(*v7 + (v6 as u128) <= (arg0.max_commit as u128), 6);
            *v7 = *v7 + (v6 as u128);
        };
        0x2::balance::join<0x2::sui::SUI>(&mut arg0.sui_balance, 0x2::coin::into_balance<0x2::sui::SUI>(v4));
        0x2::transfer::public_transfer<0x2::coin::Coin<0x2::sui::SUI>>(v3, 0x2::tx_context::sender(arg4));
        let v8 = WhitelistCommitEvent{
            sender : 0x2::tx_context::sender(arg4),
            amount : v6,
        };
        0x2::event::emit<WhitelistCommitEvent>(v8);
    }

    public entry fun create_ido<T0>(arg0: &IDOAdminCap, arg1: u64, arg2: u64, arg3: u64, arg4: u64, arg5: u64, arg6: u64, arg7: u64, arg8: u64, arg9: &mut 0x2::tx_context::TxContext) {
        let v0 = IDO<T0>{
            id                          : 0x2::object::new(arg9),
            whitelist_start_time        : arg1,
            whitelist_end_time          : arg2,
            subscription_start_time     : arg3,
            subscription_end_time       : arg4,
            whitelist_claim_time        : arg5,
            subscription_claim_time     : arg6,
            soft_cap                    : 0,
            hard_cap                    : 2000000000,
            min_commit                  : arg7,
            max_commit                  : arg8,
            wl_rate                     : 20000,
            subscription_rate           : 20000,
            owner                       : 0x2::tx_context::sender(arg9),
            whitelisted_addresses       : 0x1::vector::empty<address>(),
            whitelist_funded_amount     : 0,
            subscription_funded_amount  : 0,
            balance                     : 0x2::balance::zero<T0>(),
            sui_balance                 : 0x2::balance::zero<0x2::sui::SUI>(),
            account_deposited_wl_table  : 0x2::table::new<address, u128>(arg9),
            account_deposited_sub_table : 0x2::table::new<address, u128>(arg9),
            status                      : 0,
        };
        0x2::transfer::share_object<IDO<T0>>(v0);
    }

    public fun deposited_sub_amount<T0>(arg0: &IDO<T0>, arg1: address) : u128 {
        *0x2::table::borrow<address, u128>(&arg0.account_deposited_sub_table, arg1)
    }

    public fun deposited_wl_amount<T0>(arg0: &IDO<T0>, arg1: address) : u128 {
        *0x2::table::borrow<address, u128>(&arg0.account_deposited_wl_table, arg1)
    }

    public entry fun finalize<T0>(arg0: &IDOAdminCap, arg1: &mut IDO<T0>, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        assert!(arg1.owner == 0x2::tx_context::sender(arg3), 4);
        0x2::transfer::public_transfer<0x2::coin::Coin<0x2::sui::SUI>>(0x2::coin::from_balance<0x2::sui::SUI>(0x2::balance::split<0x2::sui::SUI>(&mut arg1.sui_balance, 0x2::balance::value<0x2::sui::SUI>(&arg1.sui_balance)), arg3), arg2);
    }

    fun init(arg0: &mut 0x2::tx_context::TxContext) {
        let v0 = IDOAdminCap{id: 0x2::object::new(arg0)};
        0x2::transfer::transfer<IDOAdminCap>(v0, 0x2::tx_context::sender(arg0));
    }

    public fun is_whitelisted<T0>(arg0: &IDO<T0>, arg1: address) : bool {
        0x1::vector::contains<address>(&arg0.whitelisted_addresses, &arg1)
    }

    public entry fun set_whitelist<T0>(arg0: &IDOAdminCap, arg1: &mut IDO<T0>, arg2: vector<address>, arg3: &mut 0x2::tx_context::TxContext) {
        assert!(arg1.owner == 0x2::tx_context::sender(arg3), 4);
        0x1::vector::append<address>(&mut arg1.whitelisted_addresses, arg2);
    }

    public fun split_coin_vec<T0>(arg0: vector<0x2::coin::Coin<T0>>, arg1: u64, arg2: &mut 0x2::tx_context::TxContext) : (0x2::coin::Coin<T0>, 0x2::coin::Coin<T0>) {
        let v0 = 0x2::coin::zero<T0>(arg2);
        0x2::pay::join_vec<T0>(&mut v0, arg0);
        (0x2::coin::split<T0>(&mut v0, arg1, arg2), v0)
    }

    public entry fun topup_rewards<T0>(arg0: &mut IDO<T0>, arg1: 0x2::coin::Coin<T0>) {
        0x2::balance::join<T0>(&mut arg0.balance, 0x2::coin::into_balance<T0>(arg1));
    }

    // decompiled from Move bytecode v6
}

