module 0x5711036356989c25395de76cacd0abf01dd4d6dd9f84a3e170ef16fd2258d180::staking_nft {
    struct NftStakingMetadata has key {
        id: 0x2::object::UID,
        admin: address,
        uid: u64,
    }

    struct PoolInfo<phantom T0, phantom T1> has store, key {
        id: 0x2::object::UID,
        uid: u64,
        total_stake_nft: u64,
        total_reward_token: 0x2::coin::Coin<T1>,
        reward_per_second: u64,
        start_timestamp: u64,
        end_timestamp: u64,
        last_reward_timestamp: u64,
        acc_token_per_share: u64,
        precision_factor: u64,
    }

    struct UserInfo<phantom T0, phantom T1> has store {
        number_nft_stake: u64,
        reward_debt: u64,
        item_ids: vector<0x2::object::ID>,
        pending_reward: u64,
    }

    struct CreatePoolEvent has drop, store {
        user: address,
        stake_token_info: 0x1::string::String,
        reward_token_info: 0x1::string::String,
        uid_info: 0x1::string::String,
    }

    struct StakingNFTEvent has copy, drop {
        item_id: 0x2::object::ID,
        sender: address,
        pool_uid: u64,
        timestamp_ms: u64,
    }

    struct WithdrawNFTEvent has copy, drop {
        item_id: 0x2::object::ID,
        sender: address,
        pool_uid: u64,
        timestamp_ms: u64,
    }

    struct RewardWithdrawEvent has copy, drop {
        sender: address,
        amount: u64,
        pool_uid: u64,
        timestamp_ms: u64,
    }

    public entry fun add_reward<T0, T1>(arg0: 0x2::coin::Coin<T1>, arg1: u64, arg2: &mut NftStakingMetadata, arg3: &mut PoolInfo<T0, T1>, arg4: &mut 0x2::tx_context::TxContext) {
        assert!(arg2.admin == 0x2::tx_context::sender(arg4), 5);
        assert!(0x2::coin::value<T1>(&arg0) == arg1, 3);
        0x2::coin::join<T1>(&mut arg3.total_reward_token, arg0);
    }

    fun cal_acc_token_per_share(arg0: u64, arg1: u64, arg2: u64, arg3: u64, arg4: u64, arg5: u64, arg6: &0x2::clock::Clock) : u64 {
        let v0 = get_multiplier(arg5, 0x2::clock::timestamp_ms(arg6) / 1000, arg2);
        if (v0 == 0) {
            return arg0
        };
        arg0 + arg3 * v0 * arg4 / arg1
    }

    fun cal_pending_reward(arg0: u64, arg1: u64, arg2: u64, arg3: u64) : u64 {
        arg0 * arg2 / arg3 - arg1
    }

    public entry fun create_pool<T0, T1>(arg0: &0x2::clock::Clock, arg1: u64, arg2: u64, arg3: u64, arg4: &mut NftStakingMetadata, arg5: &mut 0x2::tx_context::TxContext) {
        assert!(arg4.admin == 0x2::tx_context::sender(arg5), 5);
        assert!(arg2 > 0x2::clock::timestamp_ms(arg0) / 1000, 3);
        assert!(arg2 < arg3, 13);
        let v0 = PoolInfo<T0, T1>{
            id                    : 0x2::object::new(arg5),
            uid                   : arg4.uid,
            total_stake_nft       : 0,
            total_reward_token    : 0x2::coin::zero<T1>(arg5),
            reward_per_second     : arg1,
            start_timestamp       : arg2,
            end_timestamp         : arg3,
            last_reward_timestamp : arg2,
            acc_token_per_share   : 0,
            precision_factor      : 1,
        };
        0x2::transfer::share_object<PoolInfo<T0, T1>>(v0);
        arg4.uid = arg4.uid + 1;
    }

    public entry fun emergency_reward_withdraw<T0: store + key, T1>(arg0: &mut PoolInfo<T0, T1>, arg1: &mut NftStakingMetadata, arg2: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg2);
        assert!(arg1.admin == v0, 5);
        0x2::transfer::public_transfer<0x2::coin::Coin<T1>>(0x2::coin::split<T1>(&mut arg0.total_reward_token, 0x2::coin::value<T1>(&arg0.total_reward_token), arg2), v0);
    }

    fun get_multiplier(arg0: u64, arg1: u64, arg2: u64) : u64 {
        if (arg1 <= arg2) {
            arg1 - arg0
        } else if (arg0 >= arg2) {
            0
        } else {
            arg2 - arg0
        }
    }

    fun init(arg0: &mut 0x2::tx_context::TxContext) {
        let v0 = NftStakingMetadata{
            id    : 0x2::object::new(arg0),
            admin : @0x7a4a4427be66e1a616bd74cccbadbcc11d9ab048af9239c6737cc2ba1568b4c9,
            uid   : 0,
        };
        0x2::transfer::share_object<NftStakingMetadata>(v0);
    }

    fun reward_debt(arg0: u64, arg1: u64, arg2: u64) : u64 {
        arg0 * arg1 / arg2
    }

    public entry fun reward_withdraw<T0: store + key, T1>(arg0: &mut PoolInfo<T0, T1>, arg1: &0x2::clock::Clock, arg2: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg2);
        update_pool<T0, T1>(arg0, arg1);
        assert!(0x2::dynamic_field::exists_with_type<address, UserInfo<T0, T1>>(&arg0.id, v0), 9);
        let v1 = 0x2::dynamic_field::borrow_mut<address, UserInfo<T0, T1>>(&mut arg0.id, v0);
        let v2 = cal_pending_reward(v1.number_nft_stake, v1.reward_debt, arg0.acc_token_per_share, arg0.precision_factor) + v1.pending_reward;
        0x2::transfer::public_transfer<0x2::coin::Coin<T1>>(0x2::coin::split<T1>(&mut arg0.total_reward_token, v2, arg2), v0);
        v1.reward_debt = reward_debt(v1.number_nft_stake, arg0.acc_token_per_share, arg0.precision_factor);
        v1.pending_reward = 0;
        let v3 = RewardWithdrawEvent{
            sender       : v0,
            amount       : v2,
            pool_uid     : arg0.uid,
            timestamp_ms : 0x2::clock::timestamp_ms(arg1),
        };
        0x2::event::emit<RewardWithdrawEvent>(v3);
    }

    public entry fun stake_nft<T0: store + key, T1>(arg0: T0, arg1: &mut NftStakingMetadata, arg2: &mut PoolInfo<T0, T1>, arg3: &0x2::clock::Clock, arg4: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg4);
        let v1 = 1;
        assert!(arg2.end_timestamp > 0x2::clock::timestamp_ms(arg3) / 1000, 14);
        if (!0x2::dynamic_field::exists_with_type<address, UserInfo<T0, T1>>(&arg2.id, v0)) {
            let v2 = UserInfo<T0, T1>{
                number_nft_stake : 0,
                reward_debt      : 0,
                item_ids         : 0x1::vector::empty<0x2::object::ID>(),
                pending_reward   : 0,
            };
            0x2::dynamic_field::add<address, UserInfo<T0, T1>>(&mut arg2.id, v0, v2);
        };
        update_pool<T0, T1>(arg2, arg3);
        let v3 = 0x2::dynamic_field::borrow_mut<address, UserInfo<T0, T1>>(&mut arg2.id, v0);
        if (v3.number_nft_stake > 0) {
            v3.pending_reward = v3.pending_reward + cal_pending_reward(v3.number_nft_stake, v3.reward_debt, arg2.acc_token_per_share, arg2.precision_factor);
        };
        let v4 = 0x2::object::id<T0>(&arg0);
        0x2::dynamic_object_field::add<0x2::object::ID, T0>(&mut arg1.id, v4, arg0);
        0x1::vector::push_back<0x2::object::ID>(&mut v3.item_ids, v4);
        v3.number_nft_stake = v3.number_nft_stake + v1;
        arg2.total_stake_nft = arg2.total_stake_nft + v1;
        v3.reward_debt = reward_debt(v3.number_nft_stake, arg2.acc_token_per_share, arg2.precision_factor);
        let v5 = StakingNFTEvent{
            item_id      : v4,
            sender       : v0,
            pool_uid     : arg2.uid,
            timestamp_ms : 0x2::clock::timestamp_ms(arg3),
        };
        0x2::event::emit<StakingNFTEvent>(v5);
    }

    public entry fun stop_reward<T0: store + key, T1>(arg0: &mut PoolInfo<T0, T1>, arg1: &mut NftStakingMetadata, arg2: &0x2::clock::Clock, arg3: &mut 0x2::tx_context::TxContext) {
        assert!(arg1.admin == 0x2::tx_context::sender(arg3), 5);
        arg0.end_timestamp = 0x2::clock::timestamp_ms(arg2) / 1000;
    }

    fun update_pool<T0, T1>(arg0: &mut PoolInfo<T0, T1>, arg1: &0x2::clock::Clock) {
        let v0 = 0x2::clock::timestamp_ms(arg1) / 1000;
        if (v0 <= arg0.last_reward_timestamp) {
            return
        };
        if (arg0.total_stake_nft == 0) {
            arg0.last_reward_timestamp = v0;
            return
        };
        let v1 = cal_acc_token_per_share(arg0.acc_token_per_share, arg0.total_stake_nft, arg0.end_timestamp, arg0.reward_per_second, arg0.precision_factor, arg0.last_reward_timestamp, arg1);
        if (arg0.acc_token_per_share == v1) {
            return
        };
        arg0.acc_token_per_share = v1;
        arg0.last_reward_timestamp = v0;
    }

    public entry fun update_pool_info<T0: store + key, T1>(arg0: &mut PoolInfo<T0, T1>, arg1: &mut NftStakingMetadata, arg2: u64, arg3: &mut 0x2::tx_context::TxContext) {
        assert!(arg1.admin == 0x2::tx_context::sender(arg3), 5);
        arg0.reward_per_second = arg2;
    }

    public entry fun withdraw_all_nft<T0: store + key, T1>(arg0: &mut NftStakingMetadata, arg1: &mut PoolInfo<T0, T1>, arg2: &0x2::clock::Clock, arg3: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg3);
        assert!(0x2::dynamic_field::exists_with_type<address, UserInfo<T0, T1>>(&arg1.id, v0), 9);
        update_pool<T0, T1>(arg1, arg2);
        let v1 = 0x2::dynamic_field::borrow_mut<address, UserInfo<T0, T1>>(&mut arg1.id, v0);
        let v2 = 0x1::vector::length<0x2::object::ID>(&v1.item_ids);
        while (v2 > 0) {
            let v3 = 0x1::vector::pop_back<0x2::object::ID>(&mut v1.item_ids);
            0x2::transfer::public_transfer<T0>(0x2::dynamic_object_field::remove<0x2::object::ID, T0>(&mut arg0.id, v3), 0x2::tx_context::sender(arg3));
            let v4 = WithdrawNFTEvent{
                item_id      : v3,
                sender       : v0,
                pool_uid     : arg1.uid,
                timestamp_ms : 0x2::clock::timestamp_ms(arg2),
            };
            0x2::event::emit<WithdrawNFTEvent>(v4);
            v2 = v2 - 1;
        };
        0x2::transfer::public_transfer<0x2::coin::Coin<T1>>(0x2::coin::split<T1>(&mut arg1.total_reward_token, cal_pending_reward(v1.number_nft_stake, v1.reward_debt, arg1.acc_token_per_share, arg1.precision_factor) + v1.pending_reward, arg3), v0);
        arg1.total_stake_nft = arg1.total_stake_nft - 0x1::vector::length<0x2::object::ID>(&v1.item_ids);
        v1.pending_reward = 0;
        v1.number_nft_stake = 0;
        v1.item_ids = 0x1::vector::empty<0x2::object::ID>();
        v1.reward_debt = reward_debt(v1.number_nft_stake, arg1.acc_token_per_share, arg1.precision_factor);
    }

    public entry fun withdraw_nft<T0: store + key, T1>(arg0: 0x2::object::ID, arg1: &mut NftStakingMetadata, arg2: &mut PoolInfo<T0, T1>, arg3: &0x2::clock::Clock, arg4: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg4);
        update_pool<T0, T1>(arg2, arg3);
        assert!(0x2::dynamic_field::exists_with_type<address, UserInfo<T0, T1>>(&arg2.id, v0), 9);
        let v1 = 0x2::dynamic_field::borrow_mut<address, UserInfo<T0, T1>>(&mut arg2.id, v0);
        let v2 = cal_pending_reward(v1.number_nft_stake, v1.reward_debt, arg2.acc_token_per_share, arg2.precision_factor);
        let (v3, v4) = 0x1::vector::index_of<0x2::object::ID>(&mut v1.item_ids, &arg0);
        assert!(v3, 9);
        if (v3) {
            0x1::vector::remove<0x2::object::ID>(&mut v1.item_ids, v4);
        };
        v1.number_nft_stake = v1.number_nft_stake - 1;
        if (v2 > 0) {
            v1.pending_reward = v1.pending_reward + v2;
        };
        arg2.total_stake_nft = arg2.total_stake_nft - 1;
        v1.reward_debt = reward_debt(v1.number_nft_stake, arg2.acc_token_per_share, arg2.precision_factor);
        0x2::transfer::public_transfer<T0>(0x2::dynamic_object_field::remove<0x2::object::ID, T0>(&mut arg1.id, arg0), 0x2::tx_context::sender(arg4));
        let v5 = WithdrawNFTEvent{
            item_id      : arg0,
            sender       : v0,
            pool_uid     : arg2.uid,
            timestamp_ms : 0x2::clock::timestamp_ms(arg3),
        };
        0x2::event::emit<WithdrawNFTEvent>(v5);
    }

    // decompiled from Move bytecode v6
}

