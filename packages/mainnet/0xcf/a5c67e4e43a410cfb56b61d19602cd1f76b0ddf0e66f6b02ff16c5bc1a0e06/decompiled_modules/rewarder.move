module 0xc86566ecf61a57d6ec53971798a611dc09482b453ac532f6c4a338c247255235::rewarder {
    struct VaultsRewarderInfo has store {
        allocate_point: u64,
        acc_per_share: u128,
        last_reward_time: u64,
    }

    struct Rewarder has store {
        reward_coin: 0x1::type_name::TypeName,
        total_allocate_point: u64,
        emission_per_second: u64,
        last_reward_time: u64,
        total_reward_released: u128,
        total_reward_harvested: u64,
        vaults: 0x2::linked_table::LinkedTable<0x2::object::ID, VaultsRewarderInfo>,
    }

    struct RewarderManager has store, key {
        id: 0x2::object::UID,
        vault: 0x2::bag::Bag,
        vault_shares: 0x2::linked_table::LinkedTable<0x2::object::ID, u128>,
        rewarders: 0x2::linked_table::LinkedTable<0x1::type_name::TypeName, Rewarder>,
    }

    struct InitRewarderManagerEvent has copy, drop {
        id: 0x2::object::ID,
    }

    struct CreateRewarderEvent has copy, drop {
        reward_coin: 0x1::type_name::TypeName,
        emission_per_second: u64,
    }

    struct UpdateRewarderEmissionEvent has copy, drop {
        reward_coin: 0x1::type_name::TypeName,
        emission_per_second: u64,
    }

    struct DepositEvent has copy, drop {
        reward_type: 0x1::type_name::TypeName,
        deposit_amount: u64,
        after_amount: u64,
    }

    struct WithdrawRewardEvent has copy, drop {
        reward_type: 0x1::type_name::TypeName,
        vault_id: 0x2::object::ID,
        amount: u64,
    }

    struct RegisterVaultEvent has copy, drop {
        vault_id: 0x2::object::ID,
    }

    struct AddVaultToRewarderEvent has copy, drop {
        reward_type: 0x1::type_name::TypeName,
        vault_id: 0x2::object::ID,
        allocate_points: u64,
    }

    public(friend) fun accumulate_rewarder_released(arg0: &mut Rewarder, arg1: u64) {
        if (arg0.last_reward_time < arg1) {
            if (arg0.emission_per_second > 0) {
                arg0.total_reward_released = arg0.total_reward_released + (arg0.emission_per_second as u128) * ((arg1 - arg0.last_reward_time) as u128);
            };
            arg0.last_reward_time = arg1;
        };
    }

    public(friend) fun accumulate_vault_reward(arg0: &mut Rewarder, arg1: 0x2::object::ID, arg2: u128, arg3: u64) : u128 {
        let v0 = 0x2::linked_table::borrow_mut<0x2::object::ID, VaultsRewarderInfo>(&mut arg0.vaults, arg1);
        if (arg3 > v0.last_reward_time && arg0.emission_per_second > 0) {
            if (arg0.total_allocate_point > 0) {
                if (arg2 > 0) {
                    v0.acc_per_share = v0.acc_per_share + 0x714a63a0dba6da4f017b42d5d0fb78867f18bcde904868e51d951a5a6f5b7f57::full_math_u128::mul_div_floor(0x714a63a0dba6da4f017b42d5d0fb78867f18bcde904868e51d951a5a6f5b7f57::full_math_u128::mul_div_floor((arg0.emission_per_second as u128) * ((arg3 - v0.last_reward_time) as u128), (v0.allocate_point as u128), (arg0.total_allocate_point as u128)), 0xc86566ecf61a57d6ec53971798a611dc09482b453ac532f6c4a338c247255235::constants::reward_scale_factor(), arg2);
                };
            };
        };
        v0.last_reward_time = arg3;
        v0.acc_per_share
    }

    public(friend) fun accumulate_vaults_reward<T0>(arg0: &mut RewarderManager, arg1: u64) {
        let v0 = 0x2::linked_table::borrow_mut<0x1::type_name::TypeName, Rewarder>(&mut arg0.rewarders, 0x1::type_name::get<T0>());
        let v1 = 0x2::linked_table::front<0x2::object::ID, VaultsRewarderInfo>(&v0.vaults);
        while (0x1::option::is_some<0x2::object::ID>(v1)) {
            let v2 = *0x1::option::borrow<0x2::object::ID>(v1);
            accumulate_vault_reward(v0, v2, *0x2::linked_table::borrow<0x2::object::ID, u128>(&arg0.vault_shares, v2), arg1);
            v1 = 0x2::linked_table::next<0x2::object::ID, VaultsRewarderInfo>(&v0.vaults, v2);
        };
        v0.last_reward_time = arg1;
    }

    public(friend) fun add_vault<T0>(arg0: &mut RewarderManager, arg1: 0x2::object::ID, arg2: u64, arg3: &0x2::clock::Clock) {
        assert!(is_vault_registered(arg0, arg1), 0xc86566ecf61a57d6ec53971798a611dc09482b453ac532f6c4a338c247255235::error::vault_not_registered());
        let v0 = 0x1::type_name::get<T0>();
        assert!(!is_vault_in_rewarder(arg0, v0, arg1), 0xc86566ecf61a57d6ec53971798a611dc09482b453ac532f6c4a338c247255235::error::vault_already_registered());
        assert!(arg2 > 0, 0xc86566ecf61a57d6ec53971798a611dc09482b453ac532f6c4a338c247255235::error::invalid_amount());
        let v1 = ms_to_seconds(0x2::clock::timestamp_ms(arg3));
        accumulate_vaults_reward<T0>(arg0, v1);
        let v2 = 0x2::linked_table::borrow_mut<0x1::type_name::TypeName, Rewarder>(&mut arg0.rewarders, v0);
        accumulate_rewarder_released(v2, v1);
        let v3 = VaultsRewarderInfo{
            allocate_point   : arg2,
            acc_per_share    : 0,
            last_reward_time : v1,
        };
        0x2::linked_table::push_back<0x2::object::ID, VaultsRewarderInfo>(&mut v2.vaults, arg1, v3);
        v2.total_allocate_point = v2.total_allocate_point + arg2;
        let v4 = AddVaultToRewarderEvent{
            reward_type     : v0,
            vault_id        : arg1,
            allocate_points : arg2,
        };
        0x2::event::emit<AddVaultToRewarderEvent>(v4);
    }

    public fun create_rewarder<T0>(arg0: &0xc86566ecf61a57d6ec53971798a611dc09482b453ac532f6c4a338c247255235::vaults_manager::VaultsManager, arg1: &mut RewarderManager, arg2: u64, arg3: &0x2::clock::Clock, arg4: &mut 0x2::tx_context::TxContext) {
        0xc86566ecf61a57d6ec53971798a611dc09482b453ac532f6c4a338c247255235::vaults_manager::checked_package_version(arg0);
        0xc86566ecf61a57d6ec53971798a611dc09482b453ac532f6c4a338c247255235::vaults_manager::check_rewarder_manager_role(arg0, 0x2::tx_context::sender(arg4));
        let v0 = 0x1::type_name::get<T0>();
        assert!(!0x2::linked_table::contains<0x1::type_name::TypeName, Rewarder>(&arg1.rewarders, v0), 0xc86566ecf61a57d6ec53971798a611dc09482b453ac532f6c4a338c247255235::error::invalid_reward_type());
        assert!(arg2 > 0, 0xc86566ecf61a57d6ec53971798a611dc09482b453ac532f6c4a338c247255235::error::invalid_amount());
        let v1 = Rewarder{
            reward_coin            : v0,
            total_allocate_point   : 0,
            emission_per_second    : arg2,
            last_reward_time       : ms_to_seconds(0x2::clock::timestamp_ms(arg3)),
            total_reward_released  : 0,
            total_reward_harvested : 0,
            vaults                 : 0x2::linked_table::new<0x2::object::ID, VaultsRewarderInfo>(arg4),
        };
        0x2::linked_table::push_back<0x1::type_name::TypeName, Rewarder>(&mut arg1.rewarders, v0, v1);
        let v2 = CreateRewarderEvent{
            reward_coin         : v0,
            emission_per_second : arg2,
        };
        0x2::event::emit<CreateRewarderEvent>(v2);
    }

    public fun deposit_reward<T0>(arg0: &0xc86566ecf61a57d6ec53971798a611dc09482b453ac532f6c4a338c247255235::vaults_manager::VaultsManager, arg1: &mut RewarderManager, arg2: 0x2::coin::Coin<T0>, arg3: &mut 0x2::tx_context::TxContext) {
        0xc86566ecf61a57d6ec53971798a611dc09482b453ac532f6c4a338c247255235::vaults_manager::checked_package_version(arg0);
        assert!(0x2::coin::value<T0>(&arg2) > 0, 0xc86566ecf61a57d6ec53971798a611dc09482b453ac532f6c4a338c247255235::error::invalid_amount());
        let v0 = 0x1::type_name::get<T0>();
        if (!0x2::bag::contains<0x1::type_name::TypeName>(&arg1.vault, v0)) {
            0x2::bag::add<0x1::type_name::TypeName, 0x2::balance::Balance<T0>>(&mut arg1.vault, v0, 0x2::balance::zero<T0>());
        };
        let v1 = DepositEvent{
            reward_type    : v0,
            deposit_amount : 0x2::coin::value<T0>(&arg2),
            after_amount   : 0x2::balance::join<T0>(0x2::bag::borrow_mut<0x1::type_name::TypeName, 0x2::balance::Balance<T0>>(&mut arg1.vault, v0), 0x2::coin::into_balance<T0>(arg2)),
        };
        0x2::event::emit<DepositEvent>(v1);
    }

    fun init(arg0: &mut 0x2::tx_context::TxContext) {
        let v0 = RewarderManager{
            id           : 0x2::object::new(arg0),
            vault        : 0x2::bag::new(arg0),
            vault_shares : 0x2::linked_table::new<0x2::object::ID, u128>(arg0),
            rewarders    : 0x2::linked_table::new<0x1::type_name::TypeName, Rewarder>(arg0),
        };
        0x2::transfer::share_object<RewarderManager>(v0);
        let v1 = InitRewarderManagerEvent{id: 0x2::object::id<RewarderManager>(&v0)};
        0x2::event::emit<InitRewarderManagerEvent>(v1);
    }

    fun is_vault_in_rewarder(arg0: &RewarderManager, arg1: 0x1::type_name::TypeName, arg2: 0x2::object::ID) : bool {
        0x2::linked_table::contains<0x2::object::ID, VaultsRewarderInfo>(&0x2::linked_table::borrow<0x1::type_name::TypeName, Rewarder>(&arg0.rewarders, arg1).vaults, arg2)
    }

    public fun is_vault_registered(arg0: &RewarderManager, arg1: 0x2::object::ID) : bool {
        0x2::linked_table::contains<0x2::object::ID, u128>(&arg0.vault_shares, arg1)
    }

    fun ms_to_seconds(arg0: u64) : u64 {
        arg0 / 1000
    }

    public(friend) fun register_vault(arg0: &mut RewarderManager, arg1: 0x2::object::ID) {
        assert!(!is_vault_registered(arg0, arg1), 0xc86566ecf61a57d6ec53971798a611dc09482b453ac532f6c4a338c247255235::error::vault_already_registered());
        0x2::linked_table::push_back<0x2::object::ID, u128>(&mut arg0.vault_shares, arg1, 0);
        let v0 = RegisterVaultEvent{vault_id: arg1};
        0x2::event::emit<RegisterVaultEvent>(v0);
    }

    public(friend) fun set_vault_share(arg0: &mut RewarderManager, arg1: 0x2::object::ID, arg2: u128) {
        *0x2::linked_table::borrow_mut<0x2::object::ID, u128>(&mut arg0.vault_shares, arg1) = arg2;
    }

    public fun update_rewarder_emission<T0>(arg0: &0xc86566ecf61a57d6ec53971798a611dc09482b453ac532f6c4a338c247255235::vaults_manager::VaultsManager, arg1: &mut RewarderManager, arg2: u64, arg3: &0x2::clock::Clock, arg4: &0x2::tx_context::TxContext) {
        0xc86566ecf61a57d6ec53971798a611dc09482b453ac532f6c4a338c247255235::vaults_manager::checked_package_version(arg0);
        0xc86566ecf61a57d6ec53971798a611dc09482b453ac532f6c4a338c247255235::vaults_manager::check_rewarder_manager_role(arg0, 0x2::tx_context::sender(arg4));
        let v0 = 0x1::type_name::get<T0>();
        assert!(0x2::linked_table::contains<0x1::type_name::TypeName, Rewarder>(&arg1.rewarders, v0), 0xc86566ecf61a57d6ec53971798a611dc09482b453ac532f6c4a338c247255235::error::invalid_reward_type());
        assert!(arg2 > 0, 0xc86566ecf61a57d6ec53971798a611dc09482b453ac532f6c4a338c247255235::error::invalid_amount());
        let v1 = ms_to_seconds(0x2::clock::timestamp_ms(arg3));
        accumulate_vaults_reward<T0>(arg1, v1);
        let v2 = 0x2::linked_table::borrow_mut<0x1::type_name::TypeName, Rewarder>(&mut arg1.rewarders, v0);
        accumulate_rewarder_released(v2, v1);
        v2.emission_per_second = arg2;
        let v3 = UpdateRewarderEmissionEvent{
            reward_coin         : v0,
            emission_per_second : arg2,
        };
        0x2::event::emit<UpdateRewarderEmissionEvent>(v3);
    }

    public(friend) fun vault_rewards_settle(arg0: &mut RewarderManager, arg1: vector<0x1::type_name::TypeName>, arg2: 0x2::object::ID, arg3: &0x2::clock::Clock) : 0x2::vec_map::VecMap<0x1::type_name::TypeName, u128> {
        assert!(is_vault_registered(arg0, arg2), 0xc86566ecf61a57d6ec53971798a611dc09482b453ac532f6c4a338c247255235::error::vault_not_registered());
        let v0 = ms_to_seconds(0x2::clock::timestamp_ms(arg3));
        let v1 = 0x2::vec_map::empty<0x1::type_name::TypeName, u128>();
        while (0x1::vector::length<0x1::type_name::TypeName>(&arg1) > 0) {
            let v2 = 0x1::vector::pop_back<0x1::type_name::TypeName>(&mut arg1);
            let v3 = 0x2::linked_table::borrow_mut<0x1::type_name::TypeName, Rewarder>(&mut arg0.rewarders, v2);
            let v4 = accumulate_vault_reward(v3, arg2, *0x2::linked_table::borrow<0x2::object::ID, u128>(&arg0.vault_shares, arg2), v0);
            accumulate_rewarder_released(v3, v0);
            0x2::vec_map::insert<0x1::type_name::TypeName, u128>(&mut v1, v2, v4);
        };
        v1
    }

    public(friend) fun withdraw_reward<T0>(arg0: &mut RewarderManager, arg1: 0x2::object::ID, arg2: u64) : 0x2::balance::Balance<T0> {
        let v0 = 0x1::type_name::get<T0>();
        assert!(is_vault_registered(arg0, arg1), 0xc86566ecf61a57d6ec53971798a611dc09482b453ac532f6c4a338c247255235::error::vault_not_registered());
        assert!(is_vault_in_rewarder(arg0, v0, arg1), 0xc86566ecf61a57d6ec53971798a611dc09482b453ac532f6c4a338c247255235::error::vault_not_in_rewarder());
        assert!(0x2::bag::contains<0x1::type_name::TypeName>(&arg0.vault, v0), 0xc86566ecf61a57d6ec53971798a611dc09482b453ac532f6c4a338c247255235::error::invalid_reward_type());
        assert!(arg2 > 0, 0xc86566ecf61a57d6ec53971798a611dc09482b453ac532f6c4a338c247255235::error::invalid_amount());
        let v1 = 0x2::bag::borrow_mut<0x1::type_name::TypeName, 0x2::balance::Balance<T0>>(&mut arg0.vault, v0);
        assert!(0x2::balance::value<T0>(v1) >= arg2, 0xc86566ecf61a57d6ec53971798a611dc09482b453ac532f6c4a338c247255235::error::reward_not_enough());
        let v2 = 0x2::linked_table::borrow_mut<0x1::type_name::TypeName, Rewarder>(&mut arg0.rewarders, v0);
        v2.total_reward_harvested = v2.total_reward_harvested + arg2;
        let v3 = WithdrawRewardEvent{
            reward_type : v0,
            vault_id    : arg1,
            amount      : arg2,
        };
        0x2::event::emit<WithdrawRewardEvent>(v3);
        0x2::balance::split<T0>(v1, arg2)
    }

    // decompiled from Move bytecode v6
}

