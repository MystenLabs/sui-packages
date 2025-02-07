module 0xecf8dbdcad40b709a903697958bb247bdfad2196e1603ae5d9f3538d2e907d8a::rewards {
    struct Reward has store, key {
        id: 0x2::object::UID,
        tenant_id: vector<u8>,
        reward_id: u64,
        cost: u64,
        reward_type: u8,
        reward_count: u64,
        points_or_missions: u64,
        token_address: address,
    }

    struct RedeemEvent has copy, drop, store {
        id: u64,
        user: address,
        reward_id: address,
        tenant_id: vector<u8>,
        redeem_amount: u64,
        timestamp: u64,
    }

    struct DepositEvent has copy, drop, store {
        tenant_id: vector<u8>,
        reward_id: address,
        from: address,
        recipient: address,
        amount: u64,
    }

    struct DepositCount has copy, drop, store {
        tenant_id: vector<u8>,
        reward_id: address,
        amount: u64,
    }

    struct RewardCount has copy, drop, store {
        tenant_id: vector<u8>,
        user: address,
        reward_count: u64,
        reward_id: address,
    }

    struct RewardPointDetails has copy, drop, store {
        tenant_id: vector<u8>,
        reward_id: address,
    }

    struct RewardThresholdDetails has copy, drop, store {
        tenant_id: vector<u8>,
        reward_id: address,
        user: address,
    }

    struct DepositDetails has copy, drop, store {
        tenant_id: vector<u8>,
        reward_id: address,
    }

    struct UserRewardCount has store, key {
        id: 0x2::object::UID,
        reward_point_counts: 0x2::bag::Bag,
        reward_threshold_counts: 0x2::bag::Bag,
    }

    struct DepositToken has store, key {
        id: 0x2::object::UID,
        deposit_table: 0x2::bag::Bag,
    }

    public fun create_redeem_reward(arg0: vector<u8>, arg1: &0xecf8dbdcad40b709a903697958bb247bdfad2196e1603ae5d9f3538d2e907d8a::access_control::AdminKey, arg2: &0xecf8dbdcad40b709a903697958bb247bdfad2196e1603ae5d9f3538d2e907d8a::access_control::Executor, arg3: u64, arg4: u8, arg5: u64, arg6: u64, arg7: address, arg8: &mut 0xecf8dbdcad40b709a903697958bb247bdfad2196e1603ae5d9f3538d2e907d8a::state::RewardClaimState, arg9: &mut 0x2::tx_context::TxContext) {
        assert!(0xecf8dbdcad40b709a903697958bb247bdfad2196e1603ae5d9f3538d2e907d8a::access_control::assert_admin(0x2::tx_context::sender(arg9), arg0, arg1) || 0xecf8dbdcad40b709a903697958bb247bdfad2196e1603ae5d9f3538d2e907d8a::access_control::assert_executor(0x2::tx_context::sender(arg9), arg2), 1);
        let v0 = Reward{
            id                 : 0x2::object::new(arg9),
            tenant_id          : arg0,
            reward_id          : 0xecf8dbdcad40b709a903697958bb247bdfad2196e1603ae5d9f3538d2e907d8a::state::increment_last_reward_id(arg8, arg0),
            cost               : arg3,
            reward_type        : arg4,
            reward_count       : arg5,
            points_or_missions : arg6,
            token_address      : arg7,
        };
        0x2::transfer::share_object<Reward>(v0);
    }

    public fun delete_reward(arg0: &0xecf8dbdcad40b709a903697958bb247bdfad2196e1603ae5d9f3538d2e907d8a::access_control::AdminKey, arg1: &0xecf8dbdcad40b709a903697958bb247bdfad2196e1603ae5d9f3538d2e907d8a::access_control::Executor, arg2: vector<u8>, arg3: Reward, arg4: &mut 0x2::tx_context::TxContext) {
        assert!(0xecf8dbdcad40b709a903697958bb247bdfad2196e1603ae5d9f3538d2e907d8a::access_control::assert_admin(0x2::tx_context::sender(arg4), arg2, arg0) || 0xecf8dbdcad40b709a903697958bb247bdfad2196e1603ae5d9f3538d2e907d8a::access_control::assert_executor(0x2::tx_context::sender(arg4), arg1), 1);
        assert!(arg2 == arg3.tenant_id, 8);
        let Reward {
            id                 : v0,
            tenant_id          : _,
            reward_id          : _,
            cost               : _,
            reward_type        : _,
            reward_count       : _,
            points_or_missions : _,
            token_address      : _,
        } = arg3;
        0x2::object::delete(v0);
    }

    public fun deposit<T0>(arg0: vector<u8>, arg1: &mut Reward, arg2: &mut 0x2::coin::Coin<T0>, arg3: address, arg4: u64, arg5: &mut DepositToken, arg6: &mut 0x2::tx_context::TxContext) {
        assert!(0x2::balance::value<T0>(0x2::coin::balance<T0>(arg2)) >= arg4, 9);
        assert!(arg0 == arg1.tenant_id, 8);
        assert!(arg1.cost * arg1.reward_count <= arg4, 7);
        0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(0x2::coin::split<T0>(arg2, arg4, arg6), arg3);
        let v0 = DepositDetails{
            tenant_id : arg0,
            reward_id : 0x2::object::id_address<Reward>(arg1),
        };
        if (0x2::bag::contains<DepositDetails>(&arg5.deposit_table, v0)) {
            let v1 = 0x2::bag::borrow_mut<DepositDetails, u64>(&mut arg5.deposit_table, v0);
            *v1 = *v1 + arg4;
        } else {
            0x2::bag::add<DepositDetails, u64>(&mut arg5.deposit_table, v0, arg4);
        };
        let v2 = DepositEvent{
            tenant_id : arg0,
            reward_id : 0x2::object::id_address<Reward>(arg1),
            from      : 0x2::tx_context::sender(arg6),
            recipient : arg3,
            amount    : arg4,
        };
        0x2::event::emit<DepositEvent>(v2);
    }

    public fun get_available_reward_count(arg0: address, arg1: vector<u8>, arg2: &mut Reward) : u64 {
        let v0 = RewardCount{
            tenant_id    : arg1,
            user         : arg0,
            reward_count : arg2.reward_count,
            reward_id    : 0x2::object::id_address<Reward>(arg2),
        };
        0x2::event::emit<RewardCount>(v0);
        arg2.reward_count
    }

    public fun get_deposit_amount(arg0: vector<u8>, arg1: &mut Reward, arg2: &DepositToken) : u64 {
        let v0 = DepositDetails{
            tenant_id : arg0,
            reward_id : 0x2::object::id_address<Reward>(arg1),
        };
        let v1 = if (0x2::bag::contains<DepositDetails>(&arg2.deposit_table, v0)) {
            *0x2::bag::borrow<DepositDetails, u64>(&arg2.deposit_table, v0)
        } else {
            0
        };
        let v2 = DepositCount{
            tenant_id : arg0,
            reward_id : 0x2::object::id_address<Reward>(arg1),
            amount    : v1,
        };
        0x2::event::emit<DepositCount>(v2);
        arg1.reward_count
    }

    fun init(arg0: &mut 0x2::tx_context::TxContext) {
        let v0 = UserRewardCount{
            id                      : 0x2::object::new(arg0),
            reward_point_counts     : 0x2::bag::new(arg0),
            reward_threshold_counts : 0x2::bag::new(arg0),
        };
        0x2::transfer::share_object<UserRewardCount>(v0);
        let v1 = DepositToken{
            id            : 0x2::object::new(arg0),
            deposit_table : 0x2::bag::new(arg0),
        };
        0x2::transfer::share_object<DepositToken>(v1);
    }

    public fun initialize(arg0: &mut 0x2::tx_context::TxContext) {
        let v0 = UserRewardCount{
            id                      : 0x2::object::new(arg0),
            reward_point_counts     : 0x2::bag::new(arg0),
            reward_threshold_counts : 0x2::bag::new(arg0),
        };
        let v1 = DepositToken{
            id            : 0x2::object::new(arg0),
            deposit_table : 0x2::bag::new(arg0),
        };
        0x2::transfer::share_object<UserRewardCount>(v0);
        0x2::transfer::share_object<DepositToken>(v1);
    }

    public fun redeem_reward_points<T0>(arg0: vector<u8>, arg1: address, arg2: vector<u8>, arg3: &mut 0x2::coin::Coin<T0>, arg4: &mut Reward, arg5: &0x2::clock::Clock, arg6: &mut UserRewardCount, arg7: &mut 0xecf8dbdcad40b709a903697958bb247bdfad2196e1603ae5d9f3538d2e907d8a::claims::UserClaimCount, arg8: &mut 0x2::tx_context::TxContext) {
        assert!(arg0 == arg4.tenant_id, 8);
        assert!(arg4.reward_count > 0, 10);
        let v0 = RewardPointDetails{
            tenant_id : arg0,
            reward_id : 0x2::object::id_address<Reward>(arg4),
        };
        if (0x2::bag::contains<RewardPointDetails>(&arg6.reward_point_counts, v0)) {
            let v1 = 0x2::bag::borrow_mut<RewardPointDetails, u64>(&mut arg6.reward_point_counts, v0);
            *v1 = *v1 + 1;
        } else {
            0x2::bag::add<RewardPointDetails, u64>(&mut arg6.reward_point_counts, v0, 1);
        };
        0xecf8dbdcad40b709a903697958bb247bdfad2196e1603ae5d9f3538d2e907d8a::claims::reduce_points(arg2, arg0, arg7, arg4.points_or_missions);
        0xecf8dbdcad40b709a903697958bb247bdfad2196e1603ae5d9f3538d2e907d8a::closedloop_token::transfer_coin<T0>(arg3, arg1, arg4.cost, arg8);
        arg4.reward_count = arg4.reward_count - 1;
        let v2 = RedeemEvent{
            id            : arg4.reward_id,
            user          : arg1,
            reward_id     : 0x2::object::id_address<Reward>(arg4),
            tenant_id     : arg4.tenant_id,
            redeem_amount : arg4.cost,
            timestamp     : 0x2::clock::timestamp_ms(arg5),
        };
        0x2::event::emit<RedeemEvent>(v2);
    }

    public fun redeem_reward_threshold<T0>(arg0: vector<u8>, arg1: address, arg2: vector<u8>, arg3: &mut 0x2::coin::Coin<T0>, arg4: &mut Reward, arg5: &0x2::clock::Clock, arg6: &mut UserRewardCount, arg7: &mut 0xecf8dbdcad40b709a903697958bb247bdfad2196e1603ae5d9f3538d2e907d8a::claims::UserClaimCount, arg8: &mut 0x2::tx_context::TxContext) {
        assert!(arg0 == arg4.tenant_id, 8);
        assert!(arg4.reward_count > 0, 10);
        if (0xecf8dbdcad40b709a903697958bb247bdfad2196e1603ae5d9f3538d2e907d8a::claims::get_user_claim_count(arg2, arg0, arg7) < arg4.points_or_missions) {
            abort 6
        };
        0xecf8dbdcad40b709a903697958bb247bdfad2196e1603ae5d9f3538d2e907d8a::closedloop_token::transfer_coin<T0>(arg3, arg1, arg4.cost, arg8);
        let v0 = RewardThresholdDetails{
            tenant_id : arg0,
            reward_id : 0x2::object::id_address<Reward>(arg4),
            user      : arg1,
        };
        let v1 = if (0x2::bag::contains<RewardThresholdDetails>(&arg6.reward_point_counts, v0)) {
            *0x2::bag::borrow<RewardThresholdDetails, u64>(&arg6.reward_point_counts, v0)
        } else {
            0
        };
        if (v1 >= 1) {
            abort 10
        };
        if (0x2::bag::contains<RewardThresholdDetails>(&arg6.reward_threshold_counts, v0)) {
            let v2 = 0x2::bag::borrow_mut<RewardThresholdDetails, u64>(&mut arg6.reward_point_counts, v0);
            *v2 = *v2 + 1;
        } else {
            0x2::bag::add<RewardThresholdDetails, u64>(&mut arg6.reward_point_counts, v0, 1);
        };
        0xecf8dbdcad40b709a903697958bb247bdfad2196e1603ae5d9f3538d2e907d8a::claims::reduce_points(arg2, arg0, arg7, arg4.points_or_missions);
        0xecf8dbdcad40b709a903697958bb247bdfad2196e1603ae5d9f3538d2e907d8a::closedloop_token::transfer_coin<T0>(arg3, arg1, arg4.cost, arg8);
        arg4.reward_count = arg4.reward_count - 1;
        let v3 = RedeemEvent{
            id            : arg4.reward_id,
            user          : arg1,
            reward_id     : 0x2::object::id_address<Reward>(arg4),
            tenant_id     : arg4.tenant_id,
            redeem_amount : arg4.cost,
            timestamp     : 0x2::clock::timestamp_ms(arg5),
        };
        0x2::event::emit<RedeemEvent>(v3);
    }

    // decompiled from Move bytecode v6
}

