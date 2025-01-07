module 0x94e3a352b5adc2b2774d37232d7a8103f33299b4f8d0d14f04597ddedd99f9ba::pool {
    struct AdminCap<phantom T0> has store, key {
        id: 0x2::object::UID,
    }

    struct Pool<phantom T0, phantom T1> has store, key {
        id: 0x2::object::UID,
        weight: u64,
        xTokenSupply: u64,
        tokensInvested: u64,
        alpha_rewards: 0x2::balance::Balance<0x94e3a352b5adc2b2774d37232d7a8103f33299b4f8d0d14f04597ddedd99f9ba::alpha::ALPHA>,
        acc_alpha_per_xtoken: u256,
        users: 0x2::vec_map::VecMap<address, Receipt<T0, T1>>,
        locked_period_in_days: u64,
        treasury: 0x2::coin::TreasuryCap<T1>,
    }

    struct Receipt<phantom T0, phantom T1> has store, key {
        id: 0x2::object::UID,
        pool_id: 0x2::object::ID,
        xTokenBalance: u64,
        alpha_balance: 0x2::balance::Balance<0x94e3a352b5adc2b2774d37232d7a8103f33299b4f8d0d14f04597ddedd99f9ba::alpha::ALPHA>,
        last_acc_alpha_per_xtoken: u256,
        investedAmount: u64,
        locked_balance: 0x2::linked_table::LinkedTable<u64, u64>,
        balance: u256,
    }

    struct Display has drop, store {
        pool_id: 0x2::object::ID,
        xTokenBalance: u64,
        alpha_balance: u64,
        last_acc_alpha_per_xtoken: u256,
        investedAmount: u64,
        balance: u256,
    }

    public fun deposit<T0, T1>(arg0: &mut Pool<T0, T1>, arg1: &mut 0x94e3a352b5adc2b2774d37232d7a8103f33299b4f8d0d14f04597ddedd99f9ba::investor::Investor<T0>, arg2: &mut 0xe87f1b2d498106a2c61421cec75b7b5c5e348512b0dc263949a0e7a3c256571a::rewards_pool::RewardsPool<T0>, arg3: &mut 0xe87f1b2d498106a2c61421cec75b7b5c5e348512b0dc263949a0e7a3c256571a::spool::Spool, arg4: &0xefe8b36d5b2e43728cc323298626b83177803521d195cfb11e15b910e892fddf::version::Version, arg5: &mut 0xefe8b36d5b2e43728cc323298626b83177803521d195cfb11e15b910e892fddf::market::Market, arg6: 0x2::balance::Balance<T0>, arg7: Receipt<T0, T1>, arg8: &0x2::clock::Clock, arg9: &mut 0x2::tx_context::TxContext) : Receipt<T0, T1> {
        update_pool<T0, T1>(arg0, arg1, arg2, arg3, arg8, arg4, arg5, arg9);
        let v0 = exchange_rate<T0, T1>(arg0);
        let v1 = &mut arg7;
        assert_receipt<T0, T1>(v1, arg0);
        let Receipt {
            id                        : v2,
            pool_id                   : v3,
            xTokenBalance             : v4,
            alpha_balance             : v5,
            last_acc_alpha_per_xtoken : v6,
            investedAmount            : v7,
            locked_balance            : v8,
            balance                   : _,
        } = arg7;
        let v10 = v8;
        0x2::linked_table::push_back<u64, u64>(&mut v10, 0x2::clock::timestamp_ms(arg8), 0x2::balance::value<T0>(&arg6));
        arg0.tokensInvested = arg0.tokensInvested + 0x2::balance::value<T0>(&arg6);
        0x94e3a352b5adc2b2774d37232d7a8103f33299b4f8d0d14f04597ddedd99f9ba::investor::deposit<T0>(arg1, arg3, arg4, arg5, 0x2::coin::from_balance<T0>(arg6, arg9), arg8, arg9);
        let v11 = (0x2::balance::value<T0>(&arg6) as u256) * v0 / (1000000000 as u256);
        arg0.xTokenSupply = arg0.xTokenSupply + (v11 as u64);
        0x2::transfer::public_transfer<0x2::coin::Coin<T1>>(0x2::coin::mint<T1>(&mut arg0.treasury, (v11 as u64), arg9), 0x2::tx_context::sender(arg9));
        let v12 = v4 + (v11 as u64);
        0x1::string::from_ascii(0x1::type_name::into_string(0x1::type_name::get<T0>()));
        0x2::object::delete(v2);
        Receipt<T0, T1>{
            id                        : 0x2::object::new(arg9),
            pool_id                   : v3,
            xTokenBalance             : v12,
            alpha_balance             : v5,
            last_acc_alpha_per_xtoken : v6,
            investedAmount            : v7 + 0x2::balance::value<T0>(&arg6),
            locked_balance            : v10,
            balance                   : (v12 as u256) * (1000000000 as u256) / exchange_rate<T0, T1>(arg0),
        }
    }

    fun assert_receipt<T0, T1>(arg0: &mut Receipt<T0, T1>, arg1: &mut Pool<T0, T1>) {
        assert!(arg0.pool_id == 0x2::object::uid_to_inner(&arg1.id), 0);
    }

    public fun create<T0, T1>(arg0: 0x2::coin::TreasuryCap<T1>, arg1: &mut 0x2::tx_context::TxContext) : AdminCap<T0> {
        let v0 = Pool<T0, T1>{
            id                    : 0x2::object::new(arg1),
            weight                : 0,
            xTokenSupply          : 0,
            tokensInvested        : 0,
            alpha_rewards         : 0x2::balance::zero<0x94e3a352b5adc2b2774d37232d7a8103f33299b4f8d0d14f04597ddedd99f9ba::alpha::ALPHA>(),
            acc_alpha_per_xtoken  : 0,
            users                 : 0x2::vec_map::empty<address, Receipt<T0, T1>>(),
            locked_period_in_days : 0,
            treasury              : arg0,
        };
        0x2::transfer::public_share_object<Pool<T0, T1>>(v0);
        AdminCap<T0>{id: 0x2::object::new(arg1)}
    }

    public fun deposit_new<T0, T1>(arg0: &mut Pool<T0, T1>, arg1: &mut 0x94e3a352b5adc2b2774d37232d7a8103f33299b4f8d0d14f04597ddedd99f9ba::investor::Investor<T0>, arg2: &mut 0xe87f1b2d498106a2c61421cec75b7b5c5e348512b0dc263949a0e7a3c256571a::rewards_pool::RewardsPool<T0>, arg3: &mut 0xe87f1b2d498106a2c61421cec75b7b5c5e348512b0dc263949a0e7a3c256571a::spool::Spool, arg4: &0xefe8b36d5b2e43728cc323298626b83177803521d195cfb11e15b910e892fddf::version::Version, arg5: &mut 0xefe8b36d5b2e43728cc323298626b83177803521d195cfb11e15b910e892fddf::market::Market, arg6: 0x2::balance::Balance<T0>, arg7: &0x2::clock::Clock, arg8: &mut 0x2::tx_context::TxContext) : Receipt<T0, T1> {
        update_pool<T0, T1>(arg0, arg1, arg2, arg3, arg7, arg4, arg5, arg8);
        let v0 = exchange_rate<T0, T1>(arg0);
        arg0.tokensInvested = arg0.tokensInvested + 0x2::balance::value<T0>(&arg6);
        let v1 = 0x2::coin::mint<T1>(&mut arg0.treasury, (((0x2::balance::value<T0>(&arg6) as u256) * v0 / (1000000000 as u256)) as u64), arg8);
        let v2 = 0x2::coin::value<T1>(&v1);
        0x2::transfer::public_transfer<0x2::coin::Coin<T1>>(v1, 0x2::tx_context::sender(arg8));
        arg0.xTokenSupply = arg0.xTokenSupply + v2;
        let v3 = 0x2::balance::value<T0>(&arg6);
        0x94e3a352b5adc2b2774d37232d7a8103f33299b4f8d0d14f04597ddedd99f9ba::investor::deposit<T0>(arg1, arg3, arg4, arg5, 0x2::coin::from_balance<T0>(arg6, arg8), arg7, arg8);
        let _ = exchange_rate<T0, T1>(arg0);
        let v5 = 0x2::linked_table::new<u64, u64>(arg8);
        0x2::linked_table::push_back<u64, u64>(&mut v5, 0x2::clock::timestamp_ms(arg7), v3);
        Receipt<T0, T1>{
            id                        : 0x2::object::new(arg8),
            pool_id                   : 0x2::object::uid_to_inner(&arg0.id),
            xTokenBalance             : v2,
            alpha_balance             : 0x2::balance::zero<0x94e3a352b5adc2b2774d37232d7a8103f33299b4f8d0d14f04597ddedd99f9ba::alpha::ALPHA>(),
            last_acc_alpha_per_xtoken : arg0.acc_alpha_per_xtoken,
            investedAmount            : v3,
            locked_balance            : v5,
            balance                   : (v3 as u256),
        }
    }

    public fun destroy_receipt<T0, T1>(arg0: Receipt<T0, T1>) {
        let Receipt {
            id                        : v0,
            pool_id                   : _,
            xTokenBalance             : _,
            alpha_balance             : v3,
            last_acc_alpha_per_xtoken : _,
            investedAmount            : _,
            locked_balance            : v6,
            balance                   : _,
        } = arg0;
        0x2::balance::destroy_zero<0x94e3a352b5adc2b2774d37232d7a8103f33299b4f8d0d14f04597ddedd99f9ba::alpha::ALPHA>(v3);
        0x2::linked_table::destroy_empty<u64, u64>(v6);
        0x2::object::delete(v0);
    }

    fun exchange_rate<T0, T1>(arg0: &mut Pool<T0, T1>) : u256 {
        if (arg0.tokensInvested == 0 || arg0.xTokenSupply == 0) {
            (1000000000 as u256)
        } else {
            (arg0.xTokenSupply as u256) * (1000000000 as u256) / (arg0.tokensInvested as u256)
        }
    }

    public fun unlock_locked_balance_for_user<T0, T1>(arg0: &mut Pool<T0, T1>, arg1: &mut Receipt<T0, T1>, arg2: &0x2::clock::Clock) {
        while (0x2::linked_table::length<u64, u64>(&arg1.locked_balance) > 0) {
            let (v0, v1) = 0x2::linked_table::pop_front<u64, u64>(&mut arg1.locked_balance);
            if ((0x2::clock::timestamp_ms(arg2) - v0) / 8640000 >= arg0.locked_period_in_days) {
                arg1.balance = arg1.balance + (v1 as u256);
            } else {
                0x2::linked_table::push_front<u64, u64>(&mut arg1.locked_balance, v0, v1);
                break
            };
        };
    }

    public fun update_pool<T0, T1>(arg0: &mut Pool<T0, T1>, arg1: &mut 0x94e3a352b5adc2b2774d37232d7a8103f33299b4f8d0d14f04597ddedd99f9ba::investor::Investor<T0>, arg2: &mut 0xe87f1b2d498106a2c61421cec75b7b5c5e348512b0dc263949a0e7a3c256571a::rewards_pool::RewardsPool<T0>, arg3: &mut 0xe87f1b2d498106a2c61421cec75b7b5c5e348512b0dc263949a0e7a3c256571a::spool::Spool, arg4: &0x2::clock::Clock, arg5: &0xefe8b36d5b2e43728cc323298626b83177803521d195cfb11e15b910e892fddf::version::Version, arg6: &mut 0xefe8b36d5b2e43728cc323298626b83177803521d195cfb11e15b910e892fddf::market::Market, arg7: &mut 0x2::tx_context::TxContext) {
        arg0.tokensInvested = arg0.tokensInvested + 0x94e3a352b5adc2b2774d37232d7a8103f33299b4f8d0d14f04597ddedd99f9ba::investor::collect_all_rewards_and_reinvest<T0>(arg1, arg2, arg3, arg4, arg5, arg6, arg7);
    }

    public entry fun user_deposit<T0, T1>(arg0: &mut Pool<T0, T1>, arg1: &mut 0x94e3a352b5adc2b2774d37232d7a8103f33299b4f8d0d14f04597ddedd99f9ba::investor::Investor<T0>, arg2: &mut 0xe87f1b2d498106a2c61421cec75b7b5c5e348512b0dc263949a0e7a3c256571a::rewards_pool::RewardsPool<T0>, arg3: &mut 0xe87f1b2d498106a2c61421cec75b7b5c5e348512b0dc263949a0e7a3c256571a::spool::Spool, arg4: &0xefe8b36d5b2e43728cc323298626b83177803521d195cfb11e15b910e892fddf::version::Version, arg5: &mut 0xefe8b36d5b2e43728cc323298626b83177803521d195cfb11e15b910e892fddf::market::Market, arg6: 0x2::coin::Coin<T0>, arg7: &0x2::clock::Clock, arg8: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg8);
        let v1 = if (0x2::vec_map::contains<address, Receipt<T0, T1>>(&arg0.users, &v0) == true) {
            let (_, v3) = 0x2::vec_map::remove<address, Receipt<T0, T1>>(&mut arg0.users, &v0);
            deposit<T0, T1>(arg0, arg1, arg2, arg3, arg4, arg5, 0x2::coin::into_balance<T0>(arg6), v3, arg7, arg8)
        } else {
            deposit_new<T0, T1>(arg0, arg1, arg2, arg3, arg4, arg5, 0x2::coin::into_balance<T0>(arg6), arg7, arg8)
        };
        0x2::vec_map::insert<address, Receipt<T0, T1>>(&mut arg0.users, v0, v1);
    }

    public entry fun user_withdraw<T0, T1>(arg0: &mut Pool<T0, T1>, arg1: &mut 0x94e3a352b5adc2b2774d37232d7a8103f33299b4f8d0d14f04597ddedd99f9ba::investor::Investor<T0>, arg2: &mut 0xe87f1b2d498106a2c61421cec75b7b5c5e348512b0dc263949a0e7a3c256571a::rewards_pool::RewardsPool<T0>, arg3: &mut 0xe87f1b2d498106a2c61421cec75b7b5c5e348512b0dc263949a0e7a3c256571a::spool::Spool, arg4: &0xefe8b36d5b2e43728cc323298626b83177803521d195cfb11e15b910e892fddf::version::Version, arg5: &mut 0xefe8b36d5b2e43728cc323298626b83177803521d195cfb11e15b910e892fddf::market::Market, arg6: 0x2::coin::Coin<T1>, arg7: &0x2::clock::Clock, arg8: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg8);
        assert!(0x2::vec_map::contains<address, Receipt<T0, T1>>(&arg0.users, &v0) == true, 2);
        let (_, v2) = 0x2::vec_map::remove<address, Receipt<T0, T1>>(&mut arg0.users, &v0);
        let v3 = withdraw<T0, T1>(v2, arg0, arg1, arg2, arg3, arg4, arg5, arg6, v0, arg7, arg8);
        0x2::vec_map::insert<address, Receipt<T0, T1>>(&mut arg0.users, v0, v3);
    }

    public fun withdraw<T0, T1>(arg0: Receipt<T0, T1>, arg1: &mut Pool<T0, T1>, arg2: &mut 0x94e3a352b5adc2b2774d37232d7a8103f33299b4f8d0d14f04597ddedd99f9ba::investor::Investor<T0>, arg3: &mut 0xe87f1b2d498106a2c61421cec75b7b5c5e348512b0dc263949a0e7a3c256571a::rewards_pool::RewardsPool<T0>, arg4: &mut 0xe87f1b2d498106a2c61421cec75b7b5c5e348512b0dc263949a0e7a3c256571a::spool::Spool, arg5: &0xefe8b36d5b2e43728cc323298626b83177803521d195cfb11e15b910e892fddf::version::Version, arg6: &mut 0xefe8b36d5b2e43728cc323298626b83177803521d195cfb11e15b910e892fddf::market::Market, arg7: 0x2::coin::Coin<T1>, arg8: address, arg9: &0x2::clock::Clock, arg10: &mut 0x2::tx_context::TxContext) : Receipt<T0, T1> {
        update_pool<T0, T1>(arg1, arg2, arg3, arg4, arg9, arg5, arg6, arg10);
        let v0 = exchange_rate<T0, T1>(arg1);
        let v1 = &mut arg0;
        assert_receipt<T0, T1>(v1, arg1);
        let v2 = (0x2::coin::value<T1>(&arg7) as u256) * (1000000000 as u256) / v0;
        let v3 = (v2 as u64);
        let v4 = 0x1::string::from_ascii(0x1::type_name::into_string(0x1::type_name::get<T0>()));
        let v5 = 0x1::string::utf8(b"ALPHA");
        if (0x1::string::index_of(&v4, &v5) < 0x1::string::length(&v4)) {
            assert!(v2 <= arg0.balance, 1);
        } else {
            assert!(v3 <= (((arg0.xTokenBalance as u256) * (1000000000 as u256) / v0) as u64), 1);
        };
        arg1.tokensInvested = arg1.tokensInvested - v3;
        let v6 = 0x2::coin::into_balance<T1>(arg7);
        arg1.xTokenSupply = arg1.xTokenSupply - 0x2::balance::value<T1>(&v6);
        let Receipt {
            id                        : v7,
            pool_id                   : v8,
            xTokenBalance             : v9,
            alpha_balance             : v10,
            last_acc_alpha_per_xtoken : v11,
            investedAmount            : v12,
            locked_balance            : v13,
            balance                   : _,
        } = arg0;
        let v15 = v9 - 0x2::balance::value<T1>(&v6);
        0x2::balance::decrease_supply<T1>(0x2::coin::supply_mut<T1>(&mut arg1.treasury), v6);
        0x2::object::delete(v7);
        Receipt<T0, T1>{
            id                        : 0x2::object::new(arg10),
            pool_id                   : v8,
            xTokenBalance             : v15,
            alpha_balance             : v10,
            last_acc_alpha_per_xtoken : v11,
            investedAmount            : v12,
            locked_balance            : v13,
            balance                   : (v15 as u256) * (1000000000 as u256) / exchange_rate<T0, T1>(arg1),
        }
    }

    // decompiled from Move bytecode v6
}

