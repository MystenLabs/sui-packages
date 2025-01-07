module 0x89bb824d493fee3248b2948224039bcde8bdc6deee2012dc11359841a1d5f2f6::alphapool {
    struct Pool<phantom T0> has store, key {
        id: 0x2::object::UID,
        name: vector<u8>,
        image_url: vector<u8>,
        xTokenSupply: u64,
        tokensInvested: u64,
        rewards: 0x2::bag::Bag,
        acc_rewards_per_xtoken: 0x2::vec_map::VecMap<0x1::type_name::TypeName, u256>,
        locked_period_in_days: u64,
        locking_start_day: u64,
        alpha_bal: 0x2::balance::Balance<T0>,
        instant_withdraw_fee: u64,
        instant_withdraw_fee_max_cap: u64,
        deposit_fee: u64,
        deposit_fee_max_cap: u64,
        withdrawal_fee: u64,
        withdraw_fee_max_cap: u64,
    }

    struct Receipt has store, key {
        id: 0x2::object::UID,
        owner: address,
        name: 0x1::string::String,
        image_url: 0x1::string::String,
        pool_id: 0x2::object::ID,
        xTokenBalance: u64,
        last_acc_reward_per_xtoken: 0x2::vec_map::VecMap<0x1::type_name::TypeName, u256>,
        locked_balance: 0x2::linked_table::LinkedTable<u64, u64>,
        balance: u256,
        pending_rewards: 0x2::vec_map::VecMap<0x1::type_name::TypeName, u64>,
    }

    struct ALPHAPOOL has drop {
        dummy_field: bool,
    }

    struct RewardEvent has copy, drop {
        coin_type: 0x1::type_name::TypeName,
        amount: u64,
        sender: address,
    }

    struct DepositEvent has copy, drop {
        coin_type: 0x1::type_name::TypeName,
        amount_deposited: u64,
        sender: address,
    }

    struct WithdrawEvent has copy, drop {
        coin_type: 0x1::type_name::TypeName,
        amount_to_withdraw: u64,
        sender: address,
    }

    fun assert_receipt<T0>(arg0: &Receipt, arg1: &Pool<T0>) {
        assert!(arg0.pool_id == 0x2::object::uid_to_inner(&arg1.id), 0x89bb824d493fee3248b2948224039bcde8bdc6deee2012dc11359841a1d5f2f6::error::invalid_receipt_error());
    }

    public fun create<T0>(arg0: &0x89bb824d493fee3248b2948224039bcde8bdc6deee2012dc11359841a1d5f2f6::distributor::AdminCap, arg1: &0x89bb824d493fee3248b2948224039bcde8bdc6deee2012dc11359841a1d5f2f6::version::Version, arg2: vector<u8>, arg3: vector<u8>, arg4: &0x2::clock::Clock, arg5: &mut 0x2::tx_context::TxContext) {
        0x89bb824d493fee3248b2948224039bcde8bdc6deee2012dc11359841a1d5f2f6::version::assert_current_version(arg1);
        let v0 = Pool<T0>{
            id                           : 0x2::object::new(arg5),
            name                         : arg2,
            image_url                    : arg3,
            xTokenSupply                 : 0,
            tokensInvested               : 0,
            rewards                      : 0x2::bag::new(arg5),
            acc_rewards_per_xtoken       : 0x2::vec_map::empty<0x1::type_name::TypeName, u256>(),
            locked_period_in_days        : 100,
            locking_start_day            : 0x2::clock::timestamp_ms(arg4),
            alpha_bal                    : 0x2::balance::zero<T0>(),
            instant_withdraw_fee         : 5000,
            instant_withdraw_fee_max_cap : 9000,
            deposit_fee                  : 0,
            deposit_fee_max_cap          : 100,
            withdrawal_fee               : 0,
            withdraw_fee_max_cap         : 100,
        };
        0x2::transfer::public_share_object<Pool<T0>>(v0);
    }

    public fun deposit<T0>(arg0: &0x89bb824d493fee3248b2948224039bcde8bdc6deee2012dc11359841a1d5f2f6::version::Version, arg1: 0x1::option::Option<Receipt>, arg2: &mut Pool<T0>, arg3: &mut 0x89bb824d493fee3248b2948224039bcde8bdc6deee2012dc11359841a1d5f2f6::distributor::Distributor, arg4: 0x2::coin::Coin<T0>, arg5: &0x2::clock::Clock, arg6: &mut 0x2::tx_context::TxContext) : 0x1::option::Option<Receipt> {
        0x89bb824d493fee3248b2948224039bcde8bdc6deee2012dc11359841a1d5f2f6::version::assert_current_version(arg0);
        if (0x1::option::is_some<Receipt>(&arg1) == true) {
            if (0x1::option::borrow<Receipt>(&arg1).owner != 0x2::tx_context::sender(arg6)) {
                0x2::transfer::public_transfer<Receipt>(0x1::option::extract<Receipt>(&mut arg1), 0x89bb824d493fee3248b2948224039bcde8bdc6deee2012dc11359841a1d5f2f6::distributor::get_onhold_receipts_wallet_address(arg3));
                0x1::option::destroy_none<Receipt>(arg1);
                0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(arg4, 0x2::tx_context::sender(arg6));
                return 0x1::option::none<Receipt>()
            };
        };
        assert!(0x2::coin::value<T0>(&arg4) > 0, 0x89bb824d493fee3248b2948224039bcde8bdc6deee2012dc11359841a1d5f2f6::error::zero_deposit_error());
        get_pool_rewards_all<T0>(arg0, arg2, arg3, arg5, arg6);
        update_pool<T0>(arg2, arg5);
        if (0x1::option::is_some<Receipt>(&arg1) == true) {
            assert_receipt<T0>(0x1::option::borrow_mut<Receipt>(&mut arg1), arg2);
        };
        let v0 = DepositEvent{
            coin_type        : 0x1::type_name::get<T0>(),
            amount_deposited : 0x2::coin::value<T0>(&arg4),
            sender           : 0x2::tx_context::sender(arg6),
        };
        0x2::event::emit<DepositEvent>(v0);
        let v1 = 0x2::coin::into_balance<T0>(arg4);
        0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(0x2::coin::from_balance<T0>(0x2::balance::split<T0>(&mut v1, (((0x2::balance::value<T0>(&v1) as u128) * (arg2.deposit_fee as u128) / 10000) as u64)), arg6), 0x89bb824d493fee3248b2948224039bcde8bdc6deee2012dc11359841a1d5f2f6::distributor::get_fee_wallet_address(arg3));
        let v2 = 0x2::balance::value<T0>(&v1);
        arg2.tokensInvested = arg2.tokensInvested + v2;
        0x2::balance::join<T0>(&mut arg2.alpha_bal, v1);
        let v3 = (v2 as u256) * (1000000000000000000000000000000000000 as u256) / exchange_rate<T0>(arg2);
        arg2.xTokenSupply = arg2.xTokenSupply + (v3 as u64);
        let v4 = (v3 as u64);
        let v5 = arg2.locking_start_day + arg2.locked_period_in_days * 86400000;
        let v6 = if (0x1::option::is_some<Receipt>(&arg1) == true) {
            let v7 = 0x1::option::extract<Receipt>(&mut arg1);
            let v8 = &mut v7;
            update_user_rewards_all<T0>(v8, arg2);
            v7.xTokenBalance = v7.xTokenBalance + (v4 as u64);
            if (0x2::linked_table::contains<u64, u64>(&v7.locked_balance, v5) == true) {
                let v9 = 0x2::linked_table::borrow_mut<u64, u64>(&mut v7.locked_balance, v5);
                *v9 = *v9 + v4;
            } else {
                let v10 = &mut v7;
                insert_to_locked_balance(v10, v5, v4, arg6);
            };
            v7
        } else {
            let v11 = 0x2::vec_map::empty<0x1::type_name::TypeName, u256>();
            let v12 = 0x2::vec_map::empty<0x1::type_name::TypeName, u64>();
            let v13 = 0;
            while (v13 < 0x2::vec_map::size<0x1::type_name::TypeName, u256>(&arg2.acc_rewards_per_xtoken)) {
                let (v14, v15) = 0x2::vec_map::get_entry_by_idx_mut<0x1::type_name::TypeName, u256>(&mut arg2.acc_rewards_per_xtoken, v13);
                0x2::vec_map::insert<0x1::type_name::TypeName, u256>(&mut v11, *v14, *v15);
                0x2::vec_map::insert<0x1::type_name::TypeName, u64>(&mut v12, *v14, 0);
                v13 = v13 + 1;
            };
            let v16 = 0x2::linked_table::new<u64, u64>(arg6);
            0x2::linked_table::push_back<u64, u64>(&mut v16, v5, v4);
            Receipt{id: 0x2::object::new(arg6), owner: 0x2::tx_context::sender(arg6), name: 0x1::string::utf8(arg2.name), image_url: 0x1::string::utf8(arg2.image_url), pool_id: 0x2::object::uid_to_inner(&arg2.id), xTokenBalance: (v3 as u64), last_acc_reward_per_xtoken: v11, locked_balance: v16, balance: 0, pending_rewards: v12}
        };
        0x1::option::destroy_none<Receipt>(arg1);
        0x1::option::some<Receipt>(v6)
    }

    fun destroy_receipt_and_transfer_rewards<T0>(arg0: &0x89bb824d493fee3248b2948224039bcde8bdc6deee2012dc11359841a1d5f2f6::version::Version, arg1: Receipt, arg2: &mut Pool<T0>, arg3: &mut 0x89bb824d493fee3248b2948224039bcde8bdc6deee2012dc11359841a1d5f2f6::distributor::Distributor, arg4: &0x2::clock::Clock, arg5: &mut 0x2::tx_context::TxContext) {
        0x89bb824d493fee3248b2948224039bcde8bdc6deee2012dc11359841a1d5f2f6::version::assert_current_version(arg0);
        assert!(arg1.xTokenBalance == 0, 0x89bb824d493fee3248b2948224039bcde8bdc6deee2012dc11359841a1d5f2f6::error::receipt_not_empty());
        let v0 = &mut arg1;
        get_user_rewards_all<T0>(arg0, v0, arg2, arg3, arg4, arg5);
        let Receipt {
            id                         : v1,
            owner                      : _,
            name                       : _,
            image_url                  : _,
            pool_id                    : _,
            xTokenBalance              : _,
            last_acc_reward_per_xtoken : v7,
            locked_balance             : v8,
            balance                    : _,
            pending_rewards            : _,
        } = arg1;
        let v11 = v7;
        0x2::object::delete(v1);
        let v12 = 0;
        while (v12 < 0x2::vec_map::size<0x1::type_name::TypeName, u256>(&v11)) {
            let (_, _) = 0x2::vec_map::pop<0x1::type_name::TypeName, u256>(&mut v11);
            v12 = v12 + 1;
        };
        0x2::vec_map::destroy_empty<0x1::type_name::TypeName, u256>(v11);
        0x2::linked_table::destroy_empty<u64, u64>(v8);
    }

    fun exchange_rate<T0>(arg0: &Pool<T0>) : u256 {
        if (arg0.tokensInvested == 0 || arg0.xTokenSupply == 0) {
            (1000000000000000000000000000000000000 as u256)
        } else {
            (arg0.tokensInvested as u256) * (1000000000000000000000000000000000000 as u256) / (arg0.xTokenSupply as u256)
        }
    }

    public fun get_pool_rewards_all<T0>(arg0: &0x89bb824d493fee3248b2948224039bcde8bdc6deee2012dc11359841a1d5f2f6::version::Version, arg1: &mut Pool<T0>, arg2: &mut 0x89bb824d493fee3248b2948224039bcde8bdc6deee2012dc11359841a1d5f2f6::distributor::Distributor, arg3: &0x2::clock::Clock, arg4: &mut 0x2::tx_context::TxContext) {
        0x89bb824d493fee3248b2948224039bcde8bdc6deee2012dc11359841a1d5f2f6::version::assert_current_version(arg0);
        get_rewards<T0, 0x98318c1869635bbc3861677b9b7f219a52f39ac27d8a713ca5c7804dfdde55cf::beta::BETA>(arg1, arg2, arg3, arg4);
        get_rewards<T0, 0x2::sui::SUI>(arg1, arg2, arg3, arg4);
    }

    fun get_rewards<T0, T1>(arg0: &mut Pool<T0>, arg1: &mut 0x89bb824d493fee3248b2948224039bcde8bdc6deee2012dc11359841a1d5f2f6::distributor::Distributor, arg2: &0x2::clock::Clock, arg3: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x1::type_name::get<T1>();
        if (arg0.xTokenSupply == 0) {
            if (0x2::bag::contains<0x1::type_name::TypeName>(&arg0.rewards, v0) == false) {
                0x2::vec_map::insert<0x1::type_name::TypeName, u256>(&mut arg0.acc_rewards_per_xtoken, v0, 0);
                0x2::bag::add<0x1::type_name::TypeName, 0x2::balance::Balance<T1>>(&mut arg0.rewards, v0, 0x2::balance::zero<T1>());
            };
            return
        };
        if (v0 == 0x1::type_name::get<0x98318c1869635bbc3861677b9b7f219a52f39ac27d8a713ca5c7804dfdde55cf::beta::BETA>()) {
            0x2::balance::join<T0>(&mut arg0.alpha_bal, 0x89bb824d493fee3248b2948224039bcde8bdc6deee2012dc11359841a1d5f2f6::distributor::get_rewards<T0>(arg1, 0x2::object::uid_to_inner(&arg0.id), arg2, arg3));
        } else {
            let v1 = 0x89bb824d493fee3248b2948224039bcde8bdc6deee2012dc11359841a1d5f2f6::distributor::get_rewards<T1>(arg1, 0x2::object::uid_to_inner(&arg0.id), arg2, arg3);
            if (0x2::bag::contains<0x1::type_name::TypeName>(&arg0.rewards, v0) == true) {
                let v2 = 0x2::vec_map::get_mut<0x1::type_name::TypeName, u256>(&mut arg0.acc_rewards_per_xtoken, &v0);
                *v2 = *v2 + (0x2::balance::value<T1>(&v1) as u256) * (1000000000000000000000000000000000000 as u256) / (arg0.xTokenSupply as u256);
                0x2::balance::join<T1>(0x2::bag::borrow_mut<0x1::type_name::TypeName, 0x2::balance::Balance<T1>>(&mut arg0.rewards, v0), v1);
            } else {
                0x2::vec_map::insert<0x1::type_name::TypeName, u256>(&mut arg0.acc_rewards_per_xtoken, v0, (0x2::balance::value<T1>(&v1) as u256) * (1000000000000000000000000000000000000 as u256) / (arg0.xTokenSupply as u256));
                0x2::bag::add<0x1::type_name::TypeName, 0x2::balance::Balance<T1>>(&mut arg0.rewards, v0, v1);
            };
        };
    }

    fun get_user_rewards<T0, T1>(arg0: &mut Receipt, arg1: &mut Pool<T0>, arg2: &mut 0x89bb824d493fee3248b2948224039bcde8bdc6deee2012dc11359841a1d5f2f6::distributor::Distributor, arg3: &0x2::clock::Clock, arg4: &mut 0x2::tx_context::TxContext) : 0x2::balance::Balance<T1> {
        get_rewards<T0, T1>(arg1, arg2, arg3, arg4);
        let v0 = 0x1::type_name::get<T1>();
        if (0x2::bag::contains<0x1::type_name::TypeName>(&arg1.rewards, v0) == true) {
            let v2 = 0x2::vec_map::get<0x1::type_name::TypeName, u256>(&arg1.acc_rewards_per_xtoken, &v0);
            let v3 = if (0x2::vec_map::contains<0x1::type_name::TypeName, u256>(&arg0.last_acc_reward_per_xtoken, &v0) == true) {
                let v4 = 0x2::vec_map::get_mut<0x1::type_name::TypeName, u256>(&mut arg0.last_acc_reward_per_xtoken, &v0);
                *v4 = *v2;
                *v4
            } else {
                0x2::vec_map::insert<0x1::type_name::TypeName, u256>(&mut arg0.last_acc_reward_per_xtoken, v0, *v2);
                0
            };
            let v5 = 0x2::vec_map::get_mut<0x1::type_name::TypeName, u64>(&mut arg0.pending_rewards, &v0);
            let v6 = (((*v2 - v3) * (arg0.xTokenBalance as u256) / (1000000000000000000000000000000000000 as u256)) as u64) + *v5;
            *v5 = 0;
            let v7 = RewardEvent{
                coin_type : 0x1::type_name::get<T1>(),
                amount    : v6,
                sender    : 0x2::tx_context::sender(arg4),
            };
            0x2::event::emit<RewardEvent>(v7);
            0x2::balance::split<T1>(0x2::bag::borrow_mut<0x1::type_name::TypeName, 0x2::balance::Balance<T1>>(&mut arg1.rewards, v0), v6)
        } else {
            0x2::balance::zero<T1>()
        }
    }

    public fun get_user_rewards_all<T0>(arg0: &0x89bb824d493fee3248b2948224039bcde8bdc6deee2012dc11359841a1d5f2f6::version::Version, arg1: &mut Receipt, arg2: &mut Pool<T0>, arg3: &mut 0x89bb824d493fee3248b2948224039bcde8bdc6deee2012dc11359841a1d5f2f6::distributor::Distributor, arg4: &0x2::clock::Clock, arg5: &mut 0x2::tx_context::TxContext) {
        0x89bb824d493fee3248b2948224039bcde8bdc6deee2012dc11359841a1d5f2f6::version::assert_current_version(arg0);
        let v0 = get_user_rewards<T0, 0x2::sui::SUI>(arg1, arg2, arg3, arg4, arg5);
        0x2::transfer::public_transfer<0x2::coin::Coin<0x2::sui::SUI>>(0x2::coin::from_balance<0x2::sui::SUI>(v0, arg5), 0x2::tx_context::sender(arg5));
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
        0x1::vector::push_back<0x1::string::String>(v3, 0x1::string::utf8(b"{name}"));
        0x1::vector::push_back<0x1::string::String>(v3, 0x1::string::utf8(b"{image_url}"));
        0x1::vector::push_back<0x1::string::String>(v3, 0x1::string::utf8(b"Your stake object"));
        0x1::vector::push_back<0x1::string::String>(v3, 0x1::string::utf8(b"Unknown Sui Fan"));
        let v4 = 0x2::package::claim<ALPHAPOOL>(arg0, arg1);
        let v5 = 0x2::display::new_with_fields<Receipt>(&v4, v0, v2, arg1);
        0x2::display::update_version<Receipt>(&mut v5);
        0x2::transfer::public_transfer<0x2::package::Publisher>(v4, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::display::Display<Receipt>>(v5, 0x2::tx_context::sender(arg1));
    }

    fun insert_to_locked_balance(arg0: &mut Receipt, arg1: u64, arg2: u64, arg3: &mut 0x2::tx_context::TxContext) {
        if (0x2::linked_table::length<u64, u64>(&arg0.locked_balance) == 0) {
            0x2::linked_table::push_back<u64, u64>(&mut arg0.locked_balance, arg1, arg2);
        } else {
            let v0 = 0x2::linked_table::new<u64, u64>(arg3);
            while (0x2::linked_table::length<u64, u64>(&arg0.locked_balance) > 0) {
                let (v1, v2) = 0x2::linked_table::pop_back<u64, u64>(&mut arg0.locked_balance);
                if (v1 < arg1) {
                    0x2::linked_table::push_back<u64, u64>(&mut arg0.locked_balance, v1, v2);
                    0x2::linked_table::push_back<u64, u64>(&mut arg0.locked_balance, arg1, arg2);
                    break
                };
                0x2::linked_table::push_back<u64, u64>(&mut v0, v1, v2);
            };
            while (0x2::linked_table::length<u64, u64>(&v0) > 0) {
                let (v3, v4) = 0x2::linked_table::pop_back<u64, u64>(&mut v0);
                0x2::linked_table::push_back<u64, u64>(&mut arg0.locked_balance, v3, v4);
            };
            0x2::linked_table::destroy_empty<u64, u64>(v0);
        };
    }

    entry fun set_deposit_fee<T0>(arg0: &0x89bb824d493fee3248b2948224039bcde8bdc6deee2012dc11359841a1d5f2f6::distributor::AdminCap, arg1: &0x89bb824d493fee3248b2948224039bcde8bdc6deee2012dc11359841a1d5f2f6::version::Version, arg2: &mut Pool<T0>, arg3: u64) {
        0x89bb824d493fee3248b2948224039bcde8bdc6deee2012dc11359841a1d5f2f6::version::assert_current_version(arg1);
        assert!(arg3 <= arg2.deposit_fee_max_cap, 0x89bb824d493fee3248b2948224039bcde8bdc6deee2012dc11359841a1d5f2f6::error::fee_too_high_error());
        arg2.deposit_fee = arg3;
    }

    entry fun set_instant_withdraw_fee<T0>(arg0: &0x89bb824d493fee3248b2948224039bcde8bdc6deee2012dc11359841a1d5f2f6::distributor::AdminCap, arg1: &0x89bb824d493fee3248b2948224039bcde8bdc6deee2012dc11359841a1d5f2f6::version::Version, arg2: &mut Pool<T0>, arg3: u64) {
        0x89bb824d493fee3248b2948224039bcde8bdc6deee2012dc11359841a1d5f2f6::version::assert_current_version(arg1);
        assert!(arg3 <= arg2.instant_withdraw_fee_max_cap, 0x89bb824d493fee3248b2948224039bcde8bdc6deee2012dc11359841a1d5f2f6::error::fee_too_high_error());
        arg2.instant_withdraw_fee = arg3;
    }

    entry fun set_lock_period<T0>(arg0: &0x89bb824d493fee3248b2948224039bcde8bdc6deee2012dc11359841a1d5f2f6::distributor::AdminCap, arg1: &0x89bb824d493fee3248b2948224039bcde8bdc6deee2012dc11359841a1d5f2f6::version::Version, arg2: &mut Pool<T0>, arg3: u64) {
        0x89bb824d493fee3248b2948224039bcde8bdc6deee2012dc11359841a1d5f2f6::version::assert_current_version(arg1);
        arg2.locked_period_in_days = arg3;
    }

    entry fun set_withdrawal_fee<T0>(arg0: &0x89bb824d493fee3248b2948224039bcde8bdc6deee2012dc11359841a1d5f2f6::distributor::AdminCap, arg1: &0x89bb824d493fee3248b2948224039bcde8bdc6deee2012dc11359841a1d5f2f6::version::Version, arg2: &mut Pool<T0>, arg3: u64) {
        0x89bb824d493fee3248b2948224039bcde8bdc6deee2012dc11359841a1d5f2f6::version::assert_current_version(arg1);
        assert!(arg3 <= arg2.withdraw_fee_max_cap, 0x89bb824d493fee3248b2948224039bcde8bdc6deee2012dc11359841a1d5f2f6::error::fee_too_high_error());
        arg2.withdrawal_fee = arg3;
    }

    fun unlock_locked_balance_for_user<T0>(arg0: &Pool<T0>, arg1: &mut Receipt, arg2: &0x2::clock::Clock) {
        while (0x2::linked_table::length<u64, u64>(&arg1.locked_balance) > 0) {
            let (v0, v1) = 0x2::linked_table::pop_front<u64, u64>(&mut arg1.locked_balance);
            if (0x2::clock::timestamp_ms(arg2) >= v0) {
                arg1.balance = arg1.balance + (v1 as u256) * exchange_rate<T0>(arg0) / (1000000000000000000000000000000000000 as u256);
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
                0x2::linked_table::push_back<u64, u64>(&mut arg0.locked_balance, v1, v0 + v2 - arg1);
                break
            };
        };
    }

    fun update_pool<T0>(arg0: &mut Pool<T0>, arg1: &0x2::clock::Clock) {
        let v0 = (0x2::clock::timestamp_ms(arg1) - arg0.locking_start_day) / 86400000;
        if (v0 >= 7) {
            arg0.locking_start_day = arg0.locking_start_day + 7 * 86400000 * v0 / 7;
        };
        arg0.tokensInvested = 0x2::balance::value<T0>(&arg0.alpha_bal);
    }

    fun update_user_rewards<T0, T1>(arg0: &mut Receipt, arg1: &Pool<T0>) {
        let v0 = 0x1::type_name::get<T1>();
        if (0x2::bag::contains<0x1::type_name::TypeName>(&arg1.rewards, v0) == true) {
            let v1 = 0x2::vec_map::get<0x1::type_name::TypeName, u256>(&arg1.acc_rewards_per_xtoken, &v0);
            let v2 = if (0x2::vec_map::contains<0x1::type_name::TypeName, u256>(&arg0.last_acc_reward_per_xtoken, &v0) == true) {
                let v3 = 0x2::vec_map::get_mut<0x1::type_name::TypeName, u256>(&mut arg0.last_acc_reward_per_xtoken, &v0);
                *v3 = *v1;
                *v3
            } else {
                0x2::vec_map::insert<0x1::type_name::TypeName, u256>(&mut arg0.last_acc_reward_per_xtoken, v0, *v1);
                0
            };
            if (0x2::vec_map::contains<0x1::type_name::TypeName, u64>(&arg0.pending_rewards, &v0) == true) {
                let v4 = 0x2::vec_map::get_mut<0x1::type_name::TypeName, u64>(&mut arg0.pending_rewards, &v0);
                *v4 = *v4 + (((*v1 - v2) * (arg0.xTokenBalance as u256) / (1000000000000000000000000000000000000 as u256)) as u64);
            } else {
                0x2::vec_map::insert<0x1::type_name::TypeName, u64>(&mut arg0.pending_rewards, v0, (((*v1 - v2) * (arg0.xTokenBalance as u256) / (1000000000000000000000000000000000000 as u256)) as u64));
            };
        };
    }

    fun update_user_rewards_all<T0>(arg0: &mut Receipt, arg1: &Pool<T0>) {
        update_user_rewards<T0, 0x2::sui::SUI>(arg0, arg1);
    }

    public fun user_deposit<T0>(arg0: &0x89bb824d493fee3248b2948224039bcde8bdc6deee2012dc11359841a1d5f2f6::version::Version, arg1: 0x1::option::Option<Receipt>, arg2: &mut Pool<T0>, arg3: &mut 0x89bb824d493fee3248b2948224039bcde8bdc6deee2012dc11359841a1d5f2f6::distributor::Distributor, arg4: 0x2::coin::Coin<T0>, arg5: &0x2::clock::Clock, arg6: &mut 0x2::tx_context::TxContext) {
        0x89bb824d493fee3248b2948224039bcde8bdc6deee2012dc11359841a1d5f2f6::version::assert_current_version(arg0);
        let v0 = deposit<T0>(arg0, arg1, arg2, arg3, arg4, arg5, arg6);
        if (0x1::option::is_some<Receipt>(&v0) == true) {
            0x2::transfer::public_transfer<Receipt>(0x1::option::extract<Receipt>(&mut v0), 0x2::tx_context::sender(arg6));
        };
        0x1::option::destroy_none<Receipt>(v0);
    }

    public fun user_withdraw<T0>(arg0: &0x89bb824d493fee3248b2948224039bcde8bdc6deee2012dc11359841a1d5f2f6::version::Version, arg1: Receipt, arg2: &mut Pool<T0>, arg3: &mut 0x89bb824d493fee3248b2948224039bcde8bdc6deee2012dc11359841a1d5f2f6::distributor::Distributor, arg4: u64, arg5: &0x2::clock::Clock, arg6: bool, arg7: &mut 0x2::tx_context::TxContext) {
        0x89bb824d493fee3248b2948224039bcde8bdc6deee2012dc11359841a1d5f2f6::version::assert_current_version(arg0);
        let v0 = withdraw<T0>(arg0, arg1, arg2, arg3, arg4, arg5, arg6, arg7);
        if (0x1::option::is_some<Receipt>(&v0) == true) {
            0x2::transfer::public_transfer<Receipt>(0x1::option::extract<Receipt>(&mut v0), 0x2::tx_context::sender(arg7));
        };
        0x1::option::destroy_none<Receipt>(v0);
    }

    public fun withdraw<T0>(arg0: &0x89bb824d493fee3248b2948224039bcde8bdc6deee2012dc11359841a1d5f2f6::version::Version, arg1: Receipt, arg2: &mut Pool<T0>, arg3: &mut 0x89bb824d493fee3248b2948224039bcde8bdc6deee2012dc11359841a1d5f2f6::distributor::Distributor, arg4: u64, arg5: &0x2::clock::Clock, arg6: bool, arg7: &mut 0x2::tx_context::TxContext) : 0x1::option::Option<Receipt> {
        0x89bb824d493fee3248b2948224039bcde8bdc6deee2012dc11359841a1d5f2f6::version::assert_current_version(arg0);
        if (arg1.owner != 0x2::tx_context::sender(arg7)) {
            0x2::transfer::public_transfer<Receipt>(arg1, 0x89bb824d493fee3248b2948224039bcde8bdc6deee2012dc11359841a1d5f2f6::distributor::get_onhold_receipts_wallet_address(arg3));
            return 0x1::option::none<Receipt>()
        };
        get_pool_rewards_all<T0>(arg0, arg2, arg3, arg5, arg7);
        let v0 = &mut arg1;
        update_user_rewards_all<T0>(v0, arg2);
        update_pool<T0>(arg2, arg5);
        let v1 = exchange_rate<T0>(arg2);
        assert_receipt<T0>(&arg1, arg2);
        let v2 = &mut arg1;
        unlock_locked_balance_for_user<T0>(arg2, v2, arg5);
        if (arg6 == true) {
            assert!(arg4 <= (((arg1.xTokenBalance as u256) * v1 / (1000000000000000000000000000000000000 as u256)) as u64), 0x89bb824d493fee3248b2948224039bcde8bdc6deee2012dc11359841a1d5f2f6::error::insufficient_balance_error());
        } else {
            assert!(arg4 <= (arg1.balance as u64), 0x89bb824d493fee3248b2948224039bcde8bdc6deee2012dc11359841a1d5f2f6::error::insufficient_balance_error());
        };
        let v3 = WithdrawEvent{
            coin_type          : 0x1::type_name::get<T0>(),
            amount_to_withdraw : arg4,
            sender             : 0x2::tx_context::sender(arg7),
        };
        0x2::event::emit<WithdrawEvent>(v3);
        let v4 = 0;
        if (arg4 > (arg1.balance as u64)) {
            let v5 = 0x2::math::min(((((arg4 - (arg1.balance as u64)) as u128) * 10000 / ((10000 - arg2.instant_withdraw_fee) as u128)) as u64), (((arg1.xTokenBalance as u256) * v1 / (1000000000000000000000000000000000000 as u256) - arg1.balance) as u64));
            arg4 = (arg1.balance as u64) + v5;
            let v6 = &mut arg1;
            unlock_xtokens_from_locked(v6, (((v5 as u256) * (1000000000000000000000000000000000000 as u256) / v1) as u64));
            arg1.balance = 0;
            v4 = (v5 as u128) * (arg2.instant_withdraw_fee as u128) / 10000;
        } else {
            arg1.balance = arg1.balance - (arg4 as u256);
        };
        let v7 = (((arg4 as u256) * (1000000000000000000000000000000000000 as u256) / v1) as u64);
        arg1.xTokenBalance = arg1.xTokenBalance - v7;
        arg2.xTokenSupply = arg2.xTokenSupply - v7;
        arg2.tokensInvested = arg2.tokensInvested - arg4;
        let v8 = ((((arg4 - (v4 as u64)) as u128) * (arg2.withdrawal_fee as u128) / 10000) as u64) + (v4 as u64);
        0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(0x2::coin::from_balance<T0>(0x2::balance::split<T0>(&mut arg2.alpha_bal, v8), arg7), 0x89bb824d493fee3248b2948224039bcde8bdc6deee2012dc11359841a1d5f2f6::distributor::get_fee_wallet_address(arg3));
        0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(0x2::coin::from_balance<T0>(0x2::balance::split<T0>(&mut arg2.alpha_bal, arg4 - v8), arg7), 0x2::tx_context::sender(arg7));
        if (arg1.xTokenBalance == 0) {
            destroy_receipt_and_transfer_rewards<T0>(arg0, arg1, arg2, arg3, arg5, arg7);
            0x1::option::none<Receipt>()
        } else {
            0x1::option::some<Receipt>(arg1)
        }
    }

    // decompiled from Move bytecode v6
}

