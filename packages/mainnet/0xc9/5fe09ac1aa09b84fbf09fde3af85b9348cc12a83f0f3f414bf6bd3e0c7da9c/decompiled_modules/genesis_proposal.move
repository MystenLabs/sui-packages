module 0xc95fe09ac1aa09b84fbf09fde3af85b9348cc12a83f0f3f414bf6bd3e0c7da9c::genesis_proposal {
    struct Certificate has drop, store {
        dummy_field: bool,
    }

    struct HotPotato {
        gov_cap: 0x826915f8ca6d11597dfe6599b8aa02a4c08bd8d39674855254a06ee83fe7220e::genesis::GovernanceCap,
    }

    public entry fun create_proposal(arg0: &mut 0x826915f8ca6d11597dfe6599b8aa02a4c08bd8d39674855254a06ee83fe7220e::governance_v1::GovernanceInfo, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = Certificate{dummy_field: false};
        0x826915f8ca6d11597dfe6599b8aa02a4c08bd8d39674855254a06ee83fe7220e::governance_v1::create_proposal<Certificate>(arg0, v0, arg1);
    }

    public fun register_new_reserve(arg0: HotPotato, arg1: &mut 0x826915f8ca6d11597dfe6599b8aa02a4c08bd8d39674855254a06ee83fe7220e::lending_core_storage::Storage, arg2: &0x2::clock::Clock, arg3: u16, arg4: bool, arg5: bool, arg6: u64, arg7: u256, arg8: u256, arg9: u256, arg10: u256, arg11: u256, arg12: u256, arg13: u256, arg14: u256, arg15: u256, arg16: &mut 0x2::tx_context::TxContext) : HotPotato {
        0x826915f8ca6d11597dfe6599b8aa02a4c08bd8d39674855254a06ee83fe7220e::lending_core_storage::register_new_reserve(&arg0.gov_cap, arg1, arg2, arg3, arg4, arg5, arg6, arg7, arg8, arg9, arg10, arg11, arg12, arg13, arg14, arg15, arg16);
        arg0
    }

    public fun claim_from_treasury(arg0: HotPotato, arg1: &mut 0x826915f8ca6d11597dfe6599b8aa02a4c08bd8d39674855254a06ee83fe7220e::pool_manager::PoolManagerInfo, arg2: &mut 0x826915f8ca6d11597dfe6599b8aa02a4c08bd8d39674855254a06ee83fe7220e::lending_core_storage::Storage, arg3: &0x2::clock::Clock, arg4: u16, arg5: u64, arg6: u64) : HotPotato {
        0x826915f8ca6d11597dfe6599b8aa02a4c08bd8d39674855254a06ee83fe7220e::lending_logic::claim_from_treasury(&arg0.gov_cap, arg1, arg2, arg3, arg4, arg5, (arg6 as u256));
        arg0
    }

    public fun register_token_price(arg0: HotPotato, arg1: &mut 0x826915f8ca6d11597dfe6599b8aa02a4c08bd8d39674855254a06ee83fe7220e::oracle::PriceOracle, arg2: u16, arg3: vector<u8>, arg4: u256, arg5: u8, arg6: &0x2::clock::Clock) : HotPotato {
        0x826915f8ca6d11597dfe6599b8aa02a4c08bd8d39674855254a06ee83fe7220e::oracle::register_token_price(&arg0.gov_cap, arg1, arg3, arg2, arg4, arg5, arg6);
        arg0
    }

    public fun delete_remote_bridge(arg0: HotPotato, arg1: &mut 0x826915f8ca6d11597dfe6599b8aa02a4c08bd8d39674855254a06ee83fe7220e::wormhole_adapter_core::CoreState, arg2: u16) : HotPotato {
        0x826915f8ca6d11597dfe6599b8aa02a4c08bd8d39674855254a06ee83fe7220e::wormhole_adapter_core::delete_remote_bridge(&arg0.gov_cap, arg1, arg2);
        arg0
    }

    public fun register_remote_bridge(arg0: HotPotato, arg1: &mut 0x826915f8ca6d11597dfe6599b8aa02a4c08bd8d39674855254a06ee83fe7220e::wormhole_adapter_core::CoreState, arg2: u16, arg3: vector<u8>) : HotPotato {
        0x826915f8ca6d11597dfe6599b8aa02a4c08bd8d39674855254a06ee83fe7220e::wormhole_adapter_core::register_remote_bridge(&arg0.gov_cap, arg1, arg2, arg3);
        arg0
    }

    public fun remote_add_relayer(arg0: HotPotato, arg1: &mut 0x5306f64e312b581766351c07af79c72fcb1cd25147157fdc2f8ad76de9a3fb6a::state::State, arg2: &mut 0x826915f8ca6d11597dfe6599b8aa02a4c08bd8d39674855254a06ee83fe7220e::wormhole_adapter_core::CoreState, arg3: u16, arg4: vector<u8>, arg5: 0x2::coin::Coin<0x2::sui::SUI>, arg6: &0x2::clock::Clock) : HotPotato {
        0x826915f8ca6d11597dfe6599b8aa02a4c08bd8d39674855254a06ee83fe7220e::wormhole_adapter_core::remote_add_relayer(&arg0.gov_cap, arg1, arg2, arg3, arg4, arg5, arg6);
        arg0
    }

    public fun remote_delete_spender(arg0: HotPotato, arg1: &mut 0x5306f64e312b581766351c07af79c72fcb1cd25147157fdc2f8ad76de9a3fb6a::state::State, arg2: &mut 0x826915f8ca6d11597dfe6599b8aa02a4c08bd8d39674855254a06ee83fe7220e::wormhole_adapter_core::CoreState, arg3: u16, arg4: u256, arg5: 0x2::coin::Coin<0x2::sui::SUI>, arg6: &0x2::clock::Clock) : HotPotato {
        0x826915f8ca6d11597dfe6599b8aa02a4c08bd8d39674855254a06ee83fe7220e::wormhole_adapter_core::remote_delete_spender(&arg0.gov_cap, arg1, arg2, arg3, arg4, arg5, arg6);
        arg0
    }

    public fun remote_register_spender(arg0: HotPotato, arg1: &mut 0x5306f64e312b581766351c07af79c72fcb1cd25147157fdc2f8ad76de9a3fb6a::state::State, arg2: &mut 0x826915f8ca6d11597dfe6599b8aa02a4c08bd8d39674855254a06ee83fe7220e::wormhole_adapter_core::CoreState, arg3: u16, arg4: u256, arg5: 0x2::coin::Coin<0x2::sui::SUI>, arg6: &0x2::clock::Clock) : HotPotato {
        0x826915f8ca6d11597dfe6599b8aa02a4c08bd8d39674855254a06ee83fe7220e::wormhole_adapter_core::remote_register_spender(&arg0.gov_cap, arg1, arg2, arg3, arg4, arg5, arg6);
        arg0
    }

    public fun remote_remove_relayer(arg0: HotPotato, arg1: &mut 0x5306f64e312b581766351c07af79c72fcb1cd25147157fdc2f8ad76de9a3fb6a::state::State, arg2: &mut 0x826915f8ca6d11597dfe6599b8aa02a4c08bd8d39674855254a06ee83fe7220e::wormhole_adapter_core::CoreState, arg3: u16, arg4: vector<u8>, arg5: 0x2::coin::Coin<0x2::sui::SUI>, arg6: &0x2::clock::Clock) : HotPotato {
        0x826915f8ca6d11597dfe6599b8aa02a4c08bd8d39674855254a06ee83fe7220e::wormhole_adapter_core::remote_remove_relayer(&arg0.gov_cap, arg1, arg2, arg3, arg4, arg5, arg6);
        arg0
    }

    public fun add_core_relayer(arg0: HotPotato, arg1: &mut 0x826915f8ca6d11597dfe6599b8aa02a4c08bd8d39674855254a06ee83fe7220e::wormhole_adapter_core::CoreState, arg2: address) : HotPotato {
        0x826915f8ca6d11597dfe6599b8aa02a4c08bd8d39674855254a06ee83fe7220e::wormhole_adapter_core::add_relayer(&arg0.gov_cap, arg1, arg2);
        arg0
    }

    public fun add_oracle_relayer(arg0: HotPotato, arg1: &mut 0x826915f8ca6d11597dfe6599b8aa02a4c08bd8d39674855254a06ee83fe7220e::oracle::PriceOracle, arg2: address) : HotPotato {
        0x826915f8ca6d11597dfe6599b8aa02a4c08bd8d39674855254a06ee83fe7220e::oracle::add_relayer(&arg0.gov_cap, arg1, arg2);
        arg0
    }

    public fun add_pool_relayer(arg0: HotPotato, arg1: &mut 0x826915f8ca6d11597dfe6599b8aa02a4c08bd8d39674855254a06ee83fe7220e::wormhole_adapter_pool::PoolState, arg2: address) : HotPotato {
        0x826915f8ca6d11597dfe6599b8aa02a4c08bd8d39674855254a06ee83fe7220e::wormhole_adapter_pool::add_relayer(&arg0.gov_cap, arg1, arg2);
        arg0
    }

    public fun destory(arg0: HotPotato) {
        let HotPotato { gov_cap: v0 } = arg0;
        0x826915f8ca6d11597dfe6599b8aa02a4c08bd8d39674855254a06ee83fe7220e::governance_v1::destroy_governance_cap(v0);
    }

    public fun init_chain_group_id(arg0: HotPotato, arg1: &mut 0x826915f8ca6d11597dfe6599b8aa02a4c08bd8d39674855254a06ee83fe7220e::user_manager::UserManagerInfo, arg2: u16, arg3: vector<u16>) : HotPotato {
        let v0 = 0;
        while (v0 < 0x1::vector::length<u16>(&arg3)) {
            0x826915f8ca6d11597dfe6599b8aa02a4c08bd8d39674855254a06ee83fe7220e::user_manager::register_dola_chain_id(&arg0.gov_cap, arg1, *0x1::vector::borrow<u16>(&arg3, v0), arg2);
            v0 = v0 + 1;
        };
        arg0
    }

    public fun init_lending_core(arg0: HotPotato, arg1: &mut 0x826915f8ca6d11597dfe6599b8aa02a4c08bd8d39674855254a06ee83fe7220e::app_manager::TotalAppInfo, arg2: &mut 0x2::tx_context::TxContext) : HotPotato {
        0x826915f8ca6d11597dfe6599b8aa02a4c08bd8d39674855254a06ee83fe7220e::lending_core_storage::initialize_cap_with_governance(&arg0.gov_cap, arg1, arg2);
        arg0
    }

    public fun init_system_core(arg0: HotPotato, arg1: &mut 0x826915f8ca6d11597dfe6599b8aa02a4c08bd8d39674855254a06ee83fe7220e::app_manager::TotalAppInfo, arg2: &mut 0x2::tx_context::TxContext) : HotPotato {
        0x826915f8ca6d11597dfe6599b8aa02a4c08bd8d39674855254a06ee83fe7220e::system_core_storage::initialize_cap_with_governance(&arg0.gov_cap, arg1, arg2);
        arg0
    }

    public fun init_wormhole_adapter_core(arg0: HotPotato, arg1: &mut 0x5306f64e312b581766351c07af79c72fcb1cd25147157fdc2f8ad76de9a3fb6a::state::State, arg2: &mut 0x2::tx_context::TxContext) : HotPotato {
        0x826915f8ca6d11597dfe6599b8aa02a4c08bd8d39674855254a06ee83fe7220e::wormhole_adapter_core::initialize_cap_with_governance(&arg0.gov_cap, arg1, arg2);
        arg0
    }

    public fun register_new_pool(arg0: HotPotato, arg1: &mut 0x826915f8ca6d11597dfe6599b8aa02a4c08bd8d39674855254a06ee83fe7220e::pool_manager::PoolManagerInfo, arg2: vector<u8>, arg3: u16, arg4: vector<u8>, arg5: u16, arg6: u256, arg7: &mut 0x2::tx_context::TxContext) : HotPotato {
        let v0 = 0x826915f8ca6d11597dfe6599b8aa02a4c08bd8d39674855254a06ee83fe7220e::dola_address::create_dola_address(arg3, arg2);
        if (!0x826915f8ca6d11597dfe6599b8aa02a4c08bd8d39674855254a06ee83fe7220e::pool_manager::exist_pool_id(arg1, arg5)) {
            0x826915f8ca6d11597dfe6599b8aa02a4c08bd8d39674855254a06ee83fe7220e::pool_manager::register_pool_id(&arg0.gov_cap, arg1, 0x1::ascii::string(arg4), arg5, arg7);
        };
        0x826915f8ca6d11597dfe6599b8aa02a4c08bd8d39674855254a06ee83fe7220e::pool_manager::register_pool(&arg0.gov_cap, arg1, v0, arg5);
        0x826915f8ca6d11597dfe6599b8aa02a4c08bd8d39674855254a06ee83fe7220e::pool_manager::set_pool_weight(&arg0.gov_cap, arg1, v0, arg6);
        arg0
    }

    public fun remove_core_relayer(arg0: HotPotato, arg1: &mut 0x826915f8ca6d11597dfe6599b8aa02a4c08bd8d39674855254a06ee83fe7220e::wormhole_adapter_core::CoreState, arg2: address) : HotPotato {
        0x826915f8ca6d11597dfe6599b8aa02a4c08bd8d39674855254a06ee83fe7220e::wormhole_adapter_core::remove_relayer(&arg0.gov_cap, arg1, arg2);
        arg0
    }

    public fun remove_oracle_relayer(arg0: HotPotato, arg1: &mut 0x826915f8ca6d11597dfe6599b8aa02a4c08bd8d39674855254a06ee83fe7220e::oracle::PriceOracle, arg2: address) : HotPotato {
        0x826915f8ca6d11597dfe6599b8aa02a4c08bd8d39674855254a06ee83fe7220e::oracle::remove_relayer(&arg0.gov_cap, arg1, arg2);
        arg0
    }

    public fun remove_pool_relayer(arg0: HotPotato, arg1: &mut 0x826915f8ca6d11597dfe6599b8aa02a4c08bd8d39674855254a06ee83fe7220e::wormhole_adapter_pool::PoolState, arg2: address) : HotPotato {
        0x826915f8ca6d11597dfe6599b8aa02a4c08bd8d39674855254a06ee83fe7220e::wormhole_adapter_pool::remove_relayer(&arg0.gov_cap, arg1, arg2);
        arg0
    }

    public fun vote_porposal(arg0: &0x826915f8ca6d11597dfe6599b8aa02a4c08bd8d39674855254a06ee83fe7220e::governance_v1::GovernanceInfo, arg1: &mut 0x826915f8ca6d11597dfe6599b8aa02a4c08bd8d39674855254a06ee83fe7220e::governance_v1::Proposal<Certificate>, arg2: &mut 0x2::tx_context::TxContext) {
        let v0 = Certificate{dummy_field: false};
        let v1 = 0x826915f8ca6d11597dfe6599b8aa02a4c08bd8d39674855254a06ee83fe7220e::governance_v1::vote_proposal<Certificate>(arg0, v0, arg1, true, arg2);
        assert!(0x1::option::is_none<0x826915f8ca6d11597dfe6599b8aa02a4c08bd8d39674855254a06ee83fe7220e::genesis::GovernanceCap>(&v1), 0);
        0x1::option::destroy_none<0x826915f8ca6d11597dfe6599b8aa02a4c08bd8d39674855254a06ee83fe7220e::genesis::GovernanceCap>(v1);
    }

    public fun vote_proposal_final(arg0: &mut 0x826915f8ca6d11597dfe6599b8aa02a4c08bd8d39674855254a06ee83fe7220e::governance_v1::GovernanceInfo, arg1: &mut 0x826915f8ca6d11597dfe6599b8aa02a4c08bd8d39674855254a06ee83fe7220e::governance_v1::Proposal<Certificate>, arg2: &mut 0x2::tx_context::TxContext) : HotPotato {
        let v0 = Certificate{dummy_field: false};
        let v1 = 0x826915f8ca6d11597dfe6599b8aa02a4c08bd8d39674855254a06ee83fe7220e::governance_v1::vote_proposal<Certificate>(arg0, v0, arg1, true, arg2);
        assert!(0x1::option::is_some<0x826915f8ca6d11597dfe6599b8aa02a4c08bd8d39674855254a06ee83fe7220e::genesis::GovernanceCap>(&v1), 1);
        0x1::option::destroy_none<0x826915f8ca6d11597dfe6599b8aa02a4c08bd8d39674855254a06ee83fe7220e::genesis::GovernanceCap>(v1);
        HotPotato{gov_cap: 0x1::option::extract<0x826915f8ca6d11597dfe6599b8aa02a4c08bd8d39674855254a06ee83fe7220e::genesis::GovernanceCap>(&mut v1)}
    }

    // decompiled from Move bytecode v6
}

