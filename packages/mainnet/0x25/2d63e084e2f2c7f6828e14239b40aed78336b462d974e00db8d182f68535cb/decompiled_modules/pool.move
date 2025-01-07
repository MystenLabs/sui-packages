module 0x252d63e084e2f2c7f6828e14239b40aed78336b462d974e00db8d182f68535cb::pool {
    struct PublicPool<phantom T0> has store, key {
        id: 0x2::object::UID,
        start_date: u64,
        end_date: u64,
        token: 0x2::balance::Balance<T0>,
        bought: 0x2::table::Table<address, u64>,
        revenue: u64,
        sale_amount: u64,
        largest_buy_amount: u64,
        soft_cap: u64,
        max_contribution: u64,
    }

    struct PrivatePool<phantom T0> has store, key {
        id: 0x2::object::UID,
        start_date: u64,
        end_date: u64,
        token: 0x2::balance::Balance<T0>,
        whitelist: 0x2::table::Table<address, u64>,
        min_amount: u64,
        max_amount: u64,
        revenue: u64,
        price: u64,
        sale_amount: u64,
    }

    struct Ref has store, key {
        id: 0x2::object::UID,
        admin: address,
        ref_amount: 0x2::table::Table<address, u64>,
        ref_percentage: u64,
        ref_wallet: 0x2::table::Table<address, address>,
        sui: 0x2::balance::Balance<0x2::sui::SUI>,
        token_decimal: u64,
        total_ref_amount: u64,
        reward_pool: u64,
    }

    public entry fun add_a_wallet_to_whitelist<T0>(arg0: &mut Ref, arg1: &mut PrivatePool<T0>, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        assert!(arg0.admin == 0x2::tx_context::sender(arg3), 1);
        if (!0x2::table::contains<address, u64>(&arg1.whitelist, arg2)) {
            0x2::table::add<address, u64>(&mut arg1.whitelist, arg2, 0);
        };
    }

    public entry fun add_wallets_to_whitelist<T0>(arg0: &mut Ref, arg1: &mut PrivatePool<T0>, arg2: vector<address>, arg3: &mut 0x2::tx_context::TxContext) {
        assert!(arg0.admin == 0x2::tx_context::sender(arg3), 1);
        let v0 = 0;
        while (v0 < 0x1::vector::length<address>(&arg2)) {
            if (!0x2::table::contains<address, u64>(&arg1.whitelist, *0x1::vector::borrow<address>(&arg2, v0))) {
                0x2::table::add<address, u64>(&mut arg1.whitelist, *0x1::vector::borrow<address>(&arg2, v0), 0);
            };
            v0 = v0 + 1;
        };
    }

    fun buy<T0>(arg0: &mut Ref, arg1: 0x2::coin::Coin<0x2::sui::SUI>) {
        0x2::balance::join<0x2::sui::SUI>(&mut arg0.sui, 0x2::coin::into_balance<0x2::sui::SUI>(arg1));
    }

    public entry fun buy_token_private<T0>(arg0: &mut Ref, arg1: &mut PrivatePool<T0>, arg2: &0x2::clock::Clock, arg3: 0x2::coin::Coin<0x2::sui::SUI>, arg4: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg4);
        let v1 = 0x2::clock::timestamp_ms(arg2);
        let v2 = 0x2::coin::value<0x2::sui::SUI>(&arg3);
        assert!(arg1.end_date > 0, 4);
        assert!(arg1.end_date > v1, 5);
        assert!(arg1.start_date <= v1, 4);
        assert!(0x2::table::contains<address, u64>(&arg1.whitelist, v0), 2);
        assert!(v2 >= arg1.min_amount, 3);
        assert!(*0x2::table::borrow<address, u64>(&arg1.whitelist, v0) + v2 <= arg1.max_amount, 3);
        let v3 = 0x2::table::borrow_mut<address, u64>(&mut arg1.whitelist, v0);
        *v3 = *v3 + v2;
        buy<T0>(arg0, arg3);
        arg1.revenue = arg1.revenue + v2;
    }

    public entry fun buy_token_public<T0>(arg0: &mut Ref, arg1: &mut PublicPool<T0>, arg2: address, arg3: &0x2::clock::Clock, arg4: 0x2::coin::Coin<0x2::sui::SUI>, arg5: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg5);
        let v1 = 0x2::clock::timestamp_ms(arg3);
        let v2 = 0x2::coin::value<0x2::sui::SUI>(&arg4);
        assert!(arg1.end_date > 0, 4);
        assert!(arg1.end_date > v1, 5);
        assert!(arg1.start_date <= v1, 4);
        assert!(v0 != arg2, 8);
        if (0x2::table::contains<address, u64>(&arg1.bought, v0)) {
            let v3 = 0x2::table::borrow_mut<address, u64>(&mut arg1.bought, v0);
            let v4 = *v3 + v2;
            assert!(v4 <= arg1.max_contribution, 9);
            if (v4 > arg1.largest_buy_amount) {
                arg1.largest_buy_amount = v4;
            };
            *v3 = v4;
        } else {
            assert!(v2 <= arg1.max_contribution, 9);
            0x2::table::add<address, u64>(&mut arg1.bought, v0, v2);
            if (v2 > arg1.largest_buy_amount) {
                arg1.largest_buy_amount = v2;
            };
        };
        buy<T0>(arg0, arg4);
        arg1.revenue = arg1.revenue + v2;
        arg0.reward_pool = arg0.reward_pool + v2 * arg0.ref_percentage / 10000;
        if (0x2::address::to_u256(arg2) != 1) {
            arg0.total_ref_amount = arg0.total_ref_amount + v2;
            if (0x2::table::contains<address, address>(&mut arg0.ref_wallet, v0)) {
                let v5 = 0x2::table::borrow_mut<address, u64>(&mut arg0.ref_amount, arg2);
                *v5 = *v5 + v2;
            } else {
                0x2::table::add<address, address>(&mut arg0.ref_wallet, v0, arg2);
                0x2::table::add<address, u64>(&mut arg0.ref_amount, arg2, v2);
            };
        };
    }

    public entry fun change_admin(arg0: &mut Ref, arg1: address, arg2: &mut 0x2::tx_context::TxContext) {
        assert!(arg0.admin == 0x2::tx_context::sender(arg2), 1);
        arg0.admin = arg1;
    }

    fun claim<T0>(arg0: 0x2::balance::Balance<T0>, arg1: address, arg2: &mut 0x2::tx_context::TxContext) {
        0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(0x2::coin::from_balance<T0>(arg0, arg2), arg1);
    }

    public entry fun claim_private<T0>(arg0: &mut Ref, arg1: &mut PrivatePool<T0>, arg2: &0x2::clock::Clock, arg3: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg3);
        assert!(arg1.end_date > 0, 4);
        assert!(arg1.end_date < 0x2::clock::timestamp_ms(arg2), 6);
        let v1 = 0x2::table::borrow_mut<address, u64>(&mut arg1.whitelist, v0);
        claim<T0>(0x2::balance::split<T0>(&mut arg1.token, *v1 * arg1.price * arg0.token_decimal), v0, arg3);
        *v1 = 0;
    }

    public entry fun claim_public<T0>(arg0: &mut Ref, arg1: &mut PublicPool<T0>, arg2: &0x2::clock::Clock, arg3: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg3);
        assert!(arg1.end_date > 0, 4);
        assert!(arg1.end_date < 0x2::clock::timestamp_ms(arg2), 6);
        let v1 = 0x2::table::borrow_mut<address, u64>(&mut arg1.bought, v0);
        if (arg1.revenue >= arg1.soft_cap) {
            claim<T0>(0x2::balance::split<T0>(&mut arg1.token, *v1 * arg1.sale_amount * arg0.token_decimal / arg1.revenue), v0, arg3);
        } else {
            0x2::transfer::public_transfer<0x2::coin::Coin<0x2::sui::SUI>>(0x2::coin::take<0x2::sui::SUI>(&mut arg0.sui, *v1, arg3), v0);
        };
        *v1 = 0;
    }

    public entry fun claim_ref_reward<T0>(arg0: &mut Ref, arg1: &mut PublicPool<T0>, arg2: &0x2::clock::Clock, arg3: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg3);
        assert!(arg1.end_date > 0, 4);
        assert!(arg1.end_date < 0x2::clock::timestamp_ms(arg2), 6);
        assert!(0x2::table::contains<address, u64>(&arg0.ref_amount, v0), 7);
        let v1 = 0x2::table::borrow_mut<address, u64>(&mut arg0.ref_amount, v0);
        0x2::transfer::public_transfer<0x2::coin::Coin<0x2::sui::SUI>>(0x2::coin::from_balance<0x2::sui::SUI>(0x2::balance::split<0x2::sui::SUI>(&mut arg0.sui, *v1 * arg0.reward_pool / arg0.total_ref_amount), arg3), v0);
        *v1 = 0;
    }

    public entry fun create_pool<T0>(arg0: &mut Ref, arg1: u64, arg2: 0x2::coin::Coin<T0>, arg3: &mut 0x2::tx_context::TxContext) {
        assert!(arg0.admin == 0x2::tx_context::sender(arg3), 1);
        if (arg1 == 1) {
            let v0 = PrivatePool<T0>{
                id          : 0x2::object::new(arg3),
                start_date  : 0,
                end_date    : 0,
                token       : 0x2::coin::into_balance<T0>(arg2),
                whitelist   : 0x2::table::new<address, u64>(arg3),
                min_amount  : 0,
                max_amount  : 0,
                revenue     : 0,
                price       : 0,
                sale_amount : 0,
            };
            0x2::transfer::share_object<PrivatePool<T0>>(v0);
        } else {
            let v1 = PublicPool<T0>{
                id                 : 0x2::object::new(arg3),
                start_date         : 0,
                end_date           : 0,
                token              : 0x2::coin::into_balance<T0>(arg2),
                bought             : 0x2::table::new<address, u64>(arg3),
                revenue            : 0,
                sale_amount        : 0,
                largest_buy_amount : 0,
                soft_cap           : 0,
                max_contribution   : 0,
            };
            0x2::transfer::share_object<PublicPool<T0>>(v1);
        };
    }

    public entry fun deposit_to_private_pool<T0>(arg0: &mut PrivatePool<T0>, arg1: 0x2::coin::Coin<T0>, arg2: &mut Ref, arg3: &mut 0x2::tx_context::TxContext) {
        assert!(arg2.admin == 0x2::tx_context::sender(arg3), 1);
        0x2::balance::join<T0>(&mut arg0.token, 0x2::coin::into_balance<T0>(arg1));
    }

    public entry fun deposit_to_public_pool<T0>(arg0: &mut PublicPool<T0>, arg1: 0x2::coin::Coin<T0>, arg2: &mut Ref, arg3: &mut 0x2::tx_context::TxContext) {
        assert!(arg2.admin == 0x2::tx_context::sender(arg3), 1);
        0x2::balance::join<T0>(&mut arg0.token, 0x2::coin::into_balance<T0>(arg1));
    }

    fun init(arg0: &mut 0x2::tx_context::TxContext) {
        let v0 = Ref{
            id               : 0x2::object::new(arg0),
            admin            : 0x2::tx_context::sender(arg0),
            ref_amount       : 0x2::table::new<address, u64>(arg0),
            ref_percentage   : 0,
            ref_wallet       : 0x2::table::new<address, address>(arg0),
            sui              : 0x2::balance::zero<0x2::sui::SUI>(),
            token_decimal    : 100,
            total_ref_amount : 0,
            reward_pool      : 0,
        };
        0x2::transfer::share_object<Ref>(v0);
    }

    public entry fun remove_a_wallet_from_whitelist<T0>(arg0: &mut Ref, arg1: &mut PrivatePool<T0>, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        assert!(arg0.admin == 0x2::tx_context::sender(arg3), 1);
        if (0x2::table::contains<address, u64>(&arg1.whitelist, arg2)) {
            0x2::table::remove<address, u64>(&mut arg1.whitelist, arg2);
        };
    }

    public entry fun remove_wallets_from_whitelist<T0>(arg0: &mut Ref, arg1: &mut PrivatePool<T0>, arg2: vector<address>, arg3: &mut 0x2::tx_context::TxContext) {
        assert!(arg0.admin == 0x2::tx_context::sender(arg3), 1);
        let v0 = 0;
        while (v0 < 0x1::vector::length<address>(&arg2)) {
            if (0x2::table::contains<address, u64>(&arg1.whitelist, *0x1::vector::borrow<address>(&arg2, v0))) {
                0x2::table::remove<address, u64>(&mut arg1.whitelist, *0x1::vector::borrow<address>(&arg2, v0));
            };
            v0 = v0 + 1;
        };
    }

    public entry fun set_private_pool_info<T0>(arg0: &mut Ref, arg1: &mut PrivatePool<T0>, arg2: u64, arg3: u64, arg4: u64, arg5: u64, arg6: u64, arg7: u64, arg8: &mut 0x2::tx_context::TxContext) {
        assert!(arg0.admin == 0x2::tx_context::sender(arg8), 1);
        arg1.start_date = arg2;
        arg1.end_date = arg3;
        arg1.min_amount = arg4;
        arg1.max_amount = arg5;
        arg1.price = arg6;
        arg1.sale_amount = arg7;
    }

    public entry fun set_public_pool_info<T0>(arg0: &mut Ref, arg1: &mut PublicPool<T0>, arg2: u64, arg3: u64, arg4: u64, arg5: u64, arg6: u64, arg7: &mut 0x2::tx_context::TxContext) {
        assert!(arg0.admin == 0x2::tx_context::sender(arg7), 1);
        arg1.start_date = arg2;
        arg1.end_date = arg3;
        arg1.sale_amount = arg4;
        arg1.soft_cap = arg5;
        arg1.max_contribution = arg6;
    }

    public entry fun set_ref_percentage(arg0: &mut Ref, arg1: u64, arg2: &mut 0x2::tx_context::TxContext) {
        assert!(arg0.admin == 0x2::tx_context::sender(arg2), 1);
        arg0.ref_percentage = arg1;
    }

    public entry fun set_token_decimal(arg0: &mut Ref, arg1: u64, arg2: &mut 0x2::tx_context::TxContext) {
        assert!(arg0.admin == 0x2::tx_context::sender(arg2), 1);
        arg0.token_decimal = arg1;
    }

    public entry fun withdraw_from_private_pool<T0>(arg0: &mut PrivatePool<T0>, arg1: &mut Ref, arg2: address, arg3: u64, arg4: &mut 0x2::tx_context::TxContext) {
        assert!(arg1.admin == 0x2::tx_context::sender(arg4), 1);
        0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(0x2::coin::take<T0>(&mut arg0.token, arg3, arg4), arg2);
    }

    public entry fun withdraw_from_public_pool<T0>(arg0: &mut PublicPool<T0>, arg1: &mut Ref, arg2: address, arg3: u64, arg4: &mut 0x2::tx_context::TxContext) {
        assert!(arg1.admin == 0x2::tx_context::sender(arg4), 1);
        0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(0x2::coin::take<T0>(&mut arg0.token, arg3, arg4), arg2);
    }

    public entry fun withdraw_sui<T0>(arg0: &mut Ref, arg1: address, arg2: u64, arg3: &mut 0x2::tx_context::TxContext) {
        assert!(arg0.admin == 0x2::tx_context::sender(arg3), 1);
        0x2::transfer::public_transfer<0x2::coin::Coin<0x2::sui::SUI>>(0x2::coin::take<0x2::sui::SUI>(&mut arg0.sui, arg2, arg3), arg1);
    }

    // decompiled from Move bytecode v6
}

