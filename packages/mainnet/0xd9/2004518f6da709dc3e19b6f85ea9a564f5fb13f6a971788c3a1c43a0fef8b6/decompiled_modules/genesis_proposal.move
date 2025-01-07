module 0xd92004518f6da709dc3e19b6f85ea9a564f5fb13f6a971788c3a1c43a0fef8b6::genesis_proposal {
    struct Certificate has drop, store {
        dummy_field: bool,
    }

    public entry fun create_proposal(arg0: &mut 0x2daca359a68a04f3ed381b4427ffdb2ec1e464821c5098bbb4ddb9024e680845::governance_v1::GovernanceInfo, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = Certificate{dummy_field: false};
        0x2daca359a68a04f3ed381b4427ffdb2ec1e464821c5098bbb4ddb9024e680845::governance_v1::create_proposal<Certificate>(arg0, v0, arg1);
    }

    public fun register_new_reserve(arg0: 0x2daca359a68a04f3ed381b4427ffdb2ec1e464821c5098bbb4ddb9024e680845::genesis::GovernanceCap, arg1: Certificate, arg2: &mut 0x2daca359a68a04f3ed381b4427ffdb2ec1e464821c5098bbb4ddb9024e680845::lending_core_storage::Storage, arg3: &0x2::clock::Clock, arg4: u16, arg5: bool, arg6: bool, arg7: u64, arg8: u256, arg9: u256, arg10: u256, arg11: u256, arg12: u256, arg13: u256, arg14: u256, arg15: u256, arg16: u256, arg17: &mut 0x2::tx_context::TxContext) : (0x2daca359a68a04f3ed381b4427ffdb2ec1e464821c5098bbb4ddb9024e680845::genesis::GovernanceCap, Certificate) {
        0x2daca359a68a04f3ed381b4427ffdb2ec1e464821c5098bbb4ddb9024e680845::lending_core_storage::register_new_reserve(&arg0, arg2, arg3, arg4, arg5, arg6, arg7, arg8, arg9, arg10, arg11, arg12, arg13, arg14, arg15, arg16, arg17);
        (arg0, arg1)
    }

    public fun claim_from_treasury(arg0: 0x2daca359a68a04f3ed381b4427ffdb2ec1e464821c5098bbb4ddb9024e680845::genesis::GovernanceCap, arg1: Certificate, arg2: &mut 0x2daca359a68a04f3ed381b4427ffdb2ec1e464821c5098bbb4ddb9024e680845::pool_manager::PoolManagerInfo, arg3: &mut 0x2daca359a68a04f3ed381b4427ffdb2ec1e464821c5098bbb4ddb9024e680845::lending_core_storage::Storage, arg4: &0x2::clock::Clock, arg5: u16, arg6: u64, arg7: u64) : (0x2daca359a68a04f3ed381b4427ffdb2ec1e464821c5098bbb4ddb9024e680845::genesis::GovernanceCap, Certificate) {
        0x2daca359a68a04f3ed381b4427ffdb2ec1e464821c5098bbb4ddb9024e680845::lending_logic::claim_from_treasury(&arg0, arg2, arg3, arg4, arg5, arg6, (arg7 as u256));
        (arg0, arg1)
    }

    public fun register_token_price(arg0: 0x2daca359a68a04f3ed381b4427ffdb2ec1e464821c5098bbb4ddb9024e680845::genesis::GovernanceCap, arg1: Certificate, arg2: &mut 0x2daca359a68a04f3ed381b4427ffdb2ec1e464821c5098bbb4ddb9024e680845::oracle::PriceOracle, arg3: u16, arg4: vector<u8>, arg5: u256, arg6: u8, arg7: &0x2::clock::Clock) : (0x2daca359a68a04f3ed381b4427ffdb2ec1e464821c5098bbb4ddb9024e680845::genesis::GovernanceCap, Certificate) {
        0x2daca359a68a04f3ed381b4427ffdb2ec1e464821c5098bbb4ddb9024e680845::oracle::register_token_price(&arg0, arg2, arg4, arg3, arg5, arg6, arg7);
        (arg0, arg1)
    }

    public fun delete_remote_bridge(arg0: 0x2daca359a68a04f3ed381b4427ffdb2ec1e464821c5098bbb4ddb9024e680845::genesis::GovernanceCap, arg1: Certificate, arg2: &mut 0x2daca359a68a04f3ed381b4427ffdb2ec1e464821c5098bbb4ddb9024e680845::wormhole_adapter_core::CoreState, arg3: u16) : (0x2daca359a68a04f3ed381b4427ffdb2ec1e464821c5098bbb4ddb9024e680845::genesis::GovernanceCap, Certificate) {
        0x2daca359a68a04f3ed381b4427ffdb2ec1e464821c5098bbb4ddb9024e680845::wormhole_adapter_core::delete_remote_bridge(&arg0, arg2, arg3);
        (arg0, arg1)
    }

    public fun register_remote_bridge(arg0: 0x2daca359a68a04f3ed381b4427ffdb2ec1e464821c5098bbb4ddb9024e680845::genesis::GovernanceCap, arg1: Certificate, arg2: &mut 0x2daca359a68a04f3ed381b4427ffdb2ec1e464821c5098bbb4ddb9024e680845::wormhole_adapter_core::CoreState, arg3: u16, arg4: vector<u8>) : (0x2daca359a68a04f3ed381b4427ffdb2ec1e464821c5098bbb4ddb9024e680845::genesis::GovernanceCap, Certificate) {
        0x2daca359a68a04f3ed381b4427ffdb2ec1e464821c5098bbb4ddb9024e680845::wormhole_adapter_core::register_remote_bridge(&arg0, arg2, arg3, arg4);
        (arg0, arg1)
    }

    public fun remote_delete_owner(arg0: 0x2daca359a68a04f3ed381b4427ffdb2ec1e464821c5098bbb4ddb9024e680845::genesis::GovernanceCap, arg1: Certificate, arg2: &mut 0x5306f64e312b581766351c07af79c72fcb1cd25147157fdc2f8ad76de9a3fb6a::state::State, arg3: &mut 0x2daca359a68a04f3ed381b4427ffdb2ec1e464821c5098bbb4ddb9024e680845::wormhole_adapter_core::CoreState, arg4: u16, arg5: u256, arg6: 0x2::coin::Coin<0x2::sui::SUI>, arg7: &0x2::clock::Clock) : (0x2daca359a68a04f3ed381b4427ffdb2ec1e464821c5098bbb4ddb9024e680845::genesis::GovernanceCap, Certificate) {
        0x2daca359a68a04f3ed381b4427ffdb2ec1e464821c5098bbb4ddb9024e680845::wormhole_adapter_core::remote_delete_owner(&arg0, arg2, arg3, arg4, arg5, arg6, arg7);
        (arg0, arg1)
    }

    public fun remote_delete_spender(arg0: 0x2daca359a68a04f3ed381b4427ffdb2ec1e464821c5098bbb4ddb9024e680845::genesis::GovernanceCap, arg1: Certificate, arg2: &mut 0x5306f64e312b581766351c07af79c72fcb1cd25147157fdc2f8ad76de9a3fb6a::state::State, arg3: &mut 0x2daca359a68a04f3ed381b4427ffdb2ec1e464821c5098bbb4ddb9024e680845::wormhole_adapter_core::CoreState, arg4: u16, arg5: u256, arg6: 0x2::coin::Coin<0x2::sui::SUI>, arg7: &0x2::clock::Clock) : (0x2daca359a68a04f3ed381b4427ffdb2ec1e464821c5098bbb4ddb9024e680845::genesis::GovernanceCap, Certificate) {
        0x2daca359a68a04f3ed381b4427ffdb2ec1e464821c5098bbb4ddb9024e680845::wormhole_adapter_core::remote_delete_spender(&arg0, arg2, arg3, arg4, arg5, arg6, arg7);
        (arg0, arg1)
    }

    public fun remote_register_owner(arg0: 0x2daca359a68a04f3ed381b4427ffdb2ec1e464821c5098bbb4ddb9024e680845::genesis::GovernanceCap, arg1: Certificate, arg2: &mut 0x5306f64e312b581766351c07af79c72fcb1cd25147157fdc2f8ad76de9a3fb6a::state::State, arg3: &mut 0x2daca359a68a04f3ed381b4427ffdb2ec1e464821c5098bbb4ddb9024e680845::wormhole_adapter_core::CoreState, arg4: u16, arg5: u256, arg6: 0x2::coin::Coin<0x2::sui::SUI>, arg7: &0x2::clock::Clock) : (0x2daca359a68a04f3ed381b4427ffdb2ec1e464821c5098bbb4ddb9024e680845::genesis::GovernanceCap, Certificate) {
        0x2daca359a68a04f3ed381b4427ffdb2ec1e464821c5098bbb4ddb9024e680845::wormhole_adapter_core::remote_register_owner(&arg0, arg2, arg3, arg4, arg5, arg6, arg7);
        (arg0, arg1)
    }

    public fun remote_register_spender(arg0: 0x2daca359a68a04f3ed381b4427ffdb2ec1e464821c5098bbb4ddb9024e680845::genesis::GovernanceCap, arg1: Certificate, arg2: &mut 0x5306f64e312b581766351c07af79c72fcb1cd25147157fdc2f8ad76de9a3fb6a::state::State, arg3: &mut 0x2daca359a68a04f3ed381b4427ffdb2ec1e464821c5098bbb4ddb9024e680845::wormhole_adapter_core::CoreState, arg4: u16, arg5: u256, arg6: 0x2::coin::Coin<0x2::sui::SUI>, arg7: &0x2::clock::Clock) : (0x2daca359a68a04f3ed381b4427ffdb2ec1e464821c5098bbb4ddb9024e680845::genesis::GovernanceCap, Certificate) {
        0x2daca359a68a04f3ed381b4427ffdb2ec1e464821c5098bbb4ddb9024e680845::wormhole_adapter_core::remote_register_spender(&arg0, arg2, arg3, arg4, arg5, arg6, arg7);
        (arg0, arg1)
    }

    public fun destory(arg0: 0x2daca359a68a04f3ed381b4427ffdb2ec1e464821c5098bbb4ddb9024e680845::genesis::GovernanceCap, arg1: Certificate) {
        0x2daca359a68a04f3ed381b4427ffdb2ec1e464821c5098bbb4ddb9024e680845::governance_v1::destroy_governance_cap(arg0);
        let Certificate {  } = arg1;
    }

    public fun init_chain_group_id(arg0: 0x2daca359a68a04f3ed381b4427ffdb2ec1e464821c5098bbb4ddb9024e680845::genesis::GovernanceCap, arg1: Certificate, arg2: &mut 0x2daca359a68a04f3ed381b4427ffdb2ec1e464821c5098bbb4ddb9024e680845::user_manager::UserManagerInfo, arg3: u16, arg4: vector<u16>) : (0x2daca359a68a04f3ed381b4427ffdb2ec1e464821c5098bbb4ddb9024e680845::genesis::GovernanceCap, Certificate) {
        let v0 = 0;
        while (v0 < 0x1::vector::length<u16>(&arg4)) {
            0x2daca359a68a04f3ed381b4427ffdb2ec1e464821c5098bbb4ddb9024e680845::user_manager::register_dola_chain_id(&arg0, arg2, *0x1::vector::borrow<u16>(&arg4, v0), arg3);
            v0 = v0 + 1;
        };
        (arg0, arg1)
    }

    public fun init_lending_core(arg0: 0x2daca359a68a04f3ed381b4427ffdb2ec1e464821c5098bbb4ddb9024e680845::genesis::GovernanceCap, arg1: Certificate, arg2: &mut 0x2daca359a68a04f3ed381b4427ffdb2ec1e464821c5098bbb4ddb9024e680845::app_manager::TotalAppInfo, arg3: &mut 0x2::tx_context::TxContext) : (0x2daca359a68a04f3ed381b4427ffdb2ec1e464821c5098bbb4ddb9024e680845::genesis::GovernanceCap, Certificate) {
        0x2daca359a68a04f3ed381b4427ffdb2ec1e464821c5098bbb4ddb9024e680845::lending_core_storage::initialize_cap_with_governance(&arg0, arg2, arg3);
        (arg0, arg1)
    }

    public fun init_system_core(arg0: 0x2daca359a68a04f3ed381b4427ffdb2ec1e464821c5098bbb4ddb9024e680845::genesis::GovernanceCap, arg1: Certificate, arg2: &mut 0x2daca359a68a04f3ed381b4427ffdb2ec1e464821c5098bbb4ddb9024e680845::app_manager::TotalAppInfo, arg3: &mut 0x2::tx_context::TxContext) : (0x2daca359a68a04f3ed381b4427ffdb2ec1e464821c5098bbb4ddb9024e680845::genesis::GovernanceCap, Certificate) {
        0x2daca359a68a04f3ed381b4427ffdb2ec1e464821c5098bbb4ddb9024e680845::system_core_storage::initialize_cap_with_governance(&arg0, arg2, arg3);
        (arg0, arg1)
    }

    public fun init_wormhole_adapter_core(arg0: 0x2daca359a68a04f3ed381b4427ffdb2ec1e464821c5098bbb4ddb9024e680845::genesis::GovernanceCap, arg1: Certificate, arg2: &mut 0x5306f64e312b581766351c07af79c72fcb1cd25147157fdc2f8ad76de9a3fb6a::state::State, arg3: &mut 0x2::tx_context::TxContext) : (0x2daca359a68a04f3ed381b4427ffdb2ec1e464821c5098bbb4ddb9024e680845::genesis::GovernanceCap, Certificate) {
        0x2daca359a68a04f3ed381b4427ffdb2ec1e464821c5098bbb4ddb9024e680845::wormhole_adapter_core::initialize_cap_with_governance(&arg0, arg2, arg3);
        (arg0, arg1)
    }

    public fun register_new_pool(arg0: 0x2daca359a68a04f3ed381b4427ffdb2ec1e464821c5098bbb4ddb9024e680845::genesis::GovernanceCap, arg1: Certificate, arg2: &mut 0x2daca359a68a04f3ed381b4427ffdb2ec1e464821c5098bbb4ddb9024e680845::pool_manager::PoolManagerInfo, arg3: vector<u8>, arg4: u16, arg5: vector<u8>, arg6: u16, arg7: u256, arg8: &mut 0x2::tx_context::TxContext) : (0x2daca359a68a04f3ed381b4427ffdb2ec1e464821c5098bbb4ddb9024e680845::genesis::GovernanceCap, Certificate) {
        let v0 = 0x2daca359a68a04f3ed381b4427ffdb2ec1e464821c5098bbb4ddb9024e680845::dola_address::create_dola_address(arg4, arg3);
        if (!0x2daca359a68a04f3ed381b4427ffdb2ec1e464821c5098bbb4ddb9024e680845::pool_manager::exist_pool_id(arg2, arg6)) {
            0x2daca359a68a04f3ed381b4427ffdb2ec1e464821c5098bbb4ddb9024e680845::pool_manager::register_pool_id(&arg0, arg2, 0x1::ascii::string(arg5), arg6, arg8);
        };
        0x2daca359a68a04f3ed381b4427ffdb2ec1e464821c5098bbb4ddb9024e680845::pool_manager::register_pool(&arg0, arg2, v0, arg6);
        0x2daca359a68a04f3ed381b4427ffdb2ec1e464821c5098bbb4ddb9024e680845::pool_manager::set_pool_weight(&arg0, arg2, v0, arg7);
        (arg0, arg1)
    }

    public fun vote_porposal(arg0: &0x2daca359a68a04f3ed381b4427ffdb2ec1e464821c5098bbb4ddb9024e680845::governance_v1::GovernanceInfo, arg1: &mut 0x2daca359a68a04f3ed381b4427ffdb2ec1e464821c5098bbb4ddb9024e680845::governance_v1::Proposal<Certificate>, arg2: &mut 0x2::tx_context::TxContext) {
        let v0 = Certificate{dummy_field: false};
        let v1 = 0x2daca359a68a04f3ed381b4427ffdb2ec1e464821c5098bbb4ddb9024e680845::governance_v1::vote_proposal<Certificate>(arg0, v0, arg1, true, arg2);
        assert!(0x1::option::is_none<0x2daca359a68a04f3ed381b4427ffdb2ec1e464821c5098bbb4ddb9024e680845::genesis::GovernanceCap>(&v1), 0);
        0x1::option::destroy_none<0x2daca359a68a04f3ed381b4427ffdb2ec1e464821c5098bbb4ddb9024e680845::genesis::GovernanceCap>(v1);
    }

    public fun vote_proposal_final(arg0: &mut 0x2daca359a68a04f3ed381b4427ffdb2ec1e464821c5098bbb4ddb9024e680845::governance_v1::GovernanceInfo, arg1: &mut 0x2daca359a68a04f3ed381b4427ffdb2ec1e464821c5098bbb4ddb9024e680845::governance_v1::Proposal<Certificate>, arg2: &mut 0x2::tx_context::TxContext) : (0x2daca359a68a04f3ed381b4427ffdb2ec1e464821c5098bbb4ddb9024e680845::genesis::GovernanceCap, Certificate) {
        let v0 = Certificate{dummy_field: false};
        let v1 = 0x2daca359a68a04f3ed381b4427ffdb2ec1e464821c5098bbb4ddb9024e680845::governance_v1::vote_proposal<Certificate>(arg0, v0, arg1, true, arg2);
        assert!(0x1::option::is_some<0x2daca359a68a04f3ed381b4427ffdb2ec1e464821c5098bbb4ddb9024e680845::genesis::GovernanceCap>(&v1), 1);
        0x1::option::destroy_none<0x2daca359a68a04f3ed381b4427ffdb2ec1e464821c5098bbb4ddb9024e680845::genesis::GovernanceCap>(v1);
        let v2 = Certificate{dummy_field: false};
        (0x1::option::extract<0x2daca359a68a04f3ed381b4427ffdb2ec1e464821c5098bbb4ddb9024e680845::genesis::GovernanceCap>(&mut v1), v2)
    }

    // decompiled from Move bytecode v6
}

