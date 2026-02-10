module 0xf2513ec8c0158b6668e03ff5b813a529bdc1461d3727843528cf333eb86af34f::agent {
    public fun add_asset_to_ticket<T0: store, T1>(arg0: &mut 0xf2513ec8c0158b6668e03ff5b813a529bdc1461d3727843528cf333eb86af34f::account::SmartAccount, arg1: &mut 0xf2513ec8c0158b6668e03ff5b813a529bdc1461d3727843528cf333eb86af34f::ticket::AuthorizedTransferTicket<T0>, arg2: &0xf2513ec8c0158b6668e03ff5b813a529bdc1461d3727843528cf333eb86af34f::config::GlobalConfig, arg3: &mut 0x2::tx_context::TxContext) {
        0xf2513ec8c0158b6668e03ff5b813a529bdc1461d3727843528cf333eb86af34f::config::assert_version_compatibility(arg2);
        0xf2513ec8c0158b6668e03ff5b813a529bdc1461d3727843528cf333eb86af34f::ticket::assert_belongs_to_account<T0, 0xf2513ec8c0158b6668e03ff5b813a529bdc1461d3727843528cf333eb86af34f::account::SmartAccount>(arg1, arg0);
        let v0 = 0xf2513ec8c0158b6668e03ff5b813a529bdc1461d3727843528cf333eb86af34f::ticket::get_strategy_name<T0>(arg1);
        let v1 = 0xf2513ec8c0158b6668e03ff5b813a529bdc1461d3727843528cf333eb86af34f::account::balance<T1>(arg0, v0);
        if (v1 > 0) {
            0xf2513ec8c0158b6668e03ff5b813a529bdc1461d3727843528cf333eb86af34f::ticket::add_coin_internal<T0, T1>(arg1, 0xf2513ec8c0158b6668e03ff5b813a529bdc1461d3727843528cf333eb86af34f::account::withdraw_internal<T1>(arg0, arg2, v1, v0, arg3));
        };
    }

    public fun add_position_to_ticket<T0: store, T1: store + key>(arg0: &mut 0xf2513ec8c0158b6668e03ff5b813a529bdc1461d3727843528cf333eb86af34f::account::SmartAccount, arg1: &mut 0xf2513ec8c0158b6668e03ff5b813a529bdc1461d3727843528cf333eb86af34f::ticket::AuthorizedTransferTicket<T0>, arg2: &0xf2513ec8c0158b6668e03ff5b813a529bdc1461d3727843528cf333eb86af34f::config::GlobalConfig) {
        0xf2513ec8c0158b6668e03ff5b813a529bdc1461d3727843528cf333eb86af34f::config::assert_version_compatibility(arg2);
        0xf2513ec8c0158b6668e03ff5b813a529bdc1461d3727843528cf333eb86af34f::ticket::assert_belongs_to_account<T0, 0xf2513ec8c0158b6668e03ff5b813a529bdc1461d3727843528cf333eb86af34f::account::SmartAccount>(arg1, arg0);
        let v0 = 0xf2513ec8c0158b6668e03ff5b813a529bdc1461d3727843528cf333eb86af34f::ticket::get_strategy_name<T0>(arg1);
        if (0xf2513ec8c0158b6668e03ff5b813a529bdc1461d3727843528cf333eb86af34f::account::has_object_in_strategy<T1>(arg0, v0)) {
            0xf2513ec8c0158b6668e03ff5b813a529bdc1461d3727843528cf333eb86af34f::ticket::add_object_internal<T0, T1>(arg1, 0xf2513ec8c0158b6668e03ff5b813a529bdc1461d3727843528cf333eb86af34f::account::withdraw_object_internal<T1>(arg0, arg2, v0));
        };
    }

    fun assert_agent_authorized(arg0: &0xf2513ec8c0158b6668e03ff5b813a529bdc1461d3727843528cf333eb86af34f::config::GlobalConfig, arg1: &0x2::tx_context::TxContext) {
        0xf2513ec8c0158b6668e03ff5b813a529bdc1461d3727843528cf333eb86af34f::config::assert_whitelisted_agent(arg0, 0x2::tx_context::sender(arg1));
    }

    public fun burn_ticket<T0: store>(arg0: &mut 0xf2513ec8c0158b6668e03ff5b813a529bdc1461d3727843528cf333eb86af34f::account::SmartAccount, arg1: 0xf2513ec8c0158b6668e03ff5b813a529bdc1461d3727843528cf333eb86af34f::ticket::AuthorizedTransferTicket<T0>, arg2: &0xf2513ec8c0158b6668e03ff5b813a529bdc1461d3727843528cf333eb86af34f::config::GlobalConfig, arg3: &mut 0x2::tx_context::TxContext) {
        0xf2513ec8c0158b6668e03ff5b813a529bdc1461d3727843528cf333eb86af34f::config::assert_version_compatibility(arg2);
        0xf2513ec8c0158b6668e03ff5b813a529bdc1461d3727843528cf333eb86af34f::ticket::assert_belongs_to_account<T0, 0xf2513ec8c0158b6668e03ff5b813a529bdc1461d3727843528cf333eb86af34f::account::SmartAccount>(&arg1, arg0);
        consume_policies<T0>(&arg1);
        0xf2513ec8c0158b6668e03ff5b813a529bdc1461d3727843528cf333eb86af34f::account::return_balance_sheet<T0>(arg0, 0xf2513ec8c0158b6668e03ff5b813a529bdc1461d3727843528cf333eb86af34f::strategy::new_strategy_key(0xf2513ec8c0158b6668e03ff5b813a529bdc1461d3727843528cf333eb86af34f::ticket::get_strategy_name<T0>(&arg1)), 0xf2513ec8c0158b6668e03ff5b813a529bdc1461d3727843528cf333eb86af34f::ticket::burn<T0>(arg1));
    }

    fun consume_policies<T0: store>(arg0: &0xf2513ec8c0158b6668e03ff5b813a529bdc1461d3727843528cf333eb86af34f::ticket::AuthorizedTransferTicket<T0>) {
        let v0 = 0xf2513ec8c0158b6668e03ff5b813a529bdc1461d3727843528cf333eb86af34f::ticket::get_policies<T0>(arg0);
        let v1 = 0;
        while (v1 < 0x1::vector::length<0xf2513ec8c0158b6668e03ff5b813a529bdc1461d3727843528cf333eb86af34f::policy::Policy>(v0)) {
            0x1::vector::borrow<0xf2513ec8c0158b6668e03ff5b813a529bdc1461d3727843528cf333eb86af34f::policy::Policy>(v0, v1);
            v1 = v1 + 1;
        };
    }

    public fun consume_ticket_asset<T0: store, T1>(arg0: &mut 0xf2513ec8c0158b6668e03ff5b813a529bdc1461d3727843528cf333eb86af34f::account::SmartAccount, arg1: &mut 0xf2513ec8c0158b6668e03ff5b813a529bdc1461d3727843528cf333eb86af34f::ticket::AuthorizedTransferTicket<T0>, arg2: &0xf2513ec8c0158b6668e03ff5b813a529bdc1461d3727843528cf333eb86af34f::config::GlobalConfig, arg3: &mut 0x2::tx_context::TxContext) {
        0xf2513ec8c0158b6668e03ff5b813a529bdc1461d3727843528cf333eb86af34f::config::assert_version_compatibility(arg2);
        0xf2513ec8c0158b6668e03ff5b813a529bdc1461d3727843528cf333eb86af34f::ticket::assert_belongs_to_account<T0, 0xf2513ec8c0158b6668e03ff5b813a529bdc1461d3727843528cf333eb86af34f::account::SmartAccount>(arg1, arg0);
        let v0 = 0xf2513ec8c0158b6668e03ff5b813a529bdc1461d3727843528cf333eb86af34f::ticket::get_strategy_name<T0>(arg1);
        if (0xf2513ec8c0158b6668e03ff5b813a529bdc1461d3727843528cf333eb86af34f::ticket::has_asset_type<T0, T1>(arg1)) {
            let v1 = extract_strategy_base_asset_from_ticket<T0, T1>(arg1, arg3);
            deposit_strategy_base_asset_if_present<T1>(arg0, arg2, v1, v0, arg3);
        };
    }

    public fun consume_ticket_performance_fee<T0: store, T1>(arg0: &mut 0xf2513ec8c0158b6668e03ff5b813a529bdc1461d3727843528cf333eb86af34f::ticket::AuthorizedTransferTicket<T0>, arg1: &mut 0xf2513ec8c0158b6668e03ff5b813a529bdc1461d3727843528cf333eb86af34f::config::GlobalConfig, arg2: &mut 0x2::tx_context::TxContext) {
        0xf2513ec8c0158b6668e03ff5b813a529bdc1461d3727843528cf333eb86af34f::config::assert_version_compatibility(arg1);
        if (0xf2513ec8c0158b6668e03ff5b813a529bdc1461d3727843528cf333eb86af34f::ticket::has_any_perf_fees<T0>(arg0)) {
            if (0xf2513ec8c0158b6668e03ff5b813a529bdc1461d3727843528cf333eb86af34f::ticket::perf_fee_asset_balance<T0, T1>(arg0) > 0) {
                0xf2513ec8c0158b6668e03ff5b813a529bdc1461d3727843528cf333eb86af34f::config::collect_performance_fee<T1>(arg1, 0xf2513ec8c0158b6668e03ff5b813a529bdc1461d3727843528cf333eb86af34f::ticket::withdraw_performance_fee<T0, T1>(arg0, 0xf2513ec8c0158b6668e03ff5b813a529bdc1461d3727843528cf333eb86af34f::ticket::perf_fee_asset_balance<T0, T1>(arg0), arg2));
            };
        };
    }

    public fun consume_ticket_position<T0: store, T1: store + key>(arg0: &mut 0xf2513ec8c0158b6668e03ff5b813a529bdc1461d3727843528cf333eb86af34f::account::SmartAccount, arg1: &mut 0xf2513ec8c0158b6668e03ff5b813a529bdc1461d3727843528cf333eb86af34f::ticket::AuthorizedTransferTicket<T0>, arg2: &0xf2513ec8c0158b6668e03ff5b813a529bdc1461d3727843528cf333eb86af34f::config::GlobalConfig, arg3: &mut 0x2::tx_context::TxContext) {
        0xf2513ec8c0158b6668e03ff5b813a529bdc1461d3727843528cf333eb86af34f::config::assert_version_compatibility(arg2);
        0xf2513ec8c0158b6668e03ff5b813a529bdc1461d3727843528cf333eb86af34f::ticket::assert_belongs_to_account<T0, 0xf2513ec8c0158b6668e03ff5b813a529bdc1461d3727843528cf333eb86af34f::account::SmartAccount>(arg1, arg0);
        let v0 = 0xf2513ec8c0158b6668e03ff5b813a529bdc1461d3727843528cf333eb86af34f::ticket::get_strategy_name<T0>(arg1);
        if (0xf2513ec8c0158b6668e03ff5b813a529bdc1461d3727843528cf333eb86af34f::ticket::has_asset_type<T0, T1>(arg1)) {
            deposit_position_if_present<T1>(arg0, arg2, extract_position_from_ticket<T0, T1>(arg1), v0, arg3);
        };
    }

    public fun consume_ticket_reward<T0: store, T1>(arg0: &mut 0xf2513ec8c0158b6668e03ff5b813a529bdc1461d3727843528cf333eb86af34f::account::SmartAccount, arg1: &mut 0xf2513ec8c0158b6668e03ff5b813a529bdc1461d3727843528cf333eb86af34f::ticket::AuthorizedTransferTicket<T0>, arg2: &0xf2513ec8c0158b6668e03ff5b813a529bdc1461d3727843528cf333eb86af34f::config::GlobalConfig, arg3: &mut 0x2::tx_context::TxContext) {
        0xf2513ec8c0158b6668e03ff5b813a529bdc1461d3727843528cf333eb86af34f::config::assert_version_compatibility(arg2);
        0xf2513ec8c0158b6668e03ff5b813a529bdc1461d3727843528cf333eb86af34f::ticket::assert_belongs_to_account<T0, 0xf2513ec8c0158b6668e03ff5b813a529bdc1461d3727843528cf333eb86af34f::account::SmartAccount>(arg1, arg0);
        let v0 = 0xf2513ec8c0158b6668e03ff5b813a529bdc1461d3727843528cf333eb86af34f::ticket::get_strategy_name<T0>(arg1);
        if (0xf2513ec8c0158b6668e03ff5b813a529bdc1461d3727843528cf333eb86af34f::ticket::has_reward_type<T0, T1>(arg1)) {
            let v1 = extract_rewards_from_ticket<T0, T1>(arg1, arg3);
            deposit_rewards_if_present<T1>(arg0, arg2, v1, v0, arg3);
        };
    }

    fun deposit_position_if_present<T0: store + key>(arg0: &mut 0xf2513ec8c0158b6668e03ff5b813a529bdc1461d3727843528cf333eb86af34f::account::SmartAccount, arg1: &0xf2513ec8c0158b6668e03ff5b813a529bdc1461d3727843528cf333eb86af34f::config::GlobalConfig, arg2: 0x1::option::Option<T0>, arg3: 0x1::string::String, arg4: &mut 0x2::tx_context::TxContext) {
        if (0x1::option::is_some<T0>(&arg2)) {
            0xf2513ec8c0158b6668e03ff5b813a529bdc1461d3727843528cf333eb86af34f::account::deposit_object_internal<T0>(arg0, arg1, 0x1::option::destroy_some<T0>(arg2), arg3, arg4);
        } else {
            0x1::option::destroy_none<T0>(arg2);
        };
    }

    fun deposit_rewards_if_present<T0>(arg0: &mut 0xf2513ec8c0158b6668e03ff5b813a529bdc1461d3727843528cf333eb86af34f::account::SmartAccount, arg1: &0xf2513ec8c0158b6668e03ff5b813a529bdc1461d3727843528cf333eb86af34f::config::GlobalConfig, arg2: 0x1::option::Option<0x2::coin::Coin<T0>>, arg3: 0x1::string::String, arg4: &mut 0x2::tx_context::TxContext) {
        if (0x1::option::is_some<0x2::coin::Coin<T0>>(&arg2)) {
            0xf2513ec8c0158b6668e03ff5b813a529bdc1461d3727843528cf333eb86af34f::account::deposit_rewards_internal<T0>(arg0, arg1, 0x2::coin::into_balance<T0>(0x1::option::destroy_some<0x2::coin::Coin<T0>>(arg2)), arg3, arg4);
        } else {
            0x1::option::destroy_none<0x2::coin::Coin<T0>>(arg2);
        };
    }

    fun deposit_strategy_base_asset_if_present<T0>(arg0: &mut 0xf2513ec8c0158b6668e03ff5b813a529bdc1461d3727843528cf333eb86af34f::account::SmartAccount, arg1: &0xf2513ec8c0158b6668e03ff5b813a529bdc1461d3727843528cf333eb86af34f::config::GlobalConfig, arg2: 0x1::option::Option<0x2::coin::Coin<T0>>, arg3: 0x1::string::String, arg4: &mut 0x2::tx_context::TxContext) {
        if (0x1::option::is_some<0x2::coin::Coin<T0>>(&arg2)) {
            0xf2513ec8c0158b6668e03ff5b813a529bdc1461d3727843528cf333eb86af34f::account::deposit_internal<T0>(arg0, arg1, 0x1::option::destroy_some<0x2::coin::Coin<T0>>(arg2), arg3, arg4);
        } else {
            0x1::option::destroy_none<0x2::coin::Coin<T0>>(arg2);
        };
    }

    fun extract_position_from_ticket<T0: store, T1: store + key>(arg0: &mut 0xf2513ec8c0158b6668e03ff5b813a529bdc1461d3727843528cf333eb86af34f::ticket::AuthorizedTransferTicket<T0>) : 0x1::option::Option<T1> {
        if (0xf2513ec8c0158b6668e03ff5b813a529bdc1461d3727843528cf333eb86af34f::ticket::has_asset_type<T0, T1>(arg0)) {
            0x1::option::some<T1>(0xf2513ec8c0158b6668e03ff5b813a529bdc1461d3727843528cf333eb86af34f::ticket::withdraw_object_internal<T0, T1>(arg0))
        } else {
            0x1::option::none<T1>()
        }
    }

    fun extract_rewards_from_ticket<T0: store, T1>(arg0: &mut 0xf2513ec8c0158b6668e03ff5b813a529bdc1461d3727843528cf333eb86af34f::ticket::AuthorizedTransferTicket<T0>, arg1: &mut 0x2::tx_context::TxContext) : 0x1::option::Option<0x2::coin::Coin<T1>> {
        if (0xf2513ec8c0158b6668e03ff5b813a529bdc1461d3727843528cf333eb86af34f::ticket::has_reward_type<T0, T1>(arg0)) {
            0x1::option::some<0x2::coin::Coin<T1>>(0xf2513ec8c0158b6668e03ff5b813a529bdc1461d3727843528cf333eb86af34f::ticket::withdraw_reward_internal<T0, T1>(arg0, 0xf2513ec8c0158b6668e03ff5b813a529bdc1461d3727843528cf333eb86af34f::ticket::reward_balance<T0, T1>(arg0), arg1))
        } else {
            0x1::option::none<0x2::coin::Coin<T1>>()
        }
    }

    fun extract_strategy_base_asset_from_ticket<T0: store, T1>(arg0: &mut 0xf2513ec8c0158b6668e03ff5b813a529bdc1461d3727843528cf333eb86af34f::ticket::AuthorizedTransferTicket<T0>, arg1: &mut 0x2::tx_context::TxContext) : 0x1::option::Option<0x2::coin::Coin<T1>> {
        if (0xf2513ec8c0158b6668e03ff5b813a529bdc1461d3727843528cf333eb86af34f::ticket::has_asset_type<T0, T1>(arg0)) {
            0x1::option::some<0x2::coin::Coin<T1>>(0xf2513ec8c0158b6668e03ff5b813a529bdc1461d3727843528cf333eb86af34f::ticket::withdraw_coin_internal<T0, T1>(arg0, 0xf2513ec8c0158b6668e03ff5b813a529bdc1461d3727843528cf333eb86af34f::ticket::asset_balance<T0, T1>(arg0), arg1))
        } else {
            0x1::option::none<0x2::coin::Coin<T1>>()
        }
    }

    public fun issue_ticket<T0: store>(arg0: &mut 0xf2513ec8c0158b6668e03ff5b813a529bdc1461d3727843528cf333eb86af34f::account::SmartAccount, arg1: &0xf2513ec8c0158b6668e03ff5b813a529bdc1461d3727843528cf333eb86af34f::config::GlobalConfig, arg2: 0x1::string::String, arg3: &mut 0x2::tx_context::TxContext) : 0xf2513ec8c0158b6668e03ff5b813a529bdc1461d3727843528cf333eb86af34f::ticket::AuthorizedTransferTicket<T0> {
        0xf2513ec8c0158b6668e03ff5b813a529bdc1461d3727843528cf333eb86af34f::config::assert_version_compatibility(arg1);
        assert_agent_authorized(arg1, arg3);
        let v0 = mint_ticket<T0>(arg0, arg1, arg2, true, arg3);
        let v1 = &mut v0;
        write_policies<T0>(arg0, arg1, v1, arg2);
        v0
    }

    public fun issue_ticket_as_owner<T0: store>(arg0: &mut 0xf2513ec8c0158b6668e03ff5b813a529bdc1461d3727843528cf333eb86af34f::account::SmartAccount, arg1: &0xf2513ec8c0158b6668e03ff5b813a529bdc1461d3727843528cf333eb86af34f::account::AccountOwnerCap, arg2: &0xf2513ec8c0158b6668e03ff5b813a529bdc1461d3727843528cf333eb86af34f::config::GlobalConfig, arg3: 0x1::string::String, arg4: &mut 0x2::tx_context::TxContext) : 0xf2513ec8c0158b6668e03ff5b813a529bdc1461d3727843528cf333eb86af34f::ticket::AuthorizedTransferTicket<T0> {
        0xf2513ec8c0158b6668e03ff5b813a529bdc1461d3727843528cf333eb86af34f::config::assert_version_compatibility(arg2);
        0xf2513ec8c0158b6668e03ff5b813a529bdc1461d3727843528cf333eb86af34f::account::assert_account_owner(arg0, arg1);
        let v0 = mint_ticket<T0>(arg0, arg2, arg3, false, arg4);
        let v1 = &mut v0;
        write_policies<T0>(arg0, arg2, v1, arg3);
        v0
    }

    fun mint_ticket<T0: store>(arg0: &mut 0xf2513ec8c0158b6668e03ff5b813a529bdc1461d3727843528cf333eb86af34f::account::SmartAccount, arg1: &0xf2513ec8c0158b6668e03ff5b813a529bdc1461d3727843528cf333eb86af34f::config::GlobalConfig, arg2: 0x1::string::String, arg3: bool, arg4: &mut 0x2::tx_context::TxContext) : 0xf2513ec8c0158b6668e03ff5b813a529bdc1461d3727843528cf333eb86af34f::ticket::AuthorizedTransferTicket<T0> {
        let v0 = 0xf2513ec8c0158b6668e03ff5b813a529bdc1461d3727843528cf333eb86af34f::strategy::new_strategy_key(arg2);
        let v1 = 0xf2513ec8c0158b6668e03ff5b813a529bdc1461d3727843528cf333eb86af34f::config::get_strategy_by_name(arg1, arg2);
        0xf2513ec8c0158b6668e03ff5b813a529bdc1461d3727843528cf333eb86af34f::strategy::assert_sheet_type<T0>(v1);
        assert!(0xf2513ec8c0158b6668e03ff5b813a529bdc1461d3727843528cf333eb86af34f::account::has_balance_sheet<T0>(arg0, v0), 0xf2513ec8c0158b6668e03ff5b813a529bdc1461d3727843528cf333eb86af34f::errors::balance_sheet_not_found());
        0xf2513ec8c0158b6668e03ff5b813a529bdc1461d3727843528cf333eb86af34f::ticket::issue<T0>(0x2::object::id<0xf2513ec8c0158b6668e03ff5b813a529bdc1461d3727843528cf333eb86af34f::account::SmartAccount>(arg0), arg2, 0xf2513ec8c0158b6668e03ff5b813a529bdc1461d3727843528cf333eb86af34f::account::extract_balance_sheet<T0>(arg0, v0), arg3, 0xf2513ec8c0158b6668e03ff5b813a529bdc1461d3727843528cf333eb86af34f::config::performance_fee_rate(arg1, arg2), *0xf2513ec8c0158b6668e03ff5b813a529bdc1461d3727843528cf333eb86af34f::strategy::base_asset_types(v1), arg4)
    }

    fun write_policies<T0: store>(arg0: &0xf2513ec8c0158b6668e03ff5b813a529bdc1461d3727843528cf333eb86af34f::account::SmartAccount, arg1: &0xf2513ec8c0158b6668e03ff5b813a529bdc1461d3727843528cf333eb86af34f::config::GlobalConfig, arg2: &mut 0xf2513ec8c0158b6668e03ff5b813a529bdc1461d3727843528cf333eb86af34f::ticket::AuthorizedTransferTicket<T0>, arg3: 0x1::string::String) {
        assert!(0xf2513ec8c0158b6668e03ff5b813a529bdc1461d3727843528cf333eb86af34f::account::has_strategy_by_name(arg0, arg3), 0xf2513ec8c0158b6668e03ff5b813a529bdc1461d3727843528cf333eb86af34f::errors::strategy_not_found());
        let v0 = 0xf2513ec8c0158b6668e03ff5b813a529bdc1461d3727843528cf333eb86af34f::account::policies_for_strategy(arg0, arg1, arg3);
        assert!(!0x1::vector::is_empty<0xf2513ec8c0158b6668e03ff5b813a529bdc1461d3727843528cf333eb86af34f::policy::Policy>(&v0), 0xf2513ec8c0158b6668e03ff5b813a529bdc1461d3727843528cf333eb86af34f::errors::no_policies_for_strategy());
        0xf2513ec8c0158b6668e03ff5b813a529bdc1461d3727843528cf333eb86af34f::ticket::set_policies<T0>(arg2, arg1, v0);
    }

    // decompiled from Move bytecode v6
}

