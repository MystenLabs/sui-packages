module 0x9bbd650b8442abb082c20f3bc95a9434a8d47b4bef98b0832dab57c1a8ba7123::alphapool {
    struct Pool<phantom T0> has store, key {
        id: 0x2::object::UID,
        name: vector<u8>,
        image_url: vector<u8>,
        xTokenSupply: u64,
        tokensInvested: u64,
        rewards: 0x2::bag::Bag,
        acc_rewards_per_xtoken: 0x2::vec_map::VecMap<0x1::type_name::TypeName, u256>,
        locked_period_in_ms: u64,
        locking_start_ms: u64,
        alpha_bal: 0x2::balance::Balance<T0>,
        instant_withdraw_fee: u64,
        instant_withdraw_fee_max_cap: u64,
        deposit_fee: u64,
        deposit_fee_max_cap: u64,
        withdrawal_fee: u64,
        withdraw_fee_max_cap: u64,
        performance_fee: u64,
        performance_fee_max_cap: u64,
        paused: bool,
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
        unlocked_xtokens: u256,
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

    struct AirdropClaimEvent has copy, drop {
        airdrop_amount: u64,
        relock_amount: u64,
    }

    struct AirdropLossEvent has copy, drop {
        airdrop_amount: u64,
    }

    struct LockedBalanceEvent has copy, drop {
        keys: vector<u64>,
        values: vector<u64>,
    }

    struct DepositEvent has copy, drop {
        coin_type: 0x1::type_name::TypeName,
        amount_deposited: u64,
        sender: address,
    }

    struct BeforeAndAfterEvent has copy, drop {
        coin_type: 0x1::type_name::TypeName,
        tokensInvested: u64,
        xTokenSupply: u64,
    }

    struct LiquidityChangeEvent has copy, drop {
        pool_id: 0x2::object::ID,
        event_type: u8,
        fee_collected: u64,
        amount: u64,
        user_total_x_token_balance: u64,
        x_token_supply: u64,
        tokens_invested: u64,
        sender: address,
    }

    struct WithdrawEvent has copy, drop {
        coin_type: 0x1::type_name::TypeName,
        amount_to_withdraw: u64,
        sender: address,
    }

    struct FeeEvent has copy, drop {
        fee: u64,
        location: u64,
    }

    struct WithdrawEventV2 has copy, drop {
        pool_id: 0x2::object::ID,
        fee_collected: u64,
        instant_withdraw_fee_collected: u64,
        amount: u64,
        amount_withdrawn_from_unlocked: u64,
        amount_withdrawn_from_locked: u64,
        user_total_x_token_balance: u64,
        x_token_supply: u64,
        tokens_invested: u64,
        sender: address,
    }

    fun assert_receipt<T0>(arg0: &Receipt, arg1: &Pool<T0>) {
        assert!(arg0.pool_id == 0x2::object::uid_to_inner(&arg1.id), 0x9bbd650b8442abb082c20f3bc95a9434a8d47b4bef98b0832dab57c1a8ba7123::error::invalid_receipt_error());
    }

    public fun check_locked_balance(arg0: &Receipt) {
        let v0 = 0x2::linked_table::front<u64, u64>(&arg0.locked_balance);
        let v1 = 0x1::vector::empty<u64>();
        let v2 = 0x1::vector::empty<u64>();
        while (0x1::option::is_some<u64>(v0)) {
            let v3 = *v0;
            let v4 = 0x1::option::extract<u64>(&mut v3);
            0x1::vector::push_back<u64>(&mut v1, v4);
            0x1::vector::push_back<u64>(&mut v2, *0x2::linked_table::borrow<u64, u64>(&arg0.locked_balance, v4));
            v0 = 0x2::linked_table::next<u64, u64>(&arg0.locked_balance, v4);
        };
        let v5 = LockedBalanceEvent{
            keys   : v1,
            values : v2,
        };
        0x2::event::emit<LockedBalanceEvent>(v5);
    }

    public fun claim_airdrop<T0>(arg0: &0x9bbd650b8442abb082c20f3bc95a9434a8d47b4bef98b0832dab57c1a8ba7123::version::Version, arg1: Receipt, arg2: &mut Pool<T0>, arg3: &mut 0x9bbd650b8442abb082c20f3bc95a9434a8d47b4bef98b0832dab57c1a8ba7123::distributor::Distributor, arg4: &0x2::clock::Clock, arg5: &mut 0x2::tx_context::TxContext) {
        if (arg1.owner != 0x2::tx_context::sender(arg5)) {
            0x2::transfer::public_transfer<Receipt>(arg1, 0x9bbd650b8442abb082c20f3bc95a9434a8d47b4bef98b0832dab57c1a8ba7123::distributor::get_onhold_receipts_wallet_address(arg3));
            return
        };
        get_pool_rewards_all<T0>(arg0, arg2, arg3, arg4, arg5);
        update_pool<T0>(arg2, arg4);
        let v0 = &mut arg1;
        update_user_rewards_all<T0>(v0, arg2);
        let v1 = 0x9bbd650b8442abb082c20f3bc95a9434a8d47b4bef98b0832dab57c1a8ba7123::distributor::airdrop_cycle_start_timestamp(arg3);
        let v2 = 0x2::clock::timestamp_ms(arg4);
        let v3 = false;
        let v4 = 0x2::linked_table::front<u64, u64>(&arg1.locked_balance);
        let v5 = 0;
        let v6 = 0x1::vector::empty<u64>();
        while (0x1::option::is_some<u64>(v4)) {
            let v7 = *0x1::option::borrow<u64>(v4);
            if (v7 >= v1 && v7 < v1 + 98 * 86400000 && v2 >= v1 && v2 < v1 + 98 * 86400000) {
                if (v3 == false && v2 < v7) {
                    0x2::transfer::public_transfer<Receipt>(arg1, 0x2::tx_context::sender(arg5));
                    return
                };
                v3 = true;
                0x1::vector::push_back<u64>(&mut v6, v7);
                v5 = v5 + *0x2::linked_table::borrow<u64, u64>(&arg1.locked_balance, v7);
            };
            v4 = 0x2::linked_table::next<u64, u64>(&arg1.locked_balance, v7);
        };
        while (0x1::vector::length<u64>(&v6) > 0) {
            0x2::linked_table::remove<u64, u64>(&mut arg1.locked_balance, 0x1::vector::pop_back<u64>(&mut v6));
        };
        if (v5 > 0) {
            let v8 = 0x2::balance::split<T0>(&mut arg2.alpha_bal, (((v5 as u256) * exchange_rate<T0>(arg2) / (1000000000000000000000000000000000000 as u256)) as u64));
            arg1.xTokenBalance = arg1.xTokenBalance - v5;
            arg2.xTokenSupply = arg2.xTokenSupply - v5;
            let v9 = 0x9bbd650b8442abb082c20f3bc95a9434a8d47b4bef98b0832dab57c1a8ba7123::distributor::airdrop_rate(arg3) * (v5 as u256) / 1000000000;
            0x2::balance::join<T0>(&mut v8, 0x9bbd650b8442abb082c20f3bc95a9434a8d47b4bef98b0832dab57c1a8ba7123::distributor::withdraw_airdrop_balance_for_airdrop<T0>(arg3, (v9 as u64)));
            let v10 = AirdropClaimEvent{
                airdrop_amount : (v9 as u64),
                relock_amount  : 0x2::balance::value<T0>(&v8),
            };
            0x2::event::emit<AirdropClaimEvent>(v10);
            let v11 = 0x2::coin::from_balance<T0>(v8, arg5);
            user_deposit<T0>(arg0, 0x1::option::some<Receipt>(arg1), arg2, arg3, v11, arg4, arg5);
        } else {
            0x2::transfer::public_transfer<Receipt>(arg1, 0x2::tx_context::sender(arg5));
        };
    }

    public fun create<T0>(arg0: &0x9bbd650b8442abb082c20f3bc95a9434a8d47b4bef98b0832dab57c1a8ba7123::distributor::DevCap, arg1: &0x9bbd650b8442abb082c20f3bc95a9434a8d47b4bef98b0832dab57c1a8ba7123::version::Version, arg2: vector<u8>, arg3: vector<u8>, arg4: &0x2::clock::Clock, arg5: &mut 0x2::tx_context::TxContext) {
        0x9bbd650b8442abb082c20f3bc95a9434a8d47b4bef98b0832dab57c1a8ba7123::version::assert_current_version(arg1);
        let v0 = Pool<T0>{
            id                           : 0x2::object::new(arg5),
            name                         : arg2,
            image_url                    : arg3,
            xTokenSupply                 : 0,
            tokensInvested               : 0,
            rewards                      : 0x2::bag::new(arg5),
            acc_rewards_per_xtoken       : 0x2::vec_map::empty<0x1::type_name::TypeName, u256>(),
            locked_period_in_ms          : 100 * 86400000,
            locking_start_ms             : 0x2::clock::timestamp_ms(arg4),
            alpha_bal                    : 0x2::balance::zero<T0>(),
            instant_withdraw_fee         : 5000,
            instant_withdraw_fee_max_cap : 9000,
            deposit_fee                  : 0,
            deposit_fee_max_cap          : 100,
            withdrawal_fee               : 0,
            withdraw_fee_max_cap         : 100,
            performance_fee              : 2000,
            performance_fee_max_cap      : 5000,
            paused                       : false,
        };
        0x2::transfer::public_share_object<Pool<T0>>(v0);
    }

    public fun deposit<T0>(arg0: &0x9bbd650b8442abb082c20f3bc95a9434a8d47b4bef98b0832dab57c1a8ba7123::version::Version, arg1: 0x1::option::Option<Receipt>, arg2: &mut Pool<T0>, arg3: &mut 0x9bbd650b8442abb082c20f3bc95a9434a8d47b4bef98b0832dab57c1a8ba7123::distributor::Distributor, arg4: 0x2::coin::Coin<T0>, arg5: &0x2::clock::Clock, arg6: &mut 0x2::tx_context::TxContext) : 0x1::option::Option<Receipt> {
        0x9bbd650b8442abb082c20f3bc95a9434a8d47b4bef98b0832dab57c1a8ba7123::version::assert_current_version(arg0);
        if (0x1::option::is_some<Receipt>(&arg1) == true) {
            if (0x1::option::borrow<Receipt>(&arg1).owner != 0x2::tx_context::sender(arg6)) {
                0x2::transfer::public_transfer<Receipt>(0x1::option::extract<Receipt>(&mut arg1), 0x9bbd650b8442abb082c20f3bc95a9434a8d47b4bef98b0832dab57c1a8ba7123::distributor::get_onhold_receipts_wallet_address(arg3));
                0x1::option::destroy_none<Receipt>(arg1);
                0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(arg4, 0x2::tx_context::sender(arg6));
                return 0x1::option::none<Receipt>()
            };
        };
        assert!(arg2.paused == false, 0x9bbd650b8442abb082c20f3bc95a9434a8d47b4bef98b0832dab57c1a8ba7123::error::pool_paused());
        assert!(0x2::coin::value<T0>(&arg4) > 0, 0x9bbd650b8442abb082c20f3bc95a9434a8d47b4bef98b0832dab57c1a8ba7123::error::zero_deposit_error());
        get_pool_rewards_all<T0>(arg0, arg2, arg3, arg5, arg6);
        update_pool<T0>(arg2, arg5);
        if (0x1::option::is_some<Receipt>(&arg1) == true) {
            assert_receipt<T0>(0x1::option::borrow_mut<Receipt>(&mut arg1), arg2);
        };
        let v0 = 0x2::coin::into_balance<T0>(arg4);
        let v1 = (0x2::balance::value<T0>(&v0) as u128) * (arg2.deposit_fee as u128) / 10000;
        0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(0x2::coin::from_balance<T0>(0x2::balance::split<T0>(&mut v0, (v1 as u64)), arg6), 0x9bbd650b8442abb082c20f3bc95a9434a8d47b4bef98b0832dab57c1a8ba7123::distributor::get_fee_wallet_address(arg3));
        let v2 = 0x2::balance::value<T0>(&v0);
        arg2.tokensInvested = arg2.tokensInvested + v2;
        0x2::balance::join<T0>(&mut arg2.alpha_bal, v0);
        let v3 = (v2 as u256) * (1000000000000000000000000000000000000 as u256) / exchange_rate<T0>(arg2);
        assert!(v3 > 0, 0x9bbd650b8442abb082c20f3bc95a9434a8d47b4bef98b0832dab57c1a8ba7123::error::insufficient_deposit_amount());
        arg2.xTokenSupply = arg2.xTokenSupply + (v3 as u64);
        let v4 = (v3 as u64);
        let v5 = arg2.locking_start_ms + arg2.locked_period_in_ms;
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
            Receipt{id: 0x2::object::new(arg6), owner: 0x2::tx_context::sender(arg6), name: 0x1::string::utf8(arg2.name), image_url: 0x1::string::utf8(arg2.image_url), pool_id: 0x2::object::uid_to_inner(&arg2.id), xTokenBalance: (v3 as u64), last_acc_reward_per_xtoken: v11, locked_balance: v16, unlocked_xtokens: 0, pending_rewards: v12}
        };
        let v17 = v6;
        0x1::option::destroy_none<Receipt>(arg1);
        let v18 = LiquidityChangeEvent{
            pool_id                    : 0x2::object::uid_to_inner(&arg2.id),
            event_type                 : 0,
            fee_collected              : (v1 as u64),
            amount                     : v2,
            user_total_x_token_balance : v17.xTokenBalance,
            x_token_supply             : arg2.xTokenSupply,
            tokens_invested            : 0x2::balance::value<T0>(&arg2.alpha_bal),
            sender                     : 0x2::tx_context::sender(arg6),
        };
        0x2::event::emit<LiquidityChangeEvent>(v18);
        check_locked_balance(&v17);
        0x1::option::some<Receipt>(v17)
    }

    fun destroy_receipt_and_transfer_rewards<T0>(arg0: &0x9bbd650b8442abb082c20f3bc95a9434a8d47b4bef98b0832dab57c1a8ba7123::version::Version, arg1: Receipt, arg2: &mut Pool<T0>, arg3: &mut 0x9bbd650b8442abb082c20f3bc95a9434a8d47b4bef98b0832dab57c1a8ba7123::distributor::Distributor, arg4: &0x2::clock::Clock, arg5: &mut 0x2::tx_context::TxContext) {
        0x9bbd650b8442abb082c20f3bc95a9434a8d47b4bef98b0832dab57c1a8ba7123::version::assert_current_version(arg0);
        assert!(arg1.xTokenBalance < 2, 0x9bbd650b8442abb082c20f3bc95a9434a8d47b4bef98b0832dab57c1a8ba7123::error::receipt_not_empty());
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
            unlocked_xtokens           : _,
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

    public fun get_pool_rewards_all<T0>(arg0: &0x9bbd650b8442abb082c20f3bc95a9434a8d47b4bef98b0832dab57c1a8ba7123::version::Version, arg1: &mut Pool<T0>, arg2: &mut 0x9bbd650b8442abb082c20f3bc95a9434a8d47b4bef98b0832dab57c1a8ba7123::distributor::Distributor, arg3: &0x2::clock::Clock, arg4: &mut 0x2::tx_context::TxContext) {
        0x9bbd650b8442abb082c20f3bc95a9434a8d47b4bef98b0832dab57c1a8ba7123::version::assert_current_version(arg0);
        get_rewards<T0, 0xfe3afec26c59e874f3c1d60b8203cb3852d2bb2aa415df9548b8d688e6683f93::alpha::ALPHA>(arg1, arg2, arg3, arg4);
    }

    fun get_rewards<T0, T1>(arg0: &mut Pool<T0>, arg1: &mut 0x9bbd650b8442abb082c20f3bc95a9434a8d47b4bef98b0832dab57c1a8ba7123::distributor::Distributor, arg2: &0x2::clock::Clock, arg3: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x1::type_name::get<T1>();
        if (arg0.xTokenSupply == 0) {
            if (0x2::bag::contains<0x1::type_name::TypeName>(&arg0.rewards, v0) == false) {
                0x2::vec_map::insert<0x1::type_name::TypeName, u256>(&mut arg0.acc_rewards_per_xtoken, v0, 0);
                0x2::bag::add<0x1::type_name::TypeName, 0x2::balance::Balance<T1>>(&mut arg0.rewards, v0, 0x2::balance::zero<T1>());
            };
            return
        };
        if (v0 == 0x1::type_name::get<0xfe3afec26c59e874f3c1d60b8203cb3852d2bb2aa415df9548b8d688e6683f93::alpha::ALPHA>()) {
            let v1 = 0x9bbd650b8442abb082c20f3bc95a9434a8d47b4bef98b0832dab57c1a8ba7123::distributor::get_rewards<T0>(arg1, 0x2::object::uid_to_inner(&arg0.id), arg2, arg3);
            let v2 = (0x2::balance::value<T0>(&v1) as u128) * (arg0.performance_fee as u128) / 10000;
            let v3 = FeeEvent{
                fee      : (v2 as u64),
                location : 1,
            };
            0x2::event::emit<FeeEvent>(v3);
            0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(0x2::coin::from_balance<T0>(0x2::balance::split<T0>(&mut v1, (v2 as u64)), arg3), 0x9bbd650b8442abb082c20f3bc95a9434a8d47b4bef98b0832dab57c1a8ba7123::distributor::get_fee_wallet_address(arg1));
            let v4 = RewardEvent{
                coin_type : v0,
                amount    : 0x2::balance::value<T0>(&v1),
                sender    : @0x0,
            };
            0x2::event::emit<RewardEvent>(v4);
            0x2::balance::join<T0>(&mut arg0.alpha_bal, v1);
        } else {
            let v5 = 0x9bbd650b8442abb082c20f3bc95a9434a8d47b4bef98b0832dab57c1a8ba7123::distributor::get_rewards<T1>(arg1, 0x2::object::uid_to_inner(&arg0.id), arg2, arg3);
            if (0x2::bag::contains<0x1::type_name::TypeName>(&arg0.rewards, v0) == true) {
                let v6 = 0x2::vec_map::get_mut<0x1::type_name::TypeName, u256>(&mut arg0.acc_rewards_per_xtoken, &v0);
                *v6 = *v6 + (0x2::balance::value<T1>(&v5) as u256) * (1000000000000000000000000000000000000 as u256) / (arg0.xTokenSupply as u256);
                0x2::balance::join<T1>(0x2::bag::borrow_mut<0x1::type_name::TypeName, 0x2::balance::Balance<T1>>(&mut arg0.rewards, v0), v5);
            } else {
                0x2::vec_map::insert<0x1::type_name::TypeName, u256>(&mut arg0.acc_rewards_per_xtoken, v0, (0x2::balance::value<T1>(&v5) as u256) * (1000000000000000000000000000000000000 as u256) / (arg0.xTokenSupply as u256));
                0x2::bag::add<0x1::type_name::TypeName, 0x2::balance::Balance<T1>>(&mut arg0.rewards, v0, v5);
            };
        };
    }

    fun get_user_rewards<T0, T1>(arg0: &mut Receipt, arg1: &mut Pool<T0>, arg2: &mut 0x9bbd650b8442abb082c20f3bc95a9434a8d47b4bef98b0832dab57c1a8ba7123::distributor::Distributor, arg3: &0x2::clock::Clock, arg4: &mut 0x2::tx_context::TxContext) : 0x2::balance::Balance<T1> {
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
            *v5 = 0;
            0x2::balance::split<T1>(0x2::bag::borrow_mut<0x1::type_name::TypeName, 0x2::balance::Balance<T1>>(&mut arg1.rewards, v0), (((*v2 - v3) * (arg0.xTokenBalance as u256) / (1000000000000000000000000000000000000 as u256)) as u64) + *v5)
        } else {
            0x2::balance::zero<T1>()
        }
    }

    public fun get_user_rewards_all<T0>(arg0: &0x9bbd650b8442abb082c20f3bc95a9434a8d47b4bef98b0832dab57c1a8ba7123::version::Version, arg1: &mut Receipt, arg2: &mut Pool<T0>, arg3: &mut 0x9bbd650b8442abb082c20f3bc95a9434a8d47b4bef98b0832dab57c1a8ba7123::distributor::Distributor, arg4: &0x2::clock::Clock, arg5: &mut 0x2::tx_context::TxContext) {
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
        0x1::vector::push_back<0x1::string::String>(v3, 0x1::string::utf8(b"AlphaFi Liquidity Position"));
        0x1::vector::push_back<0x1::string::String>(v3, 0x1::string::utf8(b"AlphaFi"));
        let v4 = 0x2::package::claim<ALPHAPOOL>(arg0, arg1);
        let v5 = 0x2::display::new_with_fields<Receipt>(&v4, v0, v2, arg1);
        0x2::display::update_version<Receipt>(&mut v5);
        0x2::transfer::public_transfer<0x2::package::Publisher>(v4, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::display::Display<Receipt>>(v5, 0x2::tx_context::sender(arg1));
    }

    fun insert_to_locked_balance(arg0: &mut Receipt, arg1: u64, arg2: u64, arg3: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::linked_table::new<u64, u64>(arg3);
        while (0x2::linked_table::length<u64, u64>(&arg0.locked_balance) > 0) {
            let (v1, v2) = 0x2::linked_table::pop_back<u64, u64>(&mut arg0.locked_balance);
            if (v1 < arg1) {
                0x2::linked_table::push_back<u64, u64>(&mut arg0.locked_balance, v1, v2);
                break
            };
            0x2::linked_table::push_back<u64, u64>(&mut v0, v1, v2);
        };
        0x2::linked_table::push_back<u64, u64>(&mut arg0.locked_balance, arg1, arg2);
        while (0x2::linked_table::length<u64, u64>(&v0) > 0) {
            let (v3, v4) = 0x2::linked_table::pop_back<u64, u64>(&mut v0);
            0x2::linked_table::push_back<u64, u64>(&mut arg0.locked_balance, v3, v4);
        };
        0x2::linked_table::destroy_empty<u64, u64>(v0);
    }

    entry fun set_deposit_fee<T0>(arg0: &0x9bbd650b8442abb082c20f3bc95a9434a8d47b4bef98b0832dab57c1a8ba7123::distributor::AdminCap, arg1: &0x9bbd650b8442abb082c20f3bc95a9434a8d47b4bef98b0832dab57c1a8ba7123::version::Version, arg2: &mut Pool<T0>, arg3: u64) {
        0x9bbd650b8442abb082c20f3bc95a9434a8d47b4bef98b0832dab57c1a8ba7123::version::assert_current_version(arg1);
        assert!(arg3 <= arg2.deposit_fee_max_cap, 0x9bbd650b8442abb082c20f3bc95a9434a8d47b4bef98b0832dab57c1a8ba7123::error::fee_too_high_error());
        arg2.deposit_fee = arg3;
    }

    entry fun set_instant_withdraw_fee<T0>(arg0: &0x9bbd650b8442abb082c20f3bc95a9434a8d47b4bef98b0832dab57c1a8ba7123::distributor::AdminCap, arg1: &0x9bbd650b8442abb082c20f3bc95a9434a8d47b4bef98b0832dab57c1a8ba7123::version::Version, arg2: &mut Pool<T0>, arg3: u64) {
        0x9bbd650b8442abb082c20f3bc95a9434a8d47b4bef98b0832dab57c1a8ba7123::version::assert_current_version(arg1);
        assert!(arg3 <= arg2.instant_withdraw_fee_max_cap, 0x9bbd650b8442abb082c20f3bc95a9434a8d47b4bef98b0832dab57c1a8ba7123::error::fee_too_high_error());
        arg2.instant_withdraw_fee = arg3;
    }

    entry fun set_lock_period_in_ms<T0>(arg0: &0x9bbd650b8442abb082c20f3bc95a9434a8d47b4bef98b0832dab57c1a8ba7123::distributor::AdminCap, arg1: &0x9bbd650b8442abb082c20f3bc95a9434a8d47b4bef98b0832dab57c1a8ba7123::version::Version, arg2: &mut Pool<T0>, arg3: u64) {
        0x9bbd650b8442abb082c20f3bc95a9434a8d47b4bef98b0832dab57c1a8ba7123::version::assert_current_version(arg1);
        arg2.locked_period_in_ms = arg3;
    }

    entry fun set_pause<T0>(arg0: &0x9bbd650b8442abb082c20f3bc95a9434a8d47b4bef98b0832dab57c1a8ba7123::distributor::EmergencyCap, arg1: &0x9bbd650b8442abb082c20f3bc95a9434a8d47b4bef98b0832dab57c1a8ba7123::version::Version, arg2: &mut Pool<T0>, arg3: bool) {
        0x9bbd650b8442abb082c20f3bc95a9434a8d47b4bef98b0832dab57c1a8ba7123::version::assert_current_version(arg1);
        arg2.paused = arg3;
    }

    entry fun set_performance_fee<T0>(arg0: &0x9bbd650b8442abb082c20f3bc95a9434a8d47b4bef98b0832dab57c1a8ba7123::distributor::AdminCap, arg1: &0x9bbd650b8442abb082c20f3bc95a9434a8d47b4bef98b0832dab57c1a8ba7123::version::Version, arg2: &mut Pool<T0>, arg3: u64) {
        0x9bbd650b8442abb082c20f3bc95a9434a8d47b4bef98b0832dab57c1a8ba7123::version::assert_current_version(arg1);
        assert!(arg3 <= arg2.performance_fee_max_cap, 0x9bbd650b8442abb082c20f3bc95a9434a8d47b4bef98b0832dab57c1a8ba7123::error::fee_too_high_error());
        arg2.performance_fee = arg3;
    }

    entry fun set_withdrawal_fee<T0>(arg0: &0x9bbd650b8442abb082c20f3bc95a9434a8d47b4bef98b0832dab57c1a8ba7123::distributor::AdminCap, arg1: &0x9bbd650b8442abb082c20f3bc95a9434a8d47b4bef98b0832dab57c1a8ba7123::version::Version, arg2: &mut Pool<T0>, arg3: u64) {
        0x9bbd650b8442abb082c20f3bc95a9434a8d47b4bef98b0832dab57c1a8ba7123::version::assert_current_version(arg1);
        assert!(arg3 <= arg2.withdraw_fee_max_cap, 0x9bbd650b8442abb082c20f3bc95a9434a8d47b4bef98b0832dab57c1a8ba7123::error::fee_too_high_error());
        arg2.withdrawal_fee = arg3;
    }

    public fun transfer_receipt_option(arg0: &0x9bbd650b8442abb082c20f3bc95a9434a8d47b4bef98b0832dab57c1a8ba7123::version::Version, arg1: 0x1::option::Option<Receipt>, arg2: &mut 0x2::tx_context::TxContext) {
        0x9bbd650b8442abb082c20f3bc95a9434a8d47b4bef98b0832dab57c1a8ba7123::version::assert_current_version(arg0);
        if (0x1::option::is_some<Receipt>(&arg1) == true) {
            0x2::transfer::public_transfer<Receipt>(0x1::option::extract<Receipt>(&mut arg1), 0x2::tx_context::sender(arg2));
        };
        0x1::option::destroy_none<Receipt>(arg1);
    }

    fun unlock_locked_balance_for_user<T0>(arg0: &mut Receipt, arg1: &mut 0x9bbd650b8442abb082c20f3bc95a9434a8d47b4bef98b0832dab57c1a8ba7123::distributor::Distributor, arg2: &0x2::clock::Clock, arg3: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x9bbd650b8442abb082c20f3bc95a9434a8d47b4bef98b0832dab57c1a8ba7123::distributor::airdrop_cycle_start_timestamp(arg1);
        let v1 = 0x2::clock::timestamp_ms(arg2);
        let v2 = 0;
        while (0x2::linked_table::length<u64, u64>(&arg0.locked_balance) > 0) {
            let (v3, v4) = 0x2::linked_table::pop_front<u64, u64>(&mut arg0.locked_balance);
            if (v1 >= v3) {
                if (v3 >= v0 && v3 < v0 + 98 * 86400000 && v1 >= v0 && v1 < v0 + 98 * 86400000) {
                    v2 = v2 + v4;
                };
                arg0.unlocked_xtokens = arg0.unlocked_xtokens + (v4 as u256);
            } else {
                0x2::linked_table::push_front<u64, u64>(&mut arg0.locked_balance, v3, v4);
                break
            };
        };
        let v5 = 0x9bbd650b8442abb082c20f3bc95a9434a8d47b4bef98b0832dab57c1a8ba7123::distributor::airdrop_rate(arg1) * (v2 as u256) / 1000000000;
        let v6 = 0x9bbd650b8442abb082c20f3bc95a9434a8d47b4bef98b0832dab57c1a8ba7123::distributor::withdraw_airdrop_balance_for_airdrop<T0>(arg1, (v5 as u64));
        if (0x2::balance::value<T0>(&v6) > 0) {
            let v7 = AirdropLossEvent{airdrop_amount: (v5 as u64)};
            0x2::event::emit<AirdropLossEvent>(v7);
            0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(0x2::coin::from_balance<T0>(v6, arg3), 0x9bbd650b8442abb082c20f3bc95a9434a8d47b4bef98b0832dab57c1a8ba7123::distributor::get_unclaimed_airdrop_wallet_address(arg1));
        } else {
            0x2::balance::destroy_zero<T0>(v6);
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
        let v0 = 0x2::clock::timestamp_ms(arg1) - arg0.locking_start_ms;
        let v1 = 604800000;
        if (v0 >= v1) {
            arg0.locking_start_ms = arg0.locking_start_ms + v1 * v0 / v1;
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
    }

    public fun user_deposit<T0>(arg0: &0x9bbd650b8442abb082c20f3bc95a9434a8d47b4bef98b0832dab57c1a8ba7123::version::Version, arg1: 0x1::option::Option<Receipt>, arg2: &mut Pool<T0>, arg3: &mut 0x9bbd650b8442abb082c20f3bc95a9434a8d47b4bef98b0832dab57c1a8ba7123::distributor::Distributor, arg4: 0x2::coin::Coin<T0>, arg5: &0x2::clock::Clock, arg6: &mut 0x2::tx_context::TxContext) {
        0x9bbd650b8442abb082c20f3bc95a9434a8d47b4bef98b0832dab57c1a8ba7123::version::assert_current_version(arg0);
        let v0 = deposit<T0>(arg0, arg1, arg2, arg3, arg4, arg5, arg6);
        if (0x1::option::is_some<Receipt>(&v0) == true) {
            0x2::transfer::public_transfer<Receipt>(0x1::option::extract<Receipt>(&mut v0), 0x2::tx_context::sender(arg6));
        };
        0x1::option::destroy_none<Receipt>(v0);
    }

    public fun user_withdraw<T0>(arg0: &0x9bbd650b8442abb082c20f3bc95a9434a8d47b4bef98b0832dab57c1a8ba7123::version::Version, arg1: Receipt, arg2: &mut Pool<T0>, arg3: &mut 0x9bbd650b8442abb082c20f3bc95a9434a8d47b4bef98b0832dab57c1a8ba7123::distributor::Distributor, arg4: u64, arg5: &0x2::clock::Clock, arg6: bool, arg7: &mut 0x2::tx_context::TxContext) {
        0x9bbd650b8442abb082c20f3bc95a9434a8d47b4bef98b0832dab57c1a8ba7123::version::assert_current_version(arg0);
        let v0 = withdraw<T0>(arg0, arg1, arg2, arg3, arg4, arg5, arg6, arg7);
        if (0x1::option::is_some<Receipt>(&v0) == true) {
            0x2::transfer::public_transfer<Receipt>(0x1::option::extract<Receipt>(&mut v0), 0x2::tx_context::sender(arg7));
        };
        0x1::option::destroy_none<Receipt>(v0);
    }

    public fun withdraw<T0>(arg0: &0x9bbd650b8442abb082c20f3bc95a9434a8d47b4bef98b0832dab57c1a8ba7123::version::Version, arg1: Receipt, arg2: &mut Pool<T0>, arg3: &mut 0x9bbd650b8442abb082c20f3bc95a9434a8d47b4bef98b0832dab57c1a8ba7123::distributor::Distributor, arg4: u64, arg5: &0x2::clock::Clock, arg6: bool, arg7: &mut 0x2::tx_context::TxContext) : 0x1::option::Option<Receipt> {
        0x9bbd650b8442abb082c20f3bc95a9434a8d47b4bef98b0832dab57c1a8ba7123::version::assert_current_version(arg0);
        if (arg1.owner != 0x2::tx_context::sender(arg7)) {
            0x2::transfer::public_transfer<Receipt>(arg1, 0x9bbd650b8442abb082c20f3bc95a9434a8d47b4bef98b0832dab57c1a8ba7123::distributor::get_onhold_receipts_wallet_address(arg3));
            return 0x1::option::none<Receipt>()
        };
        assert!(arg2.paused == false, 0x9bbd650b8442abb082c20f3bc95a9434a8d47b4bef98b0832dab57c1a8ba7123::error::pool_paused());
        get_pool_rewards_all<T0>(arg0, arg2, arg3, arg5, arg7);
        let v0 = &mut arg1;
        update_user_rewards_all<T0>(v0, arg2);
        update_pool<T0>(arg2, arg5);
        let v1 = exchange_rate<T0>(arg2);
        assert_receipt<T0>(&arg1, arg2);
        let v2 = &mut arg1;
        unlock_locked_balance_for_user<T0>(v2, arg3, arg5, arg7);
        let v3 = (arg1.unlocked_xtokens as u256) * v1 / (1000000000000000000000000000000000000 as u256);
        if (arg6 == true) {
            assert!(arg4 <= (((arg1.xTokenBalance as u256) * v1 / (1000000000000000000000000000000000000 as u256)) as u64), 0x9bbd650b8442abb082c20f3bc95a9434a8d47b4bef98b0832dab57c1a8ba7123::error::insufficient_balance_error());
        } else {
            assert!(arg4 <= (v3 as u64), 0x9bbd650b8442abb082c20f3bc95a9434a8d47b4bef98b0832dab57c1a8ba7123::error::insufficient_balance_error());
        };
        let v4 = 0;
        let v5 = 0;
        if (arg4 > (v3 as u64)) {
            let v6 = 0x2::math::min(((((arg4 - (v3 as u64)) as u128) * 10000 / ((10000 - arg2.instant_withdraw_fee) as u128)) as u64), (((arg1.xTokenBalance as u256) * v1 / (1000000000000000000000000000000000000 as u256) - v3) as u64));
            v5 = v6;
            arg4 = (v3 as u64) + v6;
            let v7 = &mut arg1;
            unlock_xtokens_from_locked(v7, (((v6 as u256) * (1000000000000000000000000000000000000 as u256) / v1) as u64));
            arg1.unlocked_xtokens = 0;
            v4 = (v6 as u128) * (arg2.instant_withdraw_fee as u128) / 10000;
        } else {
            arg1.unlocked_xtokens = arg1.unlocked_xtokens - (arg4 as u256) * (1000000000000000000000000000000000000 as u256) / v1;
        };
        let v8 = (((arg4 as u256) * (1000000000000000000000000000000000000 as u256) / v1) as u64);
        assert!(v8 > 0, 0x9bbd650b8442abb082c20f3bc95a9434a8d47b4bef98b0832dab57c1a8ba7123::error::insufficient_withdraw_amount());
        arg1.xTokenBalance = arg1.xTokenBalance - v8;
        arg2.xTokenSupply = arg2.xTokenSupply - v8;
        arg2.tokensInvested = arg2.tokensInvested - arg4;
        let v9 = ((((arg4 - (v4 as u64)) as u128) * (arg2.withdrawal_fee as u128) / 10000) as u64) + (v4 as u64);
        0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(0x2::coin::from_balance<T0>(0x2::balance::split<T0>(&mut arg2.alpha_bal, v9), arg7), 0x9bbd650b8442abb082c20f3bc95a9434a8d47b4bef98b0832dab57c1a8ba7123::distributor::get_fee_wallet_address(arg3));
        0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(0x2::coin::from_balance<T0>(0x2::balance::split<T0>(&mut arg2.alpha_bal, arg4 - v9), arg7), 0x2::tx_context::sender(arg7));
        let v10 = WithdrawEventV2{
            pool_id                        : 0x2::object::uid_to_inner(&arg2.id),
            fee_collected                  : (v9 as u64),
            instant_withdraw_fee_collected : (v4 as u64),
            amount                         : arg4 - v9,
            amount_withdrawn_from_unlocked : 0x1::u64::min(arg4, (v3 as u64)),
            amount_withdrawn_from_locked   : v5 - (v4 as u64),
            user_total_x_token_balance     : arg1.xTokenBalance,
            x_token_supply                 : arg2.xTokenSupply,
            tokens_invested                : 0x2::balance::value<T0>(&arg2.alpha_bal),
            sender                         : 0x2::tx_context::sender(arg7),
        };
        0x2::event::emit<WithdrawEventV2>(v10);
        if (arg1.xTokenBalance < 2) {
            destroy_receipt_and_transfer_rewards<T0>(arg0, arg1, arg2, arg3, arg5, arg7);
            0x1::option::none<Receipt>()
        } else {
            check_locked_balance(&arg1);
            0x1::option::some<Receipt>(arg1)
        }
    }

    // decompiled from Move bytecode v6
}

