module 0xfcd743f223739f194d253ad66ed6e31c90d54e7f6a1c0b41a284fcb3b70d630f::state {
    struct Key has copy, drop, store {
        dummy_field: bool,
    }

    struct SAMState<phantom T0, phantom T1> has key {
        id: 0x2::object::UID,
    }

    public fun new<T0, T1>(arg0: &0x2::coin::CoinMetadata<T1>, arg1: 0x2::coin::TreasuryCap<T1>, arg2: &0xfcd743f223739f194d253ad66ed6e31c90d54e7f6a1c0b41a284fcb3b70d630f::sam_allowed_versions::AllowedVersions, arg3: &0xfcd743f223739f194d253ad66ed6e31c90d54e7f6a1c0b41a284fcb3b70d630f::acl::AdminWitness<0xfcd743f223739f194d253ad66ed6e31c90d54e7f6a1c0b41a284fcb3b70d630f::sam::SAM>, arg4: &mut 0x2::tx_context::TxContext) {
        0xfcd743f223739f194d253ad66ed6e31c90d54e7f6a1c0b41a284fcb3b70d630f::sam_allowed_versions::assert_pkg_version(arg2);
        let v0 = SAMState<T0, T1>{id: 0x2::object::new(arg4)};
        let v1 = Key{dummy_field: false};
        0x2::dynamic_field::add<Key, 0xfcd743f223739f194d253ad66ed6e31c90d54e7f6a1c0b41a284fcb3b70d630f::state_inner::SamStateV1<T0, T1>>(&mut v0.id, v1, 0xfcd743f223739f194d253ad66ed6e31c90d54e7f6a1c0b41a284fcb3b70d630f::state_inner::new<T0, T1>(arg1, arg0, arg4));
        0x2::transfer::share_object<SAMState<T0, T1>>(v0);
    }

    fun state<T0, T1>(arg0: &SAMState<T0, T1>) : &0xfcd743f223739f194d253ad66ed6e31c90d54e7f6a1c0b41a284fcb3b70d630f::state_inner::SamStateV1<T0, T1> {
        let v0 = Key{dummy_field: false};
        0x2::dynamic_field::borrow<Key, 0xfcd743f223739f194d253ad66ed6e31c90d54e7f6a1c0b41a284fcb3b70d630f::state_inner::SamStateV1<T0, T1>>(&arg0.id, v0)
    }

    public fun allocate_to_protocol<T0, T1, T2: drop>(arg0: &mut SAMState<T0, T1>, arg1: 0xfcd743f223739f194d253ad66ed6e31c90d54e7f6a1c0b41a284fcb3b70d630f::rbr::RebalanceRequest<T0>, arg2: T2, arg3: &0xfcd743f223739f194d253ad66ed6e31c90d54e7f6a1c0b41a284fcb3b70d630f::sam_allowed_versions::AllowedVersions, arg4: &mut 0x2::tx_context::TxContext) : 0x2::balance::Balance<T0> {
        0xfcd743f223739f194d253ad66ed6e31c90d54e7f6a1c0b41a284fcb3b70d630f::sam_allowed_versions::assert_pkg_version(arg3);
        0xfcd743f223739f194d253ad66ed6e31c90d54e7f6a1c0b41a284fcb3b70d630f::state_inner::allocate_to_protocol<T0, T1, T2>(state_mut<T0, T1>(arg0), arg1, arg2)
    }

    public fun approve_protocol_request<T0, T1, T2: drop>(arg0: &mut SAMState<T0, T1>, arg1: &mut 0xfcd743f223739f194d253ad66ed6e31c90d54e7f6a1c0b41a284fcb3b70d630f::ptr::ProtocolRequest<T0>, arg2: 0x911fd84fd98ed5c8c32cfc25f08f1493e532e4a4ba7d126290de00db75aa494f::fixed18::Fixed18, arg3: 0x911fd84fd98ed5c8c32cfc25f08f1493e532e4a4ba7d126290de00db75aa494f::fixed18::Fixed18, arg4: 0x2::balance::Balance<T0>, arg5: T2, arg6: &0xfcd743f223739f194d253ad66ed6e31c90d54e7f6a1c0b41a284fcb3b70d630f::sam_allowed_versions::AllowedVersions, arg7: &mut 0x2::tx_context::TxContext) {
        0xfcd743f223739f194d253ad66ed6e31c90d54e7f6a1c0b41a284fcb3b70d630f::sam_allowed_versions::assert_pkg_version(arg6);
        0xfcd743f223739f194d253ad66ed6e31c90d54e7f6a1c0b41a284fcb3b70d630f::state_inner::approve_protocol_request<T2, T0, T1>(state_mut<T0, T1>(arg0), arg1, arg2, arg3, arg4, arg5);
    }

    public fun consume_withdraw_request<T0, T1>(arg0: &mut SAMState<T0, T1>, arg1: vector<0xfcd743f223739f194d253ad66ed6e31c90d54e7f6a1c0b41a284fcb3b70d630f::wdr::WithdrawRequest<T0>>, arg2: &0xfcd743f223739f194d253ad66ed6e31c90d54e7f6a1c0b41a284fcb3b70d630f::sam_allowed_versions::AllowedVersions, arg3: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<T0> {
        0xfcd743f223739f194d253ad66ed6e31c90d54e7f6a1c0b41a284fcb3b70d630f::sam_allowed_versions::assert_pkg_version(arg2);
        let v0 = state_mut<T0, T1>(arg0);
        let v1 = 0x2::balance::zero<T0>();
        let v2 = 0;
        while (v2 < 0x1::vector::length<0xfcd743f223739f194d253ad66ed6e31c90d54e7f6a1c0b41a284fcb3b70d630f::wdr::WithdrawRequest<T0>>(&arg1)) {
            0x2::balance::join<T0>(&mut v1, 0xfcd743f223739f194d253ad66ed6e31c90d54e7f6a1c0b41a284fcb3b70d630f::state_inner::consume_withdraw<T0, T1>(v0, 0x1::vector::pop_back<0xfcd743f223739f194d253ad66ed6e31c90d54e7f6a1c0b41a284fcb3b70d630f::wdr::WithdrawRequest<T0>>(&mut arg1)));
            v2 = v2 + 1;
        };
        0x1::vector::destroy_empty<0xfcd743f223739f194d253ad66ed6e31c90d54e7f6a1c0b41a284fcb3b70d630f::wdr::WithdrawRequest<T0>>(arg1);
        0x2::coin::from_balance<T0>(v1, arg3)
    }

    public fun deposit<T0, T1>(arg0: &mut SAMState<T0, T1>, arg1: 0x2::coin::Coin<T0>, arg2: 0xfcd743f223739f194d253ad66ed6e31c90d54e7f6a1c0b41a284fcb3b70d630f::ptr::ProtocolRequest<T0>, arg3: &0xfcd743f223739f194d253ad66ed6e31c90d54e7f6a1c0b41a284fcb3b70d630f::sam_allowed_versions::AllowedVersions, arg4: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<T1> {
        0xfcd743f223739f194d253ad66ed6e31c90d54e7f6a1c0b41a284fcb3b70d630f::sam_allowed_versions::assert_pkg_version(arg3);
        let v0 = state_mut<T0, T1>(arg0);
        0xfcd743f223739f194d253ad66ed6e31c90d54e7f6a1c0b41a284fcb3b70d630f::state_inner::consume_protocol_earnings<T0, T1>(v0, arg2);
        0xfcd743f223739f194d253ad66ed6e31c90d54e7f6a1c0b41a284fcb3b70d630f::state_inner::deposit<T0, T1>(v0, arg1, arg4)
    }

    public fun fill_rebalance_request<T0, T1, T2: drop>(arg0: &mut SAMState<T0, T1>, arg1: &mut 0xfcd743f223739f194d253ad66ed6e31c90d54e7f6a1c0b41a284fcb3b70d630f::rbr::RebalanceRequest<T0>, arg2: 0x2::balance::Balance<T0>, arg3: T2, arg4: &0xfcd743f223739f194d253ad66ed6e31c90d54e7f6a1c0b41a284fcb3b70d630f::sam_allowed_versions::AllowedVersions, arg5: &mut 0x2::tx_context::TxContext) {
        0xfcd743f223739f194d253ad66ed6e31c90d54e7f6a1c0b41a284fcb3b70d630f::sam_allowed_versions::assert_pkg_version(arg4);
        0xfcd743f223739f194d253ad66ed6e31c90d54e7f6a1c0b41a284fcb3b70d630f::rbr::fill<T0, T2>(arg1, arg2, arg3);
    }

    public fun fill_withdraw_request<T0, T1, T2: drop>(arg0: &mut SAMState<T0, T1>, arg1: &mut 0xfcd743f223739f194d253ad66ed6e31c90d54e7f6a1c0b41a284fcb3b70d630f::wdr::WithdrawRequest<T0>, arg2: 0x2::balance::Balance<T0>, arg3: T2, arg4: &0xfcd743f223739f194d253ad66ed6e31c90d54e7f6a1c0b41a284fcb3b70d630f::sam_allowed_versions::AllowedVersions, arg5: &mut 0x2::tx_context::TxContext) {
        0xfcd743f223739f194d253ad66ed6e31c90d54e7f6a1c0b41a284fcb3b70d630f::sam_allowed_versions::assert_pkg_version(arg4);
        0xfcd743f223739f194d253ad66ed6e31c90d54e7f6a1c0b41a284fcb3b70d630f::wdr::fill<T0, T2>(arg1, arg2, arg3);
    }

    public fun new_protocol_request<T0, T1>(arg0: &mut SAMState<T0, T1>, arg1: &0xfcd743f223739f194d253ad66ed6e31c90d54e7f6a1c0b41a284fcb3b70d630f::sam_allowed_versions::AllowedVersions, arg2: &mut 0x2::tx_context::TxContext) : 0xfcd743f223739f194d253ad66ed6e31c90d54e7f6a1c0b41a284fcb3b70d630f::ptr::ProtocolRequest<T0> {
        0xfcd743f223739f194d253ad66ed6e31c90d54e7f6a1c0b41a284fcb3b70d630f::sam_allowed_versions::assert_pkg_version(arg1);
        0xfcd743f223739f194d253ad66ed6e31c90d54e7f6a1c0b41a284fcb3b70d630f::ptr::request<T0>()
    }

    public fun rebalance<T0, T1>(arg0: &mut SAMState<T0, T1>, arg1: 0xfcd743f223739f194d253ad66ed6e31c90d54e7f6a1c0b41a284fcb3b70d630f::ptr::ProtocolRequest<T0>, arg2: vector<0x1::option::Option<0x1::type_name::TypeName>>, arg3: vector<0x1::option::Option<0x1::type_name::TypeName>>, arg4: vector<u64>, arg5: &0xfcd743f223739f194d253ad66ed6e31c90d54e7f6a1c0b41a284fcb3b70d630f::sam_allowed_versions::AllowedVersions, arg6: &0xfcd743f223739f194d253ad66ed6e31c90d54e7f6a1c0b41a284fcb3b70d630f::acl::AdminWitness<0xfcd743f223739f194d253ad66ed6e31c90d54e7f6a1c0b41a284fcb3b70d630f::sam::SAM>, arg7: &mut 0x2::tx_context::TxContext) : vector<0xfcd743f223739f194d253ad66ed6e31c90d54e7f6a1c0b41a284fcb3b70d630f::rbr::RebalanceRequest<T0>> {
        0xfcd743f223739f194d253ad66ed6e31c90d54e7f6a1c0b41a284fcb3b70d630f::sam_allowed_versions::assert_pkg_version(arg5);
        let v0 = state_mut<T0, T1>(arg0);
        0xfcd743f223739f194d253ad66ed6e31c90d54e7f6a1c0b41a284fcb3b70d630f::state_inner::consume_protocol_earnings<T0, T1>(v0, arg1);
        0xfcd743f223739f194d253ad66ed6e31c90d54e7f6a1c0b41a284fcb3b70d630f::state_inner::rebalance<T0, T1>(v0, arg2, arg3, arg4)
    }

    public fun reclaim_from_protocol<T0, T1>(arg0: &mut SAMState<T0, T1>, arg1: 0xfcd743f223739f194d253ad66ed6e31c90d54e7f6a1c0b41a284fcb3b70d630f::rbr::RebalanceRequest<T0>, arg2: &0xfcd743f223739f194d253ad66ed6e31c90d54e7f6a1c0b41a284fcb3b70d630f::sam_allowed_versions::AllowedVersions, arg3: &mut 0x2::tx_context::TxContext) {
        0xfcd743f223739f194d253ad66ed6e31c90d54e7f6a1c0b41a284fcb3b70d630f::sam_allowed_versions::assert_pkg_version(arg2);
        0xfcd743f223739f194d253ad66ed6e31c90d54e7f6a1c0b41a284fcb3b70d630f::state_inner::reclaim_from_protocol<T0, T1>(state_mut<T0, T1>(arg0), arg1);
    }

    fun state_mut<T0, T1>(arg0: &mut SAMState<T0, T1>) : &mut 0xfcd743f223739f194d253ad66ed6e31c90d54e7f6a1c0b41a284fcb3b70d630f::state_inner::SamStateV1<T0, T1> {
        let v0 = Key{dummy_field: false};
        0x2::dynamic_field::borrow_mut<Key, 0xfcd743f223739f194d253ad66ed6e31c90d54e7f6a1c0b41a284fcb3b70d630f::state_inner::SamStateV1<T0, T1>>(&mut arg0.id, v0)
    }

    public fun withdraw<T0, T1>(arg0: &mut SAMState<T0, T1>, arg1: 0x2::coin::Coin<T1>, arg2: 0xfcd743f223739f194d253ad66ed6e31c90d54e7f6a1c0b41a284fcb3b70d630f::ptr::ProtocolRequest<T0>, arg3: &0xfcd743f223739f194d253ad66ed6e31c90d54e7f6a1c0b41a284fcb3b70d630f::sam_allowed_versions::AllowedVersions, arg4: &mut 0x2::tx_context::TxContext) : (0x2::balance::Balance<T0>, vector<0xfcd743f223739f194d253ad66ed6e31c90d54e7f6a1c0b41a284fcb3b70d630f::wdr::WithdrawRequest<T0>>) {
        0xfcd743f223739f194d253ad66ed6e31c90d54e7f6a1c0b41a284fcb3b70d630f::sam_allowed_versions::assert_pkg_version(arg3);
        let v0 = state_mut<T0, T1>(arg0);
        0xfcd743f223739f194d253ad66ed6e31c90d54e7f6a1c0b41a284fcb3b70d630f::state_inner::withdraw<T0, T1>(v0, arg1, 0xfcd743f223739f194d253ad66ed6e31c90d54e7f6a1c0b41a284fcb3b70d630f::state_inner::consume_protocol_earnings<T0, T1>(v0, arg2))
    }

    // decompiled from Move bytecode v6
}

