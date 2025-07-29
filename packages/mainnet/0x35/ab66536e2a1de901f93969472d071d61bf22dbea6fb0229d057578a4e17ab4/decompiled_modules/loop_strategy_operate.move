module 0x35ab66536e2a1de901f93969472d071d61bf22dbea6fb0229d057578a4e17ab4::loop_strategy_operate {
    public entry fun toggle_deposit(arg0: &0x35ab66536e2a1de901f93969472d071d61bf22dbea6fb0229d057578a4e17ab4::loop_strategy_manage::OperatorCap, arg1: &mut 0x35ab66536e2a1de901f93969472d071d61bf22dbea6fb0229d057578a4e17ab4::loop_strategy_core::Strategy, arg2: bool) {
        0x35ab66536e2a1de901f93969472d071d61bf22dbea6fb0229d057578a4e17ab4::loop_strategy_core::assert_version(arg1);
        0x35ab66536e2a1de901f93969472d071d61bf22dbea6fb0229d057578a4e17ab4::loop_strategy_core::toggle_deposit(arg1, arg2);
    }

    public entry fun toggle_withdraw(arg0: &0x35ab66536e2a1de901f93969472d071d61bf22dbea6fb0229d057578a4e17ab4::loop_strategy_manage::OperatorCap, arg1: &mut 0x35ab66536e2a1de901f93969472d071d61bf22dbea6fb0229d057578a4e17ab4::loop_strategy_core::Strategy, arg2: bool) {
        0x35ab66536e2a1de901f93969472d071d61bf22dbea6fb0229d057578a4e17ab4::loop_strategy_core::assert_version(arg1);
        0x35ab66536e2a1de901f93969472d071d61bf22dbea6fb0229d057578a4e17ab4::loop_strategy_core::toggle_withdraw(arg1, arg2);
    }

    public entry fun reward_reinvestment(arg0: &0x35ab66536e2a1de901f93969472d071d61bf22dbea6fb0229d057578a4e17ab4::loop_strategy_manage::OperatorCap, arg1: &0x2::clock::Clock, arg2: &mut 0x35ab66536e2a1de901f93969472d071d61bf22dbea6fb0229d057578a4e17ab4::loop_strategy_core::Strategy, arg3: &mut 0x35ab66536e2a1de901f93969472d071d61bf22dbea6fb0229d057578a4e17ab4::navi_section::NaviConfig, arg4: &mut 0x35ab66536e2a1de901f93969472d071d61bf22dbea6fb0229d057578a4e17ab4::cetus_section::CetusConfig, arg5: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<0x549e8b69270defbfafd4f94e17ec44cdbdd99820b33bda2278dea3b9a32d3f55::cert::CERT, 0x2::sui::SUI>, arg6: &mut 0xbde4ba4c2e274a60ce15c1cfff9e5c42e41654ac8b6d906a57efa4bd3c29f47d::staking::Staking, arg7: &mut 0x3::sui_system::SuiSystemState, arg8: &mut 0x2::tx_context::TxContext) {
        0x35ab66536e2a1de901f93969472d071d61bf22dbea6fb0229d057578a4e17ab4::loop_strategy_core::reinvestment(arg1, arg2, arg3, arg4, arg5, arg6, arg7, arg8);
    }

    public entry fun update_navi(arg0: &0x35ab66536e2a1de901f93969472d071d61bf22dbea6fb0229d057578a4e17ab4::loop_strategy_manage::OperatorCap, arg1: &mut 0x35ab66536e2a1de901f93969472d071d61bf22dbea6fb0229d057578a4e17ab4::navi_section::NaviConfig, arg2: u256, arg3: u256, arg4: u256, arg5: u256) {
        0x35ab66536e2a1de901f93969472d071d61bf22dbea6fb0229d057578a4e17ab4::navi_section::update_risk_parameters(arg1, arg2, arg3, arg4, arg5);
    }

    // decompiled from Move bytecode v6
}

