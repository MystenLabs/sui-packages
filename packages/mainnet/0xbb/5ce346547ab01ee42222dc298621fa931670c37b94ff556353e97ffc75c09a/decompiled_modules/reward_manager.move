module 0xbb5ce346547ab01ee42222dc298621fa931670c37b94ff556353e97ffc75c09a::reward_manager {
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
        reward_amount: u64,
    }

    struct RewardIndicesUpdated has copy, drop {
        reward_manager_id: address,
        vault_id: address,
        coin_type: 0x1::type_name::TypeName,
        reward_amount: u64,
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
        reward_amount: u64,
    }

    struct RewardBufferRateUpdated has copy, drop {
        vault_id: address,
        coin_type: 0x1::type_name::TypeName,
        rate: u64,
    }

    struct RewardAddedWithBuffer has copy, drop {
        vault_id: address,
        coin_type: 0x1::type_name::TypeName,
        reward_amount: u64,
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
        reward_amounts: 0x2::table::Table<0x1::type_name::TypeName, u64>,
        reward_indices: 0x2::vec_map::VecMap<0x1::type_name::TypeName, u256>,
        receipt_reward_indices: 0x2::table::Table<address, 0x2::table::Table<0x1::type_name::TypeName, u256>>,
        receipt_unclaimed_rewards: 0x2::table::Table<address, 0x2::table::Table<0x1::type_name::TypeName, u64>>,
        reward_buffer: RewardBuffer,
    }

    struct RewardBuffer has store {
        reward_amounts: 0x2::table::Table<0x1::type_name::TypeName, u64>,
        distributions: 0x2::vec_map::VecMap<0x1::type_name::TypeName, BufferDistribution>,
    }

    struct BufferDistribution has copy, drop, store {
        rate: u64,
        last_updated: u64,
    }

    public fun vault_id<T0>(arg0: &RewardManager<T0>) : address {
        arg0.vault_id
    }

    public fun add_new_reward_type<T0, T1>(arg0: &mut RewardManager<T0>, arg1: &0xbb5ce346547ab01ee42222dc298621fa931670c37b94ff556353e97ffc75c09a::vault::Operation, arg2: &0xbb5ce346547ab01ee42222dc298621fa931670c37b94ff556353e97ffc75c09a::vault::OperatorCap, arg3: &0x2::clock::Clock, arg4: bool) {
        check_version<T0>(arg0);
        0xbb5ce346547ab01ee42222dc298621fa931670c37b94ff556353e97ffc75c09a::vault::assert_operator_not_freezed(arg1, arg2);
        let v0 = 0x1::type_name::get<T1>();
        0x2::bag::add<0x1::type_name::TypeName, 0x2::balance::Balance<T1>>(&mut arg0.reward_balances, v0, 0x2::balance::zero<T1>());
        0x2::table::add<0x1::type_name::TypeName, u64>(&mut arg0.reward_amounts, v0, 0);
        0x2::vec_map::insert<0x1::type_name::TypeName, u256>(&mut arg0.reward_indices, v0, 0);
        if (arg4) {
            let v1 = &mut arg0.reward_buffer;
            0x2::table::add<0x1::type_name::TypeName, u64>(&mut v1.reward_amounts, v0, 0);
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

    public fun add_reward_balance<T0, T1>(arg0: &mut RewardManager<T0>, arg1: &mut 0xbb5ce346547ab01ee42222dc298621fa931670c37b94ff556353e97ffc75c09a::vault::Vault<T0>, arg2: &0xbb5ce346547ab01ee42222dc298621fa931670c37b94ff556353e97ffc75c09a::vault::Operation, arg3: &0xbb5ce346547ab01ee42222dc298621fa931670c37b94ff556353e97ffc75c09a::vault::OperatorCap, arg4: 0x2::balance::Balance<T1>) {
        check_version<T0>(arg0);
        assert!(arg0.vault_id == 0xbb5ce346547ab01ee42222dc298621fa931670c37b94ff556353e97ffc75c09a::vault::vault_id<T0>(arg1), 1001);
        0xbb5ce346547ab01ee42222dc298621fa931670c37b94ff556353e97ffc75c09a::vault::assert_operator_not_freezed(arg2, arg3);
        let v0 = 0x1::type_name::get<T1>();
        let v1 = 0x2::balance::value<T1>(&arg4);
        0x2::balance::join<T1>(0x2::bag::borrow_mut<0x1::type_name::TypeName, 0x2::balance::Balance<T1>>(&mut arg0.reward_balances, v0), arg4);
        let v2 = 0x2::table::borrow_mut<0x1::type_name::TypeName, u64>(&mut arg0.reward_amounts, v0);
        *v2 = *v2 + v1;
        update_reward_indices<T0>(arg0, arg1, v0, v1);
        let v3 = RewardBalanceAdded{
            reward_manager_id : 0x2::object::uid_to_address(&arg0.id),
            vault_id          : 0xbb5ce346547ab01ee42222dc298621fa931670c37b94ff556353e97ffc75c09a::vault::vault_id<T0>(arg1),
            coin_type         : v0,
            reward_amount     : v1,
        };
        0x2::event::emit<RewardBalanceAdded>(v3);
    }

    public fun add_reward_to_buffer<T0, T1>(arg0: &mut RewardManager<T0>, arg1: &mut 0xbb5ce346547ab01ee42222dc298621fa931670c37b94ff556353e97ffc75c09a::vault::Vault<T0>, arg2: &0xbb5ce346547ab01ee42222dc298621fa931670c37b94ff556353e97ffc75c09a::vault::Operation, arg3: &0xbb5ce346547ab01ee42222dc298621fa931670c37b94ff556353e97ffc75c09a::vault::OperatorCap, arg4: &0x2::clock::Clock, arg5: 0x2::balance::Balance<T1>) {
        check_version<T0>(arg0);
        assert!(arg0.vault_id == 0xbb5ce346547ab01ee42222dc298621fa931670c37b94ff556353e97ffc75c09a::vault::vault_id<T0>(arg1), 1001);
        0xbb5ce346547ab01ee42222dc298621fa931670c37b94ff556353e97ffc75c09a::vault::assert_operator_not_freezed(arg2, arg3);
        let v0 = 0x1::type_name::get<T1>();
        let v1 = 0x2::balance::value<T1>(&arg5);
        update_reward_buffer<T0>(arg0, arg1, arg4, v0);
        *0x2::table::borrow_mut<0x1::type_name::TypeName, u64>(&mut arg0.reward_buffer.reward_amounts, v0) = *0x2::table::borrow<0x1::type_name::TypeName, u64>(&arg0.reward_buffer.reward_amounts, v0) + v1;
        0x2::balance::join<T1>(0x2::bag::borrow_mut<0x1::type_name::TypeName, 0x2::balance::Balance<T1>>(&mut arg0.reward_balances, v0), arg5);
        let v2 = RewardAddedWithBuffer{
            vault_id      : 0xbb5ce346547ab01ee42222dc298621fa931670c37b94ff556353e97ffc75c09a::vault::vault_id<T0>(arg1),
            coin_type     : v0,
            reward_amount : v1,
        };
        0x2::event::emit<RewardAddedWithBuffer>(v2);
    }

    public(friend) fun check_version<T0>(arg0: &RewardManager<T0>) {
        assert!(arg0.version == 1, 1009);
    }

    public fun claim_reward<T0, T1>(arg0: &mut RewardManager<T0>, arg1: &mut 0xbb5ce346547ab01ee42222dc298621fa931670c37b94ff556353e97ffc75c09a::vault::Vault<T0>, arg2: &0x2::clock::Clock, arg3: &mut 0xbb5ce346547ab01ee42222dc298621fa931670c37b94ff556353e97ffc75c09a::receipt::Receipt) : 0x2::balance::Balance<T1> {
        check_version<T0>(arg0);
        0xbb5ce346547ab01ee42222dc298621fa931670c37b94ff556353e97ffc75c09a::vault::assert_enabled<T0>(arg1);
        0xbb5ce346547ab01ee42222dc298621fa931670c37b94ff556353e97ffc75c09a::vault::assert_vault_receipt_matched<T0>(arg1, arg3);
        assert!(arg0.vault_id == 0xbb5ce346547ab01ee42222dc298621fa931670c37b94ff556353e97ffc75c09a::vault::vault_id<T0>(arg1), 1001);
        let v0 = 0xbb5ce346547ab01ee42222dc298621fa931670c37b94ff556353e97ffc75c09a::receipt::receipt_id(arg3);
        assert!(0xbb5ce346547ab01ee42222dc298621fa931670c37b94ff556353e97ffc75c09a::vault_receipt_info::status(0xbb5ce346547ab01ee42222dc298621fa931670c37b94ff556353e97ffc75c09a::vault::vault_receipt_info<T0>(arg1, v0)) == 0, 1008);
        update_reward_buffers<T0>(arg0, arg1, arg2);
        update_receipt_reward<T0>(arg0, arg1, v0);
        let v1 = 0x1::type_name::get<T1>();
        let v2 = 0xbb5ce346547ab01ee42222dc298621fa931670c37b94ff556353e97ffc75c09a::vault_receipt_info::reset_unclaimed_rewards<T1>(0xbb5ce346547ab01ee42222dc298621fa931670c37b94ff556353e97ffc75c09a::vault::vault_receipt_info_mut<T0>(arg1, v0));
        let v3 = 0x2::bag::borrow_mut<0x1::type_name::TypeName, 0x2::balance::Balance<T1>>(&mut arg0.reward_balances, v1);
        assert!(v2 <= 0x2::balance::value<T1>(v3), 1002);
        let v4 = RewardClaimed{
            reward_manager_id : 0x2::object::uid_to_address(&arg0.id),
            vault_id          : 0xbb5ce346547ab01ee42222dc298621fa931670c37b94ff556353e97ffc75c09a::receipt::vault_id(arg3),
            receipt_id        : 0xbb5ce346547ab01ee42222dc298621fa931670c37b94ff556353e97ffc75c09a::receipt::receipt_id(arg3),
            coin_type         : v1,
            reward_amount     : v2,
        };
        0x2::event::emit<RewardClaimed>(v4);
        0x2::balance::split<T1>(v3, v2)
    }

    public fun create_reward_buffer_distribution<T0, T1>(arg0: &mut RewardManager<T0>, arg1: &0xbb5ce346547ab01ee42222dc298621fa931670c37b94ff556353e97ffc75c09a::vault::Operation, arg2: &0xbb5ce346547ab01ee42222dc298621fa931670c37b94ff556353e97ffc75c09a::vault::OperatorCap, arg3: &0x2::clock::Clock) {
        check_version<T0>(arg0);
        0xbb5ce346547ab01ee42222dc298621fa931670c37b94ff556353e97ffc75c09a::vault::assert_operator_not_freezed(arg1, arg2);
        let v0 = &mut arg0.reward_buffer;
        let v1 = 0x1::type_name::get<T1>();
        assert!(!0x2::table::contains<0x1::type_name::TypeName, u64>(&v0.reward_amounts, v1), 1003);
        assert!(!0x2::vec_map::contains<0x1::type_name::TypeName, BufferDistribution>(&v0.distributions, &v1), 1004);
        0x2::table::add<0x1::type_name::TypeName, u64>(&mut v0.reward_amounts, v1, 0);
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

    public(friend) fun create_reward_manager<T0>(arg0: &mut 0xbb5ce346547ab01ee42222dc298621fa931670c37b94ff556353e97ffc75c09a::vault::Vault<T0>, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = 0xbb5ce346547ab01ee42222dc298621fa931670c37b94ff556353e97ffc75c09a::vault::vault_id<T0>(arg0);
        let v1 = RewardBuffer{
            reward_amounts : 0x2::table::new<0x1::type_name::TypeName, u64>(arg1),
            distributions  : 0x2::vec_map::empty<0x1::type_name::TypeName, BufferDistribution>(),
        };
        let v2 = RewardManager<T0>{
            id                        : 0x2::object::new(arg1),
            version                   : 1,
            vault_id                  : v0,
            reward_balances           : 0x2::bag::new(arg1),
            reward_amounts            : 0x2::table::new<0x1::type_name::TypeName, u64>(arg1),
            reward_indices            : 0x2::vec_map::empty<0x1::type_name::TypeName, u256>(),
            receipt_reward_indices    : 0x2::table::new<address, 0x2::table::Table<0x1::type_name::TypeName, u256>>(arg1),
            receipt_unclaimed_rewards : 0x2::table::new<address, 0x2::table::Table<0x1::type_name::TypeName, u64>>(arg1),
            reward_buffer             : v1,
        };
        0xbb5ce346547ab01ee42222dc298621fa931670c37b94ff556353e97ffc75c09a::vault::set_reward_manager<T0>(arg0, 0x2::object::uid_to_address(&v2.id));
        let v3 = RewardManagerCreated{
            reward_manager_id : 0x2::object::uid_to_address(&v2.id),
            vault_id          : v0,
        };
        0x2::event::emit<RewardManagerCreated>(v3);
        0x2::transfer::share_object<RewardManager<T0>>(v2);
    }

    public(friend) fun issue_receipt<T0>(arg0: &RewardManager<T0>, arg1: &mut 0x2::tx_context::TxContext) : 0xbb5ce346547ab01ee42222dc298621fa931670c37b94ff556353e97ffc75c09a::receipt::Receipt {
        check_version<T0>(arg0);
        0xbb5ce346547ab01ee42222dc298621fa931670c37b94ff556353e97ffc75c09a::receipt::create_receipt(arg0.vault_id, arg1)
    }

    public(friend) fun issue_vault_receipt_info<T0>(arg0: &RewardManager<T0>, arg1: &mut 0x2::tx_context::TxContext) : 0xbb5ce346547ab01ee42222dc298621fa931670c37b94ff556353e97ffc75c09a::vault_receipt_info::VaultReceiptInfo {
        check_version<T0>(arg0);
        let v0 = reward_indices<T0>(arg0);
        0xbb5ce346547ab01ee42222dc298621fa931670c37b94ff556353e97ffc75c09a::vault_receipt_info::new_vault_receipt_info(0xbb5ce346547ab01ee42222dc298621fa931670c37b94ff556353e97ffc75c09a::vault_utils::clone_vecmap_table<0x1::type_name::TypeName, u256>(&v0, arg1), 0x2::table::new<0x1::type_name::TypeName, u64>(arg1))
    }

    public fun remove_reward_buffer_distribution<T0>(arg0: &mut RewardManager<T0>, arg1: &mut 0xbb5ce346547ab01ee42222dc298621fa931670c37b94ff556353e97ffc75c09a::vault::Vault<T0>, arg2: &0xbb5ce346547ab01ee42222dc298621fa931670c37b94ff556353e97ffc75c09a::vault::Operation, arg3: &0xbb5ce346547ab01ee42222dc298621fa931670c37b94ff556353e97ffc75c09a::vault::OperatorCap, arg4: &0x2::clock::Clock, arg5: 0x1::type_name::TypeName) {
        check_version<T0>(arg0);
        assert!(arg0.vault_id == 0xbb5ce346547ab01ee42222dc298621fa931670c37b94ff556353e97ffc75c09a::vault::vault_id<T0>(arg1), 1001);
        0xbb5ce346547ab01ee42222dc298621fa931670c37b94ff556353e97ffc75c09a::vault::assert_operator_not_freezed(arg2, arg3);
        update_reward_buffer<T0>(arg0, arg1, arg4, arg5);
        assert!(*0x2::table::borrow<0x1::type_name::TypeName, u64>(&arg0.reward_buffer.reward_amounts, arg5) == 0, 1007);
        0x2::table::remove<0x1::type_name::TypeName, u64>(&mut arg0.reward_buffer.reward_amounts, arg5);
        let (_, _) = 0x2::vec_map::remove<0x1::type_name::TypeName, BufferDistribution>(&mut arg0.reward_buffer.distributions, &arg5);
        let v2 = RewardBufferDistributionRemoved{
            reward_manager_id : 0x2::object::uid_to_address(&arg0.id),
            vault_id          : 0xbb5ce346547ab01ee42222dc298621fa931670c37b94ff556353e97ffc75c09a::vault::vault_id<T0>(arg1),
            coin_type         : arg5,
        };
        0x2::event::emit<RewardBufferDistributionRemoved>(v2);
    }

    public fun retrieve_undistributed_reward<T0, T1>(arg0: &mut RewardManager<T0>, arg1: &mut 0xbb5ce346547ab01ee42222dc298621fa931670c37b94ff556353e97ffc75c09a::vault::Vault<T0>, arg2: &0xbb5ce346547ab01ee42222dc298621fa931670c37b94ff556353e97ffc75c09a::vault::Operation, arg3: &0xbb5ce346547ab01ee42222dc298621fa931670c37b94ff556353e97ffc75c09a::vault::OperatorCap, arg4: u64, arg5: &0x2::clock::Clock) : 0x2::balance::Balance<T1> {
        check_version<T0>(arg0);
        assert!(arg0.vault_id == 0xbb5ce346547ab01ee42222dc298621fa931670c37b94ff556353e97ffc75c09a::vault::vault_id<T0>(arg1), 1001);
        0xbb5ce346547ab01ee42222dc298621fa931670c37b94ff556353e97ffc75c09a::vault::assert_operator_not_freezed(arg2, arg3);
        let v0 = 0x1::type_name::get<T1>();
        update_reward_buffer<T0>(arg0, arg1, arg5, v0);
        let v1 = *0x2::table::borrow<0x1::type_name::TypeName, u64>(&arg0.reward_buffer.reward_amounts, v0);
        assert!(v1 >= arg4, 1010);
        *0x2::table::borrow_mut<0x1::type_name::TypeName, u64>(&mut arg0.reward_buffer.reward_amounts, v0) = v1 - arg4;
        let v2 = UndistributedRewardRetrieved{
            reward_manager_id : 0x2::object::uid_to_address(&arg0.id),
            vault_id          : 0xbb5ce346547ab01ee42222dc298621fa931670c37b94ff556353e97ffc75c09a::vault::vault_id<T0>(arg1),
            reward_type       : v0,
            amount            : arg4,
        };
        0x2::event::emit<UndistributedRewardRetrieved>(v2);
        0x2::balance::split<T1>(0x2::bag::borrow_mut<0x1::type_name::TypeName, 0x2::balance::Balance<T1>>(&mut arg0.reward_balances, v0), arg4)
    }

    public fun reward_amount<T0, T1>(arg0: &RewardManager<T0>) : u64 {
        *0x2::table::borrow<0x1::type_name::TypeName, u64>(&arg0.reward_amounts, 0x1::type_name::get<T1>())
    }

    public fun reward_balance<T0, T1>(arg0: &RewardManager<T0>) : &0x2::balance::Balance<T1> {
        0x2::bag::borrow<0x1::type_name::TypeName, 0x2::balance::Balance<T1>>(&arg0.reward_balances, 0x1::type_name::get<T1>())
    }

    public fun reward_buffer_amount<T0, T1>(arg0: &RewardManager<T0>) : u64 {
        *0x2::table::borrow<0x1::type_name::TypeName, u64>(&arg0.reward_buffer.reward_amounts, 0x1::type_name::get<T1>())
    }

    public fun reward_buffer_distribution<T0, T1>(arg0: &RewardManager<T0>) : BufferDistribution {
        let v0 = 0x1::type_name::get<T1>();
        *0x2::vec_map::get<0x1::type_name::TypeName, BufferDistribution>(&arg0.reward_buffer.distributions, &v0)
    }

    public fun reward_buffer_distribution_last_updated<T0, T1>(arg0: &RewardManager<T0>) : u64 {
        let v0 = 0x1::type_name::get<T1>();
        0x2::vec_map::get<0x1::type_name::TypeName, BufferDistribution>(&arg0.reward_buffer.distributions, &v0).last_updated
    }

    public fun reward_buffer_distribution_rate<T0, T1>(arg0: &RewardManager<T0>) : u64 {
        let v0 = 0x1::type_name::get<T1>();
        0x2::vec_map::get<0x1::type_name::TypeName, BufferDistribution>(&arg0.reward_buffer.distributions, &v0).rate
    }

    public fun reward_indices<T0>(arg0: &RewardManager<T0>) : 0x2::vec_map::VecMap<0x1::type_name::TypeName, u256> {
        arg0.reward_indices
    }

    public fun set_reward_rate<T0, T1>(arg0: &mut RewardManager<T0>, arg1: &mut 0xbb5ce346547ab01ee42222dc298621fa931670c37b94ff556353e97ffc75c09a::vault::Vault<T0>, arg2: &0xbb5ce346547ab01ee42222dc298621fa931670c37b94ff556353e97ffc75c09a::vault::Operation, arg3: &0xbb5ce346547ab01ee42222dc298621fa931670c37b94ff556353e97ffc75c09a::vault::OperatorCap, arg4: &0x2::clock::Clock, arg5: u64) {
        check_version<T0>(arg0);
        assert!(arg0.vault_id == 0xbb5ce346547ab01ee42222dc298621fa931670c37b94ff556353e97ffc75c09a::vault::vault_id<T0>(arg1), 1001);
        0xbb5ce346547ab01ee42222dc298621fa931670c37b94ff556353e97ffc75c09a::vault::assert_operator_not_freezed(arg2, arg3);
        let v0 = 0x1::type_name::get<T1>();
        update_reward_buffer<T0>(arg0, arg1, arg4, v0);
        0x2::vec_map::get_mut<0x1::type_name::TypeName, BufferDistribution>(&mut arg0.reward_buffer.distributions, &v0).rate = arg5;
        let v1 = RewardBufferRateUpdated{
            vault_id  : 0xbb5ce346547ab01ee42222dc298621fa931670c37b94ff556353e97ffc75c09a::vault::vault_id<T0>(arg1),
            coin_type : v0,
            rate      : arg5,
        };
        0x2::event::emit<RewardBufferRateUpdated>(v1);
    }

    public(friend) fun update_receipt_reward<T0>(arg0: &RewardManager<T0>, arg1: &mut 0xbb5ce346547ab01ee42222dc298621fa931670c37b94ff556353e97ffc75c09a::vault::Vault<T0>, arg2: address) {
        check_version<T0>(arg0);
        let v0 = 0xbb5ce346547ab01ee42222dc298621fa931670c37b94ff556353e97ffc75c09a::vault::vault_receipt_info_mut<T0>(arg1, arg2);
        let v1 = 0x2::vec_map::keys<0x1::type_name::TypeName, u256>(&arg0.reward_indices);
        let v2 = &v1;
        let v3 = 0;
        while (v3 < 0x1::vector::length<0x1::type_name::TypeName>(v2)) {
            let v4 = 0x1::vector::borrow<0x1::type_name::TypeName>(v2, v3);
            0xbb5ce346547ab01ee42222dc298621fa931670c37b94ff556353e97ffc75c09a::vault_receipt_info::update_reward(v0, *v4, *0x2::vec_map::get<0x1::type_name::TypeName, u256>(&arg0.reward_indices, v4));
            v3 = v3 + 1;
        };
    }

    public fun update_reward_buffer<T0>(arg0: &mut RewardManager<T0>, arg1: &mut 0xbb5ce346547ab01ee42222dc298621fa931670c37b94ff556353e97ffc75c09a::vault::Vault<T0>, arg2: &0x2::clock::Clock, arg3: 0x1::type_name::TypeName) {
        check_version<T0>(arg0);
        assert!(arg0.vault_id == 0xbb5ce346547ab01ee42222dc298621fa931670c37b94ff556353e97ffc75c09a::vault::vault_id<T0>(arg1), 1001);
        let v0 = 0x2::clock::timestamp_ms(arg2);
        assert!(0x2::table::contains<0x1::type_name::TypeName, u64>(&arg0.reward_buffer.reward_amounts, arg3), 1005);
        assert!(0x2::vec_map::contains<0x1::type_name::TypeName, BufferDistribution>(&arg0.reward_buffer.distributions, &arg3), 1006);
        let v1 = 0x2::vec_map::get<0x1::type_name::TypeName, BufferDistribution>(&arg0.reward_buffer.distributions, &arg3);
        let v2 = v1.rate * (v0 - v1.last_updated);
        let v3 = *0x2::table::borrow<0x1::type_name::TypeName, u64>(&arg0.reward_buffer.reward_amounts, arg3);
        if (v3 > 0) {
            let v4 = 0x1::u64::min(v3, v2);
            update_reward_indices<T0>(arg0, arg1, arg3, v4);
            *0x2::table::borrow_mut<0x1::type_name::TypeName, u64>(&mut arg0.reward_buffer.reward_amounts, arg3) = v3 - v4;
        };
        0x2::vec_map::get_mut<0x1::type_name::TypeName, BufferDistribution>(&mut arg0.reward_buffer.distributions, &arg3).last_updated = v0;
        let v5 = RewardBufferUpdated{
            vault_id      : 0xbb5ce346547ab01ee42222dc298621fa931670c37b94ff556353e97ffc75c09a::vault::vault_id<T0>(arg1),
            coin_type     : arg3,
            reward_amount : v2,
        };
        0x2::event::emit<RewardBufferUpdated>(v5);
    }

    public fun update_reward_buffers<T0>(arg0: &mut RewardManager<T0>, arg1: &mut 0xbb5ce346547ab01ee42222dc298621fa931670c37b94ff556353e97ffc75c09a::vault::Vault<T0>, arg2: &0x2::clock::Clock) {
        check_version<T0>(arg0);
        assert!(arg0.vault_id == 0xbb5ce346547ab01ee42222dc298621fa931670c37b94ff556353e97ffc75c09a::vault::vault_id<T0>(arg1), 1001);
        let v0 = 0x2::vec_map::keys<0x1::type_name::TypeName, BufferDistribution>(&arg0.reward_buffer.distributions);
        let v1 = &v0;
        let v2 = 0;
        while (v2 < 0x1::vector::length<0x1::type_name::TypeName>(v1)) {
            update_reward_buffer<T0>(arg0, arg1, arg2, *0x1::vector::borrow<0x1::type_name::TypeName>(v1, v2));
            v2 = v2 + 1;
        };
    }

    public(friend) fun update_reward_indices<T0>(arg0: &mut RewardManager<T0>, arg1: &0xbb5ce346547ab01ee42222dc298621fa931670c37b94ff556353e97ffc75c09a::vault::Vault<T0>, arg2: 0x1::type_name::TypeName, arg3: u64) {
        check_version<T0>(arg0);
        assert!(arg0.vault_id == 0xbb5ce346547ab01ee42222dc298621fa931670c37b94ff556353e97ffc75c09a::vault::vault_id<T0>(arg1), 1001);
        assert!(0x2::table::contains<0x1::type_name::TypeName, u64>(&arg0.reward_amounts, arg2), 13906835742006444031);
        assert!(0x2::vec_map::contains<0x1::type_name::TypeName, u256>(&arg0.reward_indices, &arg2), 13906835746301411327);
        let v0 = 0xbb5ce346547ab01ee42222dc298621fa931670c37b94ff556353e97ffc75c09a::vault_utils::div_d((arg3 as u256), 0xbb5ce346547ab01ee42222dc298621fa931670c37b94ff556353e97ffc75c09a::vault::total_shares<T0>(arg1));
        let v1 = *0x2::vec_map::get<0x1::type_name::TypeName, u256>(&arg0.reward_indices, &arg2) + v0;
        *0x2::vec_map::get_mut<0x1::type_name::TypeName, u256>(&mut arg0.reward_indices, &arg2) = v1;
        let v2 = RewardIndicesUpdated{
            reward_manager_id : 0x2::object::uid_to_address(&arg0.id),
            vault_id          : 0xbb5ce346547ab01ee42222dc298621fa931670c37b94ff556353e97ffc75c09a::vault::vault_id<T0>(arg1),
            coin_type         : arg2,
            reward_amount     : arg3,
            inc_reward_index  : v0,
            new_reward_index  : v1,
        };
        0x2::event::emit<RewardIndicesUpdated>(v2);
    }

    public(friend) fun upgrade_reward_manager<T0>(arg0: &mut RewardManager<T0>) {
        assert!(arg0.version < 1, 1009);
        arg0.version = 1;
        let v0 = RewardManagerUpgraded{
            reward_manager_id : 0x2::object::uid_to_address(&arg0.id),
            version           : 1,
        };
        0x2::event::emit<RewardManagerUpgraded>(v0);
    }

    // decompiled from Move bytecode v6
}

