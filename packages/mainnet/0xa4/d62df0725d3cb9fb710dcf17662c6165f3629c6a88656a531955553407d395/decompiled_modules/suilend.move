module 0xa4d62df0725d3cb9fb710dcf17662c6165f3629c6a88656a531955553407d395::suilend {
    struct SuilendAdapterModule has drop {
        dummy_field: bool,
    }

    struct DepositEvent has copy, drop {
        obligation_id: 0x2::object::ID,
        asset_type: 0x1::type_name::TypeName,
        amount: u64,
    }

    struct WithdrawEvent has copy, drop {
        obligation_id: 0x2::object::ID,
        asset_type: 0x1::type_name::TypeName,
        amount: u64,
    }

    public fun claim_rewards<T0, T1, T2>(arg0: &mut 0x1f54a9a2d71799553197e9ea24557797c6398d6a65f2d4d3818c9304b75d5e21::lending_market::LendingMarket<T0>, arg1: &mut 0x996f3afafbd1dad037b35389b9d8eb8ee1ead9319b96294f006ca4ac174ac675::ticket::AuthorizedTransferTicket, arg2: &0xa4d62df0725d3cb9fb710dcf17662c6165f3629c6a88656a531955553407d395::agent_acl::AgentAdapterAcl, arg3: u64, arg4: bool, arg5: &0x2::clock::Clock, arg6: &mut 0x2::tx_context::TxContext) {
        let v0 = SuilendAdapterModule{dummy_field: false};
        if (!0x996f3afafbd1dad037b35389b9d8eb8ee1ead9319b96294f006ca4ac174ac675::ticket::has_asset_type<0x1f54a9a2d71799553197e9ea24557797c6398d6a65f2d4d3818c9304b75d5e21::lending_market::ObligationOwnerCap<T0>>(arg1)) {
            return
        };
        let v1 = 0x996f3afafbd1dad037b35389b9d8eb8ee1ead9319b96294f006ca4ac174ac675::ticket::withdraw_object<0x1f54a9a2d71799553197e9ea24557797c6398d6a65f2d4d3818c9304b75d5e21::lending_market::ObligationOwnerCap<T0>, 0xa4d62df0725d3cb9fb710dcf17662c6165f3629c6a88656a531955553407d395::agent_acl::Access, SuilendAdapterModule>(arg1, 0xa4d62df0725d3cb9fb710dcf17662c6165f3629c6a88656a531955553407d395::agent_acl::access(arg2), &v0);
        0x996f3afafbd1dad037b35389b9d8eb8ee1ead9319b96294f006ca4ac174ac675::ticket::add_object<0x1f54a9a2d71799553197e9ea24557797c6398d6a65f2d4d3818c9304b75d5e21::lending_market::ObligationOwnerCap<T0>, 0xa4d62df0725d3cb9fb710dcf17662c6165f3629c6a88656a531955553407d395::agent_acl::Access, SuilendAdapterModule>(arg1, 0xa4d62df0725d3cb9fb710dcf17662c6165f3629c6a88656a531955553407d395::agent_acl::access(arg2), v1, &v0);
        0x996f3afafbd1dad037b35389b9d8eb8ee1ead9319b96294f006ca4ac174ac675::ticket::add_coin<T2, 0xa4d62df0725d3cb9fb710dcf17662c6165f3629c6a88656a531955553407d395::agent_acl::Access, SuilendAdapterModule>(arg1, 0xa4d62df0725d3cb9fb710dcf17662c6165f3629c6a88656a531955553407d395::agent_acl::access(arg2), 0x1f54a9a2d71799553197e9ea24557797c6398d6a65f2d4d3818c9304b75d5e21::lending_market::claim_rewards<T0, T2>(arg0, &v1, arg5, get_reserve_id<T0, T1>(arg0), arg3, arg4, arg6), &v0);
    }

    public fun deposit<T0, T1>(arg0: &mut 0x1f54a9a2d71799553197e9ea24557797c6398d6a65f2d4d3818c9304b75d5e21::lending_market::LendingMarket<T0>, arg1: &mut 0x996f3afafbd1dad037b35389b9d8eb8ee1ead9319b96294f006ca4ac174ac675::ticket::AuthorizedTransferTicket, arg2: &0xa4d62df0725d3cb9fb710dcf17662c6165f3629c6a88656a531955553407d395::agent_acl::AgentAdapterAcl, arg3: &0x2::clock::Clock, arg4: &mut 0x2::tx_context::TxContext) {
        let v0 = SuilendAdapterModule{dummy_field: false};
        let v1 = if (0x996f3afafbd1dad037b35389b9d8eb8ee1ead9319b96294f006ca4ac174ac675::ticket::has_asset_type<0x1f54a9a2d71799553197e9ea24557797c6398d6a65f2d4d3818c9304b75d5e21::lending_market::ObligationOwnerCap<T0>>(arg1)) {
            0x996f3afafbd1dad037b35389b9d8eb8ee1ead9319b96294f006ca4ac174ac675::ticket::withdraw_object<0x1f54a9a2d71799553197e9ea24557797c6398d6a65f2d4d3818c9304b75d5e21::lending_market::ObligationOwnerCap<T0>, 0xa4d62df0725d3cb9fb710dcf17662c6165f3629c6a88656a531955553407d395::agent_acl::Access, SuilendAdapterModule>(arg1, 0xa4d62df0725d3cb9fb710dcf17662c6165f3629c6a88656a531955553407d395::agent_acl::access(arg2), &v0)
        } else {
            0x1f54a9a2d71799553197e9ea24557797c6398d6a65f2d4d3818c9304b75d5e21::lending_market::create_obligation<T0>(arg0, arg4)
        };
        let v2 = v1;
        let v3 = 0x1f54a9a2d71799553197e9ea24557797c6398d6a65f2d4d3818c9304b75d5e21::lending_market::reserve_array_index<T0, T1>(arg0);
        0x1f54a9a2d71799553197e9ea24557797c6398d6a65f2d4d3818c9304b75d5e21::lending_market::deposit_ctokens_into_obligation<T0, T1>(arg0, v3, &v2, arg3, 0x1f54a9a2d71799553197e9ea24557797c6398d6a65f2d4d3818c9304b75d5e21::lending_market::deposit_liquidity_and_mint_ctokens<T0, T1>(arg0, v3, arg3, 0x996f3afafbd1dad037b35389b9d8eb8ee1ead9319b96294f006ca4ac174ac675::ticket::withdraw_coin<T1, 0xa4d62df0725d3cb9fb710dcf17662c6165f3629c6a88656a531955553407d395::agent_acl::Access, SuilendAdapterModule>(arg1, 0xa4d62df0725d3cb9fb710dcf17662c6165f3629c6a88656a531955553407d395::agent_acl::access(arg2), 0x996f3afafbd1dad037b35389b9d8eb8ee1ead9319b96294f006ca4ac174ac675::ticket::asset_balance<T1>(arg1), &v0, arg4), arg4), arg4);
        0x996f3afafbd1dad037b35389b9d8eb8ee1ead9319b96294f006ca4ac174ac675::ticket::add_object<0x1f54a9a2d71799553197e9ea24557797c6398d6a65f2d4d3818c9304b75d5e21::lending_market::ObligationOwnerCap<T0>, 0xa4d62df0725d3cb9fb710dcf17662c6165f3629c6a88656a531955553407d395::agent_acl::Access, SuilendAdapterModule>(arg1, 0xa4d62df0725d3cb9fb710dcf17662c6165f3629c6a88656a531955553407d395::agent_acl::access(arg2), v2, &v0);
    }

    public fun get_reserve_id<T0, T1>(arg0: &0x1f54a9a2d71799553197e9ea24557797c6398d6a65f2d4d3818c9304b75d5e21::lending_market::LendingMarket<T0>) : u64 {
        0x1f54a9a2d71799553197e9ea24557797c6398d6a65f2d4d3818c9304b75d5e21::lending_market::reserve_array_index<T0, T1>(arg0)
    }

    public fun withdraw<T0, T1>(arg0: &mut 0x1f54a9a2d71799553197e9ea24557797c6398d6a65f2d4d3818c9304b75d5e21::lending_market::LendingMarket<T0>, arg1: &mut 0x996f3afafbd1dad037b35389b9d8eb8ee1ead9319b96294f006ca4ac174ac675::ticket::AuthorizedTransferTicket, arg2: &0xa4d62df0725d3cb9fb710dcf17662c6165f3629c6a88656a531955553407d395::agent_acl::AgentAdapterAcl, arg3: u64, arg4: &0x2::clock::Clock, arg5: &mut 0x2::tx_context::TxContext) {
        let v0 = SuilendAdapterModule{dummy_field: false};
        assert!(0x996f3afafbd1dad037b35389b9d8eb8ee1ead9319b96294f006ca4ac174ac675::ticket::has_asset_type<0x1f54a9a2d71799553197e9ea24557797c6398d6a65f2d4d3818c9304b75d5e21::lending_market::ObligationOwnerCap<T0>>(arg1), 0);
        let v1 = 0x996f3afafbd1dad037b35389b9d8eb8ee1ead9319b96294f006ca4ac174ac675::ticket::withdraw_object<0x1f54a9a2d71799553197e9ea24557797c6398d6a65f2d4d3818c9304b75d5e21::lending_market::ObligationOwnerCap<T0>, 0xa4d62df0725d3cb9fb710dcf17662c6165f3629c6a88656a531955553407d395::agent_acl::Access, SuilendAdapterModule>(arg1, 0xa4d62df0725d3cb9fb710dcf17662c6165f3629c6a88656a531955553407d395::agent_acl::access(arg2), &v0);
        let v2 = 0x1f54a9a2d71799553197e9ea24557797c6398d6a65f2d4d3818c9304b75d5e21::lending_market::reserve_array_index<T0, T1>(arg0);
        0x996f3afafbd1dad037b35389b9d8eb8ee1ead9319b96294f006ca4ac174ac675::ticket::add_object<0x1f54a9a2d71799553197e9ea24557797c6398d6a65f2d4d3818c9304b75d5e21::lending_market::ObligationOwnerCap<T0>, 0xa4d62df0725d3cb9fb710dcf17662c6165f3629c6a88656a531955553407d395::agent_acl::Access, SuilendAdapterModule>(arg1, 0xa4d62df0725d3cb9fb710dcf17662c6165f3629c6a88656a531955553407d395::agent_acl::access(arg2), v1, &v0);
        0x996f3afafbd1dad037b35389b9d8eb8ee1ead9319b96294f006ca4ac174ac675::ticket::add_coin<T1, 0xa4d62df0725d3cb9fb710dcf17662c6165f3629c6a88656a531955553407d395::agent_acl::Access, SuilendAdapterModule>(arg1, 0xa4d62df0725d3cb9fb710dcf17662c6165f3629c6a88656a531955553407d395::agent_acl::access(arg2), 0x1f54a9a2d71799553197e9ea24557797c6398d6a65f2d4d3818c9304b75d5e21::lending_market::redeem_ctokens_and_withdraw_liquidity<T0, T1>(arg0, v2, arg4, 0x1f54a9a2d71799553197e9ea24557797c6398d6a65f2d4d3818c9304b75d5e21::lending_market::withdraw_ctokens<T0, T1>(arg0, v2, &v1, arg4, arg3, arg5), 0x1::option::none<0x1f54a9a2d71799553197e9ea24557797c6398d6a65f2d4d3818c9304b75d5e21::lending_market::RateLimiterExemption<T0, T1>>(), arg5), &v0);
    }

    public fun withdraw_all<T0, T1>(arg0: &mut 0x1f54a9a2d71799553197e9ea24557797c6398d6a65f2d4d3818c9304b75d5e21::lending_market::LendingMarket<T0>, arg1: &mut 0x996f3afafbd1dad037b35389b9d8eb8ee1ead9319b96294f006ca4ac174ac675::ticket::AuthorizedTransferTicket, arg2: &0xa4d62df0725d3cb9fb710dcf17662c6165f3629c6a88656a531955553407d395::agent_acl::AgentAdapterAcl, arg3: &0x2::clock::Clock, arg4: &mut 0x2::tx_context::TxContext) {
        withdraw<T0, T1>(arg0, arg1, arg2, 18446744073709551615, arg3, arg4);
    }

    // decompiled from Move bytecode v6
}

