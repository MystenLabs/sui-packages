module 0x44b06989cb7a6403320783c8a3c73774e50b07590e5010866d3503637ba50b0f::agent {
    public fun add_asset_to_ticket<T0>(arg0: &mut 0x44b06989cb7a6403320783c8a3c73774e50b07590e5010866d3503637ba50b0f::account::SmartAccount, arg1: &mut 0x44b06989cb7a6403320783c8a3c73774e50b07590e5010866d3503637ba50b0f::ticket::AuthorizedTransferTicket, arg2: &0x44b06989cb7a6403320783c8a3c73774e50b07590e5010866d3503637ba50b0f::acl::SmartAccountAcl, arg3: &0x44b06989cb7a6403320783c8a3c73774e50b07590e5010866d3503637ba50b0f::config::GlobalConfig, arg4: &mut 0x2::tx_context::TxContext) {
        0x44b06989cb7a6403320783c8a3c73774e50b07590e5010866d3503637ba50b0f::config::assert_version_compatibility(arg3);
        assert_ticket_belongs_to_account(arg0, arg1);
        let v0 = 0x44b06989cb7a6403320783c8a3c73774e50b07590e5010866d3503637ba50b0f::ticket::get_strategy_name(arg1);
        0x44b06989cb7a6403320783c8a3c73774e50b07590e5010866d3503637ba50b0f::account::assert_strategy_supports_asset_type<T0>(arg0, v0);
        let v1 = 0x44b06989cb7a6403320783c8a3c73774e50b07590e5010866d3503637ba50b0f::account::balance<T0>(arg0, v0);
        if (v1 > 0) {
            0x44b06989cb7a6403320783c8a3c73774e50b07590e5010866d3503637ba50b0f::ticket::add_coin_internal<T0, 0x44b06989cb7a6403320783c8a3c73774e50b07590e5010866d3503637ba50b0f::acl::Access>(arg1, 0x44b06989cb7a6403320783c8a3c73774e50b07590e5010866d3503637ba50b0f::acl::access(arg2), 0x44b06989cb7a6403320783c8a3c73774e50b07590e5010866d3503637ba50b0f::account::withdraw_internal<T0>(arg0, arg3, v1, v0, arg4));
        };
    }

    public fun add_position_to_ticket<T0: store + key>(arg0: &mut 0x44b06989cb7a6403320783c8a3c73774e50b07590e5010866d3503637ba50b0f::account::SmartAccount, arg1: &mut 0x44b06989cb7a6403320783c8a3c73774e50b07590e5010866d3503637ba50b0f::ticket::AuthorizedTransferTicket, arg2: &0x44b06989cb7a6403320783c8a3c73774e50b07590e5010866d3503637ba50b0f::acl::SmartAccountAcl, arg3: &0x44b06989cb7a6403320783c8a3c73774e50b07590e5010866d3503637ba50b0f::config::GlobalConfig, arg4: &mut 0x2::tx_context::TxContext) {
        0x44b06989cb7a6403320783c8a3c73774e50b07590e5010866d3503637ba50b0f::config::assert_version_compatibility(arg3);
        assert_ticket_belongs_to_account(arg0, arg1);
        let v0 = 0x44b06989cb7a6403320783c8a3c73774e50b07590e5010866d3503637ba50b0f::ticket::get_strategy_name(arg1);
        if (0x44b06989cb7a6403320783c8a3c73774e50b07590e5010866d3503637ba50b0f::account::has_object_in_strategy<T0>(arg0, v0)) {
            0x44b06989cb7a6403320783c8a3c73774e50b07590e5010866d3503637ba50b0f::ticket::add_object_internal<T0, 0x44b06989cb7a6403320783c8a3c73774e50b07590e5010866d3503637ba50b0f::acl::Access>(arg1, 0x44b06989cb7a6403320783c8a3c73774e50b07590e5010866d3503637ba50b0f::acl::access(arg2), 0x44b06989cb7a6403320783c8a3c73774e50b07590e5010866d3503637ba50b0f::account::withdraw_object_internal<T0>(arg0, arg3, v0));
        };
    }

    fun assert_agent_authorized(arg0: &0x44b06989cb7a6403320783c8a3c73774e50b07590e5010866d3503637ba50b0f::config::GlobalConfig, arg1: &0x2::tx_context::TxContext) {
        0x44b06989cb7a6403320783c8a3c73774e50b07590e5010866d3503637ba50b0f::config::assert_whitelisted_agent(arg0, 0x2::tx_context::sender(arg1));
    }

    fun assert_ticket_belongs_to_account(arg0: &0x44b06989cb7a6403320783c8a3c73774e50b07590e5010866d3503637ba50b0f::account::SmartAccount, arg1: &0x44b06989cb7a6403320783c8a3c73774e50b07590e5010866d3503637ba50b0f::ticket::AuthorizedTransferTicket) {
        0x44b06989cb7a6403320783c8a3c73774e50b07590e5010866d3503637ba50b0f::ticket::assert_belongs_to_account(arg1, 0x2::object::id<0x44b06989cb7a6403320783c8a3c73774e50b07590e5010866d3503637ba50b0f::account::SmartAccount>(arg0));
    }

    public fun burn_ticket(arg0: &mut 0x44b06989cb7a6403320783c8a3c73774e50b07590e5010866d3503637ba50b0f::account::SmartAccount, arg1: 0x44b06989cb7a6403320783c8a3c73774e50b07590e5010866d3503637ba50b0f::ticket::AuthorizedTransferTicket, arg2: &0x44b06989cb7a6403320783c8a3c73774e50b07590e5010866d3503637ba50b0f::config::GlobalConfig, arg3: &mut 0x2::tx_context::TxContext) {
        0x44b06989cb7a6403320783c8a3c73774e50b07590e5010866d3503637ba50b0f::config::assert_version_compatibility(arg2);
        assert_ticket_belongs_to_account(arg0, &arg1);
        consume_policies(arg0, &arg1);
        let v0 = 0x44b06989cb7a6403320783c8a3c73774e50b07590e5010866d3503637ba50b0f::ticket::get_current_adapter(&arg1);
        if (0x1::string::length(&v0) > 0) {
            0x44b06989cb7a6403320783c8a3c73774e50b07590e5010866d3503637ba50b0f::account::set_current_adapter(arg0, arg2, v0);
        };
        0x44b06989cb7a6403320783c8a3c73774e50b07590e5010866d3503637ba50b0f::ticket::burn(arg1, arg0);
    }

    fun consume_policies(arg0: &0x44b06989cb7a6403320783c8a3c73774e50b07590e5010866d3503637ba50b0f::account::SmartAccount, arg1: &0x44b06989cb7a6403320783c8a3c73774e50b07590e5010866d3503637ba50b0f::ticket::AuthorizedTransferTicket) {
        let v0 = 0x44b06989cb7a6403320783c8a3c73774e50b07590e5010866d3503637ba50b0f::ticket::get_policies(arg1);
        let v1 = 0;
        while (v1 < 0x1::vector::length<0x44b06989cb7a6403320783c8a3c73774e50b07590e5010866d3503637ba50b0f::policy::Policy>(v0)) {
            0x1::vector::borrow<0x44b06989cb7a6403320783c8a3c73774e50b07590e5010866d3503637ba50b0f::policy::Policy>(v0, v1);
            v1 = v1 + 1;
        };
    }

    public fun consume_ticket_asset<T0>(arg0: &mut 0x44b06989cb7a6403320783c8a3c73774e50b07590e5010866d3503637ba50b0f::account::SmartAccount, arg1: &mut 0x44b06989cb7a6403320783c8a3c73774e50b07590e5010866d3503637ba50b0f::ticket::AuthorizedTransferTicket, arg2: &0x44b06989cb7a6403320783c8a3c73774e50b07590e5010866d3503637ba50b0f::acl::SmartAccountAcl, arg3: &0x44b06989cb7a6403320783c8a3c73774e50b07590e5010866d3503637ba50b0f::config::GlobalConfig, arg4: &mut 0x2::tx_context::TxContext) {
        0x44b06989cb7a6403320783c8a3c73774e50b07590e5010866d3503637ba50b0f::config::assert_version_compatibility(arg3);
        assert_ticket_belongs_to_account(arg0, arg1);
        let v0 = 0x44b06989cb7a6403320783c8a3c73774e50b07590e5010866d3503637ba50b0f::ticket::get_strategy_name(arg1);
        if (0x44b06989cb7a6403320783c8a3c73774e50b07590e5010866d3503637ba50b0f::ticket::has_asset_type<T0>(arg1)) {
            let v1 = extract_strategy_base_asset_from_ticket<T0>(arg1, 0x44b06989cb7a6403320783c8a3c73774e50b07590e5010866d3503637ba50b0f::acl::access(arg2), arg4);
            deposit_strategy_base_asset_if_present<T0>(arg0, arg3, v1, v0, arg4);
        };
    }

    public fun consume_ticket_performance_fee<T0>(arg0: &mut 0x44b06989cb7a6403320783c8a3c73774e50b07590e5010866d3503637ba50b0f::ticket::AuthorizedTransferTicket, arg1: &0x44b06989cb7a6403320783c8a3c73774e50b07590e5010866d3503637ba50b0f::acl::SmartAccountAcl, arg2: &mut 0x44b06989cb7a6403320783c8a3c73774e50b07590e5010866d3503637ba50b0f::config::GlobalConfig, arg3: &mut 0x2::tx_context::TxContext) {
        0x44b06989cb7a6403320783c8a3c73774e50b07590e5010866d3503637ba50b0f::config::assert_version_compatibility(arg2);
        if (0x44b06989cb7a6403320783c8a3c73774e50b07590e5010866d3503637ba50b0f::ticket::has_any_perf_fees(arg0)) {
            if (0x44b06989cb7a6403320783c8a3c73774e50b07590e5010866d3503637ba50b0f::ticket::perf_fee_asset_balance<T0>(arg0) > 0) {
                0x44b06989cb7a6403320783c8a3c73774e50b07590e5010866d3503637ba50b0f::config::collect_performance_fee<T0>(arg2, 0x44b06989cb7a6403320783c8a3c73774e50b07590e5010866d3503637ba50b0f::ticket::withdraw_performance_fee<T0, 0x44b06989cb7a6403320783c8a3c73774e50b07590e5010866d3503637ba50b0f::acl::Access>(arg0, 0x44b06989cb7a6403320783c8a3c73774e50b07590e5010866d3503637ba50b0f::acl::access(arg1), 0x44b06989cb7a6403320783c8a3c73774e50b07590e5010866d3503637ba50b0f::ticket::perf_fee_asset_balance<T0>(arg0), arg3));
            };
        };
    }

    public fun consume_ticket_position<T0: store + key>(arg0: &mut 0x44b06989cb7a6403320783c8a3c73774e50b07590e5010866d3503637ba50b0f::account::SmartAccount, arg1: &mut 0x44b06989cb7a6403320783c8a3c73774e50b07590e5010866d3503637ba50b0f::ticket::AuthorizedTransferTicket, arg2: &0x44b06989cb7a6403320783c8a3c73774e50b07590e5010866d3503637ba50b0f::acl::SmartAccountAcl, arg3: &0x44b06989cb7a6403320783c8a3c73774e50b07590e5010866d3503637ba50b0f::config::GlobalConfig, arg4: &mut 0x2::tx_context::TxContext) {
        0x44b06989cb7a6403320783c8a3c73774e50b07590e5010866d3503637ba50b0f::config::assert_version_compatibility(arg3);
        assert_ticket_belongs_to_account(arg0, arg1);
        let v0 = 0x44b06989cb7a6403320783c8a3c73774e50b07590e5010866d3503637ba50b0f::ticket::get_strategy_name(arg1);
        if (0x44b06989cb7a6403320783c8a3c73774e50b07590e5010866d3503637ba50b0f::ticket::has_asset_type<T0>(arg1)) {
            deposit_position_if_present<T0>(arg0, arg3, extract_position_from_ticket<T0>(arg1, 0x44b06989cb7a6403320783c8a3c73774e50b07590e5010866d3503637ba50b0f::acl::access(arg2)), v0, arg4);
        };
    }

    public fun consume_ticket_reward<T0>(arg0: &mut 0x44b06989cb7a6403320783c8a3c73774e50b07590e5010866d3503637ba50b0f::account::SmartAccount, arg1: &mut 0x44b06989cb7a6403320783c8a3c73774e50b07590e5010866d3503637ba50b0f::ticket::AuthorizedTransferTicket, arg2: &0x44b06989cb7a6403320783c8a3c73774e50b07590e5010866d3503637ba50b0f::acl::SmartAccountAcl, arg3: &0x44b06989cb7a6403320783c8a3c73774e50b07590e5010866d3503637ba50b0f::config::GlobalConfig, arg4: &mut 0x2::tx_context::TxContext) {
        0x44b06989cb7a6403320783c8a3c73774e50b07590e5010866d3503637ba50b0f::config::assert_version_compatibility(arg3);
        assert_ticket_belongs_to_account(arg0, arg1);
        let v0 = 0x44b06989cb7a6403320783c8a3c73774e50b07590e5010866d3503637ba50b0f::ticket::get_strategy_name(arg1);
        if (0x44b06989cb7a6403320783c8a3c73774e50b07590e5010866d3503637ba50b0f::ticket::has_reward_type<T0>(arg1)) {
            let v1 = extract_rewards_from_ticket<T0>(arg1, 0x44b06989cb7a6403320783c8a3c73774e50b07590e5010866d3503637ba50b0f::acl::access(arg2), arg4);
            deposit_rewards_if_present<T0>(arg0, arg3, v1, v0, arg4);
        };
    }

    fun deposit_position_if_present<T0: store + key>(arg0: &mut 0x44b06989cb7a6403320783c8a3c73774e50b07590e5010866d3503637ba50b0f::account::SmartAccount, arg1: &0x44b06989cb7a6403320783c8a3c73774e50b07590e5010866d3503637ba50b0f::config::GlobalConfig, arg2: 0x1::option::Option<T0>, arg3: 0x1::string::String, arg4: &mut 0x2::tx_context::TxContext) {
        if (0x1::option::is_some<T0>(&arg2)) {
            0x44b06989cb7a6403320783c8a3c73774e50b07590e5010866d3503637ba50b0f::account::deposit_object_internal<T0>(arg0, arg1, 0x1::option::destroy_some<T0>(arg2), arg3, arg4);
        } else {
            0x1::option::destroy_none<T0>(arg2);
        };
    }

    fun deposit_rewards_if_present<T0>(arg0: &mut 0x44b06989cb7a6403320783c8a3c73774e50b07590e5010866d3503637ba50b0f::account::SmartAccount, arg1: &0x44b06989cb7a6403320783c8a3c73774e50b07590e5010866d3503637ba50b0f::config::GlobalConfig, arg2: 0x1::option::Option<0x2::coin::Coin<T0>>, arg3: 0x1::string::String, arg4: &mut 0x2::tx_context::TxContext) {
        if (0x1::option::is_some<0x2::coin::Coin<T0>>(&arg2)) {
            0x44b06989cb7a6403320783c8a3c73774e50b07590e5010866d3503637ba50b0f::account::deposit_rewards_internal<T0>(arg0, arg1, 0x2::coin::into_balance<T0>(0x1::option::destroy_some<0x2::coin::Coin<T0>>(arg2)), arg3, arg4);
        } else {
            0x1::option::destroy_none<0x2::coin::Coin<T0>>(arg2);
        };
    }

    fun deposit_strategy_base_asset_if_present<T0>(arg0: &mut 0x44b06989cb7a6403320783c8a3c73774e50b07590e5010866d3503637ba50b0f::account::SmartAccount, arg1: &0x44b06989cb7a6403320783c8a3c73774e50b07590e5010866d3503637ba50b0f::config::GlobalConfig, arg2: 0x1::option::Option<0x2::coin::Coin<T0>>, arg3: 0x1::string::String, arg4: &mut 0x2::tx_context::TxContext) {
        if (0x1::option::is_some<0x2::coin::Coin<T0>>(&arg2)) {
            0x44b06989cb7a6403320783c8a3c73774e50b07590e5010866d3503637ba50b0f::account::deposit_internal<T0>(arg0, arg1, 0x1::option::destroy_some<0x2::coin::Coin<T0>>(arg2), arg3, arg4);
        } else {
            0x1::option::destroy_none<0x2::coin::Coin<T0>>(arg2);
        };
    }

    fun extract_position_from_ticket<T0: store + key>(arg0: &mut 0x44b06989cb7a6403320783c8a3c73774e50b07590e5010866d3503637ba50b0f::ticket::AuthorizedTransferTicket, arg1: &0x44b06989cb7a6403320783c8a3c73774e50b07590e5010866d3503637ba50b0f::acl::Access) : 0x1::option::Option<T0> {
        if (0x44b06989cb7a6403320783c8a3c73774e50b07590e5010866d3503637ba50b0f::ticket::has_asset_type<T0>(arg0)) {
            0x1::option::some<T0>(0x44b06989cb7a6403320783c8a3c73774e50b07590e5010866d3503637ba50b0f::ticket::withdraw_object_internal<T0, 0x44b06989cb7a6403320783c8a3c73774e50b07590e5010866d3503637ba50b0f::acl::Access>(arg0, arg1))
        } else {
            0x1::option::none<T0>()
        }
    }

    fun extract_rewards_from_ticket<T0>(arg0: &mut 0x44b06989cb7a6403320783c8a3c73774e50b07590e5010866d3503637ba50b0f::ticket::AuthorizedTransferTicket, arg1: &0x44b06989cb7a6403320783c8a3c73774e50b07590e5010866d3503637ba50b0f::acl::Access, arg2: &mut 0x2::tx_context::TxContext) : 0x1::option::Option<0x2::coin::Coin<T0>> {
        if (0x44b06989cb7a6403320783c8a3c73774e50b07590e5010866d3503637ba50b0f::ticket::has_reward_type<T0>(arg0)) {
            0x1::option::some<0x2::coin::Coin<T0>>(0x44b06989cb7a6403320783c8a3c73774e50b07590e5010866d3503637ba50b0f::ticket::withdraw_reward_internal<T0, 0x44b06989cb7a6403320783c8a3c73774e50b07590e5010866d3503637ba50b0f::acl::Access>(arg0, arg1, 0x44b06989cb7a6403320783c8a3c73774e50b07590e5010866d3503637ba50b0f::ticket::reward_balance<T0>(arg0), arg2))
        } else {
            0x1::option::none<0x2::coin::Coin<T0>>()
        }
    }

    fun extract_strategy_base_asset_from_ticket<T0>(arg0: &mut 0x44b06989cb7a6403320783c8a3c73774e50b07590e5010866d3503637ba50b0f::ticket::AuthorizedTransferTicket, arg1: &0x44b06989cb7a6403320783c8a3c73774e50b07590e5010866d3503637ba50b0f::acl::Access, arg2: &mut 0x2::tx_context::TxContext) : 0x1::option::Option<0x2::coin::Coin<T0>> {
        if (0x44b06989cb7a6403320783c8a3c73774e50b07590e5010866d3503637ba50b0f::ticket::has_asset_type<T0>(arg0)) {
            0x1::option::some<0x2::coin::Coin<T0>>(0x44b06989cb7a6403320783c8a3c73774e50b07590e5010866d3503637ba50b0f::ticket::withdraw_coin_internal<T0, 0x44b06989cb7a6403320783c8a3c73774e50b07590e5010866d3503637ba50b0f::acl::Access>(arg0, arg1, 0x44b06989cb7a6403320783c8a3c73774e50b07590e5010866d3503637ba50b0f::ticket::asset_balance<T0>(arg0), arg2))
        } else {
            0x1::option::none<0x2::coin::Coin<T0>>()
        }
    }

    public fun get_ticket_asset_keys(arg0: &0x44b06989cb7a6403320783c8a3c73774e50b07590e5010866d3503637ba50b0f::ticket::AuthorizedTransferTicket) : &vector<0x44b06989cb7a6403320783c8a3c73774e50b07590e5010866d3503637ba50b0f::asset_store::AssetKey> {
        0x44b06989cb7a6403320783c8a3c73774e50b07590e5010866d3503637ba50b0f::ticket::get_asset_keys(arg0)
    }

    public fun get_ticket_reward_keys(arg0: &0x44b06989cb7a6403320783c8a3c73774e50b07590e5010866d3503637ba50b0f::ticket::AuthorizedTransferTicket) : &vector<0x44b06989cb7a6403320783c8a3c73774e50b07590e5010866d3503637ba50b0f::asset_store::RewardKey> {
        0x44b06989cb7a6403320783c8a3c73774e50b07590e5010866d3503637ba50b0f::ticket::get_reward_keys(arg0)
    }

    public fun has_ticket_asset_type<T0>(arg0: &0x44b06989cb7a6403320783c8a3c73774e50b07590e5010866d3503637ba50b0f::ticket::AuthorizedTransferTicket) : bool {
        0x44b06989cb7a6403320783c8a3c73774e50b07590e5010866d3503637ba50b0f::ticket::has_asset_type<T0>(arg0)
    }

    public fun has_ticket_reward_type<T0>(arg0: &0x44b06989cb7a6403320783c8a3c73774e50b07590e5010866d3503637ba50b0f::ticket::AuthorizedTransferTicket) : bool {
        0x44b06989cb7a6403320783c8a3c73774e50b07590e5010866d3503637ba50b0f::ticket::has_reward_type<T0>(arg0)
    }

    public fun issue_ticket(arg0: &mut 0x44b06989cb7a6403320783c8a3c73774e50b07590e5010866d3503637ba50b0f::account::SmartAccount, arg1: &0x44b06989cb7a6403320783c8a3c73774e50b07590e5010866d3503637ba50b0f::config::GlobalConfig, arg2: 0x2::object::ID, arg3: &0x44b06989cb7a6403320783c8a3c73774e50b07590e5010866d3503637ba50b0f::acl::SmartAccountAcl, arg4: 0x1::string::String, arg5: &mut 0x2::tx_context::TxContext) : 0x44b06989cb7a6403320783c8a3c73774e50b07590e5010866d3503637ba50b0f::ticket::AuthorizedTransferTicket {
        0x44b06989cb7a6403320783c8a3c73774e50b07590e5010866d3503637ba50b0f::config::assert_version_compatibility(arg1);
        assert_agent_authorized(arg1, arg5);
        let v0 = mint_ticket(arg0, arg1, arg2, arg3, arg4, true, arg5);
        let v1 = &mut v0;
        write_policies(arg0, arg1, v1, arg4);
        0x44b06989cb7a6403320783c8a3c73774e50b07590e5010866d3503637ba50b0f::ticket::set_current_adapter(&mut v0, arg1, *0x44b06989cb7a6403320783c8a3c73774e50b07590e5010866d3503637ba50b0f::account::current_adapter(arg0));
        v0
    }

    public fun issue_ticket_as_owner(arg0: &mut 0x44b06989cb7a6403320783c8a3c73774e50b07590e5010866d3503637ba50b0f::account::SmartAccount, arg1: &0x44b06989cb7a6403320783c8a3c73774e50b07590e5010866d3503637ba50b0f::account::AccountOwnerCap, arg2: &0x44b06989cb7a6403320783c8a3c73774e50b07590e5010866d3503637ba50b0f::config::GlobalConfig, arg3: 0x2::object::ID, arg4: &0x44b06989cb7a6403320783c8a3c73774e50b07590e5010866d3503637ba50b0f::acl::SmartAccountAcl, arg5: 0x1::string::String, arg6: &mut 0x2::tx_context::TxContext) : 0x44b06989cb7a6403320783c8a3c73774e50b07590e5010866d3503637ba50b0f::ticket::AuthorizedTransferTicket {
        0x44b06989cb7a6403320783c8a3c73774e50b07590e5010866d3503637ba50b0f::config::assert_version_compatibility(arg2);
        0x44b06989cb7a6403320783c8a3c73774e50b07590e5010866d3503637ba50b0f::account::assert_account_owner(arg0, arg1);
        let v0 = mint_ticket(arg0, arg2, arg3, arg4, arg5, false, arg6);
        let v1 = &mut v0;
        write_policies(arg0, arg2, v1, arg5);
        0x44b06989cb7a6403320783c8a3c73774e50b07590e5010866d3503637ba50b0f::ticket::set_current_adapter(&mut v0, arg2, *0x44b06989cb7a6403320783c8a3c73774e50b07590e5010866d3503637ba50b0f::account::current_adapter(arg0));
        v0
    }

    fun mint_ticket(arg0: &mut 0x44b06989cb7a6403320783c8a3c73774e50b07590e5010866d3503637ba50b0f::account::SmartAccount, arg1: &0x44b06989cb7a6403320783c8a3c73774e50b07590e5010866d3503637ba50b0f::config::GlobalConfig, arg2: 0x2::object::ID, arg3: &0x44b06989cb7a6403320783c8a3c73774e50b07590e5010866d3503637ba50b0f::acl::SmartAccountAcl, arg4: 0x1::string::String, arg5: bool, arg6: &mut 0x2::tx_context::TxContext) : 0x44b06989cb7a6403320783c8a3c73774e50b07590e5010866d3503637ba50b0f::ticket::AuthorizedTransferTicket {
        0x44b06989cb7a6403320783c8a3c73774e50b07590e5010866d3503637ba50b0f::ticket::issue(arg2, 0x44b06989cb7a6403320783c8a3c73774e50b07590e5010866d3503637ba50b0f::acl::acl_id(arg3), 0x2::object::id<0x44b06989cb7a6403320783c8a3c73774e50b07590e5010866d3503637ba50b0f::account::SmartAccount>(arg0), arg4, 0x44b06989cb7a6403320783c8a3c73774e50b07590e5010866d3503637ba50b0f::account::extract_balance_sheet(arg0, arg4, arg6), arg5, 0x44b06989cb7a6403320783c8a3c73774e50b07590e5010866d3503637ba50b0f::config::performance_fee_rate(arg1), arg6)
    }

    fun write_policies(arg0: &0x44b06989cb7a6403320783c8a3c73774e50b07590e5010866d3503637ba50b0f::account::SmartAccount, arg1: &0x44b06989cb7a6403320783c8a3c73774e50b07590e5010866d3503637ba50b0f::config::GlobalConfig, arg2: &mut 0x44b06989cb7a6403320783c8a3c73774e50b07590e5010866d3503637ba50b0f::ticket::AuthorizedTransferTicket, arg3: 0x1::string::String) {
        assert!(0x44b06989cb7a6403320783c8a3c73774e50b07590e5010866d3503637ba50b0f::account::has_strategy_by_name(arg0, arg3), 0x44b06989cb7a6403320783c8a3c73774e50b07590e5010866d3503637ba50b0f::errors::strategy_not_found());
        let v0 = 0x44b06989cb7a6403320783c8a3c73774e50b07590e5010866d3503637ba50b0f::account::policies_for_strategy(arg0, arg1, arg3);
        if (!0x1::vector::is_empty<0x44b06989cb7a6403320783c8a3c73774e50b07590e5010866d3503637ba50b0f::policy::Policy>(&v0)) {
            0x44b06989cb7a6403320783c8a3c73774e50b07590e5010866d3503637ba50b0f::ticket::set_policies(arg2, arg1, v0);
        };
    }

    // decompiled from Move bytecode v6
}

