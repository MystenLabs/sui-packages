module 0xa02a0683ce74b8192fb221a2d5e9457a060c5ca0542df3200c0ea3be90138317::flow {
    public fun allocate<T0, T1>(arg0: &mut 0xe87b8f0d267ca2436863570c735dfda4130fd0f7446059ec64343c4962cd0735::state::SAMState<T0, T1>, arg1: vector<0xe87b8f0d267ca2436863570c735dfda4130fd0f7446059ec64343c4962cd0735::rbr::RebalanceRequest<T0, T1>>, arg2: &mut 0xa02a0683ce74b8192fb221a2d5e9457a060c5ca0542df3200c0ea3be90138317::navi_adapter::NaviAdapter<T0, T1>, arg3: &0x2::clock::Clock, arg4: &mut 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::storage::Storage, arg5: &mut 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::pool::Pool<T0>, arg6: &mut 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::incentive_v2::Incentive, arg7: &mut 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::incentive_v3::Incentive, arg8: &0xe87b8f0d267ca2436863570c735dfda4130fd0f7446059ec64343c4962cd0735::sam_allowed_versions::AllowedVersions, arg9: &mut 0x2::tx_context::TxContext) : vector<0xe87b8f0d267ca2436863570c735dfda4130fd0f7446059ec64343c4962cd0735::rbr::RebalanceRequest<T0, T1>> {
        let v0 = 0x1::vector::empty<0xe87b8f0d267ca2436863570c735dfda4130fd0f7446059ec64343c4962cd0735::rbr::RebalanceRequest<T0, T1>>();
        0x1::vector::reverse<0xe87b8f0d267ca2436863570c735dfda4130fd0f7446059ec64343c4962cd0735::rbr::RebalanceRequest<T0, T1>>(&mut arg1);
        let v1 = 0;
        while (v1 < 0x1::vector::length<0xe87b8f0d267ca2436863570c735dfda4130fd0f7446059ec64343c4962cd0735::rbr::RebalanceRequest<T0, T1>>(&arg1)) {
            let v2 = 0x1::vector::pop_back<0xe87b8f0d267ca2436863570c735dfda4130fd0f7446059ec64343c4962cd0735::rbr::RebalanceRequest<T0, T1>>(&mut arg1);
            if (0xe87b8f0d267ca2436863570c735dfda4130fd0f7446059ec64343c4962cd0735::rbr::to_witness<T0, T1>(&v2) == 0x1::option::some<0x1::type_name::TypeName>(0xa02a0683ce74b8192fb221a2d5e9457a060c5ca0542df3200c0ea3be90138317::navi_adapter::witness_type<T1>())) {
                0xa02a0683ce74b8192fb221a2d5e9457a060c5ca0542df3200c0ea3be90138317::navi_adapter::allocate_to_protocol<T0, T1>(arg2, arg0, arg3, arg4, arg5, arg6, arg7, v2, arg8, arg9);
            } else {
                0x1::vector::push_back<0xe87b8f0d267ca2436863570c735dfda4130fd0f7446059ec64343c4962cd0735::rbr::RebalanceRequest<T0, T1>>(&mut v0, v2);
            };
            v1 = v1 + 1;
        };
        0x1::vector::destroy_empty<0xe87b8f0d267ca2436863570c735dfda4130fd0f7446059ec64343c4962cd0735::rbr::RebalanceRequest<T0, T1>>(arg1);
        v0
    }

    public fun approve_navi<T0, T1>(arg0: &mut 0xe87b8f0d267ca2436863570c735dfda4130fd0f7446059ec64343c4962cd0735::state::SAMState<T0, T1>, arg1: &mut 0xe87b8f0d267ca2436863570c735dfda4130fd0f7446059ec64343c4962cd0735::ptr::ProtocolRequest<T0>, arg2: &mut 0xa02a0683ce74b8192fb221a2d5e9457a060c5ca0542df3200c0ea3be90138317::navi_adapter::NaviAdapter<T0, T1>, arg3: &0x2::clock::Clock, arg4: &0xca441b44943c16be0e6e23c5a955bb971537ea3289ae8016fbf33fffe1fd210f::oracle::PriceOracle, arg5: &mut 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::storage::Storage, arg6: &mut 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::pool::Pool<T0>, arg7: &mut 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::incentive_v2::Incentive, arg8: &mut 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::incentive_v3::Incentive, arg9: &0xe87b8f0d267ca2436863570c735dfda4130fd0f7446059ec64343c4962cd0735::sam_allowed_versions::AllowedVersions, arg10: &mut 0x2::tx_context::TxContext) {
        0xa02a0683ce74b8192fb221a2d5e9457a060c5ca0542df3200c0ea3be90138317::navi_adapter::end_approve<T0, T1>(arg2, arg0, arg1, 0xa02a0683ce74b8192fb221a2d5e9457a060c5ca0542df3200c0ea3be90138317::navi_adapter::begin_approve<T0, T1>(arg2, arg0, arg3, arg4, arg5, arg6, arg7, arg8), arg3, arg9, arg10);
    }

    public fun approve_navi_reward<T0, T1, T2, T3>(arg0: &mut 0xe87b8f0d267ca2436863570c735dfda4130fd0f7446059ec64343c4962cd0735::state::SAMState<T0, T1>, arg1: &mut 0xe87b8f0d267ca2436863570c735dfda4130fd0f7446059ec64343c4962cd0735::ptr::ProtocolRequest<T0>, arg2: &mut 0xa02a0683ce74b8192fb221a2d5e9457a060c5ca0542df3200c0ea3be90138317::navi_adapter::NaviAdapter<T0, T1>, arg3: &0x2::clock::Clock, arg4: &0xca441b44943c16be0e6e23c5a955bb971537ea3289ae8016fbf33fffe1fd210f::oracle::PriceOracle, arg5: &mut 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::storage::Storage, arg6: &mut 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::pool::Pool<T0>, arg7: &mut 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::incentive_v2::Incentive, arg8: &mut 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::incentive_v3::Incentive, arg9: &mut 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::incentive_v3::RewardFund<T2>, arg10: &0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::config::GlobalConfig, arg11: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T2, T3>, arg12: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T0, T3>, arg13: &0xe87b8f0d267ca2436863570c735dfda4130fd0f7446059ec64343c4962cd0735::sam_allowed_versions::AllowedVersions, arg14: &mut 0x2::tx_context::TxContext) {
        let v0 = 0xa02a0683ce74b8192fb221a2d5e9457a060c5ca0542df3200c0ea3be90138317::navi_adapter::begin_approve<T0, T1>(arg2, arg0, arg3, arg4, arg5, arg6, arg7, arg8);
        0xa02a0683ce74b8192fb221a2d5e9457a060c5ca0542df3200c0ea3be90138317::navi_adapter::harvest_reward<T0, T1, T2, T3>(arg2, &mut v0, arg3, arg5, arg8, arg9, arg10, arg11, arg12);
        0xa02a0683ce74b8192fb221a2d5e9457a060c5ca0542df3200c0ea3be90138317::navi_adapter::end_approve<T0, T1>(arg2, arg0, arg1, v0, arg3, arg13, arg14);
    }

    public fun approve_navi_reward_direct<T0, T1, T2>(arg0: &mut 0xe87b8f0d267ca2436863570c735dfda4130fd0f7446059ec64343c4962cd0735::state::SAMState<T0, T1>, arg1: &mut 0xe87b8f0d267ca2436863570c735dfda4130fd0f7446059ec64343c4962cd0735::ptr::ProtocolRequest<T0>, arg2: &mut 0xa02a0683ce74b8192fb221a2d5e9457a060c5ca0542df3200c0ea3be90138317::navi_adapter::NaviAdapter<T0, T1>, arg3: &0x2::clock::Clock, arg4: &0xca441b44943c16be0e6e23c5a955bb971537ea3289ae8016fbf33fffe1fd210f::oracle::PriceOracle, arg5: &mut 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::storage::Storage, arg6: &mut 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::pool::Pool<T0>, arg7: &mut 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::incentive_v2::Incentive, arg8: &mut 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::incentive_v3::Incentive, arg9: &mut 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::incentive_v3::RewardFund<T2>, arg10: &0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::config::GlobalConfig, arg11: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T0, T2>, arg12: &0xe87b8f0d267ca2436863570c735dfda4130fd0f7446059ec64343c4962cd0735::sam_allowed_versions::AllowedVersions, arg13: &mut 0x2::tx_context::TxContext) {
        let v0 = 0xa02a0683ce74b8192fb221a2d5e9457a060c5ca0542df3200c0ea3be90138317::navi_adapter::begin_approve<T0, T1>(arg2, arg0, arg3, arg4, arg5, arg6, arg7, arg8);
        0xa02a0683ce74b8192fb221a2d5e9457a060c5ca0542df3200c0ea3be90138317::navi_adapter::harvest_reward_direct<T0, T1, T2>(arg2, &mut v0, arg3, arg5, arg8, arg9, arg10, arg11);
        0xa02a0683ce74b8192fb221a2d5e9457a060c5ca0542df3200c0ea3be90138317::navi_adapter::end_approve<T0, T1>(arg2, arg0, arg1, v0, arg3, arg12, arg13);
    }

    public fun approve_navi_sui<T0, T1>(arg0: &mut 0xe87b8f0d267ca2436863570c735dfda4130fd0f7446059ec64343c4962cd0735::state::SAMState<T0, T1>, arg1: &mut 0xe87b8f0d267ca2436863570c735dfda4130fd0f7446059ec64343c4962cd0735::ptr::ProtocolRequest<T0>, arg2: &mut 0xa02a0683ce74b8192fb221a2d5e9457a060c5ca0542df3200c0ea3be90138317::navi_adapter::NaviAdapter<T0, T1>, arg3: &0x2::clock::Clock, arg4: &0xca441b44943c16be0e6e23c5a955bb971537ea3289ae8016fbf33fffe1fd210f::oracle::PriceOracle, arg5: &mut 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::storage::Storage, arg6: &mut 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::pool::Pool<T0>, arg7: &mut 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::incentive_v2::Incentive, arg8: &mut 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::incentive_v3::Incentive, arg9: &mut 0x3::sui_system::SuiSystemState, arg10: &0xe87b8f0d267ca2436863570c735dfda4130fd0f7446059ec64343c4962cd0735::sam_allowed_versions::AllowedVersions, arg11: &mut 0x2::tx_context::TxContext) {
        0xa02a0683ce74b8192fb221a2d5e9457a060c5ca0542df3200c0ea3be90138317::navi_adapter::end_approve<T0, T1>(arg2, arg0, arg1, 0xa02a0683ce74b8192fb221a2d5e9457a060c5ca0542df3200c0ea3be90138317::navi_adapter::begin_approve_sui<T0, T1>(arg2, arg0, arg3, arg4, arg5, arg6, arg7, arg8, arg9, arg11), arg3, arg10, arg11);
    }

    public fun approve_navi_sui_reward<T0, T1, T2>(arg0: &mut 0xe87b8f0d267ca2436863570c735dfda4130fd0f7446059ec64343c4962cd0735::state::SAMState<T0, T1>, arg1: &mut 0xe87b8f0d267ca2436863570c735dfda4130fd0f7446059ec64343c4962cd0735::ptr::ProtocolRequest<T0>, arg2: &mut 0xa02a0683ce74b8192fb221a2d5e9457a060c5ca0542df3200c0ea3be90138317::navi_adapter::NaviAdapter<T0, T1>, arg3: &0x2::clock::Clock, arg4: &0xca441b44943c16be0e6e23c5a955bb971537ea3289ae8016fbf33fffe1fd210f::oracle::PriceOracle, arg5: &mut 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::storage::Storage, arg6: &mut 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::pool::Pool<T0>, arg7: &mut 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::incentive_v2::Incentive, arg8: &mut 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::incentive_v3::Incentive, arg9: &mut 0x3::sui_system::SuiSystemState, arg10: &mut 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::incentive_v3::RewardFund<T2>, arg11: &0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::config::GlobalConfig, arg12: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T2, T0>, arg13: &0xe87b8f0d267ca2436863570c735dfda4130fd0f7446059ec64343c4962cd0735::sam_allowed_versions::AllowedVersions, arg14: &mut 0x2::tx_context::TxContext) {
        let v0 = 0xa02a0683ce74b8192fb221a2d5e9457a060c5ca0542df3200c0ea3be90138317::navi_adapter::begin_approve_sui<T0, T1>(arg2, arg0, arg3, arg4, arg5, arg6, arg7, arg8, arg9, arg14);
        0xa02a0683ce74b8192fb221a2d5e9457a060c5ca0542df3200c0ea3be90138317::navi_adapter::harvest_reward_direct_a<T0, T1, T2>(arg2, &mut v0, arg3, arg5, arg8, arg10, arg11, arg12);
        0xa02a0683ce74b8192fb221a2d5e9457a060c5ca0542df3200c0ea3be90138317::navi_adapter::end_approve<T0, T1>(arg2, arg0, arg1, v0, arg3, arg13, arg14);
    }

    public fun fill<T0, T1>(arg0: &mut 0xe87b8f0d267ca2436863570c735dfda4130fd0f7446059ec64343c4962cd0735::state::SAMState<T0, T1>, arg1: vector<0xe87b8f0d267ca2436863570c735dfda4130fd0f7446059ec64343c4962cd0735::wdr::WithdrawRequest<T0, T1>>, arg2: &mut 0xa02a0683ce74b8192fb221a2d5e9457a060c5ca0542df3200c0ea3be90138317::navi_adapter::NaviAdapter<T0, T1>, arg3: &0x2::clock::Clock, arg4: &0xca441b44943c16be0e6e23c5a955bb971537ea3289ae8016fbf33fffe1fd210f::oracle::PriceOracle, arg5: &mut 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::storage::Storage, arg6: &mut 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::pool::Pool<T0>, arg7: &mut 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::incentive_v2::Incentive, arg8: &mut 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::incentive_v3::Incentive, arg9: &0xe87b8f0d267ca2436863570c735dfda4130fd0f7446059ec64343c4962cd0735::sam_allowed_versions::AllowedVersions, arg10: &mut 0x2::tx_context::TxContext) : vector<0xe87b8f0d267ca2436863570c735dfda4130fd0f7446059ec64343c4962cd0735::wdr::WithdrawRequest<T0, T1>> {
        let v0 = &mut arg1;
        let v1 = 0;
        while (v1 < 0x1::vector::length<0xe87b8f0d267ca2436863570c735dfda4130fd0f7446059ec64343c4962cd0735::wdr::WithdrawRequest<T0, T1>>(v0)) {
            let v2 = 0x1::vector::borrow_mut<0xe87b8f0d267ca2436863570c735dfda4130fd0f7446059ec64343c4962cd0735::wdr::WithdrawRequest<T0, T1>>(v0, v1);
            if (0xe87b8f0d267ca2436863570c735dfda4130fd0f7446059ec64343c4962cd0735::wdr::get_witness<T0, T1>(v2) == 0xa02a0683ce74b8192fb221a2d5e9457a060c5ca0542df3200c0ea3be90138317::navi_adapter::witness_type<T1>()) {
                0xa02a0683ce74b8192fb221a2d5e9457a060c5ca0542df3200c0ea3be90138317::navi_adapter::withdraw_wdr<T0, T1>(arg2, arg0, arg3, arg4, arg5, arg6, arg7, arg8, v2, arg9, arg10);
            };
            v1 = v1 + 1;
        };
        arg1
    }

    public fun fill_rebalance<T0, T1>(arg0: &mut 0xe87b8f0d267ca2436863570c735dfda4130fd0f7446059ec64343c4962cd0735::state::SAMState<T0, T1>, arg1: vector<0xe87b8f0d267ca2436863570c735dfda4130fd0f7446059ec64343c4962cd0735::rbr::RebalanceRequest<T0, T1>>, arg2: &mut 0xa02a0683ce74b8192fb221a2d5e9457a060c5ca0542df3200c0ea3be90138317::navi_adapter::NaviAdapter<T0, T1>, arg3: &0x2::clock::Clock, arg4: &0xca441b44943c16be0e6e23c5a955bb971537ea3289ae8016fbf33fffe1fd210f::oracle::PriceOracle, arg5: &mut 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::storage::Storage, arg6: &mut 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::pool::Pool<T0>, arg7: &mut 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::incentive_v2::Incentive, arg8: &mut 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::incentive_v3::Incentive, arg9: &0xe87b8f0d267ca2436863570c735dfda4130fd0f7446059ec64343c4962cd0735::sam_allowed_versions::AllowedVersions, arg10: &mut 0x2::tx_context::TxContext) : vector<0xe87b8f0d267ca2436863570c735dfda4130fd0f7446059ec64343c4962cd0735::rbr::RebalanceRequest<T0, T1>> {
        let v0 = &mut arg1;
        let v1 = 0;
        while (v1 < 0x1::vector::length<0xe87b8f0d267ca2436863570c735dfda4130fd0f7446059ec64343c4962cd0735::rbr::RebalanceRequest<T0, T1>>(v0)) {
            let v2 = 0x1::vector::borrow_mut<0xe87b8f0d267ca2436863570c735dfda4130fd0f7446059ec64343c4962cd0735::rbr::RebalanceRequest<T0, T1>>(v0, v1);
            if (0xe87b8f0d267ca2436863570c735dfda4130fd0f7446059ec64343c4962cd0735::rbr::from_witness<T0, T1>(v2) == 0x1::option::some<0x1::type_name::TypeName>(0xa02a0683ce74b8192fb221a2d5e9457a060c5ca0542df3200c0ea3be90138317::navi_adapter::witness_type<T1>())) {
                0xa02a0683ce74b8192fb221a2d5e9457a060c5ca0542df3200c0ea3be90138317::navi_adapter::withdraw_rbr<T0, T1>(arg2, arg0, arg3, arg4, arg5, arg6, arg7, arg8, v2, arg9, arg10);
            };
            v1 = v1 + 1;
        };
        arg1
    }

    public fun fill_rebalance_sui<T0, T1>(arg0: &mut 0xe87b8f0d267ca2436863570c735dfda4130fd0f7446059ec64343c4962cd0735::state::SAMState<T0, T1>, arg1: vector<0xe87b8f0d267ca2436863570c735dfda4130fd0f7446059ec64343c4962cd0735::rbr::RebalanceRequest<T0, T1>>, arg2: &mut 0xa02a0683ce74b8192fb221a2d5e9457a060c5ca0542df3200c0ea3be90138317::navi_adapter::NaviAdapter<T0, T1>, arg3: &0x2::clock::Clock, arg4: &0xca441b44943c16be0e6e23c5a955bb971537ea3289ae8016fbf33fffe1fd210f::oracle::PriceOracle, arg5: &mut 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::storage::Storage, arg6: &mut 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::pool::Pool<T0>, arg7: &mut 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::incentive_v2::Incentive, arg8: &mut 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::incentive_v3::Incentive, arg9: &mut 0x3::sui_system::SuiSystemState, arg10: &0xe87b8f0d267ca2436863570c735dfda4130fd0f7446059ec64343c4962cd0735::sam_allowed_versions::AllowedVersions, arg11: &mut 0x2::tx_context::TxContext) : vector<0xe87b8f0d267ca2436863570c735dfda4130fd0f7446059ec64343c4962cd0735::rbr::RebalanceRequest<T0, T1>> {
        let v0 = &mut arg1;
        let v1 = 0;
        while (v1 < 0x1::vector::length<0xe87b8f0d267ca2436863570c735dfda4130fd0f7446059ec64343c4962cd0735::rbr::RebalanceRequest<T0, T1>>(v0)) {
            let v2 = 0x1::vector::borrow_mut<0xe87b8f0d267ca2436863570c735dfda4130fd0f7446059ec64343c4962cd0735::rbr::RebalanceRequest<T0, T1>>(v0, v1);
            if (0xe87b8f0d267ca2436863570c735dfda4130fd0f7446059ec64343c4962cd0735::rbr::from_witness<T0, T1>(v2) == 0x1::option::some<0x1::type_name::TypeName>(0xa02a0683ce74b8192fb221a2d5e9457a060c5ca0542df3200c0ea3be90138317::navi_adapter::witness_type<T1>())) {
                0xa02a0683ce74b8192fb221a2d5e9457a060c5ca0542df3200c0ea3be90138317::navi_adapter::withdraw_rbr_sui<T0, T1>(arg2, arg0, arg3, arg4, arg5, arg6, arg7, arg8, arg9, v2, arg10, arg11);
            };
            v1 = v1 + 1;
        };
        arg1
    }

    public fun fill_sui<T0, T1>(arg0: &mut 0xe87b8f0d267ca2436863570c735dfda4130fd0f7446059ec64343c4962cd0735::state::SAMState<T0, T1>, arg1: vector<0xe87b8f0d267ca2436863570c735dfda4130fd0f7446059ec64343c4962cd0735::wdr::WithdrawRequest<T0, T1>>, arg2: &mut 0xa02a0683ce74b8192fb221a2d5e9457a060c5ca0542df3200c0ea3be90138317::navi_adapter::NaviAdapter<T0, T1>, arg3: &0x2::clock::Clock, arg4: &0xca441b44943c16be0e6e23c5a955bb971537ea3289ae8016fbf33fffe1fd210f::oracle::PriceOracle, arg5: &mut 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::storage::Storage, arg6: &mut 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::pool::Pool<T0>, arg7: &mut 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::incentive_v2::Incentive, arg8: &mut 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::incentive_v3::Incentive, arg9: &mut 0x3::sui_system::SuiSystemState, arg10: &0xe87b8f0d267ca2436863570c735dfda4130fd0f7446059ec64343c4962cd0735::sam_allowed_versions::AllowedVersions, arg11: &mut 0x2::tx_context::TxContext) : vector<0xe87b8f0d267ca2436863570c735dfda4130fd0f7446059ec64343c4962cd0735::wdr::WithdrawRequest<T0, T1>> {
        let v0 = &mut arg1;
        let v1 = 0;
        while (v1 < 0x1::vector::length<0xe87b8f0d267ca2436863570c735dfda4130fd0f7446059ec64343c4962cd0735::wdr::WithdrawRequest<T0, T1>>(v0)) {
            let v2 = 0x1::vector::borrow_mut<0xe87b8f0d267ca2436863570c735dfda4130fd0f7446059ec64343c4962cd0735::wdr::WithdrawRequest<T0, T1>>(v0, v1);
            if (0xe87b8f0d267ca2436863570c735dfda4130fd0f7446059ec64343c4962cd0735::wdr::get_witness<T0, T1>(v2) == 0xa02a0683ce74b8192fb221a2d5e9457a060c5ca0542df3200c0ea3be90138317::navi_adapter::witness_type<T1>()) {
                0xa02a0683ce74b8192fb221a2d5e9457a060c5ca0542df3200c0ea3be90138317::navi_adapter::withdraw_wdr_sui<T0, T1>(arg2, arg0, arg3, arg4, arg5, arg6, arg7, arg8, arg9, v2, arg10, arg11);
            };
            v1 = v1 + 1;
        };
        arg1
    }

    // decompiled from Move bytecode v7
}

