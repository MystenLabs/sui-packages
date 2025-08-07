module 0xbb58785de3bb8808392b22c2110526c7c3d3bb6f30ff564ee4bb4b61193136b1::loop_strategy_operate {
    public entry fun toggle_deposit(arg0: &0xbb58785de3bb8808392b22c2110526c7c3d3bb6f30ff564ee4bb4b61193136b1::loop_strategy_manage::OperatorCap, arg1: &mut 0xbb58785de3bb8808392b22c2110526c7c3d3bb6f30ff564ee4bb4b61193136b1::loop_strategy_core::Strategy, arg2: bool) {
        0xbb58785de3bb8808392b22c2110526c7c3d3bb6f30ff564ee4bb4b61193136b1::loop_strategy_core::assert_version(arg1);
        0xbb58785de3bb8808392b22c2110526c7c3d3bb6f30ff564ee4bb4b61193136b1::loop_strategy_core::toggle_deposit(arg1, arg2);
    }

    public entry fun toggle_withdraw(arg0: &0xbb58785de3bb8808392b22c2110526c7c3d3bb6f30ff564ee4bb4b61193136b1::loop_strategy_manage::OperatorCap, arg1: &mut 0xbb58785de3bb8808392b22c2110526c7c3d3bb6f30ff564ee4bb4b61193136b1::loop_strategy_core::Strategy, arg2: bool) {
        0xbb58785de3bb8808392b22c2110526c7c3d3bb6f30ff564ee4bb4b61193136b1::loop_strategy_core::assert_version(arg1);
        0xbb58785de3bb8808392b22c2110526c7c3d3bb6f30ff564ee4bb4b61193136b1::loop_strategy_core::toggle_withdraw(arg1, arg2);
    }

    public entry fun reward_reinvestment(arg0: &0xbb58785de3bb8808392b22c2110526c7c3d3bb6f30ff564ee4bb4b61193136b1::loop_strategy_manage::OperatorCap, arg1: &0x2::clock::Clock, arg2: &mut 0xbb58785de3bb8808392b22c2110526c7c3d3bb6f30ff564ee4bb4b61193136b1::loop_strategy_core::Strategy, arg3: &mut 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::storage::Storage, arg4: &mut 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::pool::Pool<0xbde4ba4c2e274a60ce15c1cfff9e5c42e41654ac8b6d906a57efa4bd3c29f47d::hasui::HASUI>, arg5: &mut 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::incentive_v2::Incentive, arg6: &mut 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::incentive_v3::Incentive, arg7: &mut 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::incentive_v3::RewardFund<0x549e8b69270defbfafd4f94e17ec44cdbdd99820b33bda2278dea3b9a32d3f55::cert::CERT>, arg8: &0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::config::GlobalConfig, arg9: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::partner::Partner, arg10: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<0x549e8b69270defbfafd4f94e17ec44cdbdd99820b33bda2278dea3b9a32d3f55::cert::CERT, 0x2::sui::SUI>, arg11: &mut 0xbde4ba4c2e274a60ce15c1cfff9e5c42e41654ac8b6d906a57efa4bd3c29f47d::staking::Staking, arg12: &mut 0x3::sui_system::SuiSystemState, arg13: &mut 0x2::tx_context::TxContext) {
        0xbb58785de3bb8808392b22c2110526c7c3d3bb6f30ff564ee4bb4b61193136b1::loop_strategy_core::reinvestment(arg2, arg3, arg4, arg5, arg6, arg7, arg8, arg9, arg10, arg11, arg12, arg1, arg13);
    }

    public entry fun update_limit(arg0: &0xbb58785de3bb8808392b22c2110526c7c3d3bb6f30ff564ee4bb4b61193136b1::loop_strategy_manage::OperatorCap, arg1: &mut 0xbb58785de3bb8808392b22c2110526c7c3d3bb6f30ff564ee4bb4b61193136b1::loop_strategy_core::Strategy, arg2: u64, arg3: u64, arg4: u64, arg5: u64) {
        0xbb58785de3bb8808392b22c2110526c7c3d3bb6f30ff564ee4bb4b61193136b1::navi_section::update_risk_parameters(0xbb58785de3bb8808392b22c2110526c7c3d3bb6f30ff564ee4bb4b61193136b1::loop_strategy_core::get_config_mut(arg1), arg2, arg3, arg4, arg5);
    }

    public entry fun update_max_loops(arg0: &0xbb58785de3bb8808392b22c2110526c7c3d3bb6f30ff564ee4bb4b61193136b1::loop_strategy_manage::OperatorCap, arg1: &mut 0xbb58785de3bb8808392b22c2110526c7c3d3bb6f30ff564ee4bb4b61193136b1::loop_strategy_core::Strategy, arg2: u64) {
        0xbb58785de3bb8808392b22c2110526c7c3d3bb6f30ff564ee4bb4b61193136b1::navi_section::update_navi_max_loop(0xbb58785de3bb8808392b22c2110526c7c3d3bb6f30ff564ee4bb4b61193136b1::loop_strategy_core::get_config_mut(arg1), arg2);
    }

    public entry fun update_navi_asset(arg0: &0xbb58785de3bb8808392b22c2110526c7c3d3bb6f30ff564ee4bb4b61193136b1::loop_strategy_manage::OperatorCap, arg1: &mut 0xbb58785de3bb8808392b22c2110526c7c3d3bb6f30ff564ee4bb4b61193136b1::loop_strategy_core::Strategy, arg2: u8, arg3: u8) {
        0xbb58785de3bb8808392b22c2110526c7c3d3bb6f30ff564ee4bb4b61193136b1::navi_section::update_navi_asset_num(0xbb58785de3bb8808392b22c2110526c7c3d3bb6f30ff564ee4bb4b61193136b1::loop_strategy_core::get_config_mut(arg1), arg2, arg3);
    }

    // decompiled from Move bytecode v6
}

