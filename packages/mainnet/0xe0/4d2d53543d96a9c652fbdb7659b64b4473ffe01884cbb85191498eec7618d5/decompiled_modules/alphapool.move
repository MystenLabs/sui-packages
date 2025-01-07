module 0xe04d2d53543d96a9c652fbdb7659b64b4473ffe01884cbb85191498eec7618d5::alphapool {
    struct Pool<phantom T0> has store, key {
        id: 0x2::object::UID,
        xTokenSupply: u64,
        tokensInvested: u64,
        rewards: 0x2::bag::Bag,
        acc_rewards_per_xtoken: 0x2::vec_map::VecMap<0x1::type_name::TypeName, u256>,
        locked_period_in_days: u64,
        locking_start_day: u64,
        alpha_bal: 0x2::balance::Balance<T0>,
        locked_balance_withdrawal_fee: u64,
        deposit_fee: u64,
        deposit_fee_max_cap: u64,
        withdrawal_fee: u64,
        withdraw_fee_max_cap: u64,
    }

    struct Receipt has store, key {
        id: 0x2::object::UID,
        pool_id: 0x2::object::ID,
        xTokenBalance: u64,
        last_acc_reward_per_xtoken: 0x2::vec_map::VecMap<0x1::type_name::TypeName, u256>,
        locked_balance: 0x2::linked_table::LinkedTable<u64, u64>,
        balance: u256,
    }

    struct ALPHAPOOL has drop {
        dummy_field: bool,
    }

    fun assert_receipt<T0>(arg0: &Receipt, arg1: &Pool<T0>) {
        assert!(arg0.pool_id == 0x2::object::uid_to_inner(&arg1.id), 0);
    }

    public fun create<T0>(arg0: &0xe04d2d53543d96a9c652fbdb7659b64b4473ffe01884cbb85191498eec7618d5::alpha::Admin_cap, arg1: u64, arg2: &0x2::clock::Clock, arg3: u64, arg4: u64, arg5: &mut 0x2::tx_context::TxContext) {
        let v0 = Pool<T0>{
            id                            : 0x2::object::new(arg5),
            xTokenSupply                  : 0,
            tokensInvested                : 0,
            rewards                       : 0x2::bag::new(arg5),
            acc_rewards_per_xtoken        : 0x2::vec_map::empty<0x1::type_name::TypeName, u256>(),
            locked_period_in_days         : 200,
            locking_start_day             : 0x2::clock::timestamp_ms(arg2),
            alpha_bal                     : 0x2::balance::zero<T0>(),
            locked_balance_withdrawal_fee : arg1,
            deposit_fee                   : 0,
            deposit_fee_max_cap           : arg3,
            withdrawal_fee                : 0,
            withdraw_fee_max_cap          : arg4,
        };
        0x2::transfer::public_share_object<Pool<T0>>(v0);
    }

    fun deposit<T0>(arg0: 0x1::option::Option<Receipt>, arg1: &mut Pool<T0>, arg2: &mut 0xe04d2d53543d96a9c652fbdb7659b64b4473ffe01884cbb85191498eec7618d5::distributor::Distributor, arg3: 0x2::balance::Balance<T0>, arg4: &0x2::clock::Clock, arg5: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::balance::value<T0>(&arg3);
        arg1.tokensInvested = arg1.tokensInvested + v0;
        0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(0x2::coin::from_balance<T0>(0x2::balance::split<T0>(&mut arg3, 0x2::balance::value<T0>(&arg3) * arg1.deposit_fee / 100), arg5), 0xe04d2d53543d96a9c652fbdb7659b64b4473ffe01884cbb85191498eec7618d5::distributor::get_fee_wallet_address(arg2));
        0x2::balance::join<T0>(&mut arg1.alpha_bal, arg3);
        let v1 = (v0 as u256) * exchange_rate<T0>(arg1) / (1000000000 as u256);
        arg1.xTokenSupply = arg1.xTokenSupply + (v1 as u64);
        let v2 = (v1 as u64);
        let v3 = arg1.locking_start_day + arg1.locked_period_in_days * 86400000;
        if (0x1::option::is_some<Receipt>(&arg0) == true) {
            let v4 = 0x1::option::extract<Receipt>(&mut arg0);
            v4.xTokenBalance = v4.xTokenBalance + (v2 as u64);
            let v5 = &mut v4;
            unlock_locked_balance_for_user<T0>(arg1, v5, arg4);
            if (0x2::linked_table::contains<u64, u64>(&v4.locked_balance, v3) == true) {
                let v6 = 0x2::linked_table::borrow_mut<u64, u64>(&mut v4.locked_balance, v3);
                *v6 = *v6 + v2;
            } else {
                let v7 = &mut v4;
                insert_to_locked_balance(v7, v3, v2, arg5);
            };
            0x2::transfer::public_transfer<Receipt>(v4, 0x2::tx_context::sender(arg5));
        } else {
            let v8 = 0x2::vec_map::empty<0x1::type_name::TypeName, u256>();
            let v9 = 0;
            while (v9 < 0x2::vec_map::size<0x1::type_name::TypeName, u256>(&arg1.acc_rewards_per_xtoken)) {
                let (v10, v11) = 0x2::vec_map::get_entry_by_idx_mut<0x1::type_name::TypeName, u256>(&mut arg1.acc_rewards_per_xtoken, v9);
                0x2::vec_map::insert<0x1::type_name::TypeName, u256>(&mut v8, *v10, *v11);
                v9 = v9 + 1;
            };
            let v12 = 0x2::linked_table::new<u64, u64>(arg5);
            0x2::linked_table::push_back<u64, u64>(&mut v12, v3, v2);
            let v13 = Receipt{
                id                         : 0x2::object::new(arg5),
                pool_id                    : 0x2::object::uid_to_inner(&arg1.id),
                xTokenBalance              : (v1 as u64),
                last_acc_reward_per_xtoken : v8,
                locked_balance             : v12,
                balance                    : 0,
            };
            0x2::transfer::public_transfer<Receipt>(v13, 0x2::tx_context::sender(arg5));
        };
        0x1::option::destroy_none<Receipt>(arg0);
    }

    fun destroy_receipt_and_transfer_rewards<T0>(arg0: Receipt, arg1: &mut Pool<T0>, arg2: &mut 0xe04d2d53543d96a9c652fbdb7659b64b4473ffe01884cbb85191498eec7618d5::distributor::Distributor, arg3: &0x2::clock::Clock, arg4: &mut 0x2::tx_context::TxContext) {
        let v0 = &mut arg0;
        get_user_rewards_all<T0>(v0, arg1, arg2, arg3, arg4);
        let Receipt {
            id                         : v1,
            pool_id                    : _,
            xTokenBalance              : _,
            last_acc_reward_per_xtoken : v4,
            locked_balance             : v5,
            balance                    : _,
        } = arg0;
        let v7 = v4;
        0x2::object::delete(v1);
        let v8 = 0;
        while (v8 < 0x2::vec_map::size<0x1::type_name::TypeName, u256>(&v7)) {
            let (_, _) = 0x2::vec_map::pop<0x1::type_name::TypeName, u256>(&mut v7);
            v8 = v8 + 1;
        };
        0x2::vec_map::destroy_empty<0x1::type_name::TypeName, u256>(v7);
        0x2::linked_table::destroy_empty<u64, u64>(v5);
    }

    fun exchange_rate<T0>(arg0: &Pool<T0>) : u256 {
        if (arg0.tokensInvested == 0 || arg0.xTokenSupply == 0) {
            (1000000000 as u256)
        } else {
            (arg0.xTokenSupply as u256) * (1000000000 as u256) / (arg0.tokensInvested as u256)
        }
    }

    public fun get_pool_rewards_all<T0>(arg0: &mut Pool<T0>, arg1: &mut 0xe04d2d53543d96a9c652fbdb7659b64b4473ffe01884cbb85191498eec7618d5::distributor::Distributor, arg2: &0x2::clock::Clock, arg3: &mut 0x2::tx_context::TxContext) {
        get_rewards<T0, 0xe04d2d53543d96a9c652fbdb7659b64b4473ffe01884cbb85191498eec7618d5::alpha::ALPHA>(arg0, arg1, arg2, arg3);
        get_rewards<T0, 0x2::sui::SUI>(arg0, arg1, arg2, arg3);
    }

    fun get_rewards<T0, T1>(arg0: &mut Pool<T0>, arg1: &mut 0xe04d2d53543d96a9c652fbdb7659b64b4473ffe01884cbb85191498eec7618d5::distributor::Distributor, arg2: &0x2::clock::Clock, arg3: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x1::string::from_ascii(0x1::type_name::into_string(0x1::type_name::get<T1>()));
        let v1 = 0x1::string::utf8(b"ALPHA");
        if (0x1::string::index_of(&v0, &v1) < 0x1::string::length(&v0)) {
            0x2::balance::join<T0>(&mut arg0.alpha_bal, 0xe04d2d53543d96a9c652fbdb7659b64b4473ffe01884cbb85191498eec7618d5::distributor::get_rewards<T0>(arg1, 0x2::object::uid_to_inner(&arg0.id), arg2, arg3));
        } else {
            let v2 = 0xe04d2d53543d96a9c652fbdb7659b64b4473ffe01884cbb85191498eec7618d5::distributor::get_rewards<T1>(arg1, 0x2::object::uid_to_inner(&arg0.id), arg2, arg3);
            let v3 = 0x1::type_name::get<T1>();
            if (0x2::bag::contains<0x1::type_name::TypeName>(&arg0.rewards, v3) == true) {
                let v4 = 0x2::vec_map::get_mut<0x1::type_name::TypeName, u256>(&mut arg0.acc_rewards_per_xtoken, &v3);
                *v4 = *v4 + (0x2::balance::value<T1>(&v2) as u256) * (1000000000 as u256) / (arg0.xTokenSupply as u256);
                0x2::balance::join<T1>(0x2::bag::borrow_mut<0x1::type_name::TypeName, 0x2::balance::Balance<T1>>(&mut arg0.rewards, v3), v2);
            } else {
                0x2::vec_map::insert<0x1::type_name::TypeName, u256>(&mut arg0.acc_rewards_per_xtoken, v3, (0x2::balance::value<T1>(&v2) as u256) * (1000000000 as u256) / (arg0.xTokenSupply as u256));
                0x2::bag::add<0x1::type_name::TypeName, 0x2::balance::Balance<T1>>(&mut arg0.rewards, v3, v2);
            };
        };
    }

    public fun get_user_rewards<T0, T1>(arg0: &mut Receipt, arg1: &mut Pool<T0>, arg2: &mut 0xe04d2d53543d96a9c652fbdb7659b64b4473ffe01884cbb85191498eec7618d5::distributor::Distributor, arg3: &0x2::clock::Clock, arg4: &mut 0x2::tx_context::TxContext) : 0x2::balance::Balance<T1> {
        get_rewards<T0, T1>(arg1, arg2, arg3, arg4);
        let v0 = 0x1::type_name::get<T1>();
        if (0x2::bag::contains<0x1::type_name::TypeName>(&arg1.rewards, v0) == true) {
            let v2 = 0x2::vec_map::get_mut<0x1::type_name::TypeName, u256>(&mut arg1.acc_rewards_per_xtoken, &v0);
            let v3 = if (0x2::vec_map::contains<0x1::type_name::TypeName, u256>(&arg0.last_acc_reward_per_xtoken, &v0) == true) {
                let v4 = 0x2::vec_map::get_mut<0x1::type_name::TypeName, u256>(&mut arg0.last_acc_reward_per_xtoken, &v0);
                *v4 = *v2;
                *v4
            } else {
                0x2::vec_map::insert<0x1::type_name::TypeName, u256>(&mut arg0.last_acc_reward_per_xtoken, v0, *v2);
                0
            };
            0x2::balance::split<T1>(0x2::bag::borrow_mut<0x1::type_name::TypeName, 0x2::balance::Balance<T1>>(&mut arg1.rewards, v0), (((*v2 - v3) * (arg0.xTokenBalance as u256) / (1000000000 as u256)) as u64))
        } else {
            0x2::balance::zero<T1>()
        }
    }

    public fun get_user_rewards_all<T0>(arg0: &mut Receipt, arg1: &mut Pool<T0>, arg2: &mut 0xe04d2d53543d96a9c652fbdb7659b64b4473ffe01884cbb85191498eec7618d5::distributor::Distributor, arg3: &0x2::clock::Clock, arg4: &mut 0x2::tx_context::TxContext) {
        let v0 = get_user_rewards<T0, 0x2::sui::SUI>(arg0, arg1, arg2, arg3, arg4);
        0x2::transfer::public_transfer<0x2::coin::Coin<0x2::sui::SUI>>(0x2::coin::from_balance<0x2::sui::SUI>(v0, arg4), 0x2::tx_context::sender(arg4));
    }

    fun init(arg0: ALPHAPOOL, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x1::vector::empty<0x1::string::String>();
        let v1 = &mut v0;
        0x1::vector::push_back<0x1::string::String>(v1, 0x1::string::utf8(b"name"));
        0x1::vector::push_back<0x1::string::String>(v1, 0x1::string::utf8(b"image_url"));
        0x1::vector::push_back<0x1::string::String>(v1, 0x1::string::utf8(b"description"));
        0x1::vector::push_back<0x1::string::String>(v1, 0x1::string::utf8(b"creator"));
        let v2 = 0x1::vector::empty<0x1::string::String>();
        let v3 = &mut v2;
        0x1::vector::push_back<0x1::string::String>(v3, 0x1::string::utf8(b"Alpha-Pool-Receipt-Alpha"));
        0x1::vector::push_back<0x1::string::String>(v3, 0x1::string::utf8(b"https://media.gq.com/photos/5b6b20e3a3a1320b7280f029/16:9/w_2560%2Cc_limit/The-Brutal-Wonders-Of-The-Architecture-World-GQ-Style-Fall-2018_07.jpg"));
        0x1::vector::push_back<0x1::string::String>(v3, 0x1::string::utf8(b"Your stake object"));
        0x1::vector::push_back<0x1::string::String>(v3, 0x1::string::utf8(b"Unknown Sui Fan"));
        let v4 = 0x2::package::claim<ALPHAPOOL>(arg0, arg1);
        let v5 = 0x2::display::new_with_fields<Receipt>(&v4, v0, v2, arg1);
        0x2::display::update_version<Receipt>(&mut v5);
        0x2::transfer::public_transfer<0x2::package::Publisher>(v4, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::display::Display<Receipt>>(v5, 0x2::tx_context::sender(arg1));
    }

    fun insert_to_locked_balance(arg0: &mut Receipt, arg1: u64, arg2: u64, arg3: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::linked_table::new<u64, u64>(arg3);
        let v1 = false;
        while (0x2::linked_table::length<u64, u64>(&arg0.locked_balance) > 0) {
            let (v2, v3) = 0x2::linked_table::pop_front<u64, u64>(&mut arg0.locked_balance);
            if (v2 > arg1) {
                if (v1 == false) {
                    0x2::linked_table::push_back<u64, u64>(&mut v0, arg1, arg2);
                    v1 = true;
                };
            };
            0x2::linked_table::push_back<u64, u64>(&mut v0, v2, v3);
        };
        while (0x2::linked_table::length<u64, u64>(&v0) > 0) {
            let (v4, v5) = 0x2::linked_table::pop_front<u64, u64>(&mut v0);
            0x2::linked_table::push_back<u64, u64>(&mut arg0.locked_balance, v4, v5);
        };
        0x2::linked_table::destroy_empty<u64, u64>(v0);
    }

    public fun set_deposit_fee<T0>(arg0: &0xe04d2d53543d96a9c652fbdb7659b64b4473ffe01884cbb85191498eec7618d5::alpha::Admin_cap, arg1: &mut Pool<T0>, arg2: u64) {
        assert!(arg2 <= arg1.deposit_fee_max_cap, 9);
        arg1.deposit_fee = arg2;
    }

    public entry fun set_lock_period<T0>(arg0: &0xe04d2d53543d96a9c652fbdb7659b64b4473ffe01884cbb85191498eec7618d5::alpha::Admin_cap, arg1: &mut Pool<T0>, arg2: u64) {
        arg1.locked_period_in_days = arg2;
    }

    public fun set_withdrawal_fee<T0>(arg0: &0xe04d2d53543d96a9c652fbdb7659b64b4473ffe01884cbb85191498eec7618d5::alpha::Admin_cap, arg1: &mut Pool<T0>, arg2: u64) {
        assert!(arg2 <= arg1.withdraw_fee_max_cap, 9);
        arg1.withdrawal_fee = arg2;
    }

    fun unlock_locked_balance_for_user<T0>(arg0: &Pool<T0>, arg1: &mut Receipt, arg2: &0x2::clock::Clock) {
        while (0x2::linked_table::length<u64, u64>(&arg1.locked_balance) > 0) {
            let (v0, v1) = 0x2::linked_table::pop_front<u64, u64>(&mut arg1.locked_balance);
            if (0x2::clock::timestamp_ms(arg2) >= v0) {
                arg1.balance = arg1.balance + (v1 as u256) * (1000000000 as u256) / exchange_rate<T0>(arg0);
            } else {
                0x2::linked_table::push_front<u64, u64>(&mut arg1.locked_balance, v0, v1);
                break
            };
        };
    }

    fun unlock_xtokens_from_locked(arg0: &mut Receipt, arg1: u64) {
        let v0 = 0;
        while (0x2::linked_table::length<u64, u64>(&arg0.locked_balance) > 0) {
            let (v1, v2) = 0x2::linked_table::pop_back<u64, u64>(&mut arg0.locked_balance);
            if (v0 + v2 <= arg1) {
                v0 = v0 + v2;
            } else {
                0x2::linked_table::push_front<u64, u64>(&mut arg0.locked_balance, v1, v0 + v2 - arg1);
                break
            };
        };
    }

    fun update_pool<T0>(arg0: &mut Pool<T0>, arg1: &0x2::clock::Clock) {
        if ((0x2::clock::timestamp_ms(arg1) - arg0.locking_start_day) / 86400000 > 7) {
            arg0.locking_start_day = arg0.locking_start_day + 7 * 86400000;
        };
        arg0.tokensInvested = 0x2::balance::value<T0>(&arg0.alpha_bal);
    }

    public fun user_deposit<T0>(arg0: 0x1::option::Option<Receipt>, arg1: &mut Pool<T0>, arg2: &mut 0xe04d2d53543d96a9c652fbdb7659b64b4473ffe01884cbb85191498eec7618d5::distributor::Distributor, arg3: 0x2::coin::Coin<T0>, arg4: &0x2::clock::Clock, arg5: &mut 0x2::tx_context::TxContext) {
        update_pool<T0>(arg1, arg4);
        get_pool_rewards_all<T0>(arg1, arg2, arg4, arg5);
        if (0x1::option::is_some<Receipt>(&arg0) == true) {
            assert_receipt<T0>(0x1::option::borrow_mut<Receipt>(&mut arg0), arg1);
        };
        deposit<T0>(arg0, arg1, arg2, 0x2::coin::into_balance<T0>(arg3), arg4, arg5);
    }

    public fun user_withdraw<T0>(arg0: Receipt, arg1: &mut Pool<T0>, arg2: &mut 0xe04d2d53543d96a9c652fbdb7659b64b4473ffe01884cbb85191498eec7618d5::distributor::Distributor, arg3: u64, arg4: &0x2::clock::Clock, arg5: bool, arg6: &mut 0x2::tx_context::TxContext) {
        update_pool<T0>(arg1, arg4);
        get_pool_rewards_all<T0>(arg1, arg2, arg4, arg6);
        withdraw<T0>(arg0, arg1, arg2, arg3, arg4, arg5, arg6);
    }

    public fun user_xalpha_amount(arg0: &mut Receipt) : u64 {
        arg0.xTokenBalance
    }

    fun withdraw<T0>(arg0: Receipt, arg1: &mut Pool<T0>, arg2: &mut 0xe04d2d53543d96a9c652fbdb7659b64b4473ffe01884cbb85191498eec7618d5::distributor::Distributor, arg3: u64, arg4: &0x2::clock::Clock, arg5: bool, arg6: &mut 0x2::tx_context::TxContext) {
        let v0 = exchange_rate<T0>(arg1);
        assert_receipt<T0>(&arg0, arg1);
        let v1 = &mut arg0;
        unlock_locked_balance_for_user<T0>(arg1, v1, arg4);
        if (arg5 == true) {
            assert!(arg3 <= (((arg0.xTokenBalance as u256) * (1000000000 as u256) / v0) as u64), 7);
        } else {
            assert!(arg3 <= (arg0.balance as u64), 6);
        };
        let v2 = (arg3 as u256) * v0 / (1000000000 as u256);
        arg1.xTokenSupply = arg1.xTokenSupply - (v2 as u64);
        arg0.xTokenBalance = arg0.xTokenBalance - (v2 as u64);
        let v3 = 0;
        if (arg3 > (arg0.balance as u64) && arg5 == true) {
            let v4 = arg3 - (arg0.balance as u64);
            v3 = v4;
            arg3 = arg3 - v4;
        };
        let v5 = 0x2::balance::split<T0>(&mut arg1.alpha_bal, arg3);
        arg0.balance = arg0.balance - (arg3 as u256);
        if (v3 > 0) {
            let v6 = &mut arg0;
            unlock_xtokens_from_locked(v6, (((v3 as u256) * v0 / (1000000000 as u256)) as u64));
            0x2::balance::join<T0>(&mut v5, 0x2::balance::split<T0>(&mut arg1.alpha_bal, v3 - v3 * arg1.locked_balance_withdrawal_fee / 100));
        };
        0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(0x2::coin::from_balance<T0>(0x2::balance::split<T0>(&mut v5, 0x2::balance::value<T0>(&v5) * arg1.withdrawal_fee / 100), arg6), 0xe04d2d53543d96a9c652fbdb7659b64b4473ffe01884cbb85191498eec7618d5::distributor::get_fee_wallet_address(arg2));
        0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(0x2::coin::from_balance<T0>(v5, arg6), 0x2::tx_context::sender(arg6));
        let v7 = if (arg3 + v3 > arg1.tokensInvested) {
            0
        } else {
            arg1.tokensInvested - arg3 - v3
        };
        arg1.tokensInvested = v7;
        if (arg0.xTokenBalance == 0) {
            destroy_receipt_and_transfer_rewards<T0>(arg0, arg1, arg2, arg4, arg6);
        } else {
            0x2::transfer::public_transfer<Receipt>(arg0, 0x2::tx_context::sender(arg6));
        };
    }

    // decompiled from Move bytecode v6
}

