module 0xf63d57bbdb810ea1c76b0b66fd9c587baa7b12badd96d451a056c0f314eec5ad::agent {
    public fun add_asset_to_ticket<T0>(arg0: &mut 0xf63d57bbdb810ea1c76b0b66fd9c587baa7b12badd96d451a056c0f314eec5ad::account::SmartAccount, arg1: &mut 0xf63d57bbdb810ea1c76b0b66fd9c587baa7b12badd96d451a056c0f314eec5ad::ticket::AuthorizedTransferTicket, arg2: &0xf63d57bbdb810ea1c76b0b66fd9c587baa7b12badd96d451a056c0f314eec5ad::config::GlobalConfig, arg3: &mut 0x2::tx_context::TxContext) {
        0xf63d57bbdb810ea1c76b0b66fd9c587baa7b12badd96d451a056c0f314eec5ad::config::assert_version_compatibility(arg2);
        assert_ticket_belongs_to_account(arg0, arg1);
        let v0 = 0xf63d57bbdb810ea1c76b0b66fd9c587baa7b12badd96d451a056c0f314eec5ad::ticket::get_strategy_name(arg1);
        0xf63d57bbdb810ea1c76b0b66fd9c587baa7b12badd96d451a056c0f314eec5ad::account::assert_strategy_supports_asset_type<T0>(arg0, v0);
        let v1 = 0xf63d57bbdb810ea1c76b0b66fd9c587baa7b12badd96d451a056c0f314eec5ad::account::balance<T0>(arg0, v0);
        if (v1 > 0) {
            0xf63d57bbdb810ea1c76b0b66fd9c587baa7b12badd96d451a056c0f314eec5ad::ticket::add_coin_internal<T0>(arg1, 0xf63d57bbdb810ea1c76b0b66fd9c587baa7b12badd96d451a056c0f314eec5ad::account::withdraw_internal<T0>(arg0, arg2, v1, v0, arg3));
        };
    }

    public fun add_position_to_ticket<T0: store + key>(arg0: &mut 0xf63d57bbdb810ea1c76b0b66fd9c587baa7b12badd96d451a056c0f314eec5ad::account::SmartAccount, arg1: &mut 0xf63d57bbdb810ea1c76b0b66fd9c587baa7b12badd96d451a056c0f314eec5ad::ticket::AuthorizedTransferTicket, arg2: &0xf63d57bbdb810ea1c76b0b66fd9c587baa7b12badd96d451a056c0f314eec5ad::config::GlobalConfig, arg3: &mut 0x2::tx_context::TxContext) {
        0xf63d57bbdb810ea1c76b0b66fd9c587baa7b12badd96d451a056c0f314eec5ad::config::assert_version_compatibility(arg2);
        assert_ticket_belongs_to_account(arg0, arg1);
        let v0 = 0xf63d57bbdb810ea1c76b0b66fd9c587baa7b12badd96d451a056c0f314eec5ad::ticket::get_strategy_name(arg1);
        if (0xf63d57bbdb810ea1c76b0b66fd9c587baa7b12badd96d451a056c0f314eec5ad::account::has_object_in_strategy<T0>(arg0, v0)) {
            0xf63d57bbdb810ea1c76b0b66fd9c587baa7b12badd96d451a056c0f314eec5ad::ticket::add_object_internal<T0>(arg1, 0xf63d57bbdb810ea1c76b0b66fd9c587baa7b12badd96d451a056c0f314eec5ad::account::withdraw_object_internal<T0>(arg0, arg2, v0));
        };
    }

    fun assert_agent_authorized(arg0: &0xf63d57bbdb810ea1c76b0b66fd9c587baa7b12badd96d451a056c0f314eec5ad::config::GlobalConfig, arg1: &0x2::tx_context::TxContext) {
        0xf63d57bbdb810ea1c76b0b66fd9c587baa7b12badd96d451a056c0f314eec5ad::config::assert_whitelisted_agent(arg0, 0x2::tx_context::sender(arg1));
    }

    fun assert_ticket_belongs_to_account(arg0: &0xf63d57bbdb810ea1c76b0b66fd9c587baa7b12badd96d451a056c0f314eec5ad::account::SmartAccount, arg1: &0xf63d57bbdb810ea1c76b0b66fd9c587baa7b12badd96d451a056c0f314eec5ad::ticket::AuthorizedTransferTicket) {
        0xf63d57bbdb810ea1c76b0b66fd9c587baa7b12badd96d451a056c0f314eec5ad::ticket::assert_belongs_to_account(arg1, 0x2::object::id<0xf63d57bbdb810ea1c76b0b66fd9c587baa7b12badd96d451a056c0f314eec5ad::account::SmartAccount>(arg0));
    }

    public fun burn_ticket(arg0: &mut 0xf63d57bbdb810ea1c76b0b66fd9c587baa7b12badd96d451a056c0f314eec5ad::account::SmartAccount, arg1: 0xf63d57bbdb810ea1c76b0b66fd9c587baa7b12badd96d451a056c0f314eec5ad::ticket::AuthorizedTransferTicket, arg2: &0xf63d57bbdb810ea1c76b0b66fd9c587baa7b12badd96d451a056c0f314eec5ad::config::GlobalConfig, arg3: &mut 0x2::tx_context::TxContext) {
        0xf63d57bbdb810ea1c76b0b66fd9c587baa7b12badd96d451a056c0f314eec5ad::config::assert_version_compatibility(arg2);
        assert_ticket_belongs_to_account(arg0, &arg1);
        consume_policies(arg0, &arg1);
        let v0 = 0xf63d57bbdb810ea1c76b0b66fd9c587baa7b12badd96d451a056c0f314eec5ad::ticket::get_current_adapter(&arg1);
        if (0x1::string::length(&v0) > 0) {
            0xf63d57bbdb810ea1c76b0b66fd9c587baa7b12badd96d451a056c0f314eec5ad::account::set_current_adapter(arg0, arg2, v0);
        };
        0xf63d57bbdb810ea1c76b0b66fd9c587baa7b12badd96d451a056c0f314eec5ad::ticket::burn(arg1, arg0);
    }

    fun consume_policies(arg0: &0xf63d57bbdb810ea1c76b0b66fd9c587baa7b12badd96d451a056c0f314eec5ad::account::SmartAccount, arg1: &0xf63d57bbdb810ea1c76b0b66fd9c587baa7b12badd96d451a056c0f314eec5ad::ticket::AuthorizedTransferTicket) {
        let v0 = 0xf63d57bbdb810ea1c76b0b66fd9c587baa7b12badd96d451a056c0f314eec5ad::ticket::get_policies(arg1);
        let v1 = 0;
        while (v1 < 0x1::vector::length<0xf63d57bbdb810ea1c76b0b66fd9c587baa7b12badd96d451a056c0f314eec5ad::policy::Policy>(v0)) {
            0x1::vector::borrow<0xf63d57bbdb810ea1c76b0b66fd9c587baa7b12badd96d451a056c0f314eec5ad::policy::Policy>(v0, v1);
            v1 = v1 + 1;
        };
    }

    public fun consume_ticket_asset<T0>(arg0: &mut 0xf63d57bbdb810ea1c76b0b66fd9c587baa7b12badd96d451a056c0f314eec5ad::account::SmartAccount, arg1: &mut 0xf63d57bbdb810ea1c76b0b66fd9c587baa7b12badd96d451a056c0f314eec5ad::ticket::AuthorizedTransferTicket, arg2: &0xf63d57bbdb810ea1c76b0b66fd9c587baa7b12badd96d451a056c0f314eec5ad::config::GlobalConfig, arg3: &mut 0x2::tx_context::TxContext) {
        0xf63d57bbdb810ea1c76b0b66fd9c587baa7b12badd96d451a056c0f314eec5ad::config::assert_version_compatibility(arg2);
        assert_ticket_belongs_to_account(arg0, arg1);
        let v0 = 0xf63d57bbdb810ea1c76b0b66fd9c587baa7b12badd96d451a056c0f314eec5ad::ticket::get_strategy_name(arg1);
        if (0xf63d57bbdb810ea1c76b0b66fd9c587baa7b12badd96d451a056c0f314eec5ad::ticket::has_asset_type<T0>(arg1)) {
            let v1 = extract_strategy_base_asset_from_ticket<T0>(arg1, arg3);
            deposit_strategy_base_asset_if_present<T0>(arg0, arg2, v1, v0, arg3);
        };
    }

    public fun consume_ticket_performance_fee<T0>(arg0: &mut 0xf63d57bbdb810ea1c76b0b66fd9c587baa7b12badd96d451a056c0f314eec5ad::ticket::AuthorizedTransferTicket, arg1: &mut 0xf63d57bbdb810ea1c76b0b66fd9c587baa7b12badd96d451a056c0f314eec5ad::config::GlobalConfig, arg2: &mut 0x2::tx_context::TxContext) {
        0xf63d57bbdb810ea1c76b0b66fd9c587baa7b12badd96d451a056c0f314eec5ad::config::assert_version_compatibility(arg1);
        if (0xf63d57bbdb810ea1c76b0b66fd9c587baa7b12badd96d451a056c0f314eec5ad::ticket::has_any_perf_fees(arg0)) {
            if (0xf63d57bbdb810ea1c76b0b66fd9c587baa7b12badd96d451a056c0f314eec5ad::ticket::perf_fee_asset_balance<T0>(arg0) > 0) {
                0xf63d57bbdb810ea1c76b0b66fd9c587baa7b12badd96d451a056c0f314eec5ad::config::collect_performance_fee<T0>(arg1, 0xf63d57bbdb810ea1c76b0b66fd9c587baa7b12badd96d451a056c0f314eec5ad::ticket::withdraw_performance_fee<T0>(arg0, 0xf63d57bbdb810ea1c76b0b66fd9c587baa7b12badd96d451a056c0f314eec5ad::ticket::perf_fee_asset_balance<T0>(arg0), arg2));
            };
        };
    }

    public fun consume_ticket_position<T0: store + key>(arg0: &mut 0xf63d57bbdb810ea1c76b0b66fd9c587baa7b12badd96d451a056c0f314eec5ad::account::SmartAccount, arg1: &mut 0xf63d57bbdb810ea1c76b0b66fd9c587baa7b12badd96d451a056c0f314eec5ad::ticket::AuthorizedTransferTicket, arg2: &0xf63d57bbdb810ea1c76b0b66fd9c587baa7b12badd96d451a056c0f314eec5ad::config::GlobalConfig, arg3: &mut 0x2::tx_context::TxContext) {
        0xf63d57bbdb810ea1c76b0b66fd9c587baa7b12badd96d451a056c0f314eec5ad::config::assert_version_compatibility(arg2);
        assert_ticket_belongs_to_account(arg0, arg1);
        let v0 = 0xf63d57bbdb810ea1c76b0b66fd9c587baa7b12badd96d451a056c0f314eec5ad::ticket::get_strategy_name(arg1);
        if (0xf63d57bbdb810ea1c76b0b66fd9c587baa7b12badd96d451a056c0f314eec5ad::ticket::has_asset_type<T0>(arg1)) {
            deposit_position_if_present<T0>(arg0, arg2, extract_position_from_ticket<T0>(arg1), v0, arg3);
        };
    }

    public fun consume_ticket_reward<T0>(arg0: &mut 0xf63d57bbdb810ea1c76b0b66fd9c587baa7b12badd96d451a056c0f314eec5ad::account::SmartAccount, arg1: &mut 0xf63d57bbdb810ea1c76b0b66fd9c587baa7b12badd96d451a056c0f314eec5ad::ticket::AuthorizedTransferTicket, arg2: &0xf63d57bbdb810ea1c76b0b66fd9c587baa7b12badd96d451a056c0f314eec5ad::config::GlobalConfig, arg3: &mut 0x2::tx_context::TxContext) {
        0xf63d57bbdb810ea1c76b0b66fd9c587baa7b12badd96d451a056c0f314eec5ad::config::assert_version_compatibility(arg2);
        assert_ticket_belongs_to_account(arg0, arg1);
        let v0 = 0xf63d57bbdb810ea1c76b0b66fd9c587baa7b12badd96d451a056c0f314eec5ad::ticket::get_strategy_name(arg1);
        if (0xf63d57bbdb810ea1c76b0b66fd9c587baa7b12badd96d451a056c0f314eec5ad::ticket::has_reward_type<T0>(arg1)) {
            let v1 = extract_rewards_from_ticket<T0>(arg1, arg3);
            deposit_rewards_if_present<T0>(arg0, arg2, v1, v0, arg3);
        };
    }

    fun deposit_position_if_present<T0: store + key>(arg0: &mut 0xf63d57bbdb810ea1c76b0b66fd9c587baa7b12badd96d451a056c0f314eec5ad::account::SmartAccount, arg1: &0xf63d57bbdb810ea1c76b0b66fd9c587baa7b12badd96d451a056c0f314eec5ad::config::GlobalConfig, arg2: 0x1::option::Option<T0>, arg3: 0x1::string::String, arg4: &mut 0x2::tx_context::TxContext) {
        if (0x1::option::is_some<T0>(&arg2)) {
            0xf63d57bbdb810ea1c76b0b66fd9c587baa7b12badd96d451a056c0f314eec5ad::account::deposit_object_internal<T0>(arg0, arg1, 0x1::option::destroy_some<T0>(arg2), arg3, arg4);
        } else {
            0x1::option::destroy_none<T0>(arg2);
        };
    }

    fun deposit_rewards_if_present<T0>(arg0: &mut 0xf63d57bbdb810ea1c76b0b66fd9c587baa7b12badd96d451a056c0f314eec5ad::account::SmartAccount, arg1: &0xf63d57bbdb810ea1c76b0b66fd9c587baa7b12badd96d451a056c0f314eec5ad::config::GlobalConfig, arg2: 0x1::option::Option<0x2::coin::Coin<T0>>, arg3: 0x1::string::String, arg4: &mut 0x2::tx_context::TxContext) {
        if (0x1::option::is_some<0x2::coin::Coin<T0>>(&arg2)) {
            0xf63d57bbdb810ea1c76b0b66fd9c587baa7b12badd96d451a056c0f314eec5ad::account::deposit_rewards_internal<T0>(arg0, arg1, 0x2::coin::into_balance<T0>(0x1::option::destroy_some<0x2::coin::Coin<T0>>(arg2)), arg3, arg4);
        } else {
            0x1::option::destroy_none<0x2::coin::Coin<T0>>(arg2);
        };
    }

    fun deposit_strategy_base_asset_if_present<T0>(arg0: &mut 0xf63d57bbdb810ea1c76b0b66fd9c587baa7b12badd96d451a056c0f314eec5ad::account::SmartAccount, arg1: &0xf63d57bbdb810ea1c76b0b66fd9c587baa7b12badd96d451a056c0f314eec5ad::config::GlobalConfig, arg2: 0x1::option::Option<0x2::coin::Coin<T0>>, arg3: 0x1::string::String, arg4: &mut 0x2::tx_context::TxContext) {
        if (0x1::option::is_some<0x2::coin::Coin<T0>>(&arg2)) {
            0xf63d57bbdb810ea1c76b0b66fd9c587baa7b12badd96d451a056c0f314eec5ad::account::deposit_internal<T0>(arg0, arg1, 0x1::option::destroy_some<0x2::coin::Coin<T0>>(arg2), arg3, arg4);
        } else {
            0x1::option::destroy_none<0x2::coin::Coin<T0>>(arg2);
        };
    }

    fun extract_position_from_ticket<T0: store + key>(arg0: &mut 0xf63d57bbdb810ea1c76b0b66fd9c587baa7b12badd96d451a056c0f314eec5ad::ticket::AuthorizedTransferTicket) : 0x1::option::Option<T0> {
        if (0xf63d57bbdb810ea1c76b0b66fd9c587baa7b12badd96d451a056c0f314eec5ad::ticket::has_asset_type<T0>(arg0)) {
            0x1::option::some<T0>(0xf63d57bbdb810ea1c76b0b66fd9c587baa7b12badd96d451a056c0f314eec5ad::ticket::withdraw_object_internal<T0>(arg0))
        } else {
            0x1::option::none<T0>()
        }
    }

    fun extract_rewards_from_ticket<T0>(arg0: &mut 0xf63d57bbdb810ea1c76b0b66fd9c587baa7b12badd96d451a056c0f314eec5ad::ticket::AuthorizedTransferTicket, arg1: &mut 0x2::tx_context::TxContext) : 0x1::option::Option<0x2::coin::Coin<T0>> {
        if (0xf63d57bbdb810ea1c76b0b66fd9c587baa7b12badd96d451a056c0f314eec5ad::ticket::has_reward_type<T0>(arg0)) {
            0x1::option::some<0x2::coin::Coin<T0>>(0xf63d57bbdb810ea1c76b0b66fd9c587baa7b12badd96d451a056c0f314eec5ad::ticket::withdraw_reward_internal<T0>(arg0, 0xf63d57bbdb810ea1c76b0b66fd9c587baa7b12badd96d451a056c0f314eec5ad::ticket::reward_balance<T0>(arg0), arg1))
        } else {
            0x1::option::none<0x2::coin::Coin<T0>>()
        }
    }

    fun extract_strategy_base_asset_from_ticket<T0>(arg0: &mut 0xf63d57bbdb810ea1c76b0b66fd9c587baa7b12badd96d451a056c0f314eec5ad::ticket::AuthorizedTransferTicket, arg1: &mut 0x2::tx_context::TxContext) : 0x1::option::Option<0x2::coin::Coin<T0>> {
        if (0xf63d57bbdb810ea1c76b0b66fd9c587baa7b12badd96d451a056c0f314eec5ad::ticket::has_asset_type<T0>(arg0)) {
            0x1::option::some<0x2::coin::Coin<T0>>(0xf63d57bbdb810ea1c76b0b66fd9c587baa7b12badd96d451a056c0f314eec5ad::ticket::withdraw_coin_internal<T0>(arg0, 0xf63d57bbdb810ea1c76b0b66fd9c587baa7b12badd96d451a056c0f314eec5ad::ticket::asset_balance<T0>(arg0), arg1))
        } else {
            0x1::option::none<0x2::coin::Coin<T0>>()
        }
    }

    public fun get_ticket_asset_keys(arg0: &0xf63d57bbdb810ea1c76b0b66fd9c587baa7b12badd96d451a056c0f314eec5ad::ticket::AuthorizedTransferTicket) : &vector<0xf63d57bbdb810ea1c76b0b66fd9c587baa7b12badd96d451a056c0f314eec5ad::asset_store::AssetKey> {
        0xf63d57bbdb810ea1c76b0b66fd9c587baa7b12badd96d451a056c0f314eec5ad::ticket::get_asset_keys(arg0)
    }

    public fun get_ticket_reward_keys(arg0: &0xf63d57bbdb810ea1c76b0b66fd9c587baa7b12badd96d451a056c0f314eec5ad::ticket::AuthorizedTransferTicket) : &vector<0xf63d57bbdb810ea1c76b0b66fd9c587baa7b12badd96d451a056c0f314eec5ad::asset_store::RewardKey> {
        0xf63d57bbdb810ea1c76b0b66fd9c587baa7b12badd96d451a056c0f314eec5ad::ticket::get_reward_keys(arg0)
    }

    public fun has_ticket_asset_type<T0>(arg0: &0xf63d57bbdb810ea1c76b0b66fd9c587baa7b12badd96d451a056c0f314eec5ad::ticket::AuthorizedTransferTicket) : bool {
        0xf63d57bbdb810ea1c76b0b66fd9c587baa7b12badd96d451a056c0f314eec5ad::ticket::has_asset_type<T0>(arg0)
    }

    public fun has_ticket_reward_type<T0>(arg0: &0xf63d57bbdb810ea1c76b0b66fd9c587baa7b12badd96d451a056c0f314eec5ad::ticket::AuthorizedTransferTicket) : bool {
        0xf63d57bbdb810ea1c76b0b66fd9c587baa7b12badd96d451a056c0f314eec5ad::ticket::has_reward_type<T0>(arg0)
    }

    public fun issue_ticket(arg0: &mut 0xf63d57bbdb810ea1c76b0b66fd9c587baa7b12badd96d451a056c0f314eec5ad::account::SmartAccount, arg1: &0xf63d57bbdb810ea1c76b0b66fd9c587baa7b12badd96d451a056c0f314eec5ad::config::GlobalConfig, arg2: 0x1::string::String, arg3: &mut 0x2::tx_context::TxContext) : 0xf63d57bbdb810ea1c76b0b66fd9c587baa7b12badd96d451a056c0f314eec5ad::ticket::AuthorizedTransferTicket {
        0xf63d57bbdb810ea1c76b0b66fd9c587baa7b12badd96d451a056c0f314eec5ad::config::assert_version_compatibility(arg1);
        assert_agent_authorized(arg1, arg3);
        let v0 = mint_ticket(arg0, arg1, arg2, true, arg3);
        let v1 = &mut v0;
        write_policies(arg0, arg1, v1, arg2);
        0xf63d57bbdb810ea1c76b0b66fd9c587baa7b12badd96d451a056c0f314eec5ad::ticket::set_current_adapter(&mut v0, arg1, *0xf63d57bbdb810ea1c76b0b66fd9c587baa7b12badd96d451a056c0f314eec5ad::account::current_adapter(arg0));
        v0
    }

    public fun issue_ticket_as_owner(arg0: &mut 0xf63d57bbdb810ea1c76b0b66fd9c587baa7b12badd96d451a056c0f314eec5ad::account::SmartAccount, arg1: &0xf63d57bbdb810ea1c76b0b66fd9c587baa7b12badd96d451a056c0f314eec5ad::account::AccountOwnerCap, arg2: &0xf63d57bbdb810ea1c76b0b66fd9c587baa7b12badd96d451a056c0f314eec5ad::config::GlobalConfig, arg3: 0x1::string::String, arg4: &mut 0x2::tx_context::TxContext) : 0xf63d57bbdb810ea1c76b0b66fd9c587baa7b12badd96d451a056c0f314eec5ad::ticket::AuthorizedTransferTicket {
        0xf63d57bbdb810ea1c76b0b66fd9c587baa7b12badd96d451a056c0f314eec5ad::config::assert_version_compatibility(arg2);
        0xf63d57bbdb810ea1c76b0b66fd9c587baa7b12badd96d451a056c0f314eec5ad::account::assert_account_owner(arg0, arg1);
        let v0 = mint_ticket(arg0, arg2, arg3, false, arg4);
        let v1 = &mut v0;
        write_policies(arg0, arg2, v1, arg3);
        0xf63d57bbdb810ea1c76b0b66fd9c587baa7b12badd96d451a056c0f314eec5ad::ticket::set_current_adapter(&mut v0, arg2, *0xf63d57bbdb810ea1c76b0b66fd9c587baa7b12badd96d451a056c0f314eec5ad::account::current_adapter(arg0));
        v0
    }

    fun mint_ticket(arg0: &mut 0xf63d57bbdb810ea1c76b0b66fd9c587baa7b12badd96d451a056c0f314eec5ad::account::SmartAccount, arg1: &0xf63d57bbdb810ea1c76b0b66fd9c587baa7b12badd96d451a056c0f314eec5ad::config::GlobalConfig, arg2: 0x1::string::String, arg3: bool, arg4: &mut 0x2::tx_context::TxContext) : 0xf63d57bbdb810ea1c76b0b66fd9c587baa7b12badd96d451a056c0f314eec5ad::ticket::AuthorizedTransferTicket {
        0xf63d57bbdb810ea1c76b0b66fd9c587baa7b12badd96d451a056c0f314eec5ad::ticket::issue(0x2::object::id<0xf63d57bbdb810ea1c76b0b66fd9c587baa7b12badd96d451a056c0f314eec5ad::account::SmartAccount>(arg0), arg2, 0xf63d57bbdb810ea1c76b0b66fd9c587baa7b12badd96d451a056c0f314eec5ad::account::extract_balance_sheet(arg0, arg2, arg4), arg3, 0xf63d57bbdb810ea1c76b0b66fd9c587baa7b12badd96d451a056c0f314eec5ad::config::performance_fee_rate(arg1), arg4)
    }

    fun write_policies(arg0: &0xf63d57bbdb810ea1c76b0b66fd9c587baa7b12badd96d451a056c0f314eec5ad::account::SmartAccount, arg1: &0xf63d57bbdb810ea1c76b0b66fd9c587baa7b12badd96d451a056c0f314eec5ad::config::GlobalConfig, arg2: &mut 0xf63d57bbdb810ea1c76b0b66fd9c587baa7b12badd96d451a056c0f314eec5ad::ticket::AuthorizedTransferTicket, arg3: 0x1::string::String) {
        assert!(0xf63d57bbdb810ea1c76b0b66fd9c587baa7b12badd96d451a056c0f314eec5ad::account::has_strategy_by_name(arg0, arg3), 0xf63d57bbdb810ea1c76b0b66fd9c587baa7b12badd96d451a056c0f314eec5ad::errors::strategy_not_found());
        let v0 = 0xf63d57bbdb810ea1c76b0b66fd9c587baa7b12badd96d451a056c0f314eec5ad::account::policies_for_strategy(arg0, arg1, arg3);
        if (!0x1::vector::is_empty<0xf63d57bbdb810ea1c76b0b66fd9c587baa7b12badd96d451a056c0f314eec5ad::policy::Policy>(&v0)) {
            0xf63d57bbdb810ea1c76b0b66fd9c587baa7b12badd96d451a056c0f314eec5ad::ticket::set_policies(arg2, arg1, v0);
        };
    }

    // decompiled from Move bytecode v6
}

