module 0xd2550407673e08d06c4b1f16f31bb7313e5de02c5212f6e0627250e3bc72f282::state {
    struct Key has copy, drop, store {
        dummy_field: bool,
    }

    struct SAMState<phantom T0, phantom T1> has key {
        id: 0x2::object::UID,
    }

    public fun new<T0, T1>(arg0: &0x2::coin::CoinMetadata<T1>, arg1: 0x2::coin::TreasuryCap<T1>, arg2: &0xd2550407673e08d06c4b1f16f31bb7313e5de02c5212f6e0627250e3bc72f282::sam_allowed_versions::AllowedVersions, arg3: &0xd2550407673e08d06c4b1f16f31bb7313e5de02c5212f6e0627250e3bc72f282::acl::AdminWitness<0xd2550407673e08d06c4b1f16f31bb7313e5de02c5212f6e0627250e3bc72f282::sam::SAM>, arg4: &mut 0x2::tx_context::TxContext) {
        0xd2550407673e08d06c4b1f16f31bb7313e5de02c5212f6e0627250e3bc72f282::sam_allowed_versions::assert_pkg_version(arg2);
        let v0 = SAMState<T0, T1>{id: 0x2::object::new(arg4)};
        let v1 = Key{dummy_field: false};
        0x2::dynamic_field::add<Key, 0xd2550407673e08d06c4b1f16f31bb7313e5de02c5212f6e0627250e3bc72f282::state_inner::SamStateV1<T0, T1>>(&mut v0.id, v1, 0xd2550407673e08d06c4b1f16f31bb7313e5de02c5212f6e0627250e3bc72f282::state_inner::new<T0, T1>(arg1, arg0, arg4));
        0x2::transfer::share_object<SAMState<T0, T1>>(v0);
    }

    public fun decimals<T0, T1>(arg0: &SAMState<T0, T1>) : u8 {
        0xd2550407673e08d06c4b1f16f31bb7313e5de02c5212f6e0627250e3bc72f282::sam_coin_metadata::decimals(0xd2550407673e08d06c4b1f16f31bb7313e5de02c5212f6e0627250e3bc72f282::state_inner::get_metadata<T0, T1>(state<T0, T1>(arg0)))
    }

    fun state<T0, T1>(arg0: &SAMState<T0, T1>) : &0xd2550407673e08d06c4b1f16f31bb7313e5de02c5212f6e0627250e3bc72f282::state_inner::SamStateV1<T0, T1> {
        let v0 = Key{dummy_field: false};
        0x2::dynamic_field::borrow<Key, 0xd2550407673e08d06c4b1f16f31bb7313e5de02c5212f6e0627250e3bc72f282::state_inner::SamStateV1<T0, T1>>(&arg0.id, v0)
    }

    public fun allocate_to_protocol<T0, T1, T2: drop>(arg0: &mut SAMState<T0, T1>, arg1: 0xd2550407673e08d06c4b1f16f31bb7313e5de02c5212f6e0627250e3bc72f282::rbr::RebalanceRequest<T0>, arg2: T2, arg3: &0xd2550407673e08d06c4b1f16f31bb7313e5de02c5212f6e0627250e3bc72f282::sam_allowed_versions::AllowedVersions, arg4: &mut 0x2::tx_context::TxContext) : 0x2::balance::Balance<T0> {
        0xd2550407673e08d06c4b1f16f31bb7313e5de02c5212f6e0627250e3bc72f282::sam_allowed_versions::assert_pkg_version(arg3);
        0xd2550407673e08d06c4b1f16f31bb7313e5de02c5212f6e0627250e3bc72f282::state_inner::allocate_to_protocol<T0, T1, T2>(state_mut<T0, T1>(arg0), arg1, arg2)
    }

    public fun approve_protocol_request<T0, T1, T2: drop>(arg0: &mut SAMState<T0, T1>, arg1: &mut 0xd2550407673e08d06c4b1f16f31bb7313e5de02c5212f6e0627250e3bc72f282::ptr::ProtocolRequest<T0>, arg2: 0x99a1d666d9e4792bee2f34a2693aeab95a57b3c662da2e68574a03e929e60b0e::fixed18::Fixed18, arg3: 0x99a1d666d9e4792bee2f34a2693aeab95a57b3c662da2e68574a03e929e60b0e::fixed18::Fixed18, arg4: 0x2::balance::Balance<T0>, arg5: T2, arg6: &0xd2550407673e08d06c4b1f16f31bb7313e5de02c5212f6e0627250e3bc72f282::sam_allowed_versions::AllowedVersions, arg7: &mut 0x2::tx_context::TxContext) {
        0xd2550407673e08d06c4b1f16f31bb7313e5de02c5212f6e0627250e3bc72f282::sam_allowed_versions::assert_pkg_version(arg6);
        0xd2550407673e08d06c4b1f16f31bb7313e5de02c5212f6e0627250e3bc72f282::state_inner::approve_protocol_request<T2, T0, T1>(state_mut<T0, T1>(arg0), arg1, arg2, arg3, arg4, arg5);
    }

    public fun consume_withdraw_request<T0, T1>(arg0: &mut SAMState<T0, T1>, arg1: vector<0xd2550407673e08d06c4b1f16f31bb7313e5de02c5212f6e0627250e3bc72f282::wdr::WithdrawRequest<T0>>, arg2: &0xd2550407673e08d06c4b1f16f31bb7313e5de02c5212f6e0627250e3bc72f282::sam_allowed_versions::AllowedVersions, arg3: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<T0> {
        0xd2550407673e08d06c4b1f16f31bb7313e5de02c5212f6e0627250e3bc72f282::sam_allowed_versions::assert_pkg_version(arg2);
        let v0 = state_mut<T0, T1>(arg0);
        let v1 = 0x2::balance::zero<T0>();
        let v2 = 0;
        while (v2 < 0x1::vector::length<0xd2550407673e08d06c4b1f16f31bb7313e5de02c5212f6e0627250e3bc72f282::wdr::WithdrawRequest<T0>>(&arg1)) {
            0x2::balance::join<T0>(&mut v1, 0xd2550407673e08d06c4b1f16f31bb7313e5de02c5212f6e0627250e3bc72f282::state_inner::consume_withdraw<T0, T1>(v0, 0x1::vector::pop_back<0xd2550407673e08d06c4b1f16f31bb7313e5de02c5212f6e0627250e3bc72f282::wdr::WithdrawRequest<T0>>(&mut arg1), arg3));
            v2 = v2 + 1;
        };
        0x1::vector::destroy_empty<0xd2550407673e08d06c4b1f16f31bb7313e5de02c5212f6e0627250e3bc72f282::wdr::WithdrawRequest<T0>>(arg1);
        0x2::coin::from_balance<T0>(v1, arg3)
    }

    public fun deposit<T0, T1>(arg0: &mut SAMState<T0, T1>, arg1: 0x2::coin::Coin<T0>, arg2: 0xd2550407673e08d06c4b1f16f31bb7313e5de02c5212f6e0627250e3bc72f282::ptr::ProtocolRequest<T0>, arg3: &0xd2550407673e08d06c4b1f16f31bb7313e5de02c5212f6e0627250e3bc72f282::sam_allowed_versions::AllowedVersions, arg4: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<T1> {
        0xd2550407673e08d06c4b1f16f31bb7313e5de02c5212f6e0627250e3bc72f282::sam_allowed_versions::assert_pkg_version(arg3);
        let v0 = state_mut<T0, T1>(arg0);
        0xd2550407673e08d06c4b1f16f31bb7313e5de02c5212f6e0627250e3bc72f282::state_inner::consume_protocol_earnings<T0, T1>(v0, arg2);
        0xd2550407673e08d06c4b1f16f31bb7313e5de02c5212f6e0627250e3bc72f282::state_inner::deposit<T0, T1>(v0, arg1, arg4)
    }

    public fun deposit_and_rebalance<T0, T1>(arg0: &mut SAMState<T0, T1>, arg1: 0x2::coin::Coin<T0>, arg2: 0xd2550407673e08d06c4b1f16f31bb7313e5de02c5212f6e0627250e3bc72f282::ptr::ProtocolRequest<T0>, arg3: &0xd2550407673e08d06c4b1f16f31bb7313e5de02c5212f6e0627250e3bc72f282::sam_allowed_versions::AllowedVersions, arg4: &mut 0x2::tx_context::TxContext) : (0x2::coin::Coin<T1>, vector<0xd2550407673e08d06c4b1f16f31bb7313e5de02c5212f6e0627250e3bc72f282::rbr::RebalanceRequest<T0>>) {
        0xd2550407673e08d06c4b1f16f31bb7313e5de02c5212f6e0627250e3bc72f282::sam_allowed_versions::assert_pkg_version(arg3);
        let v0 = state_mut<T0, T1>(arg0);
        0xd2550407673e08d06c4b1f16f31bb7313e5de02c5212f6e0627250e3bc72f282::state_inner::consume_protocol_earnings<T0, T1>(v0, arg2);
        (0xd2550407673e08d06c4b1f16f31bb7313e5de02c5212f6e0627250e3bc72f282::state_inner::deposit<T0, T1>(v0, arg1, arg4), 0xd2550407673e08d06c4b1f16f31bb7313e5de02c5212f6e0627250e3bc72f282::state_inner::rebalance_optimal<T0, T1>(v0, arg4))
    }

    public fun fill_rebalance_request<T0, T1, T2: drop>(arg0: &mut SAMState<T0, T1>, arg1: &mut 0xd2550407673e08d06c4b1f16f31bb7313e5de02c5212f6e0627250e3bc72f282::rbr::RebalanceRequest<T0>, arg2: 0x2::balance::Balance<T0>, arg3: T2, arg4: &0xd2550407673e08d06c4b1f16f31bb7313e5de02c5212f6e0627250e3bc72f282::sam_allowed_versions::AllowedVersions, arg5: &mut 0x2::tx_context::TxContext) {
        0xd2550407673e08d06c4b1f16f31bb7313e5de02c5212f6e0627250e3bc72f282::sam_allowed_versions::assert_pkg_version(arg4);
        0xd2550407673e08d06c4b1f16f31bb7313e5de02c5212f6e0627250e3bc72f282::rbr::fill<T0, T2>(arg1, arg2, arg3);
    }

    public fun fill_withdraw_request<T0, T1, T2: drop>(arg0: &mut SAMState<T0, T1>, arg1: &mut 0xd2550407673e08d06c4b1f16f31bb7313e5de02c5212f6e0627250e3bc72f282::wdr::WithdrawRequest<T0>, arg2: 0x2::balance::Balance<T0>, arg3: T2, arg4: &0xd2550407673e08d06c4b1f16f31bb7313e5de02c5212f6e0627250e3bc72f282::sam_allowed_versions::AllowedVersions, arg5: &mut 0x2::tx_context::TxContext) {
        0xd2550407673e08d06c4b1f16f31bb7313e5de02c5212f6e0627250e3bc72f282::sam_allowed_versions::assert_pkg_version(arg4);
        0xd2550407673e08d06c4b1f16f31bb7313e5de02c5212f6e0627250e3bc72f282::wdr::fill<T0, T2>(arg1, arg2, arg3);
    }

    public fun new_protocol_request<T0, T1>(arg0: &mut SAMState<T0, T1>, arg1: &0xd2550407673e08d06c4b1f16f31bb7313e5de02c5212f6e0627250e3bc72f282::sam_allowed_versions::AllowedVersions, arg2: &mut 0x2::tx_context::TxContext) : 0xd2550407673e08d06c4b1f16f31bb7313e5de02c5212f6e0627250e3bc72f282::ptr::ProtocolRequest<T0> {
        0xd2550407673e08d06c4b1f16f31bb7313e5de02c5212f6e0627250e3bc72f282::sam_allowed_versions::assert_pkg_version(arg1);
        0xd2550407673e08d06c4b1f16f31bb7313e5de02c5212f6e0627250e3bc72f282::ptr::request<T0>()
    }

    public fun rebalance<T0, T1>(arg0: &mut SAMState<T0, T1>, arg1: 0xd2550407673e08d06c4b1f16f31bb7313e5de02c5212f6e0627250e3bc72f282::ptr::ProtocolRequest<T0>, arg2: vector<0x1::option::Option<0x1::type_name::TypeName>>, arg3: vector<0x1::option::Option<0x1::type_name::TypeName>>, arg4: vector<u64>, arg5: &0xd2550407673e08d06c4b1f16f31bb7313e5de02c5212f6e0627250e3bc72f282::sam_allowed_versions::AllowedVersions, arg6: &0xd2550407673e08d06c4b1f16f31bb7313e5de02c5212f6e0627250e3bc72f282::acl::AdminWitness<0xd2550407673e08d06c4b1f16f31bb7313e5de02c5212f6e0627250e3bc72f282::sam::SAM>, arg7: &mut 0x2::tx_context::TxContext) : vector<0xd2550407673e08d06c4b1f16f31bb7313e5de02c5212f6e0627250e3bc72f282::rbr::RebalanceRequest<T0>> {
        0xd2550407673e08d06c4b1f16f31bb7313e5de02c5212f6e0627250e3bc72f282::sam_allowed_versions::assert_pkg_version(arg5);
        let v0 = state_mut<T0, T1>(arg0);
        0xd2550407673e08d06c4b1f16f31bb7313e5de02c5212f6e0627250e3bc72f282::state_inner::consume_protocol_earnings<T0, T1>(v0, arg1);
        0xd2550407673e08d06c4b1f16f31bb7313e5de02c5212f6e0627250e3bc72f282::state_inner::rebalance<T0, T1>(v0, arg2, arg3, arg4, arg7)
    }

    public fun rebalance_auto<T0, T1>(arg0: &mut SAMState<T0, T1>, arg1: 0xd2550407673e08d06c4b1f16f31bb7313e5de02c5212f6e0627250e3bc72f282::ptr::ProtocolRequest<T0>, arg2: vector<0x1::option::Option<0x1::type_name::TypeName>>, arg3: vector<0x1::option::Option<0x1::type_name::TypeName>>, arg4: vector<u64>, arg5: &0xd2550407673e08d06c4b1f16f31bb7313e5de02c5212f6e0627250e3bc72f282::sam_allowed_versions::AllowedVersions, arg6: &mut 0x2::tx_context::TxContext) : vector<0xd2550407673e08d06c4b1f16f31bb7313e5de02c5212f6e0627250e3bc72f282::rbr::RebalanceRequest<T0>> {
        0xd2550407673e08d06c4b1f16f31bb7313e5de02c5212f6e0627250e3bc72f282::sam_allowed_versions::assert_pkg_version(arg5);
        let v0 = state_mut<T0, T1>(arg0);
        let v1 = 0xd2550407673e08d06c4b1f16f31bb7313e5de02c5212f6e0627250e3bc72f282::state_inner::consume_protocol_earnings<T0, T1>(v0, arg1);
        0xd2550407673e08d06c4b1f16f31bb7313e5de02c5212f6e0627250e3bc72f282::state_inner::rebalance_auto<T0, T1>(v0, arg2, arg3, arg4, &v1, arg6)
    }

    public fun rebalance_optimal<T0, T1>(arg0: &mut SAMState<T0, T1>, arg1: 0xd2550407673e08d06c4b1f16f31bb7313e5de02c5212f6e0627250e3bc72f282::ptr::ProtocolRequest<T0>, arg2: &0xd2550407673e08d06c4b1f16f31bb7313e5de02c5212f6e0627250e3bc72f282::sam_allowed_versions::AllowedVersions, arg3: &mut 0x2::tx_context::TxContext) : vector<0xd2550407673e08d06c4b1f16f31bb7313e5de02c5212f6e0627250e3bc72f282::rbr::RebalanceRequest<T0>> {
        0xd2550407673e08d06c4b1f16f31bb7313e5de02c5212f6e0627250e3bc72f282::sam_allowed_versions::assert_pkg_version(arg2);
        let v0 = state_mut<T0, T1>(arg0);
        0xd2550407673e08d06c4b1f16f31bb7313e5de02c5212f6e0627250e3bc72f282::state_inner::consume_protocol_earnings<T0, T1>(v0, arg1);
        0xd2550407673e08d06c4b1f16f31bb7313e5de02c5212f6e0627250e3bc72f282::state_inner::rebalance_optimal<T0, T1>(v0, arg3)
    }

    public fun reclaim_from_protocol<T0, T1>(arg0: &mut SAMState<T0, T1>, arg1: 0xd2550407673e08d06c4b1f16f31bb7313e5de02c5212f6e0627250e3bc72f282::rbr::RebalanceRequest<T0>, arg2: &0xd2550407673e08d06c4b1f16f31bb7313e5de02c5212f6e0627250e3bc72f282::sam_allowed_versions::AllowedVersions, arg3: &mut 0x2::tx_context::TxContext) {
        0xd2550407673e08d06c4b1f16f31bb7313e5de02c5212f6e0627250e3bc72f282::sam_allowed_versions::assert_pkg_version(arg2);
        0xd2550407673e08d06c4b1f16f31bb7313e5de02c5212f6e0627250e3bc72f282::state_inner::reclaim_from_protocol<T0, T1>(state_mut<T0, T1>(arg0), arg1);
    }

    public fun record_point<T0, T1, T2: drop>(arg0: &mut SAMState<T0, T1>, arg1: 0x99a1d666d9e4792bee2f34a2693aeab95a57b3c662da2e68574a03e929e60b0e::fixed18::Fixed18, arg2: 0x99a1d666d9e4792bee2f34a2693aeab95a57b3c662da2e68574a03e929e60b0e::fixed18::Fixed18, arg3: T2, arg4: &0xd2550407673e08d06c4b1f16f31bb7313e5de02c5212f6e0627250e3bc72f282::sam_allowed_versions::AllowedVersions) {
        0xd2550407673e08d06c4b1f16f31bb7313e5de02c5212f6e0627250e3bc72f282::sam_allowed_versions::assert_pkg_version(arg4);
        0xd2550407673e08d06c4b1f16f31bb7313e5de02c5212f6e0627250e3bc72f282::state_inner::record_point<T0, T1, T2>(state_mut<T0, T1>(arg0), arg1, arg2);
    }

    public fun register_protocol<T0, T1, T2>(arg0: &mut SAMState<T0, T1>, arg1: &0xd2550407673e08d06c4b1f16f31bb7313e5de02c5212f6e0627250e3bc72f282::sam_allowed_versions::AllowedVersions, arg2: &0xd2550407673e08d06c4b1f16f31bb7313e5de02c5212f6e0627250e3bc72f282::acl::AdminWitness<0xd2550407673e08d06c4b1f16f31bb7313e5de02c5212f6e0627250e3bc72f282::sam::SAM>) {
        0xd2550407673e08d06c4b1f16f31bb7313e5de02c5212f6e0627250e3bc72f282::sam_allowed_versions::assert_pkg_version(arg1);
        0xd2550407673e08d06c4b1f16f31bb7313e5de02c5212f6e0627250e3bc72f282::state_inner::register_protocol<T0, T1, T2>(state_mut<T0, T1>(arg0));
    }

    public fun set_paused<T0, T1>(arg0: &mut SAMState<T0, T1>, arg1: bool, arg2: &0xd2550407673e08d06c4b1f16f31bb7313e5de02c5212f6e0627250e3bc72f282::sam_allowed_versions::AllowedVersions, arg3: &0xd2550407673e08d06c4b1f16f31bb7313e5de02c5212f6e0627250e3bc72f282::acl::AdminWitness<0xd2550407673e08d06c4b1f16f31bb7313e5de02c5212f6e0627250e3bc72f282::sam::SAM>) {
        0xd2550407673e08d06c4b1f16f31bb7313e5de02c5212f6e0627250e3bc72f282::sam_allowed_versions::assert_pkg_version(arg2);
        0xd2550407673e08d06c4b1f16f31bb7313e5de02c5212f6e0627250e3bc72f282::state_inner::set_paused<T0, T1>(state_mut<T0, T1>(arg0), arg1);
    }

    fun state_mut<T0, T1>(arg0: &mut SAMState<T0, T1>) : &mut 0xd2550407673e08d06c4b1f16f31bb7313e5de02c5212f6e0627250e3bc72f282::state_inner::SamStateV1<T0, T1> {
        let v0 = Key{dummy_field: false};
        0x2::dynamic_field::borrow_mut<Key, 0xd2550407673e08d06c4b1f16f31bb7313e5de02c5212f6e0627250e3bc72f282::state_inner::SamStateV1<T0, T1>>(&mut arg0.id, v0)
    }

    public fun unregister_protocol<T0, T1, T2>(arg0: &mut SAMState<T0, T1>, arg1: &0xd2550407673e08d06c4b1f16f31bb7313e5de02c5212f6e0627250e3bc72f282::sam_allowed_versions::AllowedVersions, arg2: &0xd2550407673e08d06c4b1f16f31bb7313e5de02c5212f6e0627250e3bc72f282::acl::AdminWitness<0xd2550407673e08d06c4b1f16f31bb7313e5de02c5212f6e0627250e3bc72f282::sam::SAM>) {
        0xd2550407673e08d06c4b1f16f31bb7313e5de02c5212f6e0627250e3bc72f282::sam_allowed_versions::assert_pkg_version(arg1);
        0xd2550407673e08d06c4b1f16f31bb7313e5de02c5212f6e0627250e3bc72f282::state_inner::unregister_protocol<T0, T1, T2>(state_mut<T0, T1>(arg0));
    }

    public fun update_deposit_fee<T0, T1>(arg0: &mut SAMState<T0, T1>, arg1: u64, arg2: &0xd2550407673e08d06c4b1f16f31bb7313e5de02c5212f6e0627250e3bc72f282::sam_allowed_versions::AllowedVersions, arg3: &0xd2550407673e08d06c4b1f16f31bb7313e5de02c5212f6e0627250e3bc72f282::acl::AdminWitness<0xd2550407673e08d06c4b1f16f31bb7313e5de02c5212f6e0627250e3bc72f282::sam::SAM>) {
        0xd2550407673e08d06c4b1f16f31bb7313e5de02c5212f6e0627250e3bc72f282::sam_allowed_versions::assert_pkg_version(arg2);
        0xd2550407673e08d06c4b1f16f31bb7313e5de02c5212f6e0627250e3bc72f282::state_inner::update_deposit_fee<T0, T1>(state_mut<T0, T1>(arg0), arg1);
    }

    public fun update_protocol_fee<T0, T1>(arg0: &mut SAMState<T0, T1>, arg1: u64, arg2: &0xd2550407673e08d06c4b1f16f31bb7313e5de02c5212f6e0627250e3bc72f282::sam_allowed_versions::AllowedVersions, arg3: &0xd2550407673e08d06c4b1f16f31bb7313e5de02c5212f6e0627250e3bc72f282::acl::AdminWitness<0xd2550407673e08d06c4b1f16f31bb7313e5de02c5212f6e0627250e3bc72f282::sam::SAM>) {
        0xd2550407673e08d06c4b1f16f31bb7313e5de02c5212f6e0627250e3bc72f282::sam_allowed_versions::assert_pkg_version(arg2);
        0xd2550407673e08d06c4b1f16f31bb7313e5de02c5212f6e0627250e3bc72f282::state_inner::update_protocol_fee<T0, T1>(state_mut<T0, T1>(arg0), arg1);
    }

    public fun update_withdraw_fee<T0, T1>(arg0: &mut SAMState<T0, T1>, arg1: u64, arg2: &0xd2550407673e08d06c4b1f16f31bb7313e5de02c5212f6e0627250e3bc72f282::sam_allowed_versions::AllowedVersions, arg3: &0xd2550407673e08d06c4b1f16f31bb7313e5de02c5212f6e0627250e3bc72f282::acl::AdminWitness<0xd2550407673e08d06c4b1f16f31bb7313e5de02c5212f6e0627250e3bc72f282::sam::SAM>) {
        0xd2550407673e08d06c4b1f16f31bb7313e5de02c5212f6e0627250e3bc72f282::sam_allowed_versions::assert_pkg_version(arg2);
        0xd2550407673e08d06c4b1f16f31bb7313e5de02c5212f6e0627250e3bc72f282::state_inner::update_withdraw_fee<T0, T1>(state_mut<T0, T1>(arg0), arg1);
    }

    public fun withdraw<T0, T1>(arg0: &mut SAMState<T0, T1>, arg1: 0x2::coin::Coin<T1>, arg2: 0xd2550407673e08d06c4b1f16f31bb7313e5de02c5212f6e0627250e3bc72f282::ptr::ProtocolRequest<T0>, arg3: &0xd2550407673e08d06c4b1f16f31bb7313e5de02c5212f6e0627250e3bc72f282::sam_allowed_versions::AllowedVersions, arg4: &mut 0x2::tx_context::TxContext) : (0x2::balance::Balance<T0>, vector<0xd2550407673e08d06c4b1f16f31bb7313e5de02c5212f6e0627250e3bc72f282::wdr::WithdrawRequest<T0>>) {
        0xd2550407673e08d06c4b1f16f31bb7313e5de02c5212f6e0627250e3bc72f282::sam_allowed_versions::assert_pkg_version(arg3);
        let v0 = state_mut<T0, T1>(arg0);
        0xd2550407673e08d06c4b1f16f31bb7313e5de02c5212f6e0627250e3bc72f282::state_inner::withdraw<T0, T1>(v0, arg1, 0xd2550407673e08d06c4b1f16f31bb7313e5de02c5212f6e0627250e3bc72f282::state_inner::consume_protocol_earnings<T0, T1>(v0, arg2), arg4)
    }

    public fun withdraw_and_rebalance<T0, T1>(arg0: &mut SAMState<T0, T1>, arg1: 0x2::coin::Coin<T1>, arg2: 0xd2550407673e08d06c4b1f16f31bb7313e5de02c5212f6e0627250e3bc72f282::ptr::ProtocolRequest<T0>, arg3: &0xd2550407673e08d06c4b1f16f31bb7313e5de02c5212f6e0627250e3bc72f282::sam_allowed_versions::AllowedVersions, arg4: &mut 0x2::tx_context::TxContext) : (0x2::balance::Balance<T0>, vector<0xd2550407673e08d06c4b1f16f31bb7313e5de02c5212f6e0627250e3bc72f282::wdr::WithdrawRequest<T0>>, vector<0xd2550407673e08d06c4b1f16f31bb7313e5de02c5212f6e0627250e3bc72f282::rbr::RebalanceRequest<T0>>) {
        0xd2550407673e08d06c4b1f16f31bb7313e5de02c5212f6e0627250e3bc72f282::sam_allowed_versions::assert_pkg_version(arg3);
        let v0 = state_mut<T0, T1>(arg0);
        let (v1, v2) = 0xd2550407673e08d06c4b1f16f31bb7313e5de02c5212f6e0627250e3bc72f282::state_inner::withdraw<T0, T1>(v0, arg1, 0xd2550407673e08d06c4b1f16f31bb7313e5de02c5212f6e0627250e3bc72f282::state_inner::consume_protocol_earnings<T0, T1>(v0, arg2), arg4);
        (v1, v2, 0xd2550407673e08d06c4b1f16f31bb7313e5de02c5212f6e0627250e3bc72f282::state_inner::rebalance_optimal<T0, T1>(v0, arg4))
    }

    public fun withdraw_fees<T0, T1>(arg0: &mut SAMState<T0, T1>, arg1: &0xd2550407673e08d06c4b1f16f31bb7313e5de02c5212f6e0627250e3bc72f282::sam_allowed_versions::AllowedVersions, arg2: &0xd2550407673e08d06c4b1f16f31bb7313e5de02c5212f6e0627250e3bc72f282::acl::AdminWitness<0xd2550407673e08d06c4b1f16f31bb7313e5de02c5212f6e0627250e3bc72f282::sam::SAM>, arg3: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<T0> {
        0xd2550407673e08d06c4b1f16f31bb7313e5de02c5212f6e0627250e3bc72f282::sam_allowed_versions::assert_pkg_version(arg1);
        0x2::coin::from_balance<T0>(0xd2550407673e08d06c4b1f16f31bb7313e5de02c5212f6e0627250e3bc72f282::state_inner::withdraw_all_fees<T0, T1>(state_mut<T0, T1>(arg0)), arg3)
    }

    // decompiled from Move bytecode v7
}

