module 0x996f3afafbd1dad037b35389b9d8eb8ee1ead9319b96294f006ca4ac174ac675::agent {
    public fun add_asset_to_ticket<T0>(arg0: &mut 0x996f3afafbd1dad037b35389b9d8eb8ee1ead9319b96294f006ca4ac174ac675::account::SmartAccount, arg1: &mut 0x996f3afafbd1dad037b35389b9d8eb8ee1ead9319b96294f006ca4ac174ac675::ticket::AuthorizedTransferTicket, arg2: &0x996f3afafbd1dad037b35389b9d8eb8ee1ead9319b96294f006ca4ac174ac675::acl::SmartAccountAcl, arg3: &0x996f3afafbd1dad037b35389b9d8eb8ee1ead9319b96294f006ca4ac174ac675::config::GlobalConfig, arg4: &mut 0x2::tx_context::TxContext) {
        assert_agent_authorized(arg3, arg4);
        0x996f3afafbd1dad037b35389b9d8eb8ee1ead9319b96294f006ca4ac174ac675::ticket::assert_belongs_to_account(arg1, 0x2::object::id<0x996f3afafbd1dad037b35389b9d8eb8ee1ead9319b96294f006ca4ac174ac675::account::SmartAccount>(arg0));
        let v0 = 0x996f3afafbd1dad037b35389b9d8eb8ee1ead9319b96294f006ca4ac174ac675::ticket::get_strategy_name(arg1);
        0x996f3afafbd1dad037b35389b9d8eb8ee1ead9319b96294f006ca4ac174ac675::account::assert_strategy_supports_asset_type<T0>(arg0, v0);
        let v1 = 0x996f3afafbd1dad037b35389b9d8eb8ee1ead9319b96294f006ca4ac174ac675::account::balance<T0>(arg0, v0);
        if (v1 > 0) {
            0x996f3afafbd1dad037b35389b9d8eb8ee1ead9319b96294f006ca4ac174ac675::ticket::add_coin_internal<T0, 0x996f3afafbd1dad037b35389b9d8eb8ee1ead9319b96294f006ca4ac174ac675::acl::SmartAccountAcl>(arg1, arg2, 0x996f3afafbd1dad037b35389b9d8eb8ee1ead9319b96294f006ca4ac174ac675::account::withdraw_internal<T0>(arg0, v1, v0, arg4));
        };
    }

    public fun add_position_to_ticket<T0: store + key>(arg0: &mut 0x996f3afafbd1dad037b35389b9d8eb8ee1ead9319b96294f006ca4ac174ac675::account::SmartAccount, arg1: &mut 0x996f3afafbd1dad037b35389b9d8eb8ee1ead9319b96294f006ca4ac174ac675::ticket::AuthorizedTransferTicket, arg2: &0x996f3afafbd1dad037b35389b9d8eb8ee1ead9319b96294f006ca4ac174ac675::acl::SmartAccountAcl, arg3: &0x996f3afafbd1dad037b35389b9d8eb8ee1ead9319b96294f006ca4ac174ac675::config::GlobalConfig, arg4: &mut 0x2::tx_context::TxContext) {
        assert_agent_authorized(arg3, arg4);
        0x996f3afafbd1dad037b35389b9d8eb8ee1ead9319b96294f006ca4ac174ac675::ticket::assert_belongs_to_account(arg1, 0x2::object::id<0x996f3afafbd1dad037b35389b9d8eb8ee1ead9319b96294f006ca4ac174ac675::account::SmartAccount>(arg0));
        let v0 = 0x996f3afafbd1dad037b35389b9d8eb8ee1ead9319b96294f006ca4ac174ac675::ticket::get_strategy_name(arg1);
        if (0x996f3afafbd1dad037b35389b9d8eb8ee1ead9319b96294f006ca4ac174ac675::account::has_object_in_strategy<T0>(arg0, v0)) {
            0x996f3afafbd1dad037b35389b9d8eb8ee1ead9319b96294f006ca4ac174ac675::ticket::add_object_internal<T0, 0x996f3afafbd1dad037b35389b9d8eb8ee1ead9319b96294f006ca4ac174ac675::acl::SmartAccountAcl>(arg1, arg2, 0x996f3afafbd1dad037b35389b9d8eb8ee1ead9319b96294f006ca4ac174ac675::account::withdraw_object_internal<T0>(arg0, v0));
        };
    }

    fun assert_agent_authorized(arg0: &0x996f3afafbd1dad037b35389b9d8eb8ee1ead9319b96294f006ca4ac174ac675::config::GlobalConfig, arg1: &0x2::tx_context::TxContext) {
        0x996f3afafbd1dad037b35389b9d8eb8ee1ead9319b96294f006ca4ac174ac675::config::assert_whitelisted_agent(arg0, 0x2::tx_context::sender(arg1));
    }

    public fun burn_ticket(arg0: &mut 0x996f3afafbd1dad037b35389b9d8eb8ee1ead9319b96294f006ca4ac174ac675::account::SmartAccount, arg1: 0x996f3afafbd1dad037b35389b9d8eb8ee1ead9319b96294f006ca4ac174ac675::ticket::AuthorizedTransferTicket, arg2: &0x996f3afafbd1dad037b35389b9d8eb8ee1ead9319b96294f006ca4ac174ac675::acl::SmartAccountAcl, arg3: &0x996f3afafbd1dad037b35389b9d8eb8ee1ead9319b96294f006ca4ac174ac675::config::GlobalConfig, arg4: &mut 0x2::tx_context::TxContext) {
        assert_agent_authorized(arg3, arg4);
        0x996f3afafbd1dad037b35389b9d8eb8ee1ead9319b96294f006ca4ac174ac675::ticket::assert_belongs_to_account(&arg1, 0x2::object::id<0x996f3afafbd1dad037b35389b9d8eb8ee1ead9319b96294f006ca4ac174ac675::account::SmartAccount>(arg0));
        consume_policies(arg0, &arg1);
        let v0 = 0x996f3afafbd1dad037b35389b9d8eb8ee1ead9319b96294f006ca4ac174ac675::ticket::get_last_policy_consumed(&arg1);
        if (0x1::option::is_some<0x996f3afafbd1dad037b35389b9d8eb8ee1ead9319b96294f006ca4ac174ac675::policy::Policy>(&v0)) {
            let v1 = &mut arg1;
            set_last_policy_if_present(arg0, extract_last_policy_from_ticket(v1, arg2));
        };
        0x996f3afafbd1dad037b35389b9d8eb8ee1ead9319b96294f006ca4ac174ac675::ticket::burn(arg1);
    }

    fun consume_policies(arg0: &0x996f3afafbd1dad037b35389b9d8eb8ee1ead9319b96294f006ca4ac174ac675::account::SmartAccount, arg1: &0x996f3afafbd1dad037b35389b9d8eb8ee1ead9319b96294f006ca4ac174ac675::ticket::AuthorizedTransferTicket) {
        let v0 = 0x996f3afafbd1dad037b35389b9d8eb8ee1ead9319b96294f006ca4ac174ac675::ticket::get_policies(arg1);
        let v1 = 0;
        while (v1 < 0x1::vector::length<0x996f3afafbd1dad037b35389b9d8eb8ee1ead9319b96294f006ca4ac174ac675::policy::Policy>(v0)) {
            0x1::vector::borrow<0x996f3afafbd1dad037b35389b9d8eb8ee1ead9319b96294f006ca4ac174ac675::policy::Policy>(v0, v1);
            v1 = v1 + 1;
        };
    }

    public fun consume_ticket_asset<T0>(arg0: &mut 0x996f3afafbd1dad037b35389b9d8eb8ee1ead9319b96294f006ca4ac174ac675::account::SmartAccount, arg1: &mut 0x996f3afafbd1dad037b35389b9d8eb8ee1ead9319b96294f006ca4ac174ac675::ticket::AuthorizedTransferTicket, arg2: &0x996f3afafbd1dad037b35389b9d8eb8ee1ead9319b96294f006ca4ac174ac675::acl::SmartAccountAcl, arg3: &0x996f3afafbd1dad037b35389b9d8eb8ee1ead9319b96294f006ca4ac174ac675::config::GlobalConfig, arg4: &mut 0x2::tx_context::TxContext) {
        assert_agent_authorized(arg3, arg4);
        0x996f3afafbd1dad037b35389b9d8eb8ee1ead9319b96294f006ca4ac174ac675::ticket::assert_belongs_to_account(arg1, 0x2::object::id<0x996f3afafbd1dad037b35389b9d8eb8ee1ead9319b96294f006ca4ac174ac675::account::SmartAccount>(arg0));
        let v0 = 0x996f3afafbd1dad037b35389b9d8eb8ee1ead9319b96294f006ca4ac174ac675::ticket::get_strategy_name(arg1);
        if (0x996f3afafbd1dad037b35389b9d8eb8ee1ead9319b96294f006ca4ac174ac675::ticket::has_asset_type<T0>(arg1)) {
            let v1 = extract_strategy_base_asset_from_ticket<T0>(arg1, arg2, arg4);
            deposit_strategy_base_asset_if_present<T0>(arg0, v1, v0, arg4);
        };
    }

    public fun consume_ticket_position<T0: store + key>(arg0: &mut 0x996f3afafbd1dad037b35389b9d8eb8ee1ead9319b96294f006ca4ac174ac675::account::SmartAccount, arg1: &mut 0x996f3afafbd1dad037b35389b9d8eb8ee1ead9319b96294f006ca4ac174ac675::ticket::AuthorizedTransferTicket, arg2: &0x996f3afafbd1dad037b35389b9d8eb8ee1ead9319b96294f006ca4ac174ac675::acl::SmartAccountAcl, arg3: &0x996f3afafbd1dad037b35389b9d8eb8ee1ead9319b96294f006ca4ac174ac675::config::GlobalConfig, arg4: &mut 0x2::tx_context::TxContext) {
        assert_agent_authorized(arg3, arg4);
        0x996f3afafbd1dad037b35389b9d8eb8ee1ead9319b96294f006ca4ac174ac675::ticket::assert_belongs_to_account(arg1, 0x2::object::id<0x996f3afafbd1dad037b35389b9d8eb8ee1ead9319b96294f006ca4ac174ac675::account::SmartAccount>(arg0));
        let v0 = 0x996f3afafbd1dad037b35389b9d8eb8ee1ead9319b96294f006ca4ac174ac675::ticket::get_strategy_name(arg1);
        if (0x996f3afafbd1dad037b35389b9d8eb8ee1ead9319b96294f006ca4ac174ac675::ticket::has_asset_type<T0>(arg1)) {
            deposit_position_if_present<T0>(arg0, extract_position_from_ticket<T0>(arg1, arg2), v0, arg4);
        };
    }

    public fun consume_ticket_reward<T0>(arg0: &mut 0x996f3afafbd1dad037b35389b9d8eb8ee1ead9319b96294f006ca4ac174ac675::account::SmartAccount, arg1: &mut 0x996f3afafbd1dad037b35389b9d8eb8ee1ead9319b96294f006ca4ac174ac675::ticket::AuthorizedTransferTicket, arg2: &0x996f3afafbd1dad037b35389b9d8eb8ee1ead9319b96294f006ca4ac174ac675::acl::SmartAccountAcl, arg3: &0x996f3afafbd1dad037b35389b9d8eb8ee1ead9319b96294f006ca4ac174ac675::config::GlobalConfig, arg4: &mut 0x2::tx_context::TxContext) {
        assert_agent_authorized(arg3, arg4);
        0x996f3afafbd1dad037b35389b9d8eb8ee1ead9319b96294f006ca4ac174ac675::ticket::assert_belongs_to_account(arg1, 0x2::object::id<0x996f3afafbd1dad037b35389b9d8eb8ee1ead9319b96294f006ca4ac174ac675::account::SmartAccount>(arg0));
        let v0 = 0x996f3afafbd1dad037b35389b9d8eb8ee1ead9319b96294f006ca4ac174ac675::ticket::get_strategy_name(arg1);
        if (0x996f3afafbd1dad037b35389b9d8eb8ee1ead9319b96294f006ca4ac174ac675::ticket::has_reward_type<T0>(arg1)) {
            let v1 = extract_rewards_from_ticket<T0>(arg1, arg2, arg4);
            deposit_rewards_if_present<T0>(arg0, v1, v0, arg4);
        };
    }

    fun deposit_position_if_present<T0: store + key>(arg0: &mut 0x996f3afafbd1dad037b35389b9d8eb8ee1ead9319b96294f006ca4ac174ac675::account::SmartAccount, arg1: 0x1::option::Option<T0>, arg2: 0x1::string::String, arg3: &mut 0x2::tx_context::TxContext) {
        if (0x1::option::is_some<T0>(&arg1)) {
            0x996f3afafbd1dad037b35389b9d8eb8ee1ead9319b96294f006ca4ac174ac675::account::deposit_object_internal<T0>(arg0, 0x1::option::destroy_some<T0>(arg1), arg2, arg3);
        } else {
            0x1::option::destroy_none<T0>(arg1);
        };
    }

    fun deposit_rewards_if_present<T0>(arg0: &mut 0x996f3afafbd1dad037b35389b9d8eb8ee1ead9319b96294f006ca4ac174ac675::account::SmartAccount, arg1: 0x1::option::Option<0x2::coin::Coin<T0>>, arg2: 0x1::string::String, arg3: &mut 0x2::tx_context::TxContext) {
        if (0x1::option::is_some<0x2::coin::Coin<T0>>(&arg1)) {
            0x996f3afafbd1dad037b35389b9d8eb8ee1ead9319b96294f006ca4ac174ac675::account::deposit_rewards_internal<T0>(arg0, 0x2::coin::into_balance<T0>(0x1::option::destroy_some<0x2::coin::Coin<T0>>(arg1)), arg2, arg3);
        } else {
            0x1::option::destroy_none<0x2::coin::Coin<T0>>(arg1);
        };
    }

    fun deposit_strategy_base_asset_if_present<T0>(arg0: &mut 0x996f3afafbd1dad037b35389b9d8eb8ee1ead9319b96294f006ca4ac174ac675::account::SmartAccount, arg1: 0x1::option::Option<0x2::coin::Coin<T0>>, arg2: 0x1::string::String, arg3: &mut 0x2::tx_context::TxContext) {
        if (0x1::option::is_some<0x2::coin::Coin<T0>>(&arg1)) {
            0x996f3afafbd1dad037b35389b9d8eb8ee1ead9319b96294f006ca4ac174ac675::account::deposit_internal<T0>(arg0, 0x1::option::destroy_some<0x2::coin::Coin<T0>>(arg1), arg2, arg3);
        } else {
            0x1::option::destroy_none<0x2::coin::Coin<T0>>(arg1);
        };
    }

    fun extract_last_policy_from_ticket(arg0: &mut 0x996f3afafbd1dad037b35389b9d8eb8ee1ead9319b96294f006ca4ac174ac675::ticket::AuthorizedTransferTicket, arg1: &0x996f3afafbd1dad037b35389b9d8eb8ee1ead9319b96294f006ca4ac174ac675::acl::SmartAccountAcl) : 0x1::option::Option<0x996f3afafbd1dad037b35389b9d8eb8ee1ead9319b96294f006ca4ac174ac675::policy::Policy> {
        0x996f3afafbd1dad037b35389b9d8eb8ee1ead9319b96294f006ca4ac174ac675::ticket::set_last_policy_consumed(arg0, 0x1::option::none<0x996f3afafbd1dad037b35389b9d8eb8ee1ead9319b96294f006ca4ac174ac675::policy::Policy>());
        0x996f3afafbd1dad037b35389b9d8eb8ee1ead9319b96294f006ca4ac174ac675::ticket::get_last_policy_consumed(arg0)
    }

    fun extract_position_from_ticket<T0: store + key>(arg0: &mut 0x996f3afafbd1dad037b35389b9d8eb8ee1ead9319b96294f006ca4ac174ac675::ticket::AuthorizedTransferTicket, arg1: &0x996f3afafbd1dad037b35389b9d8eb8ee1ead9319b96294f006ca4ac174ac675::acl::SmartAccountAcl) : 0x1::option::Option<T0> {
        if (0x996f3afafbd1dad037b35389b9d8eb8ee1ead9319b96294f006ca4ac174ac675::ticket::has_asset_type<T0>(arg0)) {
            0x1::option::some<T0>(0x996f3afafbd1dad037b35389b9d8eb8ee1ead9319b96294f006ca4ac174ac675::ticket::withdraw_object_internal<T0, 0x996f3afafbd1dad037b35389b9d8eb8ee1ead9319b96294f006ca4ac174ac675::acl::SmartAccountAcl>(arg0, arg1))
        } else {
            0x1::option::none<T0>()
        }
    }

    fun extract_rewards_from_ticket<T0>(arg0: &mut 0x996f3afafbd1dad037b35389b9d8eb8ee1ead9319b96294f006ca4ac174ac675::ticket::AuthorizedTransferTicket, arg1: &0x996f3afafbd1dad037b35389b9d8eb8ee1ead9319b96294f006ca4ac174ac675::acl::SmartAccountAcl, arg2: &mut 0x2::tx_context::TxContext) : 0x1::option::Option<0x2::coin::Coin<T0>> {
        if (0x996f3afafbd1dad037b35389b9d8eb8ee1ead9319b96294f006ca4ac174ac675::ticket::has_reward_type<T0>(arg0)) {
            0x1::option::some<0x2::coin::Coin<T0>>(0x996f3afafbd1dad037b35389b9d8eb8ee1ead9319b96294f006ca4ac174ac675::ticket::withdraw_reward_internal<T0, 0x996f3afafbd1dad037b35389b9d8eb8ee1ead9319b96294f006ca4ac174ac675::acl::SmartAccountAcl>(arg0, arg1, 0x996f3afafbd1dad037b35389b9d8eb8ee1ead9319b96294f006ca4ac174ac675::ticket::reward_balance<T0>(arg0), arg2))
        } else {
            0x1::option::none<0x2::coin::Coin<T0>>()
        }
    }

    fun extract_strategy_base_asset_from_ticket<T0>(arg0: &mut 0x996f3afafbd1dad037b35389b9d8eb8ee1ead9319b96294f006ca4ac174ac675::ticket::AuthorizedTransferTicket, arg1: &0x996f3afafbd1dad037b35389b9d8eb8ee1ead9319b96294f006ca4ac174ac675::acl::SmartAccountAcl, arg2: &mut 0x2::tx_context::TxContext) : 0x1::option::Option<0x2::coin::Coin<T0>> {
        if (0x996f3afafbd1dad037b35389b9d8eb8ee1ead9319b96294f006ca4ac174ac675::ticket::has_asset_type<T0>(arg0)) {
            0x1::option::some<0x2::coin::Coin<T0>>(0x996f3afafbd1dad037b35389b9d8eb8ee1ead9319b96294f006ca4ac174ac675::ticket::withdraw_coin_internal<T0, 0x996f3afafbd1dad037b35389b9d8eb8ee1ead9319b96294f006ca4ac174ac675::acl::SmartAccountAcl>(arg0, arg1, 0x996f3afafbd1dad037b35389b9d8eb8ee1ead9319b96294f006ca4ac174ac675::ticket::asset_balance<T0>(arg0), arg2))
        } else {
            0x1::option::none<0x2::coin::Coin<T0>>()
        }
    }

    public fun get_ticket_asset_keys(arg0: &0x996f3afafbd1dad037b35389b9d8eb8ee1ead9319b96294f006ca4ac174ac675::ticket::AuthorizedTransferTicket) : &vector<0x996f3afafbd1dad037b35389b9d8eb8ee1ead9319b96294f006ca4ac174ac675::asset_store::AssetKey> {
        0x996f3afafbd1dad037b35389b9d8eb8ee1ead9319b96294f006ca4ac174ac675::ticket::get_asset_keys(arg0)
    }

    public fun get_ticket_reward_keys(arg0: &0x996f3afafbd1dad037b35389b9d8eb8ee1ead9319b96294f006ca4ac174ac675::ticket::AuthorizedTransferTicket) : &vector<0x996f3afafbd1dad037b35389b9d8eb8ee1ead9319b96294f006ca4ac174ac675::asset_store::RewardKey> {
        0x996f3afafbd1dad037b35389b9d8eb8ee1ead9319b96294f006ca4ac174ac675::ticket::get_reward_keys(arg0)
    }

    public fun has_ticket_asset_type<T0>(arg0: &0x996f3afafbd1dad037b35389b9d8eb8ee1ead9319b96294f006ca4ac174ac675::ticket::AuthorizedTransferTicket) : bool {
        0x996f3afafbd1dad037b35389b9d8eb8ee1ead9319b96294f006ca4ac174ac675::ticket::has_asset_type<T0>(arg0)
    }

    public fun has_ticket_reward_type<T0>(arg0: &0x996f3afafbd1dad037b35389b9d8eb8ee1ead9319b96294f006ca4ac174ac675::ticket::AuthorizedTransferTicket) : bool {
        0x996f3afafbd1dad037b35389b9d8eb8ee1ead9319b96294f006ca4ac174ac675::ticket::has_reward_type<T0>(arg0)
    }

    public fun issue_ticket(arg0: &mut 0x996f3afafbd1dad037b35389b9d8eb8ee1ead9319b96294f006ca4ac174ac675::account::SmartAccount, arg1: &0x996f3afafbd1dad037b35389b9d8eb8ee1ead9319b96294f006ca4ac174ac675::config::GlobalConfig, arg2: 0x2::object::ID, arg3: &0x996f3afafbd1dad037b35389b9d8eb8ee1ead9319b96294f006ca4ac174ac675::acl::SmartAccountAcl, arg4: 0x1::string::String, arg5: &mut 0x2::tx_context::TxContext) : 0x996f3afafbd1dad037b35389b9d8eb8ee1ead9319b96294f006ca4ac174ac675::ticket::AuthorizedTransferTicket {
        assert_agent_authorized(arg1, arg5);
        let v0 = mint_ticket(arg0, arg2, arg3, arg4, arg5);
        let v1 = &mut v0;
        write_policies(arg0, arg1, v1, arg4);
        0x996f3afafbd1dad037b35389b9d8eb8ee1ead9319b96294f006ca4ac174ac675::ticket::set_last_policy_consumed(&mut v0, *0x996f3afafbd1dad037b35389b9d8eb8ee1ead9319b96294f006ca4ac174ac675::account::last_policy_consumed(arg0));
        v0
    }

    fun mint_ticket(arg0: &0x996f3afafbd1dad037b35389b9d8eb8ee1ead9319b96294f006ca4ac174ac675::account::SmartAccount, arg1: 0x2::object::ID, arg2: &0x996f3afafbd1dad037b35389b9d8eb8ee1ead9319b96294f006ca4ac174ac675::acl::SmartAccountAcl, arg3: 0x1::string::String, arg4: &mut 0x2::tx_context::TxContext) : 0x996f3afafbd1dad037b35389b9d8eb8ee1ead9319b96294f006ca4ac174ac675::ticket::AuthorizedTransferTicket {
        0x996f3afafbd1dad037b35389b9d8eb8ee1ead9319b96294f006ca4ac174ac675::ticket::issue(arg1, 0x2::object::id<0x996f3afafbd1dad037b35389b9d8eb8ee1ead9319b96294f006ca4ac174ac675::acl::SmartAccountAcl>(arg2), 0x2::object::id<0x996f3afafbd1dad037b35389b9d8eb8ee1ead9319b96294f006ca4ac174ac675::account::SmartAccount>(arg0), arg3, arg4)
    }

    fun set_last_policy_if_present(arg0: &mut 0x996f3afafbd1dad037b35389b9d8eb8ee1ead9319b96294f006ca4ac174ac675::account::SmartAccount, arg1: 0x1::option::Option<0x996f3afafbd1dad037b35389b9d8eb8ee1ead9319b96294f006ca4ac174ac675::policy::Policy>) {
        0x996f3afafbd1dad037b35389b9d8eb8ee1ead9319b96294f006ca4ac174ac675::account::set_last_policy_consumed(arg0, arg1);
    }

    fun write_policies(arg0: &0x996f3afafbd1dad037b35389b9d8eb8ee1ead9319b96294f006ca4ac174ac675::account::SmartAccount, arg1: &0x996f3afafbd1dad037b35389b9d8eb8ee1ead9319b96294f006ca4ac174ac675::config::GlobalConfig, arg2: &mut 0x996f3afafbd1dad037b35389b9d8eb8ee1ead9319b96294f006ca4ac174ac675::ticket::AuthorizedTransferTicket, arg3: 0x1::string::String) {
        assert!(0x996f3afafbd1dad037b35389b9d8eb8ee1ead9319b96294f006ca4ac174ac675::account::has_strategy_by_name(arg0, arg3), 0x996f3afafbd1dad037b35389b9d8eb8ee1ead9319b96294f006ca4ac174ac675::errors::strategy_not_found());
        let v0 = 0x996f3afafbd1dad037b35389b9d8eb8ee1ead9319b96294f006ca4ac174ac675::account::policies_for_strategy(arg0, arg1, arg3);
        if (!0x1::vector::is_empty<0x996f3afafbd1dad037b35389b9d8eb8ee1ead9319b96294f006ca4ac174ac675::policy::Policy>(&v0)) {
            0x996f3afafbd1dad037b35389b9d8eb8ee1ead9319b96294f006ca4ac174ac675::ticket::set_policies(arg2, v0);
        };
    }

    // decompiled from Move bytecode v6
}

