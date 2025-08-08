module 0x1d1c128f63952a03886b375b3e27c97e3ae51d508a5ae98a4356699da621c0b2::agent {
    public fun add_position_to_ticket<T0, T1: store + key>(arg0: &mut 0x1d1c128f63952a03886b375b3e27c97e3ae51d508a5ae98a4356699da621c0b2::account::SmartAccount, arg1: &mut 0x1d1c128f63952a03886b375b3e27c97e3ae51d508a5ae98a4356699da621c0b2::ticket::AuthorizedTransferTicket, arg2: &0x1d1c128f63952a03886b375b3e27c97e3ae51d508a5ae98a4356699da621c0b2::acl::SmartAccountAcl, arg3: &mut 0x2::tx_context::TxContext) {
        0x1d1c128f63952a03886b375b3e27c97e3ae51d508a5ae98a4356699da621c0b2::ticket::add_value_internal<T1, 0x1d1c128f63952a03886b375b3e27c97e3ae51d508a5ae98a4356699da621c0b2::acl::SmartAccountAcl>(arg1, arg2, 0x1d1c128f63952a03886b375b3e27c97e3ae51d508a5ae98a4356699da621c0b2::keys::position(), 0x1d1c128f63952a03886b375b3e27c97e3ae51d508a5ae98a4356699da621c0b2::account::withdraw_object_internal<T0, T1>(arg0));
    }

    fun add_strategy_base_asset_if_amount_positive<T0, T1>(arg0: &mut 0x1d1c128f63952a03886b375b3e27c97e3ae51d508a5ae98a4356699da621c0b2::account::SmartAccount, arg1: &mut 0x1d1c128f63952a03886b375b3e27c97e3ae51d508a5ae98a4356699da621c0b2::ticket::AuthorizedTransferTicket, arg2: &0x1d1c128f63952a03886b375b3e27c97e3ae51d508a5ae98a4356699da621c0b2::acl::SmartAccountAcl, arg3: u64, arg4: &mut 0x2::tx_context::TxContext) {
        if (arg3 > 0) {
            0x1d1c128f63952a03886b375b3e27c97e3ae51d508a5ae98a4356699da621c0b2::ticket::add_value_internal<0x2::coin::Coin<T1>, 0x1d1c128f63952a03886b375b3e27c97e3ae51d508a5ae98a4356699da621c0b2::acl::SmartAccountAcl>(arg1, arg2, 0x1d1c128f63952a03886b375b3e27c97e3ae51d508a5ae98a4356699da621c0b2::keys::strategy_base_asset(), 0x1d1c128f63952a03886b375b3e27c97e3ae51d508a5ae98a4356699da621c0b2::account::withdraw_internal<T0, T1>(arg0, arg3, arg4));
        };
    }

    fun assert_agent_authorized(arg0: &0x1d1c128f63952a03886b375b3e27c97e3ae51d508a5ae98a4356699da621c0b2::config::GlobalConfig, arg1: &0x2::tx_context::TxContext) {
        0x1d1c128f63952a03886b375b3e27c97e3ae51d508a5ae98a4356699da621c0b2::config::assert_whitelisted_agent(arg0, 0x2::tx_context::sender(arg1));
    }

    fun consume_rules_if_present<T0>(arg0: &0x1d1c128f63952a03886b375b3e27c97e3ae51d508a5ae98a4356699da621c0b2::account::SmartAccount, arg1: 0x1::option::Option<vector<0x1d1c128f63952a03886b375b3e27c97e3ae51d508a5ae98a4356699da621c0b2::rule::Rule>>) {
        if (0x1::option::is_some<vector<0x1d1c128f63952a03886b375b3e27c97e3ae51d508a5ae98a4356699da621c0b2::rule::Rule>>(&arg1)) {
            let v0 = 0x1::option::destroy_some<vector<0x1d1c128f63952a03886b375b3e27c97e3ae51d508a5ae98a4356699da621c0b2::rule::Rule>>(arg1);
            let v1 = 0;
            while (v1 < 0x1::vector::length<0x1d1c128f63952a03886b375b3e27c97e3ae51d508a5ae98a4356699da621c0b2::rule::Rule>(&v0)) {
                0x1::vector::borrow<0x1d1c128f63952a03886b375b3e27c97e3ae51d508a5ae98a4356699da621c0b2::rule::Rule>(&v0, v1);
                v1 = v1 + 1;
            };
        } else {
            0x1::option::destroy_none<vector<0x1d1c128f63952a03886b375b3e27c97e3ae51d508a5ae98a4356699da621c0b2::rule::Rule>>(arg1);
        };
    }

    public fun consume_ticket<T0, T1, T2>(arg0: &mut 0x1d1c128f63952a03886b375b3e27c97e3ae51d508a5ae98a4356699da621c0b2::account::SmartAccount, arg1: 0x1d1c128f63952a03886b375b3e27c97e3ae51d508a5ae98a4356699da621c0b2::ticket::AuthorizedTransferTicket, arg2: &0x1d1c128f63952a03886b375b3e27c97e3ae51d508a5ae98a4356699da621c0b2::acl::SmartAccountAcl, arg3: &0x1d1c128f63952a03886b375b3e27c97e3ae51d508a5ae98a4356699da621c0b2::config::GlobalConfig, arg4: &mut 0x2::tx_context::TxContext) {
        assert_agent_authorized(arg3, arg4);
        let v0 = &mut arg1;
        process_ticket_by_keys<T0, T1, T2>(arg0, v0, arg2);
        0x1d1c128f63952a03886b375b3e27c97e3ae51d508a5ae98a4356699da621c0b2::ticket::burn(arg1);
    }

    fun deposit_asset_if_present<T0, T1>(arg0: &mut 0x1d1c128f63952a03886b375b3e27c97e3ae51d508a5ae98a4356699da621c0b2::account::SmartAccount, arg1: 0x1::option::Option<0x2::coin::Coin<T1>>) {
        if (0x1::option::is_some<0x2::coin::Coin<T1>>(&arg1)) {
            0x1d1c128f63952a03886b375b3e27c97e3ae51d508a5ae98a4356699da621c0b2::account::deposit_internal<T0, T1>(arg0, 0x1::option::destroy_some<0x2::coin::Coin<T1>>(arg1));
        } else {
            0x1::option::destroy_none<0x2::coin::Coin<T1>>(arg1);
        };
    }

    fun deposit_position_if_present<T0, T1: store + key>(arg0: &mut 0x1d1c128f63952a03886b375b3e27c97e3ae51d508a5ae98a4356699da621c0b2::account::SmartAccount, arg1: 0x1::option::Option<T1>) {
        if (0x1::option::is_some<T1>(&arg1)) {
            0x1d1c128f63952a03886b375b3e27c97e3ae51d508a5ae98a4356699da621c0b2::account::deposit_object_internal<T0, T1>(arg0, 0x1::option::destroy_some<T1>(arg1));
        } else {
            0x1::option::destroy_none<T1>(arg1);
        };
    }

    fun deposit_rewards_if_present<T0>(arg0: &mut 0x1d1c128f63952a03886b375b3e27c97e3ae51d508a5ae98a4356699da621c0b2::account::SmartAccount, arg1: 0x1::option::Option<0x2::coin::Coin<T0>>) {
        if (0x1::option::is_some<0x2::coin::Coin<T0>>(&arg1)) {
            0x1d1c128f63952a03886b375b3e27c97e3ae51d508a5ae98a4356699da621c0b2::account::deposit_rewards_internal<T0>(arg0, 0x2::coin::into_balance<T0>(0x1::option::destroy_some<0x2::coin::Coin<T0>>(arg1)));
        } else {
            0x1::option::destroy_none<0x2::coin::Coin<T0>>(arg1);
        };
    }

    fun deposit_strategy_base_asset_if_present<T0, T1>(arg0: &mut 0x1d1c128f63952a03886b375b3e27c97e3ae51d508a5ae98a4356699da621c0b2::account::SmartAccount, arg1: 0x1::option::Option<0x2::coin::Coin<T1>>) {
        if (0x1::option::is_some<0x2::coin::Coin<T1>>(&arg1)) {
            0x1d1c128f63952a03886b375b3e27c97e3ae51d508a5ae98a4356699da621c0b2::account::deposit_internal<T0, T1>(arg0, 0x1::option::destroy_some<0x2::coin::Coin<T1>>(arg1));
        } else {
            0x1::option::destroy_none<0x2::coin::Coin<T1>>(arg1);
        };
    }

    fun extract_asset_from_ticket<T0>(arg0: &mut 0x1d1c128f63952a03886b375b3e27c97e3ae51d508a5ae98a4356699da621c0b2::ticket::AuthorizedTransferTicket, arg1: &0x1d1c128f63952a03886b375b3e27c97e3ae51d508a5ae98a4356699da621c0b2::acl::SmartAccountAcl) : 0x1::option::Option<0x2::coin::Coin<T0>> {
        if (0x1d1c128f63952a03886b375b3e27c97e3ae51d508a5ae98a4356699da621c0b2::ticket::contains_asset<vector<u8>>(arg0, 0x1d1c128f63952a03886b375b3e27c97e3ae51d508a5ae98a4356699da621c0b2::keys::asset())) {
            0x1::option::some<0x2::coin::Coin<T0>>(0x1d1c128f63952a03886b375b3e27c97e3ae51d508a5ae98a4356699da621c0b2::ticket::remove_value_internal<0x2::coin::Coin<T0>, 0x1d1c128f63952a03886b375b3e27c97e3ae51d508a5ae98a4356699da621c0b2::acl::SmartAccountAcl>(arg0, arg1, 0x1d1c128f63952a03886b375b3e27c97e3ae51d508a5ae98a4356699da621c0b2::keys::asset()))
        } else {
            0x1::option::none<0x2::coin::Coin<T0>>()
        }
    }

    fun extract_last_rule_from_ticket(arg0: &mut 0x1d1c128f63952a03886b375b3e27c97e3ae51d508a5ae98a4356699da621c0b2::ticket::AuthorizedTransferTicket, arg1: &0x1d1c128f63952a03886b375b3e27c97e3ae51d508a5ae98a4356699da621c0b2::acl::SmartAccountAcl) : 0x1::option::Option<0x1d1c128f63952a03886b375b3e27c97e3ae51d508a5ae98a4356699da621c0b2::rule::Rule> {
        if (0x1d1c128f63952a03886b375b3e27c97e3ae51d508a5ae98a4356699da621c0b2::ticket::contains_asset<vector<u8>>(arg0, 0x1d1c128f63952a03886b375b3e27c97e3ae51d508a5ae98a4356699da621c0b2::keys::last_rule_consumed())) {
            0x1d1c128f63952a03886b375b3e27c97e3ae51d508a5ae98a4356699da621c0b2::ticket::remove_value_internal<0x1::option::Option<0x1d1c128f63952a03886b375b3e27c97e3ae51d508a5ae98a4356699da621c0b2::rule::Rule>, 0x1d1c128f63952a03886b375b3e27c97e3ae51d508a5ae98a4356699da621c0b2::acl::SmartAccountAcl>(arg0, arg1, 0x1d1c128f63952a03886b375b3e27c97e3ae51d508a5ae98a4356699da621c0b2::keys::last_rule_consumed())
        } else {
            0x1::option::none<0x1d1c128f63952a03886b375b3e27c97e3ae51d508a5ae98a4356699da621c0b2::rule::Rule>()
        }
    }

    fun extract_position_from_ticket<T0: store + key>(arg0: &mut 0x1d1c128f63952a03886b375b3e27c97e3ae51d508a5ae98a4356699da621c0b2::ticket::AuthorizedTransferTicket, arg1: &0x1d1c128f63952a03886b375b3e27c97e3ae51d508a5ae98a4356699da621c0b2::acl::SmartAccountAcl) : 0x1::option::Option<T0> {
        if (0x1d1c128f63952a03886b375b3e27c97e3ae51d508a5ae98a4356699da621c0b2::ticket::contains_asset<vector<u8>>(arg0, 0x1d1c128f63952a03886b375b3e27c97e3ae51d508a5ae98a4356699da621c0b2::keys::position())) {
            0x1::option::some<T0>(0x1d1c128f63952a03886b375b3e27c97e3ae51d508a5ae98a4356699da621c0b2::ticket::remove_value_internal<T0, 0x1d1c128f63952a03886b375b3e27c97e3ae51d508a5ae98a4356699da621c0b2::acl::SmartAccountAcl>(arg0, arg1, 0x1d1c128f63952a03886b375b3e27c97e3ae51d508a5ae98a4356699da621c0b2::keys::position()))
        } else {
            0x1::option::none<T0>()
        }
    }

    fun extract_rewards_from_ticket<T0>(arg0: &mut 0x1d1c128f63952a03886b375b3e27c97e3ae51d508a5ae98a4356699da621c0b2::ticket::AuthorizedTransferTicket, arg1: &0x1d1c128f63952a03886b375b3e27c97e3ae51d508a5ae98a4356699da621c0b2::acl::SmartAccountAcl) : 0x1::option::Option<0x2::coin::Coin<T0>> {
        if (0x1d1c128f63952a03886b375b3e27c97e3ae51d508a5ae98a4356699da621c0b2::ticket::contains_asset<vector<u8>>(arg0, 0x1d1c128f63952a03886b375b3e27c97e3ae51d508a5ae98a4356699da621c0b2::keys::rewards())) {
            0x1::option::some<0x2::coin::Coin<T0>>(0x1d1c128f63952a03886b375b3e27c97e3ae51d508a5ae98a4356699da621c0b2::ticket::remove_value_internal<0x2::coin::Coin<T0>, 0x1d1c128f63952a03886b375b3e27c97e3ae51d508a5ae98a4356699da621c0b2::acl::SmartAccountAcl>(arg0, arg1, 0x1d1c128f63952a03886b375b3e27c97e3ae51d508a5ae98a4356699da621c0b2::keys::rewards()))
        } else {
            0x1::option::none<0x2::coin::Coin<T0>>()
        }
    }

    fun extract_rules_from_ticket(arg0: &mut 0x1d1c128f63952a03886b375b3e27c97e3ae51d508a5ae98a4356699da621c0b2::ticket::AuthorizedTransferTicket, arg1: &0x1d1c128f63952a03886b375b3e27c97e3ae51d508a5ae98a4356699da621c0b2::acl::SmartAccountAcl) : 0x1::option::Option<vector<0x1d1c128f63952a03886b375b3e27c97e3ae51d508a5ae98a4356699da621c0b2::rule::Rule>> {
        if (0x1d1c128f63952a03886b375b3e27c97e3ae51d508a5ae98a4356699da621c0b2::ticket::contains_asset<vector<u8>>(arg0, 0x1d1c128f63952a03886b375b3e27c97e3ae51d508a5ae98a4356699da621c0b2::keys::rules())) {
            0x1::option::some<vector<0x1d1c128f63952a03886b375b3e27c97e3ae51d508a5ae98a4356699da621c0b2::rule::Rule>>(0x1d1c128f63952a03886b375b3e27c97e3ae51d508a5ae98a4356699da621c0b2::ticket::remove_value_internal<vector<0x1d1c128f63952a03886b375b3e27c97e3ae51d508a5ae98a4356699da621c0b2::rule::Rule>, 0x1d1c128f63952a03886b375b3e27c97e3ae51d508a5ae98a4356699da621c0b2::acl::SmartAccountAcl>(arg0, arg1, 0x1d1c128f63952a03886b375b3e27c97e3ae51d508a5ae98a4356699da621c0b2::keys::rules()))
        } else {
            0x1::option::none<vector<0x1d1c128f63952a03886b375b3e27c97e3ae51d508a5ae98a4356699da621c0b2::rule::Rule>>()
        }
    }

    fun extract_strategy_base_asset_from_ticket<T0>(arg0: &mut 0x1d1c128f63952a03886b375b3e27c97e3ae51d508a5ae98a4356699da621c0b2::ticket::AuthorizedTransferTicket, arg1: &0x1d1c128f63952a03886b375b3e27c97e3ae51d508a5ae98a4356699da621c0b2::acl::SmartAccountAcl) : 0x1::option::Option<0x2::coin::Coin<T0>> {
        if (0x1d1c128f63952a03886b375b3e27c97e3ae51d508a5ae98a4356699da621c0b2::ticket::contains_asset<vector<u8>>(arg0, 0x1d1c128f63952a03886b375b3e27c97e3ae51d508a5ae98a4356699da621c0b2::keys::strategy_base_asset())) {
            0x1::option::some<0x2::coin::Coin<T0>>(0x1d1c128f63952a03886b375b3e27c97e3ae51d508a5ae98a4356699da621c0b2::ticket::remove_value_internal<0x2::coin::Coin<T0>, 0x1d1c128f63952a03886b375b3e27c97e3ae51d508a5ae98a4356699da621c0b2::acl::SmartAccountAcl>(arg0, arg1, 0x1d1c128f63952a03886b375b3e27c97e3ae51d508a5ae98a4356699da621c0b2::keys::strategy_base_asset()))
        } else {
            0x1::option::none<0x2::coin::Coin<T0>>()
        }
    }

    public fun get_ticket_keys(arg0: &0x1d1c128f63952a03886b375b3e27c97e3ae51d508a5ae98a4356699da621c0b2::ticket::AuthorizedTransferTicket) : &vector<vector<u8>> {
        0x1d1c128f63952a03886b375b3e27c97e3ae51d508a5ae98a4356699da621c0b2::ticket::get_keys(arg0)
    }

    public fun has_ticket_key(arg0: &0x1d1c128f63952a03886b375b3e27c97e3ae51d508a5ae98a4356699da621c0b2::ticket::AuthorizedTransferTicket, arg1: vector<u8>) : bool {
        0x1d1c128f63952a03886b375b3e27c97e3ae51d508a5ae98a4356699da621c0b2::ticket::has_key(arg0, arg1)
    }

    public fun issue_ticket<T0, T1>(arg0: &mut 0x1d1c128f63952a03886b375b3e27c97e3ae51d508a5ae98a4356699da621c0b2::account::SmartAccount, arg1: u64, arg2: &0x1d1c128f63952a03886b375b3e27c97e3ae51d508a5ae98a4356699da621c0b2::config::GlobalConfig, arg3: 0x2::object::ID, arg4: &0x1d1c128f63952a03886b375b3e27c97e3ae51d508a5ae98a4356699da621c0b2::acl::SmartAccountAcl, arg5: &mut 0x2::tx_context::TxContext) : 0x1d1c128f63952a03886b375b3e27c97e3ae51d508a5ae98a4356699da621c0b2::ticket::AuthorizedTransferTicket {
        assert_agent_authorized(arg2, arg5);
        let v0 = mint_ticket(arg3, arg4, arg5);
        let v1 = &mut v0;
        write_strategies<T0>(arg0, arg2, v1, arg4);
        let v2 = &mut v0;
        write_last_rule(v2, arg4, *0x1d1c128f63952a03886b375b3e27c97e3ae51d508a5ae98a4356699da621c0b2::account::last_rule_consumed(arg0));
        let v3 = &mut v0;
        add_strategy_base_asset_if_amount_positive<T0, T1>(arg0, v3, arg4, arg1, arg5);
        v0
    }

    fun mint_ticket(arg0: 0x2::object::ID, arg1: &0x1d1c128f63952a03886b375b3e27c97e3ae51d508a5ae98a4356699da621c0b2::acl::SmartAccountAcl, arg2: &mut 0x2::tx_context::TxContext) : 0x1d1c128f63952a03886b375b3e27c97e3ae51d508a5ae98a4356699da621c0b2::ticket::AuthorizedTransferTicket {
        0x1d1c128f63952a03886b375b3e27c97e3ae51d508a5ae98a4356699da621c0b2::ticket::issue(arg0, 0x2::object::id<0x1d1c128f63952a03886b375b3e27c97e3ae51d508a5ae98a4356699da621c0b2::acl::SmartAccountAcl>(arg1), arg2)
    }

    public fun process_position_in_ticket<T0, T1: store + key>(arg0: &mut 0x1d1c128f63952a03886b375b3e27c97e3ae51d508a5ae98a4356699da621c0b2::account::SmartAccount, arg1: &mut 0x1d1c128f63952a03886b375b3e27c97e3ae51d508a5ae98a4356699da621c0b2::ticket::AuthorizedTransferTicket, arg2: &0x1d1c128f63952a03886b375b3e27c97e3ae51d508a5ae98a4356699da621c0b2::acl::SmartAccountAcl) {
        if (0x1d1c128f63952a03886b375b3e27c97e3ae51d508a5ae98a4356699da621c0b2::ticket::contains_asset<vector<u8>>(arg1, 0x1d1c128f63952a03886b375b3e27c97e3ae51d508a5ae98a4356699da621c0b2::keys::position())) {
            deposit_position_if_present<T0, T1>(arg0, extract_position_from_ticket<T1>(arg1, arg2));
        };
    }

    fun process_ticket_by_keys<T0, T1, T2>(arg0: &mut 0x1d1c128f63952a03886b375b3e27c97e3ae51d508a5ae98a4356699da621c0b2::account::SmartAccount, arg1: &mut 0x1d1c128f63952a03886b375b3e27c97e3ae51d508a5ae98a4356699da621c0b2::ticket::AuthorizedTransferTicket, arg2: &0x1d1c128f63952a03886b375b3e27c97e3ae51d508a5ae98a4356699da621c0b2::acl::SmartAccountAcl) {
        if (0x1d1c128f63952a03886b375b3e27c97e3ae51d508a5ae98a4356699da621c0b2::ticket::contains_asset<vector<u8>>(arg1, 0x1d1c128f63952a03886b375b3e27c97e3ae51d508a5ae98a4356699da621c0b2::keys::strategy_base_asset())) {
            let v0 = extract_strategy_base_asset_from_ticket<T1>(arg1, arg2);
            deposit_strategy_base_asset_if_present<T0, T1>(arg0, v0);
        };
        if (0x1d1c128f63952a03886b375b3e27c97e3ae51d508a5ae98a4356699da621c0b2::ticket::contains_asset<vector<u8>>(arg1, 0x1d1c128f63952a03886b375b3e27c97e3ae51d508a5ae98a4356699da621c0b2::keys::asset())) {
            let v1 = extract_asset_from_ticket<T1>(arg1, arg2);
            deposit_asset_if_present<T0, T1>(arg0, v1);
        };
        if (0x1d1c128f63952a03886b375b3e27c97e3ae51d508a5ae98a4356699da621c0b2::ticket::contains_asset<vector<u8>>(arg1, 0x1d1c128f63952a03886b375b3e27c97e3ae51d508a5ae98a4356699da621c0b2::keys::rewards())) {
            let v2 = extract_rewards_from_ticket<T2>(arg1, arg2);
            deposit_rewards_if_present<T2>(arg0, v2);
        };
        if (0x1d1c128f63952a03886b375b3e27c97e3ae51d508a5ae98a4356699da621c0b2::ticket::contains_asset<vector<u8>>(arg1, 0x1d1c128f63952a03886b375b3e27c97e3ae51d508a5ae98a4356699da621c0b2::keys::rules())) {
            let v3 = extract_rules_from_ticket(arg1, arg2);
            consume_rules_if_present<T0>(arg0, v3);
        };
        if (0x1d1c128f63952a03886b375b3e27c97e3ae51d508a5ae98a4356699da621c0b2::ticket::contains_asset<vector<u8>>(arg1, 0x1d1c128f63952a03886b375b3e27c97e3ae51d508a5ae98a4356699da621c0b2::keys::last_rule_consumed())) {
            set_last_rule_if_present(arg0, extract_last_rule_from_ticket(arg1, arg2));
        };
    }

    fun set_last_rule_if_present(arg0: &mut 0x1d1c128f63952a03886b375b3e27c97e3ae51d508a5ae98a4356699da621c0b2::account::SmartAccount, arg1: 0x1::option::Option<0x1d1c128f63952a03886b375b3e27c97e3ae51d508a5ae98a4356699da621c0b2::rule::Rule>) {
        0x1d1c128f63952a03886b375b3e27c97e3ae51d508a5ae98a4356699da621c0b2::account::set_last_rule_consumed(arg0, arg1);
    }

    fun write_last_rule(arg0: &mut 0x1d1c128f63952a03886b375b3e27c97e3ae51d508a5ae98a4356699da621c0b2::ticket::AuthorizedTransferTicket, arg1: &0x1d1c128f63952a03886b375b3e27c97e3ae51d508a5ae98a4356699da621c0b2::acl::SmartAccountAcl, arg2: 0x1::option::Option<0x1d1c128f63952a03886b375b3e27c97e3ae51d508a5ae98a4356699da621c0b2::rule::Rule>) {
        if (0x1::option::is_some<0x1d1c128f63952a03886b375b3e27c97e3ae51d508a5ae98a4356699da621c0b2::rule::Rule>(&arg2)) {
            0x1d1c128f63952a03886b375b3e27c97e3ae51d508a5ae98a4356699da621c0b2::ticket::add_value_internal<0x1::option::Option<0x1d1c128f63952a03886b375b3e27c97e3ae51d508a5ae98a4356699da621c0b2::rule::Rule>, 0x1d1c128f63952a03886b375b3e27c97e3ae51d508a5ae98a4356699da621c0b2::acl::SmartAccountAcl>(arg0, arg1, 0x1d1c128f63952a03886b375b3e27c97e3ae51d508a5ae98a4356699da621c0b2::keys::last_rule_consumed(), arg2);
        };
    }

    fun write_strategies<T0>(arg0: &0x1d1c128f63952a03886b375b3e27c97e3ae51d508a5ae98a4356699da621c0b2::account::SmartAccount, arg1: &0x1d1c128f63952a03886b375b3e27c97e3ae51d508a5ae98a4356699da621c0b2::config::GlobalConfig, arg2: &mut 0x1d1c128f63952a03886b375b3e27c97e3ae51d508a5ae98a4356699da621c0b2::ticket::AuthorizedTransferTicket, arg3: &0x1d1c128f63952a03886b375b3e27c97e3ae51d508a5ae98a4356699da621c0b2::acl::SmartAccountAcl) {
        let v0 = 0x1d1c128f63952a03886b375b3e27c97e3ae51d508a5ae98a4356699da621c0b2::account::find_strategy_key_for_base_asset<T0>(arg0);
        if (0x1::option::is_some<0x1d1c128f63952a03886b375b3e27c97e3ae51d508a5ae98a4356699da621c0b2::strategy::StrategyKey>(&v0)) {
            let v1 = 0x1d1c128f63952a03886b375b3e27c97e3ae51d508a5ae98a4356699da621c0b2::config::get_rules_for_strategy(arg1, 0x1::option::destroy_some<0x1d1c128f63952a03886b375b3e27c97e3ae51d508a5ae98a4356699da621c0b2::strategy::StrategyKey>(v0));
            if (!0x1::vector::is_empty<0x1d1c128f63952a03886b375b3e27c97e3ae51d508a5ae98a4356699da621c0b2::rule::Rule>(&v1)) {
                0x1d1c128f63952a03886b375b3e27c97e3ae51d508a5ae98a4356699da621c0b2::ticket::add_value_internal<vector<0x1d1c128f63952a03886b375b3e27c97e3ae51d508a5ae98a4356699da621c0b2::rule::Rule>, 0x1d1c128f63952a03886b375b3e27c97e3ae51d508a5ae98a4356699da621c0b2::acl::SmartAccountAcl>(arg2, arg3, 0x1d1c128f63952a03886b375b3e27c97e3ae51d508a5ae98a4356699da621c0b2::keys::rules(), v1);
            };
            return
        } else {
            0x1::option::destroy_none<0x1d1c128f63952a03886b375b3e27c97e3ae51d508a5ae98a4356699da621c0b2::strategy::StrategyKey>(v0);
            abort 0x1d1c128f63952a03886b375b3e27c97e3ae51d508a5ae98a4356699da621c0b2::errors::config_rule_not_found()
        };
    }

    // decompiled from Move bytecode v6
}

