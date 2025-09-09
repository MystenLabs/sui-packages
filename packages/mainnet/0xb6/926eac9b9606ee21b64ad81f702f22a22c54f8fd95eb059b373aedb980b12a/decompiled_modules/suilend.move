module 0xb6926eac9b9606ee21b64ad81f702f22a22c54f8fd95eb059b373aedb980b12a::suilend {
    struct SuilendAdapterModule has drop {
        dummy_field: bool,
    }

    public fun claim_rewards<T0, T1, T2>(arg0: &mut 0x1f54a9a2d71799553197e9ea24557797c6398d6a65f2d4d3818c9304b75d5e21::lending_market::LendingMarket<T0>, arg1: &mut 0x44b06989cb7a6403320783c8a3c73774e50b07590e5010866d3503637ba50b0f::ticket::AuthorizedTransferTicket, arg2: &0xb6926eac9b9606ee21b64ad81f702f22a22c54f8fd95eb059b373aedb980b12a::agent_acl::AgentAdapterAcl, arg3: u64, arg4: bool, arg5: &0x2::clock::Clock, arg6: &mut 0x2::tx_context::TxContext) {
        let v0 = SuilendAdapterModule{dummy_field: false};
        if (!0x44b06989cb7a6403320783c8a3c73774e50b07590e5010866d3503637ba50b0f::ticket::has_asset_type<0x1f54a9a2d71799553197e9ea24557797c6398d6a65f2d4d3818c9304b75d5e21::lending_market::ObligationOwnerCap<T0>>(arg1)) {
            return
        };
        let v1 = 0x44b06989cb7a6403320783c8a3c73774e50b07590e5010866d3503637ba50b0f::ticket::withdraw_object<0x1f54a9a2d71799553197e9ea24557797c6398d6a65f2d4d3818c9304b75d5e21::lending_market::ObligationOwnerCap<T0>, 0xb6926eac9b9606ee21b64ad81f702f22a22c54f8fd95eb059b373aedb980b12a::agent_acl::Access, SuilendAdapterModule>(arg1, 0xb6926eac9b9606ee21b64ad81f702f22a22c54f8fd95eb059b373aedb980b12a::agent_acl::access(arg2), &v0);
        let v2 = 0x1f54a9a2d71799553197e9ea24557797c6398d6a65f2d4d3818c9304b75d5e21::lending_market::claim_rewards<T0, T2>(arg0, &v1, arg5, get_reserve_id<T0, T1>(arg0), arg3, arg4, arg6);
        0x44b06989cb7a6403320783c8a3c73774e50b07590e5010866d3503637ba50b0f::ticket::add_object<0x1f54a9a2d71799553197e9ea24557797c6398d6a65f2d4d3818c9304b75d5e21::lending_market::ObligationOwnerCap<T0>, 0xb6926eac9b9606ee21b64ad81f702f22a22c54f8fd95eb059b373aedb980b12a::agent_acl::Access, SuilendAdapterModule>(arg1, 0xb6926eac9b9606ee21b64ad81f702f22a22c54f8fd95eb059b373aedb980b12a::agent_acl::access(arg2), v1, &v0);
        let v3 = 0x2::coin::value<T2>(&v2);
        let v4 = 0x44b06989cb7a6403320783c8a3c73774e50b07590e5010866d3503637ba50b0f::ticket::calculate_performance_fee(arg1, v3);
        if (v4 > 0) {
            0x44b06989cb7a6403320783c8a3c73774e50b07590e5010866d3503637ba50b0f::ticket::collect_performance_fee<T2, 0xb6926eac9b9606ee21b64ad81f702f22a22c54f8fd95eb059b373aedb980b12a::agent_acl::Access>(arg1, 0xb6926eac9b9606ee21b64ad81f702f22a22c54f8fd95eb059b373aedb980b12a::agent_acl::access(arg2), 0x2::coin::split<T2>(&mut v2, v4, arg6));
        };
        0x44b06989cb7a6403320783c8a3c73774e50b07590e5010866d3503637ba50b0f::ticket::add_coin<T2, 0xb6926eac9b9606ee21b64ad81f702f22a22c54f8fd95eb059b373aedb980b12a::agent_acl::Access, SuilendAdapterModule>(arg1, 0xb6926eac9b9606ee21b64ad81f702f22a22c54f8fd95eb059b373aedb980b12a::agent_acl::access(arg2), v2, &v0);
        let v5 = if (0x44b06989cb7a6403320783c8a3c73774e50b07590e5010866d3503637ba50b0f::ticket::is_agent_ticket(arg1)) {
            0xb6926eac9b9606ee21b64ad81f702f22a22c54f8fd95eb059b373aedb980b12a::events::agent_owner_type()
        } else {
            0xb6926eac9b9606ee21b64ad81f702f22a22c54f8fd95eb059b373aedb980b12a::events::user_owner_type()
        };
        0xb6926eac9b9606ee21b64ad81f702f22a22c54f8fd95eb059b373aedb980b12a::events::emit_adapter_activity_event(0x44b06989cb7a6403320783c8a3c73774e50b07590e5010866d3503637ba50b0f::ticket::get_account_id(arg1), 0x1::string::utf8(b"suilend"), 0xb6926eac9b9606ee21b64ad81f702f22a22c54f8fd95eb059b373aedb980b12a::events::claim_reward_operation(), v5, 0x2::tx_context::sender(arg6), 0x44b06989cb7a6403320783c8a3c73774e50b07590e5010866d3503637ba50b0f::ticket::get_strategy_name(arg1), 0x1::type_name::get<T2>(), v3);
    }

    public fun deposit<T0, T1>(arg0: &mut 0x1f54a9a2d71799553197e9ea24557797c6398d6a65f2d4d3818c9304b75d5e21::lending_market::LendingMarket<T0>, arg1: &mut 0x44b06989cb7a6403320783c8a3c73774e50b07590e5010866d3503637ba50b0f::ticket::AuthorizedTransferTicket, arg2: &0xb6926eac9b9606ee21b64ad81f702f22a22c54f8fd95eb059b373aedb980b12a::agent_acl::AgentAdapterAcl, arg3: &0x2::clock::Clock, arg4: &mut 0x2::tx_context::TxContext) {
        let v0 = SuilendAdapterModule{dummy_field: false};
        0x44b06989cb7a6403320783c8a3c73774e50b07590e5010866d3503637ba50b0f::ticket::set_adapter_name<0xb6926eac9b9606ee21b64ad81f702f22a22c54f8fd95eb059b373aedb980b12a::agent_acl::Access, SuilendAdapterModule>(arg1, 0xb6926eac9b9606ee21b64ad81f702f22a22c54f8fd95eb059b373aedb980b12a::agent_acl::access(arg2), 0x1::string::utf8(b"suilend"), &v0);
        let v1 = 0x44b06989cb7a6403320783c8a3c73774e50b07590e5010866d3503637ba50b0f::ticket::asset_balance<T1>(arg1);
        let v2 = if (0x44b06989cb7a6403320783c8a3c73774e50b07590e5010866d3503637ba50b0f::ticket::has_asset_type<0x1f54a9a2d71799553197e9ea24557797c6398d6a65f2d4d3818c9304b75d5e21::lending_market::ObligationOwnerCap<T0>>(arg1)) {
            0x44b06989cb7a6403320783c8a3c73774e50b07590e5010866d3503637ba50b0f::ticket::withdraw_object<0x1f54a9a2d71799553197e9ea24557797c6398d6a65f2d4d3818c9304b75d5e21::lending_market::ObligationOwnerCap<T0>, 0xb6926eac9b9606ee21b64ad81f702f22a22c54f8fd95eb059b373aedb980b12a::agent_acl::Access, SuilendAdapterModule>(arg1, 0xb6926eac9b9606ee21b64ad81f702f22a22c54f8fd95eb059b373aedb980b12a::agent_acl::access(arg2), &v0)
        } else {
            0x1f54a9a2d71799553197e9ea24557797c6398d6a65f2d4d3818c9304b75d5e21::lending_market::create_obligation<T0>(arg0, arg4)
        };
        let v3 = v2;
        let v4 = 0x1f54a9a2d71799553197e9ea24557797c6398d6a65f2d4d3818c9304b75d5e21::lending_market::reserve_array_index<T0, T1>(arg0);
        0x1f54a9a2d71799553197e9ea24557797c6398d6a65f2d4d3818c9304b75d5e21::lending_market::deposit_ctokens_into_obligation<T0, T1>(arg0, v4, &v3, arg3, 0x1f54a9a2d71799553197e9ea24557797c6398d6a65f2d4d3818c9304b75d5e21::lending_market::deposit_liquidity_and_mint_ctokens<T0, T1>(arg0, v4, arg3, 0x44b06989cb7a6403320783c8a3c73774e50b07590e5010866d3503637ba50b0f::ticket::withdraw_coin<T1, 0xb6926eac9b9606ee21b64ad81f702f22a22c54f8fd95eb059b373aedb980b12a::agent_acl::Access, SuilendAdapterModule>(arg1, 0xb6926eac9b9606ee21b64ad81f702f22a22c54f8fd95eb059b373aedb980b12a::agent_acl::access(arg2), v1, &v0, arg4), arg4), arg4);
        0x44b06989cb7a6403320783c8a3c73774e50b07590e5010866d3503637ba50b0f::ticket::add_object<0x1f54a9a2d71799553197e9ea24557797c6398d6a65f2d4d3818c9304b75d5e21::lending_market::ObligationOwnerCap<T0>, 0xb6926eac9b9606ee21b64ad81f702f22a22c54f8fd95eb059b373aedb980b12a::agent_acl::Access, SuilendAdapterModule>(arg1, 0xb6926eac9b9606ee21b64ad81f702f22a22c54f8fd95eb059b373aedb980b12a::agent_acl::access(arg2), v3, &v0);
        0x44b06989cb7a6403320783c8a3c73774e50b07590e5010866d3503637ba50b0f::ticket::record_adapter_deposit<SuilendAdapterModule, 0xb6926eac9b9606ee21b64ad81f702f22a22c54f8fd95eb059b373aedb980b12a::agent_acl::Access>(arg1, 0xb6926eac9b9606ee21b64ad81f702f22a22c54f8fd95eb059b373aedb980b12a::agent_acl::access(arg2), v1, &v0);
        let v5 = if (0x44b06989cb7a6403320783c8a3c73774e50b07590e5010866d3503637ba50b0f::ticket::is_agent_ticket(arg1)) {
            0xb6926eac9b9606ee21b64ad81f702f22a22c54f8fd95eb059b373aedb980b12a::events::agent_owner_type()
        } else {
            0xb6926eac9b9606ee21b64ad81f702f22a22c54f8fd95eb059b373aedb980b12a::events::user_owner_type()
        };
        0xb6926eac9b9606ee21b64ad81f702f22a22c54f8fd95eb059b373aedb980b12a::events::emit_adapter_activity_event(0x44b06989cb7a6403320783c8a3c73774e50b07590e5010866d3503637ba50b0f::ticket::get_account_id(arg1), 0x1::string::utf8(b"suilend"), 0xb6926eac9b9606ee21b64ad81f702f22a22c54f8fd95eb059b373aedb980b12a::events::deposit_operation(), v5, 0x2::tx_context::sender(arg4), 0x44b06989cb7a6403320783c8a3c73774e50b07590e5010866d3503637ba50b0f::ticket::get_strategy_name(arg1), 0x1::type_name::get<T1>(), v1);
    }

    public fun get_reserve_id<T0, T1>(arg0: &0x1f54a9a2d71799553197e9ea24557797c6398d6a65f2d4d3818c9304b75d5e21::lending_market::LendingMarket<T0>) : u64 {
        0x1f54a9a2d71799553197e9ea24557797c6398d6a65f2d4d3818c9304b75d5e21::lending_market::reserve_array_index<T0, T1>(arg0)
    }

    public fun withdraw_all<T0, T1>(arg0: &mut 0x1f54a9a2d71799553197e9ea24557797c6398d6a65f2d4d3818c9304b75d5e21::lending_market::LendingMarket<T0>, arg1: &mut 0x44b06989cb7a6403320783c8a3c73774e50b07590e5010866d3503637ba50b0f::ticket::AuthorizedTransferTicket, arg2: &0xb6926eac9b9606ee21b64ad81f702f22a22c54f8fd95eb059b373aedb980b12a::agent_acl::AgentAdapterAcl, arg3: &0x2::clock::Clock, arg4: &mut 0x2::tx_context::TxContext) {
        let v0 = SuilendAdapterModule{dummy_field: false};
        assert!(0x44b06989cb7a6403320783c8a3c73774e50b07590e5010866d3503637ba50b0f::ticket::has_asset_type<0x1f54a9a2d71799553197e9ea24557797c6398d6a65f2d4d3818c9304b75d5e21::lending_market::ObligationOwnerCap<T0>>(arg1), 0);
        let v1 = 0x44b06989cb7a6403320783c8a3c73774e50b07590e5010866d3503637ba50b0f::ticket::withdraw_object<0x1f54a9a2d71799553197e9ea24557797c6398d6a65f2d4d3818c9304b75d5e21::lending_market::ObligationOwnerCap<T0>, 0xb6926eac9b9606ee21b64ad81f702f22a22c54f8fd95eb059b373aedb980b12a::agent_acl::Access, SuilendAdapterModule>(arg1, 0xb6926eac9b9606ee21b64ad81f702f22a22c54f8fd95eb059b373aedb980b12a::agent_acl::access(arg2), &v0);
        let v2 = 0x1f54a9a2d71799553197e9ea24557797c6398d6a65f2d4d3818c9304b75d5e21::lending_market::reserve_array_index<T0, T1>(arg0);
        let v3 = 0x1f54a9a2d71799553197e9ea24557797c6398d6a65f2d4d3818c9304b75d5e21::lending_market::redeem_ctokens_and_withdraw_liquidity<T0, T1>(arg0, v2, arg3, 0x1f54a9a2d71799553197e9ea24557797c6398d6a65f2d4d3818c9304b75d5e21::lending_market::withdraw_ctokens<T0, T1>(arg0, v2, &v1, arg3, 18446744073709551615, arg4), 0x1::option::none<0x1f54a9a2d71799553197e9ea24557797c6398d6a65f2d4d3818c9304b75d5e21::lending_market::RateLimiterExemption<T0, T1>>(), arg4);
        0x44b06989cb7a6403320783c8a3c73774e50b07590e5010866d3503637ba50b0f::ticket::add_object<0x1f54a9a2d71799553197e9ea24557797c6398d6a65f2d4d3818c9304b75d5e21::lending_market::ObligationOwnerCap<T0>, 0xb6926eac9b9606ee21b64ad81f702f22a22c54f8fd95eb059b373aedb980b12a::agent_acl::Access, SuilendAdapterModule>(arg1, 0xb6926eac9b9606ee21b64ad81f702f22a22c54f8fd95eb059b373aedb980b12a::agent_acl::access(arg2), v1, &v0);
        let v4 = 0x2::coin::value<T1>(&v3);
        let v5 = 0xb6926eac9b9606ee21b64ad81f702f22a22c54f8fd95eb059b373aedb980b12a::utils::calculate_yield_performance_fee(arg1, v4, 0x44b06989cb7a6403320783c8a3c73774e50b07590e5010866d3503637ba50b0f::ticket::adapter_total_deposited<SuilendAdapterModule>(arg1));
        if (v5 > 0) {
            0x44b06989cb7a6403320783c8a3c73774e50b07590e5010866d3503637ba50b0f::ticket::collect_performance_fee<T1, 0xb6926eac9b9606ee21b64ad81f702f22a22c54f8fd95eb059b373aedb980b12a::agent_acl::Access>(arg1, 0xb6926eac9b9606ee21b64ad81f702f22a22c54f8fd95eb059b373aedb980b12a::agent_acl::access(arg2), 0x2::coin::split<T1>(&mut v3, v5, arg4));
        };
        0x44b06989cb7a6403320783c8a3c73774e50b07590e5010866d3503637ba50b0f::ticket::add_coin<T1, 0xb6926eac9b9606ee21b64ad81f702f22a22c54f8fd95eb059b373aedb980b12a::agent_acl::Access, SuilendAdapterModule>(arg1, 0xb6926eac9b9606ee21b64ad81f702f22a22c54f8fd95eb059b373aedb980b12a::agent_acl::access(arg2), v3, &v0);
        0x44b06989cb7a6403320783c8a3c73774e50b07590e5010866d3503637ba50b0f::ticket::reset_adapter_deposits<SuilendAdapterModule, 0xb6926eac9b9606ee21b64ad81f702f22a22c54f8fd95eb059b373aedb980b12a::agent_acl::Access>(arg1, 0xb6926eac9b9606ee21b64ad81f702f22a22c54f8fd95eb059b373aedb980b12a::agent_acl::access(arg2), &v0);
        let v6 = if (0x44b06989cb7a6403320783c8a3c73774e50b07590e5010866d3503637ba50b0f::ticket::is_agent_ticket(arg1)) {
            0xb6926eac9b9606ee21b64ad81f702f22a22c54f8fd95eb059b373aedb980b12a::events::agent_owner_type()
        } else {
            0xb6926eac9b9606ee21b64ad81f702f22a22c54f8fd95eb059b373aedb980b12a::events::user_owner_type()
        };
        0xb6926eac9b9606ee21b64ad81f702f22a22c54f8fd95eb059b373aedb980b12a::events::emit_adapter_activity_event(0x44b06989cb7a6403320783c8a3c73774e50b07590e5010866d3503637ba50b0f::ticket::get_account_id(arg1), 0x1::string::utf8(b"suilend"), 0xb6926eac9b9606ee21b64ad81f702f22a22c54f8fd95eb059b373aedb980b12a::events::withdraw_operation(), v6, 0x2::tx_context::sender(arg4), 0x44b06989cb7a6403320783c8a3c73774e50b07590e5010866d3503637ba50b0f::ticket::get_strategy_name(arg1), 0x1::type_name::get<T1>(), v4);
    }

    // decompiled from Move bytecode v6
}

