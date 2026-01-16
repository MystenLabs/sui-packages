module 0xec609c742ab97a056182daff442093b14ffdbcecb525cb8fc22a33c6f6c633a4::agent {
    public fun add_asset_to_ticket<T0>(arg0: &mut 0xec609c742ab97a056182daff442093b14ffdbcecb525cb8fc22a33c6f6c633a4::account::SmartAccount, arg1: &mut 0xec609c742ab97a056182daff442093b14ffdbcecb525cb8fc22a33c6f6c633a4::ticket::AuthorizedTransferTicket, arg2: &0xec609c742ab97a056182daff442093b14ffdbcecb525cb8fc22a33c6f6c633a4::config::GlobalConfig, arg3: &mut 0x2::tx_context::TxContext) {
        0xec609c742ab97a056182daff442093b14ffdbcecb525cb8fc22a33c6f6c633a4::config::assert_version_compatibility(arg2);
        0xec609c742ab97a056182daff442093b14ffdbcecb525cb8fc22a33c6f6c633a4::ticket::assert_belongs_to_account<0xec609c742ab97a056182daff442093b14ffdbcecb525cb8fc22a33c6f6c633a4::account::SmartAccount>(arg1, arg0);
        let v0 = 0xec609c742ab97a056182daff442093b14ffdbcecb525cb8fc22a33c6f6c633a4::ticket::get_strategy_name(arg1);
        let v1 = 0xec609c742ab97a056182daff442093b14ffdbcecb525cb8fc22a33c6f6c633a4::account::balance<T0>(arg0, v0);
        if (v1 > 0) {
            0xec609c742ab97a056182daff442093b14ffdbcecb525cb8fc22a33c6f6c633a4::ticket::add_coin_internal<T0>(arg1, 0xec609c742ab97a056182daff442093b14ffdbcecb525cb8fc22a33c6f6c633a4::account::withdraw_internal<T0>(arg0, arg2, v1, v0, arg3));
        };
    }

    public fun add_position_to_ticket<T0: store + key>(arg0: &mut 0xec609c742ab97a056182daff442093b14ffdbcecb525cb8fc22a33c6f6c633a4::account::SmartAccount, arg1: &mut 0xec609c742ab97a056182daff442093b14ffdbcecb525cb8fc22a33c6f6c633a4::ticket::AuthorizedTransferTicket, arg2: &0xec609c742ab97a056182daff442093b14ffdbcecb525cb8fc22a33c6f6c633a4::config::GlobalConfig) {
        0xec609c742ab97a056182daff442093b14ffdbcecb525cb8fc22a33c6f6c633a4::config::assert_version_compatibility(arg2);
        0xec609c742ab97a056182daff442093b14ffdbcecb525cb8fc22a33c6f6c633a4::ticket::assert_belongs_to_account<0xec609c742ab97a056182daff442093b14ffdbcecb525cb8fc22a33c6f6c633a4::account::SmartAccount>(arg1, arg0);
        let v0 = 0xec609c742ab97a056182daff442093b14ffdbcecb525cb8fc22a33c6f6c633a4::ticket::get_strategy_name(arg1);
        if (0xec609c742ab97a056182daff442093b14ffdbcecb525cb8fc22a33c6f6c633a4::account::has_object_in_strategy<T0>(arg0, v0)) {
            0xec609c742ab97a056182daff442093b14ffdbcecb525cb8fc22a33c6f6c633a4::ticket::add_object_internal<T0>(arg1, 0xec609c742ab97a056182daff442093b14ffdbcecb525cb8fc22a33c6f6c633a4::account::withdraw_object_internal<T0>(arg0, arg2, v0));
        };
    }

    fun assert_agent_authorized(arg0: &0xec609c742ab97a056182daff442093b14ffdbcecb525cb8fc22a33c6f6c633a4::config::GlobalConfig, arg1: &0x2::tx_context::TxContext) {
        0xec609c742ab97a056182daff442093b14ffdbcecb525cb8fc22a33c6f6c633a4::config::assert_whitelisted_agent(arg0, 0x2::tx_context::sender(arg1));
    }

    public fun burn_ticket(arg0: &mut 0xec609c742ab97a056182daff442093b14ffdbcecb525cb8fc22a33c6f6c633a4::account::SmartAccount, arg1: 0xec609c742ab97a056182daff442093b14ffdbcecb525cb8fc22a33c6f6c633a4::ticket::AuthorizedTransferTicket, arg2: &0xec609c742ab97a056182daff442093b14ffdbcecb525cb8fc22a33c6f6c633a4::config::GlobalConfig, arg3: &mut 0x2::tx_context::TxContext) {
        0xec609c742ab97a056182daff442093b14ffdbcecb525cb8fc22a33c6f6c633a4::config::assert_version_compatibility(arg2);
        0xec609c742ab97a056182daff442093b14ffdbcecb525cb8fc22a33c6f6c633a4::ticket::assert_belongs_to_account<0xec609c742ab97a056182daff442093b14ffdbcecb525cb8fc22a33c6f6c633a4::account::SmartAccount>(&arg1, arg0);
        consume_policies(arg0, &arg1);
        0xec609c742ab97a056182daff442093b14ffdbcecb525cb8fc22a33c6f6c633a4::ticket::burn(arg1, arg0);
    }

    fun consume_policies(arg0: &0xec609c742ab97a056182daff442093b14ffdbcecb525cb8fc22a33c6f6c633a4::account::SmartAccount, arg1: &0xec609c742ab97a056182daff442093b14ffdbcecb525cb8fc22a33c6f6c633a4::ticket::AuthorizedTransferTicket) {
        let v0 = 0xec609c742ab97a056182daff442093b14ffdbcecb525cb8fc22a33c6f6c633a4::ticket::get_policies(arg1);
        let v1 = 0;
        while (v1 < 0x1::vector::length<0xec609c742ab97a056182daff442093b14ffdbcecb525cb8fc22a33c6f6c633a4::policy::Policy>(v0)) {
            0x1::vector::borrow<0xec609c742ab97a056182daff442093b14ffdbcecb525cb8fc22a33c6f6c633a4::policy::Policy>(v0, v1);
            v1 = v1 + 1;
        };
    }

    public fun consume_ticket_asset<T0>(arg0: &mut 0xec609c742ab97a056182daff442093b14ffdbcecb525cb8fc22a33c6f6c633a4::account::SmartAccount, arg1: &mut 0xec609c742ab97a056182daff442093b14ffdbcecb525cb8fc22a33c6f6c633a4::ticket::AuthorizedTransferTicket, arg2: &0xec609c742ab97a056182daff442093b14ffdbcecb525cb8fc22a33c6f6c633a4::config::GlobalConfig, arg3: &mut 0x2::tx_context::TxContext) {
        0xec609c742ab97a056182daff442093b14ffdbcecb525cb8fc22a33c6f6c633a4::config::assert_version_compatibility(arg2);
        0xec609c742ab97a056182daff442093b14ffdbcecb525cb8fc22a33c6f6c633a4::ticket::assert_belongs_to_account<0xec609c742ab97a056182daff442093b14ffdbcecb525cb8fc22a33c6f6c633a4::account::SmartAccount>(arg1, arg0);
        let v0 = 0xec609c742ab97a056182daff442093b14ffdbcecb525cb8fc22a33c6f6c633a4::ticket::get_strategy_name(arg1);
        if (0xec609c742ab97a056182daff442093b14ffdbcecb525cb8fc22a33c6f6c633a4::ticket::has_asset_type<T0>(arg1)) {
            let v1 = extract_strategy_base_asset_from_ticket<T0>(arg1, arg3);
            deposit_strategy_base_asset_if_present<T0>(arg0, arg2, v1, v0, arg3);
        };
    }

    public fun consume_ticket_performance_fee<T0>(arg0: &mut 0xec609c742ab97a056182daff442093b14ffdbcecb525cb8fc22a33c6f6c633a4::ticket::AuthorizedTransferTicket, arg1: &mut 0xec609c742ab97a056182daff442093b14ffdbcecb525cb8fc22a33c6f6c633a4::config::GlobalConfig, arg2: &mut 0x2::tx_context::TxContext) {
        0xec609c742ab97a056182daff442093b14ffdbcecb525cb8fc22a33c6f6c633a4::config::assert_version_compatibility(arg1);
        if (0xec609c742ab97a056182daff442093b14ffdbcecb525cb8fc22a33c6f6c633a4::ticket::has_any_perf_fees(arg0)) {
            if (0xec609c742ab97a056182daff442093b14ffdbcecb525cb8fc22a33c6f6c633a4::ticket::perf_fee_asset_balance<T0>(arg0) > 0) {
                0xec609c742ab97a056182daff442093b14ffdbcecb525cb8fc22a33c6f6c633a4::config::collect_performance_fee<T0>(arg1, 0xec609c742ab97a056182daff442093b14ffdbcecb525cb8fc22a33c6f6c633a4::ticket::withdraw_performance_fee<T0>(arg0, 0xec609c742ab97a056182daff442093b14ffdbcecb525cb8fc22a33c6f6c633a4::ticket::perf_fee_asset_balance<T0>(arg0), arg2));
            };
        };
    }

    public fun consume_ticket_position<T0: store + key>(arg0: &mut 0xec609c742ab97a056182daff442093b14ffdbcecb525cb8fc22a33c6f6c633a4::account::SmartAccount, arg1: &mut 0xec609c742ab97a056182daff442093b14ffdbcecb525cb8fc22a33c6f6c633a4::ticket::AuthorizedTransferTicket, arg2: &0xec609c742ab97a056182daff442093b14ffdbcecb525cb8fc22a33c6f6c633a4::config::GlobalConfig, arg3: &mut 0x2::tx_context::TxContext) {
        0xec609c742ab97a056182daff442093b14ffdbcecb525cb8fc22a33c6f6c633a4::config::assert_version_compatibility(arg2);
        0xec609c742ab97a056182daff442093b14ffdbcecb525cb8fc22a33c6f6c633a4::ticket::assert_belongs_to_account<0xec609c742ab97a056182daff442093b14ffdbcecb525cb8fc22a33c6f6c633a4::account::SmartAccount>(arg1, arg0);
        let v0 = 0xec609c742ab97a056182daff442093b14ffdbcecb525cb8fc22a33c6f6c633a4::ticket::get_strategy_name(arg1);
        if (0xec609c742ab97a056182daff442093b14ffdbcecb525cb8fc22a33c6f6c633a4::ticket::has_asset_type<T0>(arg1)) {
            deposit_position_if_present<T0>(arg0, arg2, extract_position_from_ticket<T0>(arg1), v0, arg3);
        };
    }

    public fun consume_ticket_reward<T0>(arg0: &mut 0xec609c742ab97a056182daff442093b14ffdbcecb525cb8fc22a33c6f6c633a4::account::SmartAccount, arg1: &mut 0xec609c742ab97a056182daff442093b14ffdbcecb525cb8fc22a33c6f6c633a4::ticket::AuthorizedTransferTicket, arg2: &0xec609c742ab97a056182daff442093b14ffdbcecb525cb8fc22a33c6f6c633a4::config::GlobalConfig, arg3: &mut 0x2::tx_context::TxContext) {
        0xec609c742ab97a056182daff442093b14ffdbcecb525cb8fc22a33c6f6c633a4::config::assert_version_compatibility(arg2);
        0xec609c742ab97a056182daff442093b14ffdbcecb525cb8fc22a33c6f6c633a4::ticket::assert_belongs_to_account<0xec609c742ab97a056182daff442093b14ffdbcecb525cb8fc22a33c6f6c633a4::account::SmartAccount>(arg1, arg0);
        let v0 = 0xec609c742ab97a056182daff442093b14ffdbcecb525cb8fc22a33c6f6c633a4::ticket::get_strategy_name(arg1);
        if (0xec609c742ab97a056182daff442093b14ffdbcecb525cb8fc22a33c6f6c633a4::ticket::has_reward_type<T0>(arg1)) {
            let v1 = extract_rewards_from_ticket<T0>(arg1, arg3);
            deposit_rewards_if_present<T0>(arg0, arg2, v1, v0, arg3);
        };
    }

    fun deposit_position_if_present<T0: store + key>(arg0: &mut 0xec609c742ab97a056182daff442093b14ffdbcecb525cb8fc22a33c6f6c633a4::account::SmartAccount, arg1: &0xec609c742ab97a056182daff442093b14ffdbcecb525cb8fc22a33c6f6c633a4::config::GlobalConfig, arg2: 0x1::option::Option<T0>, arg3: 0x1::string::String, arg4: &mut 0x2::tx_context::TxContext) {
        if (0x1::option::is_some<T0>(&arg2)) {
            0xec609c742ab97a056182daff442093b14ffdbcecb525cb8fc22a33c6f6c633a4::account::deposit_object_internal<T0>(arg0, arg1, 0x1::option::destroy_some<T0>(arg2), arg3, arg4);
        } else {
            0x1::option::destroy_none<T0>(arg2);
        };
    }

    fun deposit_rewards_if_present<T0>(arg0: &mut 0xec609c742ab97a056182daff442093b14ffdbcecb525cb8fc22a33c6f6c633a4::account::SmartAccount, arg1: &0xec609c742ab97a056182daff442093b14ffdbcecb525cb8fc22a33c6f6c633a4::config::GlobalConfig, arg2: 0x1::option::Option<0x2::coin::Coin<T0>>, arg3: 0x1::string::String, arg4: &mut 0x2::tx_context::TxContext) {
        if (0x1::option::is_some<0x2::coin::Coin<T0>>(&arg2)) {
            0xec609c742ab97a056182daff442093b14ffdbcecb525cb8fc22a33c6f6c633a4::account::deposit_rewards_internal<T0>(arg0, arg1, 0x2::coin::into_balance<T0>(0x1::option::destroy_some<0x2::coin::Coin<T0>>(arg2)), arg3, arg4);
        } else {
            0x1::option::destroy_none<0x2::coin::Coin<T0>>(arg2);
        };
    }

    fun deposit_strategy_base_asset_if_present<T0>(arg0: &mut 0xec609c742ab97a056182daff442093b14ffdbcecb525cb8fc22a33c6f6c633a4::account::SmartAccount, arg1: &0xec609c742ab97a056182daff442093b14ffdbcecb525cb8fc22a33c6f6c633a4::config::GlobalConfig, arg2: 0x1::option::Option<0x2::coin::Coin<T0>>, arg3: 0x1::string::String, arg4: &mut 0x2::tx_context::TxContext) {
        if (0x1::option::is_some<0x2::coin::Coin<T0>>(&arg2)) {
            0xec609c742ab97a056182daff442093b14ffdbcecb525cb8fc22a33c6f6c633a4::account::deposit_internal<T0>(arg0, arg1, 0x1::option::destroy_some<0x2::coin::Coin<T0>>(arg2), arg3, arg4);
        } else {
            0x1::option::destroy_none<0x2::coin::Coin<T0>>(arg2);
        };
    }

    fun extract_position_from_ticket<T0: store + key>(arg0: &mut 0xec609c742ab97a056182daff442093b14ffdbcecb525cb8fc22a33c6f6c633a4::ticket::AuthorizedTransferTicket) : 0x1::option::Option<T0> {
        if (0xec609c742ab97a056182daff442093b14ffdbcecb525cb8fc22a33c6f6c633a4::ticket::has_asset_type<T0>(arg0)) {
            0x1::option::some<T0>(0xec609c742ab97a056182daff442093b14ffdbcecb525cb8fc22a33c6f6c633a4::ticket::withdraw_object_internal<T0>(arg0))
        } else {
            0x1::option::none<T0>()
        }
    }

    fun extract_rewards_from_ticket<T0>(arg0: &mut 0xec609c742ab97a056182daff442093b14ffdbcecb525cb8fc22a33c6f6c633a4::ticket::AuthorizedTransferTicket, arg1: &mut 0x2::tx_context::TxContext) : 0x1::option::Option<0x2::coin::Coin<T0>> {
        if (0xec609c742ab97a056182daff442093b14ffdbcecb525cb8fc22a33c6f6c633a4::ticket::has_reward_type<T0>(arg0)) {
            0x1::option::some<0x2::coin::Coin<T0>>(0xec609c742ab97a056182daff442093b14ffdbcecb525cb8fc22a33c6f6c633a4::ticket::withdraw_reward_internal<T0>(arg0, 0xec609c742ab97a056182daff442093b14ffdbcecb525cb8fc22a33c6f6c633a4::ticket::reward_balance<T0>(arg0), arg1))
        } else {
            0x1::option::none<0x2::coin::Coin<T0>>()
        }
    }

    fun extract_strategy_base_asset_from_ticket<T0>(arg0: &mut 0xec609c742ab97a056182daff442093b14ffdbcecb525cb8fc22a33c6f6c633a4::ticket::AuthorizedTransferTicket, arg1: &mut 0x2::tx_context::TxContext) : 0x1::option::Option<0x2::coin::Coin<T0>> {
        if (0xec609c742ab97a056182daff442093b14ffdbcecb525cb8fc22a33c6f6c633a4::ticket::has_asset_type<T0>(arg0)) {
            0x1::option::some<0x2::coin::Coin<T0>>(0xec609c742ab97a056182daff442093b14ffdbcecb525cb8fc22a33c6f6c633a4::ticket::withdraw_coin_internal<T0>(arg0, 0xec609c742ab97a056182daff442093b14ffdbcecb525cb8fc22a33c6f6c633a4::ticket::asset_balance<T0>(arg0), arg1))
        } else {
            0x1::option::none<0x2::coin::Coin<T0>>()
        }
    }

    public fun issue_ticket(arg0: &mut 0xec609c742ab97a056182daff442093b14ffdbcecb525cb8fc22a33c6f6c633a4::account::SmartAccount, arg1: &0xec609c742ab97a056182daff442093b14ffdbcecb525cb8fc22a33c6f6c633a4::config::GlobalConfig, arg2: 0x1::string::String, arg3: &mut 0x2::tx_context::TxContext) : 0xec609c742ab97a056182daff442093b14ffdbcecb525cb8fc22a33c6f6c633a4::ticket::AuthorizedTransferTicket {
        0xec609c742ab97a056182daff442093b14ffdbcecb525cb8fc22a33c6f6c633a4::config::assert_version_compatibility(arg1);
        assert_agent_authorized(arg1, arg3);
        let v0 = mint_ticket(arg0, arg1, arg2, true, arg3);
        let v1 = &mut v0;
        write_policies(arg0, arg1, v1, arg2);
        v0
    }

    public fun issue_ticket_as_owner(arg0: &mut 0xec609c742ab97a056182daff442093b14ffdbcecb525cb8fc22a33c6f6c633a4::account::SmartAccount, arg1: &0xec609c742ab97a056182daff442093b14ffdbcecb525cb8fc22a33c6f6c633a4::account::AccountOwnerCap, arg2: &0xec609c742ab97a056182daff442093b14ffdbcecb525cb8fc22a33c6f6c633a4::config::GlobalConfig, arg3: 0x1::string::String, arg4: &mut 0x2::tx_context::TxContext) : 0xec609c742ab97a056182daff442093b14ffdbcecb525cb8fc22a33c6f6c633a4::ticket::AuthorizedTransferTicket {
        0xec609c742ab97a056182daff442093b14ffdbcecb525cb8fc22a33c6f6c633a4::config::assert_version_compatibility(arg2);
        0xec609c742ab97a056182daff442093b14ffdbcecb525cb8fc22a33c6f6c633a4::account::assert_account_owner(arg0, arg1);
        let v0 = mint_ticket(arg0, arg2, arg3, false, arg4);
        let v1 = &mut v0;
        write_policies(arg0, arg2, v1, arg3);
        v0
    }

    fun mint_ticket(arg0: &mut 0xec609c742ab97a056182daff442093b14ffdbcecb525cb8fc22a33c6f6c633a4::account::SmartAccount, arg1: &0xec609c742ab97a056182daff442093b14ffdbcecb525cb8fc22a33c6f6c633a4::config::GlobalConfig, arg2: 0x1::string::String, arg3: bool, arg4: &mut 0x2::tx_context::TxContext) : 0xec609c742ab97a056182daff442093b14ffdbcecb525cb8fc22a33c6f6c633a4::ticket::AuthorizedTransferTicket {
        0xec609c742ab97a056182daff442093b14ffdbcecb525cb8fc22a33c6f6c633a4::ticket::issue(0x2::object::id<0xec609c742ab97a056182daff442093b14ffdbcecb525cb8fc22a33c6f6c633a4::account::SmartAccount>(arg0), arg2, 0xec609c742ab97a056182daff442093b14ffdbcecb525cb8fc22a33c6f6c633a4::account::extract_balance_sheet(arg0, arg2, arg4), arg3, 0xec609c742ab97a056182daff442093b14ffdbcecb525cb8fc22a33c6f6c633a4::config::performance_fee_rate(arg1, arg2), *0xec609c742ab97a056182daff442093b14ffdbcecb525cb8fc22a33c6f6c633a4::strategy::base_asset_types(0xec609c742ab97a056182daff442093b14ffdbcecb525cb8fc22a33c6f6c633a4::config::get_strategy_by_name(arg1, arg2)), arg4)
    }

    fun write_policies(arg0: &0xec609c742ab97a056182daff442093b14ffdbcecb525cb8fc22a33c6f6c633a4::account::SmartAccount, arg1: &0xec609c742ab97a056182daff442093b14ffdbcecb525cb8fc22a33c6f6c633a4::config::GlobalConfig, arg2: &mut 0xec609c742ab97a056182daff442093b14ffdbcecb525cb8fc22a33c6f6c633a4::ticket::AuthorizedTransferTicket, arg3: 0x1::string::String) {
        assert!(0xec609c742ab97a056182daff442093b14ffdbcecb525cb8fc22a33c6f6c633a4::account::has_strategy_by_name(arg0, arg3), 0xec609c742ab97a056182daff442093b14ffdbcecb525cb8fc22a33c6f6c633a4::errors::strategy_not_found());
        let v0 = 0xec609c742ab97a056182daff442093b14ffdbcecb525cb8fc22a33c6f6c633a4::account::policies_for_strategy(arg0, arg1, arg3);
        assert!(!0x1::vector::is_empty<0xec609c742ab97a056182daff442093b14ffdbcecb525cb8fc22a33c6f6c633a4::policy::Policy>(&v0), 0xec609c742ab97a056182daff442093b14ffdbcecb525cb8fc22a33c6f6c633a4::errors::no_policies_for_strategy());
        0xec609c742ab97a056182daff442093b14ffdbcecb525cb8fc22a33c6f6c633a4::ticket::set_policies(arg2, arg1, v0);
    }

    // decompiled from Move bytecode v6
}

