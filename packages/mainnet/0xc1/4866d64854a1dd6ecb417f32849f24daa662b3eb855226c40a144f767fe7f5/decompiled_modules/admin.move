module 0xc14866d64854a1dd6ecb417f32849f24daa662b3eb855226c40a144f767fe7f5::admin {
    struct AdminCap has store, key {
        id: 0x2::object::UID,
    }

    struct ManageCap has store, key {
        id: 0x2::object::UID,
        whitelisted_addresses: vector<address>,
    }

    struct FarmCreatedEvent has copy, drop, store {
        farm_id: 0x2::object::ID,
        base_token_type: 0x1::type_name::TypeName,
    }

    struct RewardsUpdatedEvent has copy, drop, store {
        farm_id: 0x2::object::ID,
        reward_token_type: 0x1::type_name::TypeName,
        rewards_per_sec: u64,
        is_claimable: bool,
    }

    public fun add_reward<T0, T1>(arg0: &ManageCap, arg1: &mut 0xc14866d64854a1dd6ecb417f32849f24daa662b3eb855226c40a144f767fe7f5::farm::Farm<T0>, arg2: 0x2::balance::Balance<T1>, arg3: u64, arg4: bool, arg5: &0xc14866d64854a1dd6ecb417f32849f24daa662b3eb855226c40a144f767fe7f5::version::Version, arg6: &0x2::clock::Clock, arg7: &mut 0x2::tx_context::TxContext) {
        assert_manager(arg0, arg7);
        0xc14866d64854a1dd6ecb417f32849f24daa662b3eb855226c40a144f767fe7f5::version::assert_supported_version(arg5);
        0xc14866d64854a1dd6ecb417f32849f24daa662b3eb855226c40a144f767fe7f5::farm::add_reward<T0, T1>(arg1, arg2, arg3, arg4, arg6);
        let v0 = RewardsUpdatedEvent{
            farm_id           : 0x2::object::id<0xc14866d64854a1dd6ecb417f32849f24daa662b3eb855226c40a144f767fe7f5::farm::Farm<T0>>(arg1),
            reward_token_type : 0x1::type_name::get<T1>(),
            rewards_per_sec   : arg3,
            is_claimable      : arg4,
        };
        0x2::event::emit<RewardsUpdatedEvent>(v0);
    }

    public fun add_whitelisted_manager_address(arg0: &AdminCap, arg1: &mut ManageCap, arg2: address) {
        assert!(!0x1::vector::contains<address>(&arg1.whitelisted_addresses, &arg2), 0xc14866d64854a1dd6ecb417f32849f24daa662b3eb855226c40a144f767fe7f5::error::already_whitelisted());
        0x1::vector::push_back<address>(&mut arg1.whitelisted_addresses, arg2);
    }

    fun assert_manager(arg0: &ManageCap, arg1: &0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg1);
        assert!(0x1::vector::contains<address>(&arg0.whitelisted_addresses, &v0), 0xc14866d64854a1dd6ecb417f32849f24daa662b3eb855226c40a144f767fe7f5::error::inavlid_auth());
    }

    fun init(arg0: &mut 0x2::tx_context::TxContext) {
        let v0 = AdminCap{id: 0x2::object::new(arg0)};
        0x2::transfer::transfer<AdminCap>(v0, 0x2::tx_context::sender(arg0));
        let v1 = ManageCap{
            id                    : 0x2::object::new(arg0),
            whitelisted_addresses : 0x1::vector::singleton<address>(0x2::tx_context::sender(arg0)),
        };
        0x2::transfer::share_object<ManageCap>(v1);
    }

    public fun initialize_farm<T0>(arg0: &ManageCap, arg1: 0x2::balance::Balance<T0>, arg2: &0xc14866d64854a1dd6ecb417f32849f24daa662b3eb855226c40a144f767fe7f5::version::Version, arg3: &0x2::clock::Clock, arg4: &mut 0x2::tx_context::TxContext) {
        assert_manager(arg0, arg4);
        0xc14866d64854a1dd6ecb417f32849f24daa662b3eb855226c40a144f767fe7f5::version::assert_supported_version(arg2);
        let v0 = 0xc14866d64854a1dd6ecb417f32849f24daa662b3eb855226c40a144f767fe7f5::farm::initialize<T0>(arg1, arg3, arg4);
        let v1 = FarmCreatedEvent{
            farm_id         : 0x2::object::id<0xc14866d64854a1dd6ecb417f32849f24daa662b3eb855226c40a144f767fe7f5::farm::Farm<T0>>(&v0),
            base_token_type : 0x1::type_name::get<T0>(),
        };
        0x2::event::emit<FarmCreatedEvent>(v1);
        0x2::transfer::public_share_object<0xc14866d64854a1dd6ecb417f32849f24daa662b3eb855226c40a144f767fe7f5::farm::Farm<T0>>(v0);
    }

    public fun initialize_farm_with_return<T0>(arg0: &ManageCap, arg1: 0x2::balance::Balance<T0>, arg2: &0xc14866d64854a1dd6ecb417f32849f24daa662b3eb855226c40a144f767fe7f5::version::Version, arg3: &0x2::clock::Clock, arg4: &mut 0x2::tx_context::TxContext) : 0xc14866d64854a1dd6ecb417f32849f24daa662b3eb855226c40a144f767fe7f5::farm::Farm<T0> {
        assert_manager(arg0, arg4);
        0xc14866d64854a1dd6ecb417f32849f24daa662b3eb855226c40a144f767fe7f5::version::assert_supported_version(arg2);
        let v0 = 0xc14866d64854a1dd6ecb417f32849f24daa662b3eb855226c40a144f767fe7f5::farm::initialize<T0>(arg1, arg3, arg4);
        let v1 = FarmCreatedEvent{
            farm_id         : 0x2::object::id<0xc14866d64854a1dd6ecb417f32849f24daa662b3eb855226c40a144f767fe7f5::farm::Farm<T0>>(&v0),
            base_token_type : 0x1::type_name::get<T0>(),
        };
        0x2::event::emit<FarmCreatedEvent>(v1);
        v0
    }

    public fun remove_whitelisted_manager_address(arg0: &AdminCap, arg1: &mut ManageCap, arg2: address) {
        let (v0, v1) = 0x1::vector::index_of<address>(&arg1.whitelisted_addresses, &arg2);
        assert!(v0, 0xc14866d64854a1dd6ecb417f32849f24daa662b3eb855226c40a144f767fe7f5::error::not_whitelisted());
        0x1::vector::remove<address>(&mut arg1.whitelisted_addresses, v1);
    }

    public fun update_points<T0>(arg0: &ManageCap, arg1: &mut 0xc14866d64854a1dd6ecb417f32849f24daa662b3eb855226c40a144f767fe7f5::farm::Farm<T0>, arg2: u64, arg3: &0xc14866d64854a1dd6ecb417f32849f24daa662b3eb855226c40a144f767fe7f5::version::Version, arg4: &0x2::clock::Clock, arg5: &mut 0x2::tx_context::TxContext) {
        assert_manager(arg0, arg5);
        0xc14866d64854a1dd6ecb417f32849f24daa662b3eb855226c40a144f767fe7f5::version::assert_supported_version(arg3);
        0xc14866d64854a1dd6ecb417f32849f24daa662b3eb855226c40a144f767fe7f5::farm::update_points<T0>(arg1, arg2, arg4);
    }

    public fun update_points_with_receipt<T0>(arg0: 0xfe579a58d32d38e154a8c0d4aa646238851f340258d10c7482cef9bea165b823::receipt::PermissionedReceipt, arg1: &ManageCap, arg2: &mut 0xc14866d64854a1dd6ecb417f32849f24daa662b3eb855226c40a144f767fe7f5::farm::Farm<T0>, arg3: &0xc14866d64854a1dd6ecb417f32849f24daa662b3eb855226c40a144f767fe7f5::acl::Acl, arg4: &0xc14866d64854a1dd6ecb417f32849f24daa662b3eb855226c40a144f767fe7f5::version::Version, arg5: &0x2::clock::Clock, arg6: &mut 0x2::tx_context::TxContext) {
        assert_manager(arg1, arg6);
        let v0 = 0xc14866d64854a1dd6ecb417f32849f24daa662b3eb855226c40a144f767fe7f5::acl::access(arg3);
        assert!(0xfe579a58d32d38e154a8c0d4aa646238851f340258d10c7482cef9bea165b823::receipt::remove_data<vector<u8>, 0x2::object::ID, 0xc14866d64854a1dd6ecb417f32849f24daa662b3eb855226c40a144f767fe7f5::acl::Access>(&mut arg0, v0, b"farm_id") == 0x2::object::id<0xc14866d64854a1dd6ecb417f32849f24daa662b3eb855226c40a144f767fe7f5::farm::Farm<T0>>(arg2), 0xc14866d64854a1dd6ecb417f32849f24daa662b3eb855226c40a144f767fe7f5::error::inavlid_farm());
        update_points<T0>(arg1, arg2, 0xfe579a58d32d38e154a8c0d4aa646238851f340258d10c7482cef9bea165b823::receipt::remove_data<vector<u8>, u64, 0xc14866d64854a1dd6ecb417f32849f24daa662b3eb855226c40a144f767fe7f5::acl::Access>(&mut arg0, v0, b"points"), arg4, arg5, arg6);
        0xfe579a58d32d38e154a8c0d4aa646238851f340258d10c7482cef9bea165b823::receipt::burn(arg0);
    }

    public fun update_reward<T0, T1>(arg0: &ManageCap, arg1: &mut 0xc14866d64854a1dd6ecb417f32849f24daa662b3eb855226c40a144f767fe7f5::farm::Farm<T0>, arg2: 0x2::balance::Balance<T1>, arg3: u64, arg4: bool, arg5: &0xc14866d64854a1dd6ecb417f32849f24daa662b3eb855226c40a144f767fe7f5::version::Version, arg6: &0x2::clock::Clock, arg7: &mut 0x2::tx_context::TxContext) {
        assert_manager(arg0, arg7);
        0xc14866d64854a1dd6ecb417f32849f24daa662b3eb855226c40a144f767fe7f5::version::assert_supported_version(arg5);
        0xc14866d64854a1dd6ecb417f32849f24daa662b3eb855226c40a144f767fe7f5::farm::update_reward<T0, T1>(arg1, arg2, arg3, arg4, arg6);
        let v0 = RewardsUpdatedEvent{
            farm_id           : 0x2::object::id<0xc14866d64854a1dd6ecb417f32849f24daa662b3eb855226c40a144f767fe7f5::farm::Farm<T0>>(arg1),
            reward_token_type : 0x1::type_name::get<T1>(),
            rewards_per_sec   : arg3,
            is_claimable      : arg4,
        };
        0x2::event::emit<RewardsUpdatedEvent>(v0);
    }

    public fun update_reward_with_receipt<T0, T1>(arg0: 0xfe579a58d32d38e154a8c0d4aa646238851f340258d10c7482cef9bea165b823::receipt::PermissionedReceipt, arg1: &ManageCap, arg2: &mut 0xc14866d64854a1dd6ecb417f32849f24daa662b3eb855226c40a144f767fe7f5::farm::Farm<T0>, arg3: &0xc14866d64854a1dd6ecb417f32849f24daa662b3eb855226c40a144f767fe7f5::acl::Acl, arg4: &0xc14866d64854a1dd6ecb417f32849f24daa662b3eb855226c40a144f767fe7f5::version::Version, arg5: &0x2::clock::Clock, arg6: &mut 0x2::tx_context::TxContext) {
        assert_manager(arg1, arg6);
        let v0 = 0xc14866d64854a1dd6ecb417f32849f24daa662b3eb855226c40a144f767fe7f5::acl::access(arg3);
        assert!(0xfe579a58d32d38e154a8c0d4aa646238851f340258d10c7482cef9bea165b823::receipt::remove_data<vector<u8>, 0x2::object::ID, 0xc14866d64854a1dd6ecb417f32849f24daa662b3eb855226c40a144f767fe7f5::acl::Access>(&mut arg0, v0, b"farm_id") == 0x2::object::id<0xc14866d64854a1dd6ecb417f32849f24daa662b3eb855226c40a144f767fe7f5::farm::Farm<T0>>(arg2), 0xc14866d64854a1dd6ecb417f32849f24daa662b3eb855226c40a144f767fe7f5::error::inavlid_farm());
        update_reward<T0, T1>(arg1, arg2, 0xfe579a58d32d38e154a8c0d4aa646238851f340258d10c7482cef9bea165b823::receipt::remove_data<vector<u8>, 0x2::balance::Balance<T1>, 0xc14866d64854a1dd6ecb417f32849f24daa662b3eb855226c40a144f767fe7f5::acl::Access>(&mut arg0, v0, b"reward_balance"), 0xfe579a58d32d38e154a8c0d4aa646238851f340258d10c7482cef9bea165b823::receipt::remove_data<vector<u8>, u64, 0xc14866d64854a1dd6ecb417f32849f24daa662b3eb855226c40a144f767fe7f5::acl::Access>(&mut arg0, v0, b"rewards_per_sec"), 0xfe579a58d32d38e154a8c0d4aa646238851f340258d10c7482cef9bea165b823::receipt::remove_data<vector<u8>, bool, 0xc14866d64854a1dd6ecb417f32849f24daa662b3eb855226c40a144f767fe7f5::acl::Access>(&mut arg0, v0, b"is_claimable"), arg4, arg5, arg6);
        0xfe579a58d32d38e154a8c0d4aa646238851f340258d10c7482cef9bea165b823::receipt::burn(arg0);
    }

    public fun withdraw_unharvested<T0, T1>(arg0: &ManageCap, arg1: &mut 0xc14866d64854a1dd6ecb417f32849f24daa662b3eb855226c40a144f767fe7f5::farm::Farm<T0>, arg2: &0xc14866d64854a1dd6ecb417f32849f24daa662b3eb855226c40a144f767fe7f5::version::Version, arg3: &0x2::clock::Clock, arg4: &mut 0x2::tx_context::TxContext) : 0x2::balance::Balance<T1> {
        assert_manager(arg0, arg4);
        0xc14866d64854a1dd6ecb417f32849f24daa662b3eb855226c40a144f767fe7f5::version::assert_supported_version(arg2);
        0xc14866d64854a1dd6ecb417f32849f24daa662b3eb855226c40a144f767fe7f5::farm::withdraw_unharvested<T0, T1>(arg1, arg3)
    }

    // decompiled from Move bytecode v6
}

