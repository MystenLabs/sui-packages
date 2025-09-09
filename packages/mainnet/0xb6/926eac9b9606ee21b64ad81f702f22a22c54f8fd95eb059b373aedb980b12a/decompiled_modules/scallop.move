module 0xb6926eac9b9606ee21b64ad81f702f22a22c54f8fd95eb059b373aedb980b12a::scallop {
    struct ScallopAdapterModule has drop {
        dummy_field: bool,
    }

    public fun deposit<T0>(arg0: &0xefe8b36d5b2e43728cc323298626b83177803521d195cfb11e15b910e892fddf::version::Version, arg1: &mut 0x44b06989cb7a6403320783c8a3c73774e50b07590e5010866d3503637ba50b0f::ticket::AuthorizedTransferTicket, arg2: &0xb6926eac9b9606ee21b64ad81f702f22a22c54f8fd95eb059b373aedb980b12a::agent_acl::AgentAdapterAcl, arg3: &mut 0xefe8b36d5b2e43728cc323298626b83177803521d195cfb11e15b910e892fddf::market::Market, arg4: &0x2::clock::Clock, arg5: &mut 0x2::tx_context::TxContext) {
        let v0 = ScallopAdapterModule{dummy_field: false};
        0x44b06989cb7a6403320783c8a3c73774e50b07590e5010866d3503637ba50b0f::ticket::set_adapter_name<0xb6926eac9b9606ee21b64ad81f702f22a22c54f8fd95eb059b373aedb980b12a::agent_acl::Access, ScallopAdapterModule>(arg1, 0xb6926eac9b9606ee21b64ad81f702f22a22c54f8fd95eb059b373aedb980b12a::agent_acl::access(arg2), 0x1::string::utf8(b"scallop"), &v0);
        let v1 = 0x44b06989cb7a6403320783c8a3c73774e50b07590e5010866d3503637ba50b0f::ticket::withdraw_coin<T0, 0xb6926eac9b9606ee21b64ad81f702f22a22c54f8fd95eb059b373aedb980b12a::agent_acl::Access, ScallopAdapterModule>(arg1, 0xb6926eac9b9606ee21b64ad81f702f22a22c54f8fd95eb059b373aedb980b12a::agent_acl::access(arg2), 0x44b06989cb7a6403320783c8a3c73774e50b07590e5010866d3503637ba50b0f::ticket::asset_balance<T0>(arg1), &v0, arg5);
        let v2 = 0x2::coin::value<T0>(&v1);
        0x44b06989cb7a6403320783c8a3c73774e50b07590e5010866d3503637ba50b0f::ticket::add_coin<0xefe8b36d5b2e43728cc323298626b83177803521d195cfb11e15b910e892fddf::reserve::MarketCoin<T0>, 0xb6926eac9b9606ee21b64ad81f702f22a22c54f8fd95eb059b373aedb980b12a::agent_acl::Access, ScallopAdapterModule>(arg1, 0xb6926eac9b9606ee21b64ad81f702f22a22c54f8fd95eb059b373aedb980b12a::agent_acl::access(arg2), 0xefe8b36d5b2e43728cc323298626b83177803521d195cfb11e15b910e892fddf::mint::mint<T0>(arg0, arg3, v1, arg4, arg5), &v0);
        0x44b06989cb7a6403320783c8a3c73774e50b07590e5010866d3503637ba50b0f::ticket::record_adapter_deposit<ScallopAdapterModule, 0xb6926eac9b9606ee21b64ad81f702f22a22c54f8fd95eb059b373aedb980b12a::agent_acl::Access>(arg1, 0xb6926eac9b9606ee21b64ad81f702f22a22c54f8fd95eb059b373aedb980b12a::agent_acl::access(arg2), v2, &v0);
        let v3 = if (0x44b06989cb7a6403320783c8a3c73774e50b07590e5010866d3503637ba50b0f::ticket::is_agent_ticket(arg1)) {
            0xb6926eac9b9606ee21b64ad81f702f22a22c54f8fd95eb059b373aedb980b12a::events::agent_owner_type()
        } else {
            0xb6926eac9b9606ee21b64ad81f702f22a22c54f8fd95eb059b373aedb980b12a::events::user_owner_type()
        };
        0xb6926eac9b9606ee21b64ad81f702f22a22c54f8fd95eb059b373aedb980b12a::events::emit_adapter_activity_event(0x44b06989cb7a6403320783c8a3c73774e50b07590e5010866d3503637ba50b0f::ticket::get_account_id(arg1), 0x1::string::utf8(b"scallop"), 0xb6926eac9b9606ee21b64ad81f702f22a22c54f8fd95eb059b373aedb980b12a::events::deposit_operation(), v3, 0x2::tx_context::sender(arg5), 0x44b06989cb7a6403320783c8a3c73774e50b07590e5010866d3503637ba50b0f::ticket::get_strategy_name(arg1), 0x1::type_name::get<T0>(), v2);
    }

    public fun withdraw_all<T0>(arg0: &0xefe8b36d5b2e43728cc323298626b83177803521d195cfb11e15b910e892fddf::version::Version, arg1: &mut 0x44b06989cb7a6403320783c8a3c73774e50b07590e5010866d3503637ba50b0f::ticket::AuthorizedTransferTicket, arg2: &0xb6926eac9b9606ee21b64ad81f702f22a22c54f8fd95eb059b373aedb980b12a::agent_acl::AgentAdapterAcl, arg3: &mut 0xefe8b36d5b2e43728cc323298626b83177803521d195cfb11e15b910e892fddf::market::Market, arg4: &0x2::clock::Clock, arg5: &mut 0x2::tx_context::TxContext) {
        let v0 = ScallopAdapterModule{dummy_field: false};
        assert!(0x44b06989cb7a6403320783c8a3c73774e50b07590e5010866d3503637ba50b0f::ticket::has_asset_type<0xefe8b36d5b2e43728cc323298626b83177803521d195cfb11e15b910e892fddf::reserve::MarketCoin<T0>>(arg1), 0);
        let v1 = 0xefe8b36d5b2e43728cc323298626b83177803521d195cfb11e15b910e892fddf::redeem::redeem<T0>(arg0, arg3, 0x44b06989cb7a6403320783c8a3c73774e50b07590e5010866d3503637ba50b0f::ticket::withdraw_coin<0xefe8b36d5b2e43728cc323298626b83177803521d195cfb11e15b910e892fddf::reserve::MarketCoin<T0>, 0xb6926eac9b9606ee21b64ad81f702f22a22c54f8fd95eb059b373aedb980b12a::agent_acl::Access, ScallopAdapterModule>(arg1, 0xb6926eac9b9606ee21b64ad81f702f22a22c54f8fd95eb059b373aedb980b12a::agent_acl::access(arg2), 0x44b06989cb7a6403320783c8a3c73774e50b07590e5010866d3503637ba50b0f::ticket::asset_balance<0xefe8b36d5b2e43728cc323298626b83177803521d195cfb11e15b910e892fddf::reserve::MarketCoin<T0>>(arg1), &v0, arg5), arg4, arg5);
        let v2 = 0x2::coin::value<T0>(&v1);
        let v3 = 0xb6926eac9b9606ee21b64ad81f702f22a22c54f8fd95eb059b373aedb980b12a::utils::calculate_yield_performance_fee(arg1, v2, 0x44b06989cb7a6403320783c8a3c73774e50b07590e5010866d3503637ba50b0f::ticket::adapter_total_deposited<ScallopAdapterModule>(arg1));
        if (v3 > 0) {
            0x44b06989cb7a6403320783c8a3c73774e50b07590e5010866d3503637ba50b0f::ticket::collect_performance_fee<T0, 0xb6926eac9b9606ee21b64ad81f702f22a22c54f8fd95eb059b373aedb980b12a::agent_acl::Access>(arg1, 0xb6926eac9b9606ee21b64ad81f702f22a22c54f8fd95eb059b373aedb980b12a::agent_acl::access(arg2), 0x2::coin::split<T0>(&mut v1, v3, arg5));
        };
        0x44b06989cb7a6403320783c8a3c73774e50b07590e5010866d3503637ba50b0f::ticket::add_coin<T0, 0xb6926eac9b9606ee21b64ad81f702f22a22c54f8fd95eb059b373aedb980b12a::agent_acl::Access, ScallopAdapterModule>(arg1, 0xb6926eac9b9606ee21b64ad81f702f22a22c54f8fd95eb059b373aedb980b12a::agent_acl::access(arg2), v1, &v0);
        0x44b06989cb7a6403320783c8a3c73774e50b07590e5010866d3503637ba50b0f::ticket::reset_adapter_deposits<ScallopAdapterModule, 0xb6926eac9b9606ee21b64ad81f702f22a22c54f8fd95eb059b373aedb980b12a::agent_acl::Access>(arg1, 0xb6926eac9b9606ee21b64ad81f702f22a22c54f8fd95eb059b373aedb980b12a::agent_acl::access(arg2), &v0);
        let v4 = if (0x44b06989cb7a6403320783c8a3c73774e50b07590e5010866d3503637ba50b0f::ticket::is_agent_ticket(arg1)) {
            0xb6926eac9b9606ee21b64ad81f702f22a22c54f8fd95eb059b373aedb980b12a::events::agent_owner_type()
        } else {
            0xb6926eac9b9606ee21b64ad81f702f22a22c54f8fd95eb059b373aedb980b12a::events::user_owner_type()
        };
        0xb6926eac9b9606ee21b64ad81f702f22a22c54f8fd95eb059b373aedb980b12a::events::emit_adapter_activity_event(0x44b06989cb7a6403320783c8a3c73774e50b07590e5010866d3503637ba50b0f::ticket::get_account_id(arg1), 0x1::string::utf8(b"scallop"), 0xb6926eac9b9606ee21b64ad81f702f22a22c54f8fd95eb059b373aedb980b12a::events::withdraw_operation(), v4, 0x2::tx_context::sender(arg5), 0x44b06989cb7a6403320783c8a3c73774e50b07590e5010866d3503637ba50b0f::ticket::get_strategy_name(arg1), 0x1::type_name::get<T0>(), v2);
    }

    // decompiled from Move bytecode v6
}

