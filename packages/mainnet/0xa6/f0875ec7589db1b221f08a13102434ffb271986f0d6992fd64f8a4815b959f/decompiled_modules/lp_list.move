module 0xa6f0875ec7589db1b221f08a13102434ffb271986f0d6992fd64f8a4815b959f::lp_list {
    struct PoolInfo has copy, drop, store {
        type: 0x1::ascii::String,
        address: address,
        project_url: 0x1::ascii::String,
        is_display_rewarder: bool,
        is_closed: bool,
        rewarder_display1: bool,
        rewarder_display2: bool,
        rewarder_display3: bool,
        extensions: 0x2::vec_map::VecMap<0x1::ascii::String, 0x1::ascii::String>,
    }

    struct FetchPoolListEvent<T0: copy + drop + store> has copy, drop, store {
        full_list: 0xa6f0875ec7589db1b221f08a13102434ffb271986f0d6992fd64f8a4815b959f::core::FullList<T0>,
    }

    public entry fun add_approver_to_list(arg0: &0xa6f0875ec7589db1b221f08a13102434ffb271986f0d6992fd64f8a4815b959f::core::GlobalConfig, arg1: address, arg2: &mut 0xa6f0875ec7589db1b221f08a13102434ffb271986f0d6992fd64f8a4815b959f::core::List<address>, arg3: &mut 0x2::tx_context::TxContext) {
        0xa6f0875ec7589db1b221f08a13102434ffb271986f0d6992fd64f8a4815b959f::core::checked_package_version(arg0);
        0xa6f0875ec7589db1b221f08a13102434ffb271986f0d6992fd64f8a4815b959f::core::add_approver_to_list<address>(arg1, arg2);
    }

    public entry fun add_approver_to_registry(arg0: &0xa6f0875ec7589db1b221f08a13102434ffb271986f0d6992fd64f8a4815b959f::core::GlobalConfig, arg1: address, arg2: &mut 0xa6f0875ec7589db1b221f08a13102434ffb271986f0d6992fd64f8a4815b959f::core::Registry<address, PoolInfo>, arg3: &0xa6f0875ec7589db1b221f08a13102434ffb271986f0d6992fd64f8a4815b959f::core::AdminCap, arg4: &mut 0x2::tx_context::TxContext) {
        0xa6f0875ec7589db1b221f08a13102434ffb271986f0d6992fd64f8a4815b959f::core::checked_package_version(arg0);
        0xa6f0875ec7589db1b221f08a13102434ffb271986f0d6992fd64f8a4815b959f::core::add_approver_to_registry<address, PoolInfo>(arg1, arg2);
    }

    public entry fun add_to_list(arg0: &0xa6f0875ec7589db1b221f08a13102434ffb271986f0d6992fd64f8a4815b959f::core::GlobalConfig, arg1: address, arg2: &mut 0xa6f0875ec7589db1b221f08a13102434ffb271986f0d6992fd64f8a4815b959f::core::Registry<address, PoolInfo>, arg3: &mut 0xa6f0875ec7589db1b221f08a13102434ffb271986f0d6992fd64f8a4815b959f::core::List<address>, arg4: &mut 0x2::tx_context::TxContext) {
        0xa6f0875ec7589db1b221f08a13102434ffb271986f0d6992fd64f8a4815b959f::core::checked_package_version(arg0);
        0xa6f0875ec7589db1b221f08a13102434ffb271986f0d6992fd64f8a4815b959f::core::add_to_list<address, PoolInfo>(arg1, arg2, arg3, arg4);
    }

    public entry fun add_to_registry_by_approver<T0, T1>(arg0: &0xa6f0875ec7589db1b221f08a13102434ffb271986f0d6992fd64f8a4815b959f::core::GlobalConfig, arg1: 0x1::ascii::String, arg2: address, arg3: 0x1::ascii::String, arg4: bool, arg5: bool, arg6: bool, arg7: bool, arg8: bool, arg9: bool, arg10: &mut 0xa6f0875ec7589db1b221f08a13102434ffb271986f0d6992fd64f8a4815b959f::core::Registry<address, PoolInfo>, arg11: &mut 0x2::tx_context::TxContext) {
        0xa6f0875ec7589db1b221f08a13102434ffb271986f0d6992fd64f8a4815b959f::core::checked_package_version(arg0);
        let v0 = PoolInfo{
            type                : arg1,
            address             : arg2,
            project_url         : arg3,
            is_display_rewarder : arg4,
            is_closed           : arg5,
            rewarder_display1   : arg6,
            rewarder_display2   : arg7,
            rewarder_display3   : arg8,
            extensions          : 0x2::vec_map::empty<0x1::ascii::String, 0x1::ascii::String>(),
        };
        0xa6f0875ec7589db1b221f08a13102434ffb271986f0d6992fd64f8a4815b959f::core::add_to_registry_by_approver<address, PoolInfo>(arg2, v0, arg9, arg10, arg11);
    }

    public entry fun create_list(arg0: &0xa6f0875ec7589db1b221f08a13102434ffb271986f0d6992fd64f8a4815b959f::core::GlobalConfig, arg1: &mut 0x2::tx_context::TxContext) {
        0xa6f0875ec7589db1b221f08a13102434ffb271986f0d6992fd64f8a4815b959f::core::checked_package_version(arg0);
        0xa6f0875ec7589db1b221f08a13102434ffb271986f0d6992fd64f8a4815b959f::core::create_list<address>(arg1);
    }

    public entry fun remove_approver_from_list(arg0: &0xa6f0875ec7589db1b221f08a13102434ffb271986f0d6992fd64f8a4815b959f::core::GlobalConfig, arg1: address, arg2: &mut 0xa6f0875ec7589db1b221f08a13102434ffb271986f0d6992fd64f8a4815b959f::core::List<address>, arg3: &mut 0x2::tx_context::TxContext) {
        0xa6f0875ec7589db1b221f08a13102434ffb271986f0d6992fd64f8a4815b959f::core::checked_package_version(arg0);
        0xa6f0875ec7589db1b221f08a13102434ffb271986f0d6992fd64f8a4815b959f::core::remove_approver_from_list<address>(arg1, arg2);
    }

    public entry fun remove_approver_from_registry(arg0: &0xa6f0875ec7589db1b221f08a13102434ffb271986f0d6992fd64f8a4815b959f::core::GlobalConfig, arg1: address, arg2: &mut 0xa6f0875ec7589db1b221f08a13102434ffb271986f0d6992fd64f8a4815b959f::core::Registry<address, PoolInfo>, arg3: &0xa6f0875ec7589db1b221f08a13102434ffb271986f0d6992fd64f8a4815b959f::core::AdminCap, arg4: &mut 0x2::tx_context::TxContext) {
        0xa6f0875ec7589db1b221f08a13102434ffb271986f0d6992fd64f8a4815b959f::core::checked_package_version(arg0);
        0xa6f0875ec7589db1b221f08a13102434ffb271986f0d6992fd64f8a4815b959f::core::remove_approver_from_registry<address, PoolInfo>(arg1, arg2);
    }

    public entry fun remove_from_list(arg0: &0xa6f0875ec7589db1b221f08a13102434ffb271986f0d6992fd64f8a4815b959f::core::GlobalConfig, arg1: address, arg2: &mut 0xa6f0875ec7589db1b221f08a13102434ffb271986f0d6992fd64f8a4815b959f::core::List<address>, arg3: &mut 0x2::tx_context::TxContext) {
        0xa6f0875ec7589db1b221f08a13102434ffb271986f0d6992fd64f8a4815b959f::core::checked_package_version(arg0);
        0xa6f0875ec7589db1b221f08a13102434ffb271986f0d6992fd64f8a4815b959f::core::remove_from_list<address>(arg1, arg2);
    }

    public entry fun remove_from_registry_by_approver(arg0: &mut 0x2::tx_context::TxContext) {
        0xa6f0875ec7589db1b221f08a13102434ffb271986f0d6992fd64f8a4815b959f::core::remove_from_registry_by_approver<address, PoolInfo>(arg0);
    }

    public entry fun add_extension_by_approver(arg0: &0xa6f0875ec7589db1b221f08a13102434ffb271986f0d6992fd64f8a4815b959f::core::GlobalConfig, arg1: 0x1::ascii::String, arg2: 0x1::ascii::String, arg3: address, arg4: &mut 0xa6f0875ec7589db1b221f08a13102434ffb271986f0d6992fd64f8a4815b959f::core::Registry<address, PoolInfo>, arg5: &mut 0x2::tx_context::TxContext) {
        0xa6f0875ec7589db1b221f08a13102434ffb271986f0d6992fd64f8a4815b959f::core::checked_package_version(arg0);
        assert!(0xa6f0875ec7589db1b221f08a13102434ffb271986f0d6992fd64f8a4815b959f::core::is_registry_approvers<address, PoolInfo>(arg4, arg5), 22);
        let v0 = 0xa6f0875ec7589db1b221f08a13102434ffb271986f0d6992fd64f8a4815b959f::core::get_info<address, PoolInfo>(arg3, arg4);
        0x2::vec_map::insert<0x1::ascii::String, 0x1::ascii::String>(&mut v0.extensions, arg1, arg2);
        0xa6f0875ec7589db1b221f08a13102434ffb271986f0d6992fd64f8a4815b959f::core::set_info<address, PoolInfo>(arg3, v0, arg4);
    }

    public entry fun drop_extension_by_approver(arg0: &0xa6f0875ec7589db1b221f08a13102434ffb271986f0d6992fd64f8a4815b959f::core::GlobalConfig, arg1: 0x1::ascii::String, arg2: address, arg3: &mut 0xa6f0875ec7589db1b221f08a13102434ffb271986f0d6992fd64f8a4815b959f::core::Registry<address, PoolInfo>, arg4: &mut 0x2::tx_context::TxContext) {
        0xa6f0875ec7589db1b221f08a13102434ffb271986f0d6992fd64f8a4815b959f::core::checked_package_version(arg0);
        assert!(0xa6f0875ec7589db1b221f08a13102434ffb271986f0d6992fd64f8a4815b959f::core::is_registry_approvers<address, PoolInfo>(arg3, arg4), 22);
        let v0 = 0xa6f0875ec7589db1b221f08a13102434ffb271986f0d6992fd64f8a4815b959f::core::get_info<address, PoolInfo>(arg2, arg3);
        let (_, _) = 0x2::vec_map::remove<0x1::ascii::String, 0x1::ascii::String>(&mut v0.extensions, &arg1);
        0xa6f0875ec7589db1b221f08a13102434ffb271986f0d6992fd64f8a4815b959f::core::set_info<address, PoolInfo>(arg2, v0, arg3);
    }

    public entry fun fetch_all_registered_coin_info(arg0: &mut 0xa6f0875ec7589db1b221f08a13102434ffb271986f0d6992fd64f8a4815b959f::core::Registry<address, PoolInfo>, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = FetchPoolListEvent<PoolInfo>{full_list: 0xa6f0875ec7589db1b221f08a13102434ffb271986f0d6992fd64f8a4815b959f::core::new_full_list<PoolInfo>()};
        0xa6f0875ec7589db1b221f08a13102434ffb271986f0d6992fd64f8a4815b959f::core::get_all_registered_coin_info<address, PoolInfo>(&mut v0.full_list, arg0);
        0x2::event::emit<FetchPoolListEvent<PoolInfo>>(v0);
    }

    public entry fun fetch_all_registered_coin_info_with_limit(arg0: &mut 0xa6f0875ec7589db1b221f08a13102434ffb271986f0d6992fd64f8a4815b959f::core::Registry<address, PoolInfo>, arg1: u64, arg2: u64, arg3: &mut 0x2::tx_context::TxContext) {
        let v0 = FetchPoolListEvent<PoolInfo>{full_list: 0xa6f0875ec7589db1b221f08a13102434ffb271986f0d6992fd64f8a4815b959f::core::new_full_list<PoolInfo>()};
        0xa6f0875ec7589db1b221f08a13102434ffb271986f0d6992fd64f8a4815b959f::core::get_all_registered_coin_info_with_limit<address, PoolInfo>(&mut v0.full_list, arg0, arg1, arg2);
        0x2::event::emit<FetchPoolListEvent<PoolInfo>>(v0);
    }

    public entry fun fetch_full_list(arg0: &mut 0xa6f0875ec7589db1b221f08a13102434ffb271986f0d6992fd64f8a4815b959f::core::Registry<address, PoolInfo>, arg1: &mut 0xa6f0875ec7589db1b221f08a13102434ffb271986f0d6992fd64f8a4815b959f::core::List<address>, arg2: &mut 0x2::tx_context::TxContext) {
        let v0 = FetchPoolListEvent<PoolInfo>{full_list: 0xa6f0875ec7589db1b221f08a13102434ffb271986f0d6992fd64f8a4815b959f::core::new_full_list<PoolInfo>()};
        0xa6f0875ec7589db1b221f08a13102434ffb271986f0d6992fd64f8a4815b959f::core::get_full_list<address, PoolInfo>(arg1, &mut v0.full_list, arg0);
        0x2::event::emit<FetchPoolListEvent<PoolInfo>>(v0);
    }

    public entry fun fetch_full_list_with_limit(arg0: &mut 0xa6f0875ec7589db1b221f08a13102434ffb271986f0d6992fd64f8a4815b959f::core::Registry<address, PoolInfo>, arg1: &mut 0xa6f0875ec7589db1b221f08a13102434ffb271986f0d6992fd64f8a4815b959f::core::List<address>, arg2: u64, arg3: u64, arg4: &mut 0x2::tx_context::TxContext) {
        let v0 = FetchPoolListEvent<PoolInfo>{full_list: 0xa6f0875ec7589db1b221f08a13102434ffb271986f0d6992fd64f8a4815b959f::core::new_full_list<PoolInfo>()};
        0xa6f0875ec7589db1b221f08a13102434ffb271986f0d6992fd64f8a4815b959f::core::get_full_list_with_limit<address, PoolInfo>(arg1, &mut v0.full_list, arg0, arg2, arg3);
        0x2::event::emit<FetchPoolListEvent<PoolInfo>>(v0);
    }

    fun init(arg0: &mut 0x2::tx_context::TxContext) {
        0xa6f0875ec7589db1b221f08a13102434ffb271986f0d6992fd64f8a4815b959f::core::initialize<address, PoolInfo>(arg0);
    }

    // decompiled from Move bytecode v6
}

