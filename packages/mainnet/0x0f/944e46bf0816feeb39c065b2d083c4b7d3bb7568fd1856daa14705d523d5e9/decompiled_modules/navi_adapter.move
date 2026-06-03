module 0xf944e46bf0816feeb39c065b2d083c4b7d3bb7568fd1856daa14705d523d5e9::navi_adapter {
    struct NaviWitness<phantom T0> has drop {
        dummy_field: bool,
    }

    struct NaviAdapter<phantom T0, phantom T1> has store, key {
        id: 0x2::object::UID,
        coin_in: u64,
        account_cap: 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::account::AccountCap,
        asset: u8,
        apr: u256,
    }

    public fun new<T0, T1>(arg0: u8, arg1: &0xd2550407673e08d06c4b1f16f31bb7313e5de02c5212f6e0627250e3bc72f282::acl::AdminWitness<0xd2550407673e08d06c4b1f16f31bb7313e5de02c5212f6e0627250e3bc72f282::sam::SAM>, arg2: &mut 0x2::tx_context::TxContext) {
        let v0 = NaviAdapter<T0, T1>{
            id          : 0x2::object::new(arg2),
            coin_in     : 0,
            account_cap : 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::lending::create_account(arg2),
            asset       : arg0,
            apr         : 0,
        };
        0x2::transfer::public_share_object<NaviAdapter<T0, T1>>(v0);
    }

    public fun allocate_to_protocol<T0, T1>(arg0: &mut NaviAdapter<T0, T1>, arg1: &mut 0xd2550407673e08d06c4b1f16f31bb7313e5de02c5212f6e0627250e3bc72f282::state::SAMState<T0, T1>, arg2: &0x2::clock::Clock, arg3: &mut 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::storage::Storage, arg4: &mut 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::pool::Pool<T0>, arg5: &mut 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::incentive_v2::Incentive, arg6: &mut 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::incentive_v3::Incentive, arg7: 0xd2550407673e08d06c4b1f16f31bb7313e5de02c5212f6e0627250e3bc72f282::rbr::RebalanceRequest<T0>, arg8: &0xd2550407673e08d06c4b1f16f31bb7313e5de02c5212f6e0627250e3bc72f282::sam_allowed_versions::AllowedVersions, arg9: &mut 0x2::tx_context::TxContext) {
        let v0 = NaviWitness<T1>{dummy_field: false};
        let v1 = 0xd2550407673e08d06c4b1f16f31bb7313e5de02c5212f6e0627250e3bc72f282::state::allocate_to_protocol<T0, T1, NaviWitness<T1>>(arg1, arg7, v0, arg8, arg9);
        arg0.coin_in = arg0.coin_in + 0x2::balance::value<T0>(&v1);
        0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::incentive_v3::deposit_with_account_cap<T0>(arg2, arg3, arg4, arg0.asset, 0x2::coin::from_balance<T0>(v1, arg9), arg5, arg6, &arg0.account_cap);
    }

    public fun approve_protocol_request<T0, T1>(arg0: &mut NaviAdapter<T0, T1>, arg1: &mut 0xd2550407673e08d06c4b1f16f31bb7313e5de02c5212f6e0627250e3bc72f282::state::SAMState<T0, T1>, arg2: &0x2::clock::Clock, arg3: &0xca441b44943c16be0e6e23c5a955bb971537ea3289ae8016fbf33fffe1fd210f::oracle::PriceOracle, arg4: &mut 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::storage::Storage, arg5: &mut 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::pool::Pool<T0>, arg6: &mut 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::incentive_v2::Incentive, arg7: &mut 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::incentive_v3::Incentive, arg8: &mut 0xd2550407673e08d06c4b1f16f31bb7313e5de02c5212f6e0627250e3bc72f282::ptr::ProtocolRequest<T0>, arg9: &0xd2550407673e08d06c4b1f16f31bb7313e5de02c5212f6e0627250e3bc72f282::sam_allowed_versions::AllowedVersions, arg10: &mut 0x2::tx_context::TxContext) {
        let v0 = redeem_growth<T0, T1>(arg0, arg2, arg3, arg4, arg5, arg6, arg7, arg10);
        record<T0, T1>(arg0, arg1, arg4, v0, arg8, arg9, arg10);
    }

    public fun approve_protocol_request_sui<T0, T1>(arg0: &mut NaviAdapter<T0, T1>, arg1: &mut 0xd2550407673e08d06c4b1f16f31bb7313e5de02c5212f6e0627250e3bc72f282::state::SAMState<T0, T1>, arg2: &0x2::clock::Clock, arg3: &0xca441b44943c16be0e6e23c5a955bb971537ea3289ae8016fbf33fffe1fd210f::oracle::PriceOracle, arg4: &mut 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::storage::Storage, arg5: &mut 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::pool::Pool<T0>, arg6: &mut 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::incentive_v2::Incentive, arg7: &mut 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::incentive_v3::Incentive, arg8: &mut 0x3::sui_system::SuiSystemState, arg9: &mut 0xd2550407673e08d06c4b1f16f31bb7313e5de02c5212f6e0627250e3bc72f282::ptr::ProtocolRequest<T0>, arg10: &0xd2550407673e08d06c4b1f16f31bb7313e5de02c5212f6e0627250e3bc72f282::sam_allowed_versions::AllowedVersions, arg11: &mut 0x2::tx_context::TxContext) {
        let v0 = redeem_growth_sui<T0, T1>(arg0, arg2, arg3, arg4, arg5, arg6, arg7, arg8, arg11);
        record<T0, T1>(arg0, arg1, arg4, v0, arg9, arg10, arg11);
    }

    fun get_apr<T0, T1>(arg0: &NaviAdapter<T0, T1>) : 0x99a1d666d9e4792bee2f34a2693aeab95a57b3c662da2e68574a03e929e60b0e::fixed18::Fixed18 {
        0x99a1d666d9e4792bee2f34a2693aeab95a57b3c662da2e68574a03e929e60b0e::fixed18::from_raw_u256(arg0.apr)
    }

    fun get_available_liquidity<T0, T1>(arg0: &NaviAdapter<T0, T1>, arg1: u8) : 0x99a1d666d9e4792bee2f34a2693aeab95a57b3c662da2e68574a03e929e60b0e::fixed18::Fixed18 {
        0x99a1d666d9e4792bee2f34a2693aeab95a57b3c662da2e68574a03e929e60b0e::fixed18::u64_to_fixed18(arg0.coin_in, arg1)
    }

    fun learn_and_growth<T0, T1>(arg0: &mut NaviAdapter<T0, T1>, arg1: &mut 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::storage::Storage, arg2: &0x2::clock::Clock) : u64 {
        let (v0, _) = 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::storage::get_user_balance(arg1, arg0.asset, 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::account::account_owner(&arg0.account_cap));
        let (v2, _) = 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::storage::get_index(arg1, arg0.asset);
        let v4 = (ray_mul(v0, v2) as u64);
        arg0.apr = 0xb23208de702112f80bc9a36b441c9d5df3be072e7e7157be09d8818cefb57533::apr::update_apr_from_ratio(&mut arg0.id, arg0.apr, v2, 0x2::clock::timestamp_ms(arg2));
        if (v4 <= arg0.coin_in) {
            0
        } else {
            v4 - arg0.coin_in
        }
    }

    fun ray_mul(arg0: u256, arg1: u256) : u256 {
        (arg0 * arg1 + 1000000000000000000000000000 / 2) / 1000000000000000000000000000
    }

    fun record<T0, T1>(arg0: &NaviAdapter<T0, T1>, arg1: &mut 0xd2550407673e08d06c4b1f16f31bb7313e5de02c5212f6e0627250e3bc72f282::state::SAMState<T0, T1>, arg2: &mut 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::storage::Storage, arg3: 0x2::balance::Balance<T0>, arg4: &mut 0xd2550407673e08d06c4b1f16f31bb7313e5de02c5212f6e0627250e3bc72f282::ptr::ProtocolRequest<T0>, arg5: &0xd2550407673e08d06c4b1f16f31bb7313e5de02c5212f6e0627250e3bc72f282::sam_allowed_versions::AllowedVersions, arg6: &mut 0x2::tx_context::TxContext) {
        let v0 = 0xd2550407673e08d06c4b1f16f31bb7313e5de02c5212f6e0627250e3bc72f282::state::decimals<T0, T1>(arg1);
        let v1 = get_apr<T0, T1>(arg0);
        let v2 = NaviWitness<T1>{dummy_field: false};
        0xd2550407673e08d06c4b1f16f31bb7313e5de02c5212f6e0627250e3bc72f282::state::approve_protocol_request<T0, T1, NaviWitness<T1>>(arg1, arg4, get_available_liquidity<T0, T1>(arg0, v0), v1, arg3, v2, arg5, arg6);
        let v3 = NaviWitness<T1>{dummy_field: false};
        0xd2550407673e08d06c4b1f16f31bb7313e5de02c5212f6e0627250e3bc72f282::state::record_point<T0, T1, NaviWitness<T1>>(arg1, v1, reserve_depth<T0, T1>(arg0, arg2, v0), v3, arg5);
    }

    fun redeem_growth<T0, T1>(arg0: &mut NaviAdapter<T0, T1>, arg1: &0x2::clock::Clock, arg2: &0xca441b44943c16be0e6e23c5a955bb971537ea3289ae8016fbf33fffe1fd210f::oracle::PriceOracle, arg3: &mut 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::storage::Storage, arg4: &mut 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::pool::Pool<T0>, arg5: &mut 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::incentive_v2::Incentive, arg6: &mut 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::incentive_v3::Incentive, arg7: &mut 0x2::tx_context::TxContext) : 0x2::balance::Balance<T0> {
        let v0 = learn_and_growth<T0, T1>(arg0, arg3, arg1);
        if (v0 == 0) {
            return 0x2::balance::zero<T0>()
        };
        0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::incentive_v3::withdraw_with_account_cap<T0>(arg1, arg2, arg3, arg4, arg0.asset, v0, arg5, arg6, &arg0.account_cap)
    }

    fun redeem_growth_sui<T0, T1>(arg0: &mut NaviAdapter<T0, T1>, arg1: &0x2::clock::Clock, arg2: &0xca441b44943c16be0e6e23c5a955bb971537ea3289ae8016fbf33fffe1fd210f::oracle::PriceOracle, arg3: &mut 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::storage::Storage, arg4: &mut 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::pool::Pool<T0>, arg5: &mut 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::incentive_v2::Incentive, arg6: &mut 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::incentive_v3::Incentive, arg7: &mut 0x3::sui_system::SuiSystemState, arg8: &mut 0x2::tx_context::TxContext) : 0x2::balance::Balance<T0> {
        let v0 = learn_and_growth<T0, T1>(arg0, arg3, arg1);
        if (v0 == 0) {
            return 0x2::balance::zero<T0>()
        };
        0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::incentive_v3::withdraw_with_account_cap_v2<T0>(arg1, arg2, arg3, arg4, arg0.asset, v0, arg5, arg6, &arg0.account_cap, arg7, arg8)
    }

    fun reserve_depth<T0, T1>(arg0: &NaviAdapter<T0, T1>, arg1: &mut 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::storage::Storage, arg2: u8) : 0x99a1d666d9e4792bee2f34a2693aeab95a57b3c662da2e68574a03e929e60b0e::fixed18::Fixed18 {
        let (v0, _) = 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::storage::get_total_supply(arg1, arg0.asset);
        let (v2, _) = 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::storage::get_index(arg1, arg0.asset);
        0x99a1d666d9e4792bee2f34a2693aeab95a57b3c662da2e68574a03e929e60b0e::fixed18::u64_to_fixed18((ray_mul(v0, v2) as u64), arg2)
    }

    public fun update_apr<T0, T1>(arg0: &mut NaviAdapter<T0, T1>, arg1: u256, arg2: &0xd2550407673e08d06c4b1f16f31bb7313e5de02c5212f6e0627250e3bc72f282::acl::AdminWitness<0xd2550407673e08d06c4b1f16f31bb7313e5de02c5212f6e0627250e3bc72f282::sam::SAM>) {
        arg0.apr = arg1;
    }

    public fun withdraw_wdr<T0, T1>(arg0: &mut NaviAdapter<T0, T1>, arg1: &mut 0xd2550407673e08d06c4b1f16f31bb7313e5de02c5212f6e0627250e3bc72f282::state::SAMState<T0, T1>, arg2: &0x2::clock::Clock, arg3: &0xca441b44943c16be0e6e23c5a955bb971537ea3289ae8016fbf33fffe1fd210f::oracle::PriceOracle, arg4: &mut 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::storage::Storage, arg5: &mut 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::pool::Pool<T0>, arg6: &mut 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::incentive_v2::Incentive, arg7: &mut 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::incentive_v3::Incentive, arg8: &mut 0xd2550407673e08d06c4b1f16f31bb7313e5de02c5212f6e0627250e3bc72f282::wdr::WithdrawRequest<T0>, arg9: &0xd2550407673e08d06c4b1f16f31bb7313e5de02c5212f6e0627250e3bc72f282::sam_allowed_versions::AllowedVersions, arg10: &mut 0x2::tx_context::TxContext) {
        let v0 = 0xd2550407673e08d06c4b1f16f31bb7313e5de02c5212f6e0627250e3bc72f282::wdr::get_coin_amount<T0>(arg8);
        arg0.coin_in = arg0.coin_in - v0;
        let v1 = NaviWitness<T1>{dummy_field: false};
        0xd2550407673e08d06c4b1f16f31bb7313e5de02c5212f6e0627250e3bc72f282::state::fill_withdraw_request<T0, T1, NaviWitness<T1>>(arg1, arg8, 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::incentive_v3::withdraw_with_account_cap<T0>(arg2, arg3, arg4, arg5, arg0.asset, v0, arg6, arg7, &arg0.account_cap), v1, arg9, arg10);
    }

    public fun withdraw_wdr_sui<T0, T1>(arg0: &mut NaviAdapter<T0, T1>, arg1: &mut 0xd2550407673e08d06c4b1f16f31bb7313e5de02c5212f6e0627250e3bc72f282::state::SAMState<T0, T1>, arg2: &0x2::clock::Clock, arg3: &0xca441b44943c16be0e6e23c5a955bb971537ea3289ae8016fbf33fffe1fd210f::oracle::PriceOracle, arg4: &mut 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::storage::Storage, arg5: &mut 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::pool::Pool<T0>, arg6: &mut 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::incentive_v2::Incentive, arg7: &mut 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::incentive_v3::Incentive, arg8: &mut 0x3::sui_system::SuiSystemState, arg9: &mut 0xd2550407673e08d06c4b1f16f31bb7313e5de02c5212f6e0627250e3bc72f282::wdr::WithdrawRequest<T0>, arg10: &0xd2550407673e08d06c4b1f16f31bb7313e5de02c5212f6e0627250e3bc72f282::sam_allowed_versions::AllowedVersions, arg11: &mut 0x2::tx_context::TxContext) {
        let v0 = 0xd2550407673e08d06c4b1f16f31bb7313e5de02c5212f6e0627250e3bc72f282::wdr::get_coin_amount<T0>(arg9);
        arg0.coin_in = arg0.coin_in - v0;
        let v1 = NaviWitness<T1>{dummy_field: false};
        0xd2550407673e08d06c4b1f16f31bb7313e5de02c5212f6e0627250e3bc72f282::state::fill_withdraw_request<T0, T1, NaviWitness<T1>>(arg1, arg9, 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::incentive_v3::withdraw_with_account_cap_v2<T0>(arg2, arg3, arg4, arg5, arg0.asset, v0, arg6, arg7, &arg0.account_cap, arg8, arg11), v1, arg10, arg11);
    }

    public fun witness_type<T0>() : 0x1::type_name::TypeName {
        0x1::type_name::get<NaviWitness<T0>>()
    }

    // decompiled from Move bytecode v7
}

