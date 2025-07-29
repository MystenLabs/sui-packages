module 0x35ab66536e2a1de901f93969472d071d61bf22dbea6fb0229d057578a4e17ab4::loop_strategy_manage {
    struct AdminCap has store, key {
        id: 0x2::object::UID,
        init: bool,
    }

    struct OperatorCap has store, key {
        id: 0x2::object::UID,
    }

    public entry fun migrate(arg0: &AdminCap, arg1: &mut 0x35ab66536e2a1de901f93969472d071d61bf22dbea6fb0229d057578a4e17ab4::loop_strategy_core::Strategy) {
        0x35ab66536e2a1de901f93969472d071d61bf22dbea6fb0229d057578a4e17ab4::loop_strategy_core::migrate(arg1);
    }

    fun init(arg0: &mut 0x2::tx_context::TxContext) {
        let v0 = AdminCap{
            id   : 0x2::object::new(arg0),
            init : false,
        };
        0x2::transfer::transfer<AdminCap>(v0, 0x2::tx_context::sender(arg0));
    }

    public entry fun init_cetus_config(arg0: &AdminCap, arg1: 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::config::GlobalConfig, arg2: 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::partner::Partner, arg3: &mut 0x2::tx_context::TxContext) {
        0x35ab66536e2a1de901f93969472d071d61bf22dbea6fb0229d057578a4e17ab4::cetus_section::new_cetus(arg1, arg2, arg3);
    }

    public entry fun init_navi_config(arg0: &AdminCap, arg1: 0x2::coin::TreasuryCap<0x35ab66536e2a1de901f93969472d071d61bf22dbea6fb0229d057578a4e17ab4::vaultlpt::VAULTLPT>, arg2: 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::storage::Storage, arg3: 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::pool::Pool<0xbde4ba4c2e274a60ce15c1cfff9e5c42e41654ac8b6d906a57efa4bd3c29f47d::hasui::HASUI>, arg4: u8, arg5: 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::pool::Pool<0x2::sui::SUI>, arg6: u8, arg7: 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::incentive_v2::Incentive, arg8: 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::incentive_v3::Incentive, arg9: 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::flash_loan::Config, arg10: 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::incentive_v3::RewardFund<0x549e8b69270defbfafd4f94e17ec44cdbdd99820b33bda2278dea3b9a32d3f55::cert::CERT>, arg11: &mut 0x2::tx_context::TxContext) {
        0x35ab66536e2a1de901f93969472d071d61bf22dbea6fb0229d057578a4e17ab4::navi_section::new_navi(arg1, arg2, arg3, arg4, arg5, arg6, arg7, arg8, arg9, arg10, arg11);
    }

    public entry fun init_strategy_config(arg0: &mut AdminCap, arg1: &mut 0x2::tx_context::TxContext) {
        assert!(!arg0.init, 1);
        0x35ab66536e2a1de901f93969472d071d61bf22dbea6fb0229d057578a4e17ab4::loop_strategy_core::initialize(arg1);
        arg0.init = true;
    }

    public entry fun set_operator_cap_to_address(arg0: &AdminCap, arg1: address, arg2: &mut 0x2::tx_context::TxContext) {
        let v0 = OperatorCap{id: 0x2::object::new(arg2)};
        0x2::transfer::transfer<OperatorCap>(v0, arg1);
    }

    // decompiled from Move bytecode v6
}

