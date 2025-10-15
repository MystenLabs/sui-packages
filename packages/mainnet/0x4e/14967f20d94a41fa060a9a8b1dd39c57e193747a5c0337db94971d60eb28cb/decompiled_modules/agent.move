module 0x4e14967f20d94a41fa060a9a8b1dd39c57e193747a5c0337db94971d60eb28cb::agent {
    public fun add_asset_to_ticket<T0>(arg0: &mut 0x4e14967f20d94a41fa060a9a8b1dd39c57e193747a5c0337db94971d60eb28cb::account::SmartAccount, arg1: &mut 0x4e14967f20d94a41fa060a9a8b1dd39c57e193747a5c0337db94971d60eb28cb::ticket::AuthorizedTransferTicket, arg2: &0x4e14967f20d94a41fa060a9a8b1dd39c57e193747a5c0337db94971d60eb28cb::config::GlobalConfig, arg3: &mut 0x2::tx_context::TxContext) {
        0x4e14967f20d94a41fa060a9a8b1dd39c57e193747a5c0337db94971d60eb28cb::config::assert_version_compatibility(arg2);
        assert_ticket_belongs_to_account(arg0, arg1);
        let v0 = 0x4e14967f20d94a41fa060a9a8b1dd39c57e193747a5c0337db94971d60eb28cb::ticket::get_strategy_name(arg1);
        let v1 = 0x4e14967f20d94a41fa060a9a8b1dd39c57e193747a5c0337db94971d60eb28cb::account::balance<T0>(arg0, v0);
        if (v1 > 0) {
            0x4e14967f20d94a41fa060a9a8b1dd39c57e193747a5c0337db94971d60eb28cb::ticket::add_coin_internal<T0>(arg1, 0x4e14967f20d94a41fa060a9a8b1dd39c57e193747a5c0337db94971d60eb28cb::account::withdraw_internal<T0>(arg0, arg2, v1, v0, arg3));
        };
    }

    public fun add_position_to_ticket<T0: store + key>(arg0: &mut 0x4e14967f20d94a41fa060a9a8b1dd39c57e193747a5c0337db94971d60eb28cb::account::SmartAccount, arg1: &mut 0x4e14967f20d94a41fa060a9a8b1dd39c57e193747a5c0337db94971d60eb28cb::ticket::AuthorizedTransferTicket, arg2: &0x4e14967f20d94a41fa060a9a8b1dd39c57e193747a5c0337db94971d60eb28cb::config::GlobalConfig) {
        0x4e14967f20d94a41fa060a9a8b1dd39c57e193747a5c0337db94971d60eb28cb::config::assert_version_compatibility(arg2);
        assert_ticket_belongs_to_account(arg0, arg1);
        let v0 = 0x4e14967f20d94a41fa060a9a8b1dd39c57e193747a5c0337db94971d60eb28cb::ticket::get_strategy_name(arg1);
        if (0x4e14967f20d94a41fa060a9a8b1dd39c57e193747a5c0337db94971d60eb28cb::account::has_object_in_strategy<T0>(arg0, v0)) {
            0x4e14967f20d94a41fa060a9a8b1dd39c57e193747a5c0337db94971d60eb28cb::ticket::add_object_internal<T0>(arg1, 0x4e14967f20d94a41fa060a9a8b1dd39c57e193747a5c0337db94971d60eb28cb::account::withdraw_object_internal<T0>(arg0, arg2, v0));
        };
    }

    fun assert_agent_authorized(arg0: &0x4e14967f20d94a41fa060a9a8b1dd39c57e193747a5c0337db94971d60eb28cb::config::GlobalConfig, arg1: &0x2::tx_context::TxContext) {
        0x4e14967f20d94a41fa060a9a8b1dd39c57e193747a5c0337db94971d60eb28cb::config::assert_whitelisted_agent(arg0, 0x2::tx_context::sender(arg1));
    }

    fun assert_ticket_belongs_to_account(arg0: &0x4e14967f20d94a41fa060a9a8b1dd39c57e193747a5c0337db94971d60eb28cb::account::SmartAccount, arg1: &0x4e14967f20d94a41fa060a9a8b1dd39c57e193747a5c0337db94971d60eb28cb::ticket::AuthorizedTransferTicket) {
        0x4e14967f20d94a41fa060a9a8b1dd39c57e193747a5c0337db94971d60eb28cb::ticket::assert_belongs_to_account(arg1, 0x2::object::id<0x4e14967f20d94a41fa060a9a8b1dd39c57e193747a5c0337db94971d60eb28cb::account::SmartAccount>(arg0));
    }

    public fun burn_ticket(arg0: &mut 0x4e14967f20d94a41fa060a9a8b1dd39c57e193747a5c0337db94971d60eb28cb::account::SmartAccount, arg1: 0x4e14967f20d94a41fa060a9a8b1dd39c57e193747a5c0337db94971d60eb28cb::ticket::AuthorizedTransferTicket, arg2: &0x4e14967f20d94a41fa060a9a8b1dd39c57e193747a5c0337db94971d60eb28cb::config::GlobalConfig, arg3: &mut 0x2::tx_context::TxContext) {
        0x4e14967f20d94a41fa060a9a8b1dd39c57e193747a5c0337db94971d60eb28cb::config::assert_version_compatibility(arg2);
        assert_ticket_belongs_to_account(arg0, &arg1);
        consume_policies(arg0, &arg1);
        let v0 = 0x4e14967f20d94a41fa060a9a8b1dd39c57e193747a5c0337db94971d60eb28cb::ticket::get_current_adapter(&arg1);
        if (0x1::string::length(&v0) > 0) {
            0x4e14967f20d94a41fa060a9a8b1dd39c57e193747a5c0337db94971d60eb28cb::account::set_current_adapter(arg0, arg2, v0);
        };
        0x4e14967f20d94a41fa060a9a8b1dd39c57e193747a5c0337db94971d60eb28cb::ticket::burn(arg1, arg0);
    }

    fun consume_policies(arg0: &0x4e14967f20d94a41fa060a9a8b1dd39c57e193747a5c0337db94971d60eb28cb::account::SmartAccount, arg1: &0x4e14967f20d94a41fa060a9a8b1dd39c57e193747a5c0337db94971d60eb28cb::ticket::AuthorizedTransferTicket) {
        let v0 = 0x4e14967f20d94a41fa060a9a8b1dd39c57e193747a5c0337db94971d60eb28cb::ticket::get_policies(arg1);
        let v1 = 0;
        while (v1 < 0x1::vector::length<0x4e14967f20d94a41fa060a9a8b1dd39c57e193747a5c0337db94971d60eb28cb::policy::Policy>(v0)) {
            0x1::vector::borrow<0x4e14967f20d94a41fa060a9a8b1dd39c57e193747a5c0337db94971d60eb28cb::policy::Policy>(v0, v1);
            v1 = v1 + 1;
        };
    }

    public fun consume_ticket_asset<T0>(arg0: &mut 0x4e14967f20d94a41fa060a9a8b1dd39c57e193747a5c0337db94971d60eb28cb::account::SmartAccount, arg1: &mut 0x4e14967f20d94a41fa060a9a8b1dd39c57e193747a5c0337db94971d60eb28cb::ticket::AuthorizedTransferTicket, arg2: &0x4e14967f20d94a41fa060a9a8b1dd39c57e193747a5c0337db94971d60eb28cb::config::GlobalConfig, arg3: &mut 0x2::tx_context::TxContext) {
        0x4e14967f20d94a41fa060a9a8b1dd39c57e193747a5c0337db94971d60eb28cb::config::assert_version_compatibility(arg2);
        assert_ticket_belongs_to_account(arg0, arg1);
        let v0 = 0x4e14967f20d94a41fa060a9a8b1dd39c57e193747a5c0337db94971d60eb28cb::ticket::get_strategy_name(arg1);
        if (0x4e14967f20d94a41fa060a9a8b1dd39c57e193747a5c0337db94971d60eb28cb::ticket::has_asset_type<T0>(arg1)) {
            let v1 = extract_strategy_base_asset_from_ticket<T0>(arg1, arg3);
            deposit_strategy_base_asset_if_present<T0>(arg0, arg2, v1, v0, arg3);
        };
    }

    public fun consume_ticket_performance_fee<T0>(arg0: &mut 0x4e14967f20d94a41fa060a9a8b1dd39c57e193747a5c0337db94971d60eb28cb::ticket::AuthorizedTransferTicket, arg1: &mut 0x4e14967f20d94a41fa060a9a8b1dd39c57e193747a5c0337db94971d60eb28cb::config::GlobalConfig, arg2: &mut 0x2::tx_context::TxContext) {
        0x4e14967f20d94a41fa060a9a8b1dd39c57e193747a5c0337db94971d60eb28cb::config::assert_version_compatibility(arg1);
        if (0x4e14967f20d94a41fa060a9a8b1dd39c57e193747a5c0337db94971d60eb28cb::ticket::has_any_perf_fees(arg0)) {
            if (0x4e14967f20d94a41fa060a9a8b1dd39c57e193747a5c0337db94971d60eb28cb::ticket::perf_fee_asset_balance<T0>(arg0) > 0) {
                0x4e14967f20d94a41fa060a9a8b1dd39c57e193747a5c0337db94971d60eb28cb::config::collect_performance_fee<T0>(arg1, 0x4e14967f20d94a41fa060a9a8b1dd39c57e193747a5c0337db94971d60eb28cb::ticket::withdraw_performance_fee<T0>(arg0, 0x4e14967f20d94a41fa060a9a8b1dd39c57e193747a5c0337db94971d60eb28cb::ticket::perf_fee_asset_balance<T0>(arg0), arg2));
            };
        };
    }

    public fun consume_ticket_position<T0: store + key>(arg0: &mut 0x4e14967f20d94a41fa060a9a8b1dd39c57e193747a5c0337db94971d60eb28cb::account::SmartAccount, arg1: &mut 0x4e14967f20d94a41fa060a9a8b1dd39c57e193747a5c0337db94971d60eb28cb::ticket::AuthorizedTransferTicket, arg2: &0x4e14967f20d94a41fa060a9a8b1dd39c57e193747a5c0337db94971d60eb28cb::config::GlobalConfig, arg3: &mut 0x2::tx_context::TxContext) {
        0x4e14967f20d94a41fa060a9a8b1dd39c57e193747a5c0337db94971d60eb28cb::config::assert_version_compatibility(arg2);
        assert_ticket_belongs_to_account(arg0, arg1);
        let v0 = 0x4e14967f20d94a41fa060a9a8b1dd39c57e193747a5c0337db94971d60eb28cb::ticket::get_strategy_name(arg1);
        if (0x4e14967f20d94a41fa060a9a8b1dd39c57e193747a5c0337db94971d60eb28cb::ticket::has_asset_type<T0>(arg1)) {
            deposit_position_if_present<T0>(arg0, arg2, extract_position_from_ticket<T0>(arg1), v0, arg3);
        };
    }

    public fun consume_ticket_reward<T0>(arg0: &mut 0x4e14967f20d94a41fa060a9a8b1dd39c57e193747a5c0337db94971d60eb28cb::account::SmartAccount, arg1: &mut 0x4e14967f20d94a41fa060a9a8b1dd39c57e193747a5c0337db94971d60eb28cb::ticket::AuthorizedTransferTicket, arg2: &0x4e14967f20d94a41fa060a9a8b1dd39c57e193747a5c0337db94971d60eb28cb::config::GlobalConfig, arg3: &mut 0x2::tx_context::TxContext) {
        0x4e14967f20d94a41fa060a9a8b1dd39c57e193747a5c0337db94971d60eb28cb::config::assert_version_compatibility(arg2);
        assert_ticket_belongs_to_account(arg0, arg1);
        let v0 = 0x4e14967f20d94a41fa060a9a8b1dd39c57e193747a5c0337db94971d60eb28cb::ticket::get_strategy_name(arg1);
        if (0x4e14967f20d94a41fa060a9a8b1dd39c57e193747a5c0337db94971d60eb28cb::ticket::has_reward_type<T0>(arg1)) {
            let v1 = extract_rewards_from_ticket<T0>(arg1, arg3);
            deposit_rewards_if_present<T0>(arg0, arg2, v1, v0, arg3);
        };
    }

    fun deposit_position_if_present<T0: store + key>(arg0: &mut 0x4e14967f20d94a41fa060a9a8b1dd39c57e193747a5c0337db94971d60eb28cb::account::SmartAccount, arg1: &0x4e14967f20d94a41fa060a9a8b1dd39c57e193747a5c0337db94971d60eb28cb::config::GlobalConfig, arg2: 0x1::option::Option<T0>, arg3: 0x1::string::String, arg4: &mut 0x2::tx_context::TxContext) {
        if (0x1::option::is_some<T0>(&arg2)) {
            0x4e14967f20d94a41fa060a9a8b1dd39c57e193747a5c0337db94971d60eb28cb::account::deposit_object_internal<T0>(arg0, arg1, 0x1::option::destroy_some<T0>(arg2), arg3, arg4);
        } else {
            0x1::option::destroy_none<T0>(arg2);
        };
    }

    fun deposit_rewards_if_present<T0>(arg0: &mut 0x4e14967f20d94a41fa060a9a8b1dd39c57e193747a5c0337db94971d60eb28cb::account::SmartAccount, arg1: &0x4e14967f20d94a41fa060a9a8b1dd39c57e193747a5c0337db94971d60eb28cb::config::GlobalConfig, arg2: 0x1::option::Option<0x2::coin::Coin<T0>>, arg3: 0x1::string::String, arg4: &mut 0x2::tx_context::TxContext) {
        if (0x1::option::is_some<0x2::coin::Coin<T0>>(&arg2)) {
            0x4e14967f20d94a41fa060a9a8b1dd39c57e193747a5c0337db94971d60eb28cb::account::deposit_rewards_internal<T0>(arg0, arg1, 0x2::coin::into_balance<T0>(0x1::option::destroy_some<0x2::coin::Coin<T0>>(arg2)), arg3, arg4);
        } else {
            0x1::option::destroy_none<0x2::coin::Coin<T0>>(arg2);
        };
    }

    fun deposit_strategy_base_asset_if_present<T0>(arg0: &mut 0x4e14967f20d94a41fa060a9a8b1dd39c57e193747a5c0337db94971d60eb28cb::account::SmartAccount, arg1: &0x4e14967f20d94a41fa060a9a8b1dd39c57e193747a5c0337db94971d60eb28cb::config::GlobalConfig, arg2: 0x1::option::Option<0x2::coin::Coin<T0>>, arg3: 0x1::string::String, arg4: &mut 0x2::tx_context::TxContext) {
        if (0x1::option::is_some<0x2::coin::Coin<T0>>(&arg2)) {
            0x4e14967f20d94a41fa060a9a8b1dd39c57e193747a5c0337db94971d60eb28cb::account::deposit_internal<T0>(arg0, arg1, 0x1::option::destroy_some<0x2::coin::Coin<T0>>(arg2), arg3, arg4);
        } else {
            0x1::option::destroy_none<0x2::coin::Coin<T0>>(arg2);
        };
    }

    fun extract_position_from_ticket<T0: store + key>(arg0: &mut 0x4e14967f20d94a41fa060a9a8b1dd39c57e193747a5c0337db94971d60eb28cb::ticket::AuthorizedTransferTicket) : 0x1::option::Option<T0> {
        if (0x4e14967f20d94a41fa060a9a8b1dd39c57e193747a5c0337db94971d60eb28cb::ticket::has_asset_type<T0>(arg0)) {
            0x1::option::some<T0>(0x4e14967f20d94a41fa060a9a8b1dd39c57e193747a5c0337db94971d60eb28cb::ticket::withdraw_object_internal<T0>(arg0))
        } else {
            0x1::option::none<T0>()
        }
    }

    fun extract_rewards_from_ticket<T0>(arg0: &mut 0x4e14967f20d94a41fa060a9a8b1dd39c57e193747a5c0337db94971d60eb28cb::ticket::AuthorizedTransferTicket, arg1: &mut 0x2::tx_context::TxContext) : 0x1::option::Option<0x2::coin::Coin<T0>> {
        if (0x4e14967f20d94a41fa060a9a8b1dd39c57e193747a5c0337db94971d60eb28cb::ticket::has_reward_type<T0>(arg0)) {
            0x1::option::some<0x2::coin::Coin<T0>>(0x4e14967f20d94a41fa060a9a8b1dd39c57e193747a5c0337db94971d60eb28cb::ticket::withdraw_reward_internal<T0>(arg0, 0x4e14967f20d94a41fa060a9a8b1dd39c57e193747a5c0337db94971d60eb28cb::ticket::reward_balance<T0>(arg0), arg1))
        } else {
            0x1::option::none<0x2::coin::Coin<T0>>()
        }
    }

    fun extract_strategy_base_asset_from_ticket<T0>(arg0: &mut 0x4e14967f20d94a41fa060a9a8b1dd39c57e193747a5c0337db94971d60eb28cb::ticket::AuthorizedTransferTicket, arg1: &mut 0x2::tx_context::TxContext) : 0x1::option::Option<0x2::coin::Coin<T0>> {
        if (0x4e14967f20d94a41fa060a9a8b1dd39c57e193747a5c0337db94971d60eb28cb::ticket::has_asset_type<T0>(arg0)) {
            0x1::option::some<0x2::coin::Coin<T0>>(0x4e14967f20d94a41fa060a9a8b1dd39c57e193747a5c0337db94971d60eb28cb::ticket::withdraw_coin_internal<T0>(arg0, 0x4e14967f20d94a41fa060a9a8b1dd39c57e193747a5c0337db94971d60eb28cb::ticket::asset_balance<T0>(arg0), arg1))
        } else {
            0x1::option::none<0x2::coin::Coin<T0>>()
        }
    }

    public fun get_ticket_asset_keys(arg0: &0x4e14967f20d94a41fa060a9a8b1dd39c57e193747a5c0337db94971d60eb28cb::ticket::AuthorizedTransferTicket) : &vector<0x4e14967f20d94a41fa060a9a8b1dd39c57e193747a5c0337db94971d60eb28cb::asset_store::AssetKey> {
        0x4e14967f20d94a41fa060a9a8b1dd39c57e193747a5c0337db94971d60eb28cb::ticket::get_asset_keys(arg0)
    }

    public fun get_ticket_base_asset_types(arg0: &0x4e14967f20d94a41fa060a9a8b1dd39c57e193747a5c0337db94971d60eb28cb::ticket::AuthorizedTransferTicket) : &vector<0x1::type_name::TypeName> {
        0x4e14967f20d94a41fa060a9a8b1dd39c57e193747a5c0337db94971d60eb28cb::ticket::get_base_asset_types(arg0)
    }

    public fun get_ticket_reward_keys(arg0: &0x4e14967f20d94a41fa060a9a8b1dd39c57e193747a5c0337db94971d60eb28cb::ticket::AuthorizedTransferTicket) : &vector<0x4e14967f20d94a41fa060a9a8b1dd39c57e193747a5c0337db94971d60eb28cb::asset_store::RewardKey> {
        0x4e14967f20d94a41fa060a9a8b1dd39c57e193747a5c0337db94971d60eb28cb::ticket::get_reward_keys(arg0)
    }

    public fun has_ticket_asset_type<T0>(arg0: &0x4e14967f20d94a41fa060a9a8b1dd39c57e193747a5c0337db94971d60eb28cb::ticket::AuthorizedTransferTicket) : bool {
        0x4e14967f20d94a41fa060a9a8b1dd39c57e193747a5c0337db94971d60eb28cb::ticket::has_asset_type<T0>(arg0)
    }

    public fun has_ticket_reward_type<T0>(arg0: &0x4e14967f20d94a41fa060a9a8b1dd39c57e193747a5c0337db94971d60eb28cb::ticket::AuthorizedTransferTicket) : bool {
        0x4e14967f20d94a41fa060a9a8b1dd39c57e193747a5c0337db94971d60eb28cb::ticket::has_reward_type<T0>(arg0)
    }

    public fun issue_ticket(arg0: &mut 0x4e14967f20d94a41fa060a9a8b1dd39c57e193747a5c0337db94971d60eb28cb::account::SmartAccount, arg1: &0x4e14967f20d94a41fa060a9a8b1dd39c57e193747a5c0337db94971d60eb28cb::config::GlobalConfig, arg2: 0x1::string::String, arg3: &mut 0x2::tx_context::TxContext) : 0x4e14967f20d94a41fa060a9a8b1dd39c57e193747a5c0337db94971d60eb28cb::ticket::AuthorizedTransferTicket {
        0x4e14967f20d94a41fa060a9a8b1dd39c57e193747a5c0337db94971d60eb28cb::config::assert_version_compatibility(arg1);
        assert_agent_authorized(arg1, arg3);
        let v0 = mint_ticket(arg0, arg1, arg2, true, arg3);
        let v1 = &mut v0;
        write_policies(arg0, arg1, v1, arg2);
        0x4e14967f20d94a41fa060a9a8b1dd39c57e193747a5c0337db94971d60eb28cb::ticket::set_current_adapter(&mut v0, arg1, *0x4e14967f20d94a41fa060a9a8b1dd39c57e193747a5c0337db94971d60eb28cb::account::current_adapter(arg0));
        v0
    }

    public fun issue_ticket_as_owner(arg0: &mut 0x4e14967f20d94a41fa060a9a8b1dd39c57e193747a5c0337db94971d60eb28cb::account::SmartAccount, arg1: &0x4e14967f20d94a41fa060a9a8b1dd39c57e193747a5c0337db94971d60eb28cb::account::AccountOwnerCap, arg2: &0x4e14967f20d94a41fa060a9a8b1dd39c57e193747a5c0337db94971d60eb28cb::config::GlobalConfig, arg3: 0x1::string::String, arg4: &mut 0x2::tx_context::TxContext) : 0x4e14967f20d94a41fa060a9a8b1dd39c57e193747a5c0337db94971d60eb28cb::ticket::AuthorizedTransferTicket {
        0x4e14967f20d94a41fa060a9a8b1dd39c57e193747a5c0337db94971d60eb28cb::config::assert_version_compatibility(arg2);
        0x4e14967f20d94a41fa060a9a8b1dd39c57e193747a5c0337db94971d60eb28cb::account::assert_account_owner(arg0, arg1);
        let v0 = mint_ticket(arg0, arg2, arg3, false, arg4);
        let v1 = &mut v0;
        write_policies(arg0, arg2, v1, arg3);
        0x4e14967f20d94a41fa060a9a8b1dd39c57e193747a5c0337db94971d60eb28cb::ticket::set_current_adapter(&mut v0, arg2, *0x4e14967f20d94a41fa060a9a8b1dd39c57e193747a5c0337db94971d60eb28cb::account::current_adapter(arg0));
        v0
    }

    fun mint_ticket(arg0: &mut 0x4e14967f20d94a41fa060a9a8b1dd39c57e193747a5c0337db94971d60eb28cb::account::SmartAccount, arg1: &0x4e14967f20d94a41fa060a9a8b1dd39c57e193747a5c0337db94971d60eb28cb::config::GlobalConfig, arg2: 0x1::string::String, arg3: bool, arg4: &mut 0x2::tx_context::TxContext) : 0x4e14967f20d94a41fa060a9a8b1dd39c57e193747a5c0337db94971d60eb28cb::ticket::AuthorizedTransferTicket {
        0x4e14967f20d94a41fa060a9a8b1dd39c57e193747a5c0337db94971d60eb28cb::ticket::issue(0x2::object::id<0x4e14967f20d94a41fa060a9a8b1dd39c57e193747a5c0337db94971d60eb28cb::account::SmartAccount>(arg0), arg2, 0x4e14967f20d94a41fa060a9a8b1dd39c57e193747a5c0337db94971d60eb28cb::account::extract_balance_sheet(arg0, arg2, arg4), arg3, 0x4e14967f20d94a41fa060a9a8b1dd39c57e193747a5c0337db94971d60eb28cb::config::performance_fee_rate(arg1), *0x4e14967f20d94a41fa060a9a8b1dd39c57e193747a5c0337db94971d60eb28cb::strategy::base_asset_types(0x4e14967f20d94a41fa060a9a8b1dd39c57e193747a5c0337db94971d60eb28cb::config::get_strategy_by_name(arg1, arg2)), arg4)
    }

    public fun ticket_supports_asset_type<T0>(arg0: &0x4e14967f20d94a41fa060a9a8b1dd39c57e193747a5c0337db94971d60eb28cb::ticket::AuthorizedTransferTicket) : bool {
        0x4e14967f20d94a41fa060a9a8b1dd39c57e193747a5c0337db94971d60eb28cb::ticket::supports_asset_type<T0>(arg0)
    }

    fun write_policies(arg0: &0x4e14967f20d94a41fa060a9a8b1dd39c57e193747a5c0337db94971d60eb28cb::account::SmartAccount, arg1: &0x4e14967f20d94a41fa060a9a8b1dd39c57e193747a5c0337db94971d60eb28cb::config::GlobalConfig, arg2: &mut 0x4e14967f20d94a41fa060a9a8b1dd39c57e193747a5c0337db94971d60eb28cb::ticket::AuthorizedTransferTicket, arg3: 0x1::string::String) {
        assert!(0x4e14967f20d94a41fa060a9a8b1dd39c57e193747a5c0337db94971d60eb28cb::account::has_strategy_by_name(arg0, arg3), 0x4e14967f20d94a41fa060a9a8b1dd39c57e193747a5c0337db94971d60eb28cb::errors::strategy_not_found());
        let v0 = 0x4e14967f20d94a41fa060a9a8b1dd39c57e193747a5c0337db94971d60eb28cb::account::policies_for_strategy(arg0, arg1, arg3);
        if (!0x1::vector::is_empty<0x4e14967f20d94a41fa060a9a8b1dd39c57e193747a5c0337db94971d60eb28cb::policy::Policy>(&v0)) {
            0x4e14967f20d94a41fa060a9a8b1dd39c57e193747a5c0337db94971d60eb28cb::ticket::set_policies(arg2, arg1, v0);
        };
    }

    // decompiled from Move bytecode v6
}

