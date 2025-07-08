module 0x703f0059e0ac03280da3fa91518ceea1353b2bdc50e7b58f57b336be9cd94189::reward_manager {
    struct RewardManagerCreated has copy, drop {
        reward_manager_id: address,
        vault_id: address,
    }

    struct RewardTypeAdded has copy, drop {
        reward_manager_id: address,
        vault_id: address,
        coin_type: 0x1::type_name::TypeName,
    }

    struct RewardBalanceAdded has copy, drop {
        reward_manager_id: address,
        vault_id: address,
        coin_type: 0x1::type_name::TypeName,
        reward_amount: u256,
    }

    struct RewardIndicesUpdated has copy, drop {
        reward_manager_id: address,
        vault_id: address,
        coin_type: 0x1::type_name::TypeName,
        reward_amount: u256,
        inc_reward_index: u256,
        new_reward_index: u256,
    }

    struct RewardClaimed has copy, drop {
        reward_manager_id: address,
        vault_id: address,
        receipt_id: address,
        coin_type: 0x1::type_name::TypeName,
        reward_amount: u64,
    }

    struct RewardBufferUpdated has copy, drop {
        vault_id: address,
        coin_type: 0x1::type_name::TypeName,
        reward_amount: u256,
    }

    struct RewardBufferRateUpdated has copy, drop {
        vault_id: address,
        coin_type: 0x1::type_name::TypeName,
        rate: u256,
    }

    struct RewardAddedWithBuffer has copy, drop {
        vault_id: address,
        coin_type: 0x1::type_name::TypeName,
        reward_amount: u256,
    }

    struct RewardBufferDistributionCreated has copy, drop {
        reward_manager_id: address,
        vault_id: address,
        coin_type: 0x1::type_name::TypeName,
    }

    struct RewardBufferDistributionRemoved has copy, drop {
        reward_manager_id: address,
        vault_id: address,
        coin_type: 0x1::type_name::TypeName,
    }

    struct RewardManagerUpgraded has copy, drop {
        reward_manager_id: address,
        version: u64,
    }

    struct UndistributedRewardRetrieved has copy, drop {
        reward_manager_id: address,
        vault_id: address,
        reward_type: 0x1::type_name::TypeName,
        amount: u64,
    }

    struct RewardManager<phantom T0> has store, key {
        id: 0x2::object::UID,
        version: u64,
        vault_id: address,
        reward_balances: 0x2::bag::Bag,
        reward_amounts: 0x2::table::Table<0x1::type_name::TypeName, u256>,
        reward_indices: 0x2::vec_map::VecMap<0x1::type_name::TypeName, u256>,
        reward_buffer: RewardBuffer,
    }

    struct RewardBuffer has store {
        reward_amounts: 0x2::table::Table<0x1::type_name::TypeName, u256>,
        distributions: 0x2::vec_map::VecMap<0x1::type_name::TypeName, BufferDistribution>,
    }

    struct BufferDistribution has copy, drop, store {
        rate: u256,
        last_updated: u64,
    }

    public fun vault_id<T0>(arg0: &RewardManager<T0>) : address {
        arg0.vault_id
    }

    public fun add_new_reward_type<T0, T1>(arg0: &mut RewardManager<T0>, arg1: &0x703f0059e0ac03280da3fa91518ceea1353b2bdc50e7b58f57b336be9cd94189::vault::Operation, arg2: &0x703f0059e0ac03280da3fa91518ceea1353b2bdc50e7b58f57b336be9cd94189::vault::OperatorCap, arg3: &0x2::clock::Clock, arg4: bool) {
        check_version<T0>(arg0);
        0x703f0059e0ac03280da3fa91518ceea1353b2bdc50e7b58f57b336be9cd94189::vault::assert_operator_not_freezed(arg1, arg2);
        let v0 = 0x1::type_name::get<T1>();
        0x2::bag::add<0x1::type_name::TypeName, 0x2::balance::Balance<T1>>(&mut arg0.reward_balances, v0, 0x2::balance::zero<T1>());
        0x2::table::add<0x1::type_name::TypeName, u256>(&mut arg0.reward_amounts, v0, 0);
        0x2::vec_map::insert<0x1::type_name::TypeName, u256>(&mut arg0.reward_indices, v0, 0);
        if (arg4) {
            let v1 = &mut arg0.reward_buffer;
            0x2::table::add<0x1::type_name::TypeName, u256>(&mut v1.reward_amounts, v0, 0);
            let v2 = BufferDistribution{
                rate         : 0,
                last_updated : 0x2::clock::timestamp_ms(arg3),
            };
            0x2::vec_map::insert<0x1::type_name::TypeName, BufferDistribution>(&mut v1.distributions, v0, v2);
            let v3 = RewardBufferDistributionCreated{
                reward_manager_id : 0x2::object::uid_to_address(&arg0.id),
                vault_id          : arg0.vault_id,
                coin_type         : v0,
            };
            0x2::event::emit<RewardBufferDistributionCreated>(v3);
        };
        let v4 = RewardTypeAdded{
            reward_manager_id : 0x2::object::uid_to_address(&arg0.id),
            vault_id          : arg0.vault_id,
            coin_type         : v0,
        };
        0x2::event::emit<RewardTypeAdded>(v4);
    }

    public fun add_reward_balance<T0, T1>(arg0: &mut RewardManager<T0>, arg1: &mut 0x703f0059e0ac03280da3fa91518ceea1353b2bdc50e7b58f57b336be9cd94189::vault::Vault<T0>, arg2: &0x703f0059e0ac03280da3fa91518ceea1353b2bdc50e7b58f57b336be9cd94189::vault::Operation, arg3: &0x703f0059e0ac03280da3fa91518ceea1353b2bdc50e7b58f57b336be9cd94189::vault::OperatorCap, arg4: 0x2::balance::Balance<T1>) {
        check_version<T0>(arg0);
        assert!(arg0.vault_id == 0x703f0059e0ac03280da3fa91518ceea1353b2bdc50e7b58f57b336be9cd94189::vault::vault_id<T0>(arg1), 1001);
        0x703f0059e0ac03280da3fa91518ceea1353b2bdc50e7b58f57b336be9cd94189::vault::assert_operator_not_freezed(arg2, arg3);
        let v0 = 0x1::type_name::get<T1>();
        let v1 = 0x703f0059e0ac03280da3fa91518ceea1353b2bdc50e7b58f57b336be9cd94189::vault_utils::to_decimals((0x2::balance::value<T1>(&arg4) as u256));
        assert!(v1 >= 0x703f0059e0ac03280da3fa91518ceea1353b2bdc50e7b58f57b336be9cd94189::vault_utils::mul_with_oracle_price(0x703f0059e0ac03280da3fa91518ceea1353b2bdc50e7b58f57b336be9cd94189::vault::total_shares<T0>(arg1), 1), 1012);
        0x2::balance::join<T1>(0x2::bag::borrow_mut<0x1::type_name::TypeName, 0x2::balance::Balance<T1>>(&mut arg0.reward_balances, v0), arg4);
        let v2 = 0x2::table::borrow_mut<0x1::type_name::TypeName, u256>(&mut arg0.reward_amounts, v0);
        *v2 = *v2 + v1;
        update_reward_indices<T0>(arg0, arg1, v0, v1);
        let v3 = RewardBalanceAdded{
            reward_manager_id : 0x2::object::uid_to_address(&arg0.id),
            vault_id          : 0x703f0059e0ac03280da3fa91518ceea1353b2bdc50e7b58f57b336be9cd94189::vault::vault_id<T0>(arg1),
            coin_type         : v0,
            reward_amount     : v1,
        };
        0x2::event::emit<RewardBalanceAdded>(v3);
    }

    public fun add_reward_to_buffer<T0, T1>(arg0: &mut RewardManager<T0>, arg1: &mut 0x703f0059e0ac03280da3fa91518ceea1353b2bdc50e7b58f57b336be9cd94189::vault::Vault<T0>, arg2: &0x703f0059e0ac03280da3fa91518ceea1353b2bdc50e7b58f57b336be9cd94189::vault::Operation, arg3: &0x703f0059e0ac03280da3fa91518ceea1353b2bdc50e7b58f57b336be9cd94189::vault::OperatorCap, arg4: &0x2::clock::Clock, arg5: 0x2::balance::Balance<T1>) {
        check_version<T0>(arg0);
        assert!(arg0.vault_id == 0x703f0059e0ac03280da3fa91518ceea1353b2bdc50e7b58f57b336be9cd94189::vault::vault_id<T0>(arg1), 1001);
        0x703f0059e0ac03280da3fa91518ceea1353b2bdc50e7b58f57b336be9cd94189::vault::assert_operator_not_freezed(arg2, arg3);
        let v0 = 0x1::type_name::get<T1>();
        let v1 = 0x703f0059e0ac03280da3fa91518ceea1353b2bdc50e7b58f57b336be9cd94189::vault_utils::to_decimals((0x2::balance::value<T1>(&arg5) as u256));
        update_reward_buffer<T0>(arg0, arg1, arg4, v0);
        *0x2::table::borrow_mut<0x1::type_name::TypeName, u256>(&mut arg0.reward_buffer.reward_amounts, v0) = *0x2::table::borrow<0x1::type_name::TypeName, u256>(&arg0.reward_buffer.reward_amounts, v0) + v1;
        0x2::balance::join<T1>(0x2::bag::borrow_mut<0x1::type_name::TypeName, 0x2::balance::Balance<T1>>(&mut arg0.reward_balances, v0), arg5);
        let v2 = RewardAddedWithBuffer{
            vault_id      : 0x703f0059e0ac03280da3fa91518ceea1353b2bdc50e7b58f57b336be9cd94189::vault::vault_id<T0>(arg1),
            coin_type     : v0,
            reward_amount : v1,
        };
        0x2::event::emit<RewardAddedWithBuffer>(v2);
    }

    public(friend) fun check_version<T0>(arg0: &RewardManager<T0>) {
        assert!(arg0.version == 1, 1007);
    }

    public fun claim_reward<T0, T1>(arg0: &mut RewardManager<T0>, arg1: &mut 0x703f0059e0ac03280da3fa91518ceea1353b2bdc50e7b58f57b336be9cd94189::vault::Vault<T0>, arg2: &0x2::clock::Clock, arg3: &mut 0x703f0059e0ac03280da3fa91518ceea1353b2bdc50e7b58f57b336be9cd94189::receipt::Receipt) : 0x2::balance::Balance<T1> {
        check_version<T0>(arg0);
        0x703f0059e0ac03280da3fa91518ceea1353b2bdc50e7b58f57b336be9cd94189::vault::assert_enabled<T0>(arg1);
        0x703f0059e0ac03280da3fa91518ceea1353b2bdc50e7b58f57b336be9cd94189::vault::assert_vault_receipt_matched<T0>(arg1, arg3);
        assert!(arg0.vault_id == 0x703f0059e0ac03280da3fa91518ceea1353b2bdc50e7b58f57b336be9cd94189::vault::vault_id<T0>(arg1), 1001);
        let v0 = 0x703f0059e0ac03280da3fa91518ceea1353b2bdc50e7b58f57b336be9cd94189::receipt::receipt_id(arg3);
        assert!(0x703f0059e0ac03280da3fa91518ceea1353b2bdc50e7b58f57b336be9cd94189::vault_receipt_info::status(0x703f0059e0ac03280da3fa91518ceea1353b2bdc50e7b58f57b336be9cd94189::vault::vault_receipt_info<T0>(arg1, v0)) == 0, 1006);
        update_reward_buffers<T0>(arg0, arg1, arg2);
        update_receipt_reward<T0>(arg0, arg1, v0);
        let v1 = 0x1::type_name::get<T1>();
        let v2 = (0x703f0059e0ac03280da3fa91518ceea1353b2bdc50e7b58f57b336be9cd94189::vault_utils::from_decimals((0x703f0059e0ac03280da3fa91518ceea1353b2bdc50e7b58f57b336be9cd94189::vault_receipt_info::reset_unclaimed_rewards<T1>(0x703f0059e0ac03280da3fa91518ceea1353b2bdc50e7b58f57b336be9cd94189::vault::vault_receipt_info_mut<T0>(arg1, v0)) as u256)) as u64);
        let v3 = 0x2::bag::borrow_mut<0x1::type_name::TypeName, 0x2::balance::Balance<T1>>(&mut arg0.reward_balances, v1);
        assert!(v2 <= 0x2::balance::value<T1>(v3), 1002);
        let v4 = RewardClaimed{
            reward_manager_id : 0x2::object::uid_to_address(&arg0.id),
            vault_id          : 0x703f0059e0ac03280da3fa91518ceea1353b2bdc50e7b58f57b336be9cd94189::receipt::vault_id(arg3),
            receipt_id        : 0x703f0059e0ac03280da3fa91518ceea1353b2bdc50e7b58f57b336be9cd94189::receipt::receipt_id(arg3),
            coin_type         : v1,
            reward_amount     : v2,
        };
        0x2::event::emit<RewardClaimed>(v4);
        0x2::balance::split<T1>(v3, v2)
    }

    public fun create_reward_buffer_distribution<T0, T1>(arg0: &mut RewardManager<T0>, arg1: &0x703f0059e0ac03280da3fa91518ceea1353b2bdc50e7b58f57b336be9cd94189::vault::Operation, arg2: &0x703f0059e0ac03280da3fa91518ceea1353b2bdc50e7b58f57b336be9cd94189::vault::OperatorCap, arg3: &0x2::clock::Clock) {
        check_version<T0>(arg0);
        0x703f0059e0ac03280da3fa91518ceea1353b2bdc50e7b58f57b336be9cd94189::vault::assert_operator_not_freezed(arg1, arg2);
        let v0 = &mut arg0.reward_buffer;
        let v1 = 0x1::type_name::get<T1>();
        assert!(!0x2::table::contains<0x1::type_name::TypeName, u256>(&v0.reward_amounts, v1), 1003);
        0x2::table::add<0x1::type_name::TypeName, u256>(&mut v0.reward_amounts, v1, 0);
        let v2 = BufferDistribution{
            rate         : 0,
            last_updated : 0x2::clock::timestamp_ms(arg3),
        };
        0x2::vec_map::insert<0x1::type_name::TypeName, BufferDistribution>(&mut v0.distributions, v1, v2);
        let v3 = RewardBufferDistributionCreated{
            reward_manager_id : 0x2::object::uid_to_address(&arg0.id),
            vault_id          : arg0.vault_id,
            coin_type         : v1,
        };
        0x2::event::emit<RewardBufferDistributionCreated>(v3);
    }

    public(friend) fun create_reward_manager<T0>(arg0: &mut 0x703f0059e0ac03280da3fa91518ceea1353b2bdc50e7b58f57b336be9cd94189::vault::Vault<T0>, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x703f0059e0ac03280da3fa91518ceea1353b2bdc50e7b58f57b336be9cd94189::vault::vault_id<T0>(arg0);
        let v1 = RewardBuffer{
            reward_amounts : 0x2::table::new<0x1::type_name::TypeName, u256>(arg1),
            distributions  : 0x2::vec_map::empty<0x1::type_name::TypeName, BufferDistribution>(),
        };
        let v2 = RewardManager<T0>{
            id              : 0x2::object::new(arg1),
            version         : 1,
            vault_id        : v0,
            reward_balances : 0x2::bag::new(arg1),
            reward_amounts  : 0x2::table::new<0x1::type_name::TypeName, u256>(arg1),
            reward_indices  : 0x2::vec_map::empty<0x1::type_name::TypeName, u256>(),
            reward_buffer   : v1,
        };
        0x703f0059e0ac03280da3fa91518ceea1353b2bdc50e7b58f57b336be9cd94189::vault::set_reward_manager<T0>(arg0, 0x2::object::uid_to_address(&v2.id));
        let v3 = RewardManagerCreated{
            reward_manager_id : 0x2::object::uid_to_address(&v2.id),
            vault_id          : v0,
        };
        0x2::event::emit<RewardManagerCreated>(v3);
        0x2::transfer::share_object<RewardManager<T0>>(v2);
    }

    public(friend) fun issue_receipt<T0>(arg0: &RewardManager<T0>, arg1: &mut 0x2::tx_context::TxContext) : 0x703f0059e0ac03280da3fa91518ceea1353b2bdc50e7b58f57b336be9cd94189::receipt::Receipt {
        check_version<T0>(arg0);
        0x703f0059e0ac03280da3fa91518ceea1353b2bdc50e7b58f57b336be9cd94189::receipt::create_receipt(arg0.vault_id, arg1)
    }

    public(friend) fun issue_vault_receipt_info<T0>(arg0: &RewardManager<T0>, arg1: &mut 0x2::tx_context::TxContext) : 0x703f0059e0ac03280da3fa91518ceea1353b2bdc50e7b58f57b336be9cd94189::vault_receipt_info::VaultReceiptInfo {
        check_version<T0>(arg0);
        let v0 = reward_indices<T0>(arg0);
        0x703f0059e0ac03280da3fa91518ceea1353b2bdc50e7b58f57b336be9cd94189::vault_receipt_info::new_vault_receipt_info(0x703f0059e0ac03280da3fa91518ceea1353b2bdc50e7b58f57b336be9cd94189::vault_utils::clone_vecmap_table<0x1::type_name::TypeName, u256>(&v0, arg1), 0x2::table::new<0x1::type_name::TypeName, u256>(arg1))
    }

    public fun remove_reward_buffer_distribution<T0>(arg0: &mut RewardManager<T0>, arg1: &mut 0x703f0059e0ac03280da3fa91518ceea1353b2bdc50e7b58f57b336be9cd94189::vault::Vault<T0>, arg2: &0x703f0059e0ac03280da3fa91518ceea1353b2bdc50e7b58f57b336be9cd94189::vault::Operation, arg3: &0x703f0059e0ac03280da3fa91518ceea1353b2bdc50e7b58f57b336be9cd94189::vault::OperatorCap, arg4: &0x2::clock::Clock, arg5: 0x1::type_name::TypeName) {
        check_version<T0>(arg0);
        assert!(arg0.vault_id == 0x703f0059e0ac03280da3fa91518ceea1353b2bdc50e7b58f57b336be9cd94189::vault::vault_id<T0>(arg1), 1001);
        0x703f0059e0ac03280da3fa91518ceea1353b2bdc50e7b58f57b336be9cd94189::vault::assert_operator_not_freezed(arg2, arg3);
        update_reward_buffer<T0>(arg0, arg1, arg4, arg5);
        assert!(*0x2::table::borrow<0x1::type_name::TypeName, u256>(&arg0.reward_buffer.reward_amounts, arg5) == 0, 1005);
        0x2::table::remove<0x1::type_name::TypeName, u256>(&mut arg0.reward_buffer.reward_amounts, arg5);
        let (_, _) = 0x2::vec_map::remove<0x1::type_name::TypeName, BufferDistribution>(&mut arg0.reward_buffer.distributions, &arg5);
        let v2 = RewardBufferDistributionRemoved{
            reward_manager_id : 0x2::object::uid_to_address(&arg0.id),
            vault_id          : 0x703f0059e0ac03280da3fa91518ceea1353b2bdc50e7b58f57b336be9cd94189::vault::vault_id<T0>(arg1),
            coin_type         : arg5,
        };
        0x2::event::emit<RewardBufferDistributionRemoved>(v2);
    }

    public fun retrieve_undistributed_reward<T0, T1>(arg0: &mut RewardManager<T0>, arg1: &mut 0x703f0059e0ac03280da3fa91518ceea1353b2bdc50e7b58f57b336be9cd94189::vault::Vault<T0>, arg2: &0x703f0059e0ac03280da3fa91518ceea1353b2bdc50e7b58f57b336be9cd94189::vault::Operation, arg3: &0x703f0059e0ac03280da3fa91518ceea1353b2bdc50e7b58f57b336be9cd94189::vault::OperatorCap, arg4: u64, arg5: &0x2::clock::Clock) : 0x2::balance::Balance<T1> {
        check_version<T0>(arg0);
        assert!(arg0.vault_id == 0x703f0059e0ac03280da3fa91518ceea1353b2bdc50e7b58f57b336be9cd94189::vault::vault_id<T0>(arg1), 1001);
        0x703f0059e0ac03280da3fa91518ceea1353b2bdc50e7b58f57b336be9cd94189::vault::assert_operator_not_freezed(arg2, arg3);
        let v0 = 0x1::type_name::get<T1>();
        update_reward_buffer<T0>(arg0, arg1, arg5, v0);
        let v1 = *0x2::table::borrow<0x1::type_name::TypeName, u256>(&arg0.reward_buffer.reward_amounts, v0);
        let v2 = 0x703f0059e0ac03280da3fa91518ceea1353b2bdc50e7b58f57b336be9cd94189::vault_utils::to_decimals((arg4 as u256));
        assert!(v1 >= v2, 108);
        *0x2::table::borrow_mut<0x1::type_name::TypeName, u256>(&mut arg0.reward_buffer.reward_amounts, v0) = v1 - v2;
        let v3 = UndistributedRewardRetrieved{
            reward_manager_id : 0x2::object::uid_to_address(&arg0.id),
            vault_id          : 0x703f0059e0ac03280da3fa91518ceea1353b2bdc50e7b58f57b336be9cd94189::vault::vault_id<T0>(arg1),
            reward_type       : v0,
            amount            : arg4,
        };
        0x2::event::emit<UndistributedRewardRetrieved>(v3);
        0x2::balance::split<T1>(0x2::bag::borrow_mut<0x1::type_name::TypeName, 0x2::balance::Balance<T1>>(&mut arg0.reward_balances, v0), arg4)
    }

    public fun reward_amount<T0, T1>(arg0: &RewardManager<T0>) : u256 {
        *0x2::table::borrow<0x1::type_name::TypeName, u256>(&arg0.reward_amounts, 0x1::type_name::get<T1>())
    }

    public fun reward_balance<T0, T1>(arg0: &RewardManager<T0>) : &0x2::balance::Balance<T1> {
        0x2::bag::borrow<0x1::type_name::TypeName, 0x2::balance::Balance<T1>>(&arg0.reward_balances, 0x1::type_name::get<T1>())
    }

    public fun reward_buffer_amount<T0, T1>(arg0: &RewardManager<T0>) : u256 {
        *0x2::table::borrow<0x1::type_name::TypeName, u256>(&arg0.reward_buffer.reward_amounts, 0x1::type_name::get<T1>())
    }

    public fun reward_buffer_distribution_last_updated<T0, T1>(arg0: &RewardManager<T0>) : u64 {
        let v0 = 0x1::type_name::get<T1>();
        0x2::vec_map::get<0x1::type_name::TypeName, BufferDistribution>(&arg0.reward_buffer.distributions, &v0).last_updated
    }

    public fun reward_buffer_distribution_rate<T0, T1>(arg0: &RewardManager<T0>) : u256 {
        let v0 = 0x1::type_name::get<T1>();
        0x2::vec_map::get<0x1::type_name::TypeName, BufferDistribution>(&arg0.reward_buffer.distributions, &v0).rate
    }

    public fun reward_indices<T0>(arg0: &RewardManager<T0>) : 0x2::vec_map::VecMap<0x1::type_name::TypeName, u256> {
        arg0.reward_indices
    }

    public fun set_reward_rate<T0, T1>(arg0: &mut RewardManager<T0>, arg1: &mut 0x703f0059e0ac03280da3fa91518ceea1353b2bdc50e7b58f57b336be9cd94189::vault::Vault<T0>, arg2: &0x703f0059e0ac03280da3fa91518ceea1353b2bdc50e7b58f57b336be9cd94189::vault::Operation, arg3: &0x703f0059e0ac03280da3fa91518ceea1353b2bdc50e7b58f57b336be9cd94189::vault::OperatorCap, arg4: &0x2::clock::Clock, arg5: u256) {
        check_version<T0>(arg0);
        assert!(arg0.vault_id == 0x703f0059e0ac03280da3fa91518ceea1353b2bdc50e7b58f57b336be9cd94189::vault::vault_id<T0>(arg1), 1001);
        0x703f0059e0ac03280da3fa91518ceea1353b2bdc50e7b58f57b336be9cd94189::vault::assert_operator_not_freezed(arg2, arg3);
        assert!(arg5 < 1340186218024493002587627141304258192746180378074543565271499814906401, 1009);
        let v0 = 0x1::type_name::get<T1>();
        update_reward_buffer<T0>(arg0, arg1, arg4, v0);
        0x2::vec_map::get_mut<0x1::type_name::TypeName, BufferDistribution>(&mut arg0.reward_buffer.distributions, &v0).rate = arg5;
        let v1 = RewardBufferRateUpdated{
            vault_id  : 0x703f0059e0ac03280da3fa91518ceea1353b2bdc50e7b58f57b336be9cd94189::vault::vault_id<T0>(arg1),
            coin_type : v0,
            rate      : arg5,
        };
        0x2::event::emit<RewardBufferRateUpdated>(v1);
    }

    public(friend) fun update_receipt_reward<T0>(arg0: &RewardManager<T0>, arg1: &mut 0x703f0059e0ac03280da3fa91518ceea1353b2bdc50e7b58f57b336be9cd94189::vault::Vault<T0>, arg2: address) {
        check_version<T0>(arg0);
        let v0 = 0x703f0059e0ac03280da3fa91518ceea1353b2bdc50e7b58f57b336be9cd94189::vault::vault_receipt_info_mut<T0>(arg1, arg2);
        let v1 = 0x2::vec_map::keys<0x1::type_name::TypeName, u256>(&arg0.reward_indices);
        let v2 = &v1;
        let v3 = 0;
        while (v3 < 0x1::vector::length<0x1::type_name::TypeName>(v2)) {
            let v4 = 0x1::vector::borrow<0x1::type_name::TypeName>(v2, v3);
            0x703f0059e0ac03280da3fa91518ceea1353b2bdc50e7b58f57b336be9cd94189::vault_receipt_info::update_reward(v0, *v4, *0x2::vec_map::get<0x1::type_name::TypeName, u256>(&arg0.reward_indices, v4));
            v3 = v3 + 1;
        };
    }

    public fun update_reward_buffer<T0>(arg0: &mut RewardManager<T0>, arg1: &mut 0x703f0059e0ac03280da3fa91518ceea1353b2bdc50e7b58f57b336be9cd94189::vault::Vault<T0>, arg2: &0x2::clock::Clock, arg3: 0x1::type_name::TypeName) {
        check_version<T0>(arg0);
        assert!(arg0.vault_id == 0x703f0059e0ac03280da3fa91518ceea1353b2bdc50e7b58f57b336be9cd94189::vault::vault_id<T0>(arg1), 1001);
        assert!(0x2::table::contains<0x1::type_name::TypeName, u256>(&arg0.reward_buffer.reward_amounts, arg3), 1004);
        let v0 = 0x2::clock::timestamp_ms(arg2);
        let v1 = 0x2::vec_map::get<0x1::type_name::TypeName, BufferDistribution>(&arg0.reward_buffer.distributions, &arg3);
        if (v0 > v1.last_updated) {
            if (v1.rate == 0) {
                0x2::vec_map::get_mut<0x1::type_name::TypeName, BufferDistribution>(&mut arg0.reward_buffer.distributions, &arg3).last_updated = v0;
                let v2 = RewardBufferUpdated{
                    vault_id      : 0x703f0059e0ac03280da3fa91518ceea1353b2bdc50e7b58f57b336be9cd94189::vault::vault_id<T0>(arg1),
                    coin_type     : arg3,
                    reward_amount : 0,
                };
                0x2::event::emit<RewardBufferUpdated>(v2);
            } else {
                let v3 = 0x703f0059e0ac03280da3fa91518ceea1353b2bdc50e7b58f57b336be9cd94189::vault::total_shares<T0>(arg1);
                let v4 = v1.rate * ((v0 - v1.last_updated) as u256);
                let v5 = *0x2::table::borrow<0x1::type_name::TypeName, u256>(&arg0.reward_buffer.reward_amounts, arg3);
                if (v5 == 0) {
                    0x2::vec_map::get_mut<0x1::type_name::TypeName, BufferDistribution>(&mut arg0.reward_buffer.distributions, &arg3).last_updated = v0;
                    let v6 = RewardBufferUpdated{
                        vault_id      : 0x703f0059e0ac03280da3fa91518ceea1353b2bdc50e7b58f57b336be9cd94189::vault::vault_id<T0>(arg1),
                        coin_type     : arg3,
                        reward_amount : 0,
                    };
                    0x2::event::emit<RewardBufferUpdated>(v6);
                } else {
                    let v7 = 0x1::u256::min(v5, v4);
                    let v8 = if (v7 >= 0x703f0059e0ac03280da3fa91518ceea1353b2bdc50e7b58f57b336be9cd94189::vault_utils::mul_with_oracle_price(v3, 1)) {
                        v7
                    } else {
                        0
                    };
                    if (v8 > 0) {
                        if (v3 > 0) {
                            update_reward_indices<T0>(arg0, arg1, arg3, v8);
                            *0x2::table::borrow_mut<0x1::type_name::TypeName, u256>(&mut arg0.reward_buffer.reward_amounts, arg3) = v5 - v8;
                        };
                        0x2::vec_map::get_mut<0x1::type_name::TypeName, BufferDistribution>(&mut arg0.reward_buffer.distributions, &arg3).last_updated = v0;
                    };
                    let v9 = RewardBufferUpdated{
                        vault_id      : 0x703f0059e0ac03280da3fa91518ceea1353b2bdc50e7b58f57b336be9cd94189::vault::vault_id<T0>(arg1),
                        coin_type     : arg3,
                        reward_amount : v8,
                    };
                    0x2::event::emit<RewardBufferUpdated>(v9);
                };
            };
        };
    }

    public fun update_reward_buffers<T0>(arg0: &mut RewardManager<T0>, arg1: &mut 0x703f0059e0ac03280da3fa91518ceea1353b2bdc50e7b58f57b336be9cd94189::vault::Vault<T0>, arg2: &0x2::clock::Clock) {
        check_version<T0>(arg0);
        assert!(arg0.vault_id == 0x703f0059e0ac03280da3fa91518ceea1353b2bdc50e7b58f57b336be9cd94189::vault::vault_id<T0>(arg1), 1001);
        let v0 = 0x2::vec_map::keys<0x1::type_name::TypeName, BufferDistribution>(&arg0.reward_buffer.distributions);
        let v1 = &v0;
        let v2 = 0;
        while (v2 < 0x1::vector::length<0x1::type_name::TypeName>(v1)) {
            update_reward_buffer<T0>(arg0, arg1, arg2, *0x1::vector::borrow<0x1::type_name::TypeName>(v1, v2));
            v2 = v2 + 1;
        };
    }

    public(friend) fun update_reward_indices<T0>(arg0: &mut RewardManager<T0>, arg1: &0x703f0059e0ac03280da3fa91518ceea1353b2bdc50e7b58f57b336be9cd94189::vault::Vault<T0>, arg2: 0x1::type_name::TypeName, arg3: u256) {
        check_version<T0>(arg0);
        assert!(0x2::table::contains<0x1::type_name::TypeName, u256>(&arg0.reward_amounts, arg2), 1011);
        let v0 = 0x703f0059e0ac03280da3fa91518ceea1353b2bdc50e7b58f57b336be9cd94189::vault::total_shares<T0>(arg1);
        assert!(v0 > 0, 1010);
        let v1 = 0x703f0059e0ac03280da3fa91518ceea1353b2bdc50e7b58f57b336be9cd94189::vault_utils::div_with_oracle_price(arg3, v0);
        let v2 = *0x2::vec_map::get<0x1::type_name::TypeName, u256>(&arg0.reward_indices, &arg2) + v1;
        *0x2::vec_map::get_mut<0x1::type_name::TypeName, u256>(&mut arg0.reward_indices, &arg2) = v2;
        let v3 = RewardIndicesUpdated{
            reward_manager_id : 0x2::object::uid_to_address(&arg0.id),
            vault_id          : 0x703f0059e0ac03280da3fa91518ceea1353b2bdc50e7b58f57b336be9cd94189::vault::vault_id<T0>(arg1),
            coin_type         : arg2,
            reward_amount     : arg3,
            inc_reward_index  : v1,
            new_reward_index  : v2,
        };
        0x2::event::emit<RewardIndicesUpdated>(v3);
    }

    public(friend) fun upgrade_reward_manager<T0>(arg0: &mut RewardManager<T0>) {
        assert!(arg0.version < 1, 1007);
        arg0.version = 1;
        let v0 = RewardManagerUpgraded{
            reward_manager_id : 0x2::object::uid_to_address(&arg0.id),
            version           : 1,
        };
        0x2::event::emit<RewardManagerUpgraded>(v0);
    }

    // decompiled from Move bytecode v6
}

