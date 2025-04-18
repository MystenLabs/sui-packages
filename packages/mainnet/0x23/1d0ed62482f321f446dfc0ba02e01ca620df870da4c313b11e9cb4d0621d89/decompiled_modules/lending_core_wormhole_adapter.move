module 0x231d0ed62482f321f446dfc0ba02e01ca620df870da4c313b11e9cb4d0621d89::lending_core_wormhole_adapter {
    struct LendingCoreEvent has copy, drop {
        nonce: u64,
        sender_user_id: u64,
        source_chain_id: u16,
        dst_chain_id: u16,
        dola_pool_id: u16,
        receiver: vector<u8>,
        amount: u256,
        liquidate_user_id: u64,
        call_type: u8,
    }

    struct RelayEvent has copy, drop {
        sequence: u64,
        source_chain_id: u16,
        source_chain_nonce: u64,
        dst_pool: 0x231d0ed62482f321f446dfc0ba02e01ca620df870da4c313b11e9cb4d0621d89::dola_address::DolaAddress,
        call_type: u8,
    }

    public entry fun borrow(arg0: &0x231d0ed62482f321f446dfc0ba02e01ca620df870da4c313b11e9cb4d0621d89::genesis::GovernanceGenesis, arg1: &mut 0x231d0ed62482f321f446dfc0ba02e01ca620df870da4c313b11e9cb4d0621d89::pool_manager::PoolManagerInfo, arg2: &mut 0x231d0ed62482f321f446dfc0ba02e01ca620df870da4c313b11e9cb4d0621d89::user_manager::UserManagerInfo, arg3: &mut 0x5306f64e312b581766351c07af79c72fcb1cd25147157fdc2f8ad76de9a3fb6a::state::State, arg4: &mut 0x231d0ed62482f321f446dfc0ba02e01ca620df870da4c313b11e9cb4d0621d89::wormhole_adapter_core::CoreState, arg5: &mut 0x231d0ed62482f321f446dfc0ba02e01ca620df870da4c313b11e9cb4d0621d89::oracle::PriceOracle, arg6: &mut 0x231d0ed62482f321f446dfc0ba02e01ca620df870da4c313b11e9cb4d0621d89::lending_core_storage::Storage, arg7: 0x2::coin::Coin<0x2::sui::SUI>, arg8: vector<u8>, arg9: &0x2::clock::Clock, arg10: &mut 0x2::tx_context::TxContext) {
        0x231d0ed62482f321f446dfc0ba02e01ca620df870da4c313b11e9cb4d0621d89::genesis::check_latest_version(arg0);
        let (v0, v1) = 0x231d0ed62482f321f446dfc0ba02e01ca620df870da4c313b11e9cb4d0621d89::wormhole_adapter_core::receive_withdraw(arg3, arg4, 0x231d0ed62482f321f446dfc0ba02e01ca620df870da4c313b11e9cb4d0621d89::lending_core_storage::get_app_cap(arg6), arg8, arg9, arg10);
        let (v2, v3, v4, v5, v6, v7) = 0x231d0ed62482f321f446dfc0ba02e01ca620df870da4c313b11e9cb4d0621d89::lending_codec::decode_withdraw_payload(v1);
        let v8 = v6;
        assert!(v7 == 0x231d0ed62482f321f446dfc0ba02e01ca620df870da4c313b11e9cb4d0621d89::lending_codec::get_borrow_type(), 1);
        let v9 = (v4 as u256);
        let v10 = 0x231d0ed62482f321f446dfc0ba02e01ca620df870da4c313b11e9cb4d0621d89::pool_manager::get_id_by_pool(arg1, v5);
        let v11 = 0x231d0ed62482f321f446dfc0ba02e01ca620df870da4c313b11e9cb4d0621d89::user_manager::get_dola_user_id(arg2, v0);
        0x231d0ed62482f321f446dfc0ba02e01ca620df870da4c313b11e9cb4d0621d89::lending_logic::execute_borrow(arg1, arg6, arg5, arg9, v11, v10, v9);
        assert!(0x231d0ed62482f321f446dfc0ba02e01ca620df870da4c313b11e9cb4d0621d89::pool_manager::get_pool_liquidity(arg1, v5) >= v9, 0);
        let v12 = RelayEvent{
            sequence           : 0x231d0ed62482f321f446dfc0ba02e01ca620df870da4c313b11e9cb4d0621d89::wormhole_adapter_core::send_withdraw(arg3, arg4, 0x231d0ed62482f321f446dfc0ba02e01ca620df870da4c313b11e9cb4d0621d89::lending_core_storage::get_app_cap(arg6), arg1, v5, v8, v2, v3, v9, arg7, arg9, arg10),
            source_chain_id    : v2,
            source_chain_nonce : v3,
            dst_pool           : v5,
            call_type          : v7,
        };
        0x2::event::emit<RelayEvent>(v12);
        let v13 = LendingCoreEvent{
            nonce             : v3,
            sender_user_id    : v11,
            source_chain_id   : v2,
            dst_chain_id      : 0x231d0ed62482f321f446dfc0ba02e01ca620df870da4c313b11e9cb4d0621d89::dola_address::get_dola_chain_id(&v8),
            dola_pool_id      : v10,
            receiver          : 0x231d0ed62482f321f446dfc0ba02e01ca620df870da4c313b11e9cb4d0621d89::dola_address::get_dola_address(&v8),
            amount            : v9,
            liquidate_user_id : 0,
            call_type         : v7,
        };
        0x2::event::emit<LendingCoreEvent>(v13);
    }

    public entry fun as_collateral(arg0: &0x231d0ed62482f321f446dfc0ba02e01ca620df870da4c313b11e9cb4d0621d89::genesis::GovernanceGenesis, arg1: &mut 0x231d0ed62482f321f446dfc0ba02e01ca620df870da4c313b11e9cb4d0621d89::pool_manager::PoolManagerInfo, arg2: &mut 0x231d0ed62482f321f446dfc0ba02e01ca620df870da4c313b11e9cb4d0621d89::user_manager::UserManagerInfo, arg3: &mut 0x5306f64e312b581766351c07af79c72fcb1cd25147157fdc2f8ad76de9a3fb6a::state::State, arg4: &mut 0x231d0ed62482f321f446dfc0ba02e01ca620df870da4c313b11e9cb4d0621d89::wormhole_adapter_core::CoreState, arg5: &mut 0x231d0ed62482f321f446dfc0ba02e01ca620df870da4c313b11e9cb4d0621d89::oracle::PriceOracle, arg6: &mut 0x231d0ed62482f321f446dfc0ba02e01ca620df870da4c313b11e9cb4d0621d89::lending_core_storage::Storage, arg7: vector<u8>, arg8: &0x2::clock::Clock, arg9: &mut 0x2::tx_context::TxContext) {
        0x231d0ed62482f321f446dfc0ba02e01ca620df870da4c313b11e9cb4d0621d89::genesis::check_latest_version(arg0);
        let (v0, v1) = 0x231d0ed62482f321f446dfc0ba02e01ca620df870da4c313b11e9cb4d0621d89::wormhole_adapter_core::receive_message(arg3, arg4, 0x231d0ed62482f321f446dfc0ba02e01ca620df870da4c313b11e9cb4d0621d89::lending_core_storage::get_app_cap(arg6), arg7, arg8, arg9);
        let (v2, v3) = 0x231d0ed62482f321f446dfc0ba02e01ca620df870da4c313b11e9cb4d0621d89::lending_codec::decode_manage_collateral_payload(v1);
        let v4 = v2;
        assert!(v3 == 0x231d0ed62482f321f446dfc0ba02e01ca620df870da4c313b11e9cb4d0621d89::lending_codec::get_as_colleteral_type(), 1);
        let v5 = 0;
        while (v5 < 0x1::vector::length<u16>(&v4)) {
            0x231d0ed62482f321f446dfc0ba02e01ca620df870da4c313b11e9cb4d0621d89::lending_logic::as_collateral(arg1, arg6, arg5, arg8, 0x231d0ed62482f321f446dfc0ba02e01ca620df870da4c313b11e9cb4d0621d89::user_manager::get_dola_user_id(arg2, v0), *0x1::vector::borrow<u16>(&v4, v5));
            v5 = v5 + 1;
        };
    }

    public entry fun cancel_as_collateral(arg0: &0x231d0ed62482f321f446dfc0ba02e01ca620df870da4c313b11e9cb4d0621d89::genesis::GovernanceGenesis, arg1: &mut 0x231d0ed62482f321f446dfc0ba02e01ca620df870da4c313b11e9cb4d0621d89::pool_manager::PoolManagerInfo, arg2: &mut 0x231d0ed62482f321f446dfc0ba02e01ca620df870da4c313b11e9cb4d0621d89::user_manager::UserManagerInfo, arg3: &mut 0x5306f64e312b581766351c07af79c72fcb1cd25147157fdc2f8ad76de9a3fb6a::state::State, arg4: &mut 0x231d0ed62482f321f446dfc0ba02e01ca620df870da4c313b11e9cb4d0621d89::wormhole_adapter_core::CoreState, arg5: &mut 0x231d0ed62482f321f446dfc0ba02e01ca620df870da4c313b11e9cb4d0621d89::oracle::PriceOracle, arg6: &mut 0x231d0ed62482f321f446dfc0ba02e01ca620df870da4c313b11e9cb4d0621d89::lending_core_storage::Storage, arg7: vector<u8>, arg8: &0x2::clock::Clock, arg9: &mut 0x2::tx_context::TxContext) {
        0x231d0ed62482f321f446dfc0ba02e01ca620df870da4c313b11e9cb4d0621d89::genesis::check_latest_version(arg0);
        let (v0, v1) = 0x231d0ed62482f321f446dfc0ba02e01ca620df870da4c313b11e9cb4d0621d89::wormhole_adapter_core::receive_message(arg3, arg4, 0x231d0ed62482f321f446dfc0ba02e01ca620df870da4c313b11e9cb4d0621d89::lending_core_storage::get_app_cap(arg6), arg7, arg8, arg9);
        let (v2, v3) = 0x231d0ed62482f321f446dfc0ba02e01ca620df870da4c313b11e9cb4d0621d89::lending_codec::decode_manage_collateral_payload(v1);
        let v4 = v2;
        assert!(v3 == 0x231d0ed62482f321f446dfc0ba02e01ca620df870da4c313b11e9cb4d0621d89::lending_codec::get_cancel_as_colleteral_type(), 1);
        let v5 = 0;
        while (v5 < 0x1::vector::length<u16>(&v4)) {
            0x231d0ed62482f321f446dfc0ba02e01ca620df870da4c313b11e9cb4d0621d89::lending_logic::cancel_as_collateral(arg1, arg6, arg5, arg8, 0x231d0ed62482f321f446dfc0ba02e01ca620df870da4c313b11e9cb4d0621d89::user_manager::get_dola_user_id(arg2, v0), *0x1::vector::borrow<u16>(&v4, v5));
            v5 = v5 + 1;
        };
    }

    entry fun claim_reward<T0>(arg0: &0x231d0ed62482f321f446dfc0ba02e01ca620df870da4c313b11e9cb4d0621d89::genesis::GovernanceGenesis, arg1: &mut 0x231d0ed62482f321f446dfc0ba02e01ca620df870da4c313b11e9cb4d0621d89::pool_manager::PoolManagerInfo, arg2: &mut 0x231d0ed62482f321f446dfc0ba02e01ca620df870da4c313b11e9cb4d0621d89::user_manager::UserManagerInfo, arg3: &mut 0x231d0ed62482f321f446dfc0ba02e01ca620df870da4c313b11e9cb4d0621d89::boost::BoostReserves, arg4: &mut 0x231d0ed62482f321f446dfc0ba02e01ca620df870da4c313b11e9cb4d0621d89::boost::RewardPool<T0>, arg5: &mut 0x5306f64e312b581766351c07af79c72fcb1cd25147157fdc2f8ad76de9a3fb6a::state::State, arg6: &mut 0x231d0ed62482f321f446dfc0ba02e01ca620df870da4c313b11e9cb4d0621d89::wormhole_adapter_core::CoreState, arg7: &mut 0x231d0ed62482f321f446dfc0ba02e01ca620df870da4c313b11e9cb4d0621d89::lending_core_storage::Storage, arg8: 0x2::coin::Coin<0x2::sui::SUI>, arg9: vector<u8>, arg10: &0x2::clock::Clock, arg11: &mut 0x2::tx_context::TxContext) {
        0x231d0ed62482f321f446dfc0ba02e01ca620df870da4c313b11e9cb4d0621d89::genesis::check_latest_version(arg0);
        let (v0, v1) = 0x231d0ed62482f321f446dfc0ba02e01ca620df870da4c313b11e9cb4d0621d89::wormhole_adapter_core::receive_withdraw(arg5, arg6, 0x231d0ed62482f321f446dfc0ba02e01ca620df870da4c313b11e9cb4d0621d89::lending_core_storage::get_app_cap(arg7), arg9, arg10, arg11);
        let (v2, v3, v4, v5, v6, v7, v8, v9) = 0x231d0ed62482f321f446dfc0ba02e01ca620df870da4c313b11e9cb4d0621d89::lending_codec::decode_claim_reward_payload(v1);
        let v10 = v6;
        assert!(v9 == 0x231d0ed62482f321f446dfc0ba02e01ca620df870da4c313b11e9cb4d0621d89::lending_codec::get_claim_reward_type(), 1);
        let v11 = 0x231d0ed62482f321f446dfc0ba02e01ca620df870da4c313b11e9cb4d0621d89::pool_manager::get_id_by_pool(arg1, v5);
        let v12 = 0x231d0ed62482f321f446dfc0ba02e01ca620df870da4c313b11e9cb4d0621d89::user_manager::get_dola_user_id(arg2, v0);
        assert!(0x231d0ed62482f321f446dfc0ba02e01ca620df870da4c313b11e9cb4d0621d89::boost::check_pool_coin_type<T0>(arg3, v11), 3);
        assert!(0x2::object::id_address<0x231d0ed62482f321f446dfc0ba02e01ca620df870da4c313b11e9cb4d0621d89::boost::RewardPool<T0>>(arg4) == 0x231d0ed62482f321f446dfc0ba02e01ca620df870da4c313b11e9cb4d0621d89::dola_address::convert_dola_to_address(v4), 2);
        let v13 = 0x231d0ed62482f321f446dfc0ba02e01ca620df870da4c313b11e9cb4d0621d89::boost::claim<T0>(arg7, v7, v12, v8, arg4, arg10, arg11);
        let v14 = (0x2::coin::value<T0>(&v13) as u256);
        0x231d0ed62482f321f446dfc0ba02e01ca620df870da4c313b11e9cb4d0621d89::boost::burn_boost_coin<T0>(arg3, v11, v13);
        assert!(0x231d0ed62482f321f446dfc0ba02e01ca620df870da4c313b11e9cb4d0621d89::pool_manager::get_pool_liquidity(arg1, v5) >= v14, 0);
        let v15 = RelayEvent{
            sequence           : 0x231d0ed62482f321f446dfc0ba02e01ca620df870da4c313b11e9cb4d0621d89::wormhole_adapter_core::send_withdraw(arg5, arg6, 0x231d0ed62482f321f446dfc0ba02e01ca620df870da4c313b11e9cb4d0621d89::lending_core_storage::get_app_cap(arg7), arg1, v5, v10, v2, v3, v14, arg8, arg10, arg11),
            source_chain_id    : v2,
            source_chain_nonce : v3,
            dst_pool           : v5,
            call_type          : v9,
        };
        0x2::event::emit<RelayEvent>(v15);
        let v16 = LendingCoreEvent{
            nonce             : v3,
            sender_user_id    : v12,
            source_chain_id   : v2,
            dst_chain_id      : 0x231d0ed62482f321f446dfc0ba02e01ca620df870da4c313b11e9cb4d0621d89::dola_address::get_dola_chain_id(&v10),
            dola_pool_id      : v11,
            receiver          : 0x231d0ed62482f321f446dfc0ba02e01ca620df870da4c313b11e9cb4d0621d89::dola_address::get_dola_address(&v10),
            amount            : v14,
            liquidate_user_id : 0,
            call_type         : v9,
        };
        0x2::event::emit<LendingCoreEvent>(v16);
    }

    public entry fun liquidate(arg0: &0x231d0ed62482f321f446dfc0ba02e01ca620df870da4c313b11e9cb4d0621d89::genesis::GovernanceGenesis, arg1: &mut 0x231d0ed62482f321f446dfc0ba02e01ca620df870da4c313b11e9cb4d0621d89::pool_manager::PoolManagerInfo, arg2: &mut 0x231d0ed62482f321f446dfc0ba02e01ca620df870da4c313b11e9cb4d0621d89::user_manager::UserManagerInfo, arg3: &mut 0x5306f64e312b581766351c07af79c72fcb1cd25147157fdc2f8ad76de9a3fb6a::state::State, arg4: &mut 0x231d0ed62482f321f446dfc0ba02e01ca620df870da4c313b11e9cb4d0621d89::wormhole_adapter_core::CoreState, arg5: &mut 0x231d0ed62482f321f446dfc0ba02e01ca620df870da4c313b11e9cb4d0621d89::oracle::PriceOracle, arg6: &mut 0x231d0ed62482f321f446dfc0ba02e01ca620df870da4c313b11e9cb4d0621d89::lending_core_storage::Storage, arg7: vector<u8>, arg8: &0x2::clock::Clock, arg9: &mut 0x2::tx_context::TxContext) {
        0x231d0ed62482f321f446dfc0ba02e01ca620df870da4c313b11e9cb4d0621d89::genesis::check_latest_version(arg0);
        let (v0, v1) = 0x231d0ed62482f321f446dfc0ba02e01ca620df870da4c313b11e9cb4d0621d89::wormhole_adapter_core::receive_message(arg3, arg4, 0x231d0ed62482f321f446dfc0ba02e01ca620df870da4c313b11e9cb4d0621d89::lending_core_storage::get_app_cap(arg6), arg7, arg8, arg9);
        let v2 = v0;
        let (v3, v4, v5, v6, v7, v8) = 0x231d0ed62482f321f446dfc0ba02e01ca620df870da4c313b11e9cb4d0621d89::lending_codec::decode_liquidate_payload_v2(v1);
        let v9 = 0x231d0ed62482f321f446dfc0ba02e01ca620df870da4c313b11e9cb4d0621d89::user_manager::get_dola_user_id(arg2, v2);
        0x231d0ed62482f321f446dfc0ba02e01ca620df870da4c313b11e9cb4d0621d89::lending_logic::execute_liquidate(arg1, arg6, arg5, arg8, v9, v6, v7, v5);
        let v10 = LendingCoreEvent{
            nonce             : v4,
            sender_user_id    : v9,
            source_chain_id   : v3,
            dst_chain_id      : 0x231d0ed62482f321f446dfc0ba02e01ca620df870da4c313b11e9cb4d0621d89::dola_address::get_dola_chain_id(&v2),
            dola_pool_id      : v7,
            receiver          : 0x231d0ed62482f321f446dfc0ba02e01ca620df870da4c313b11e9cb4d0621d89::dola_address::get_dola_address(&v2),
            amount            : 0,
            liquidate_user_id : v6,
            call_type         : v8,
        };
        0x2::event::emit<LendingCoreEvent>(v10);
    }

    public entry fun repay(arg0: &0x231d0ed62482f321f446dfc0ba02e01ca620df870da4c313b11e9cb4d0621d89::genesis::GovernanceGenesis, arg1: &mut 0x231d0ed62482f321f446dfc0ba02e01ca620df870da4c313b11e9cb4d0621d89::pool_manager::PoolManagerInfo, arg2: &mut 0x231d0ed62482f321f446dfc0ba02e01ca620df870da4c313b11e9cb4d0621d89::user_manager::UserManagerInfo, arg3: &mut 0x5306f64e312b581766351c07af79c72fcb1cd25147157fdc2f8ad76de9a3fb6a::state::State, arg4: &mut 0x231d0ed62482f321f446dfc0ba02e01ca620df870da4c313b11e9cb4d0621d89::wormhole_adapter_core::CoreState, arg5: &mut 0x231d0ed62482f321f446dfc0ba02e01ca620df870da4c313b11e9cb4d0621d89::oracle::PriceOracle, arg6: &mut 0x231d0ed62482f321f446dfc0ba02e01ca620df870da4c313b11e9cb4d0621d89::lending_core_storage::Storage, arg7: vector<u8>, arg8: &0x2::clock::Clock, arg9: &mut 0x2::tx_context::TxContext) {
        0x231d0ed62482f321f446dfc0ba02e01ca620df870da4c313b11e9cb4d0621d89::genesis::check_latest_version(arg0);
        let (v0, v1, v2, v3) = 0x231d0ed62482f321f446dfc0ba02e01ca620df870da4c313b11e9cb4d0621d89::wormhole_adapter_core::receive_deposit(arg3, arg4, 0x231d0ed62482f321f446dfc0ba02e01ca620df870da4c313b11e9cb4d0621d89::lending_core_storage::get_app_cap(arg6), arg7, arg1, arg2, arg8, arg9);
        let v4 = 0x231d0ed62482f321f446dfc0ba02e01ca620df870da4c313b11e9cb4d0621d89::pool_manager::get_id_by_pool(arg1, v0);
        let v5 = 0x231d0ed62482f321f446dfc0ba02e01ca620df870da4c313b11e9cb4d0621d89::user_manager::get_dola_user_id(arg2, v1);
        0x231d0ed62482f321f446dfc0ba02e01ca620df870da4c313b11e9cb4d0621d89::lending_logic::execute_repay(arg1, arg6, arg5, arg8, v5, v4, v2);
        let (v6, v7, v8, v9) = 0x231d0ed62482f321f446dfc0ba02e01ca620df870da4c313b11e9cb4d0621d89::lending_codec::decode_deposit_payload(v3);
        let v10 = v8;
        assert!(v9 == 0x231d0ed62482f321f446dfc0ba02e01ca620df870da4c313b11e9cb4d0621d89::lending_codec::get_repay_type(), 1);
        let v11 = LendingCoreEvent{
            nonce             : v7,
            sender_user_id    : v5,
            source_chain_id   : v6,
            dst_chain_id      : 0x231d0ed62482f321f446dfc0ba02e01ca620df870da4c313b11e9cb4d0621d89::dola_address::get_dola_chain_id(&v10),
            dola_pool_id      : v4,
            receiver          : 0x231d0ed62482f321f446dfc0ba02e01ca620df870da4c313b11e9cb4d0621d89::dola_address::get_dola_address(&v10),
            amount            : v2,
            liquidate_user_id : 0,
            call_type         : v9,
        };
        0x2::event::emit<LendingCoreEvent>(v11);
    }

    entry fun sponsor<T0>(arg0: &0x231d0ed62482f321f446dfc0ba02e01ca620df870da4c313b11e9cb4d0621d89::genesis::GovernanceGenesis, arg1: &mut 0x231d0ed62482f321f446dfc0ba02e01ca620df870da4c313b11e9cb4d0621d89::pool_manager::PoolManagerInfo, arg2: &mut 0x231d0ed62482f321f446dfc0ba02e01ca620df870da4c313b11e9cb4d0621d89::user_manager::UserManagerInfo, arg3: &mut 0x5306f64e312b581766351c07af79c72fcb1cd25147157fdc2f8ad76de9a3fb6a::state::State, arg4: &mut 0x231d0ed62482f321f446dfc0ba02e01ca620df870da4c313b11e9cb4d0621d89::boost::BoostReserves, arg5: &mut 0x231d0ed62482f321f446dfc0ba02e01ca620df870da4c313b11e9cb4d0621d89::wormhole_adapter_core::CoreState, arg6: &mut 0x231d0ed62482f321f446dfc0ba02e01ca620df870da4c313b11e9cb4d0621d89::lending_core_storage::Storage, arg7: vector<u8>, arg8: &0x2::clock::Clock, arg9: &mut 0x2::tx_context::TxContext) {
        0x231d0ed62482f321f446dfc0ba02e01ca620df870da4c313b11e9cb4d0621d89::genesis::check_latest_version(arg0);
        let (v0, v1, v2, v3) = 0x231d0ed62482f321f446dfc0ba02e01ca620df870da4c313b11e9cb4d0621d89::wormhole_adapter_core::receive_deposit(arg3, arg5, 0x231d0ed62482f321f446dfc0ba02e01ca620df870da4c313b11e9cb4d0621d89::lending_core_storage::get_app_cap(arg6), arg7, arg1, arg2, arg8, arg9);
        let v4 = v1;
        let v5 = 0x231d0ed62482f321f446dfc0ba02e01ca620df870da4c313b11e9cb4d0621d89::pool_manager::get_id_by_pool(arg1, v0);
        let (v6, v7, _, v9) = 0x231d0ed62482f321f446dfc0ba02e01ca620df870da4c313b11e9cb4d0621d89::lending_codec::decode_deposit_payload(v3);
        assert!(v9 == 0x231d0ed62482f321f446dfc0ba02e01ca620df870da4c313b11e9cb4d0621d89::lending_codec::get_sponsor_type(), 1);
        0x231d0ed62482f321f446dfc0ba02e01ca620df870da4c313b11e9cb4d0621d89::boost::deposit_boost_coin<T0>(arg4, v5, 0x231d0ed62482f321f446dfc0ba02e01ca620df870da4c313b11e9cb4d0621d89::boost::mint_boost_coin<T0>(arg4, v5, (v2 as u64), arg9));
        let v10 = LendingCoreEvent{
            nonce             : v7,
            sender_user_id    : 0x231d0ed62482f321f446dfc0ba02e01ca620df870da4c313b11e9cb4d0621d89::user_manager::get_dola_user_id(arg2, v4),
            source_chain_id   : v6,
            dst_chain_id      : 0x231d0ed62482f321f446dfc0ba02e01ca620df870da4c313b11e9cb4d0621d89::dola_address::get_dola_chain_id(&v4),
            dola_pool_id      : v5,
            receiver          : 0x231d0ed62482f321f446dfc0ba02e01ca620df870da4c313b11e9cb4d0621d89::dola_address::get_dola_address(&v4),
            amount            : v2,
            liquidate_user_id : 0,
            call_type         : v9,
        };
        0x2::event::emit<LendingCoreEvent>(v10);
    }

    public entry fun supply(arg0: &0x231d0ed62482f321f446dfc0ba02e01ca620df870da4c313b11e9cb4d0621d89::genesis::GovernanceGenesis, arg1: &mut 0x231d0ed62482f321f446dfc0ba02e01ca620df870da4c313b11e9cb4d0621d89::pool_manager::PoolManagerInfo, arg2: &mut 0x231d0ed62482f321f446dfc0ba02e01ca620df870da4c313b11e9cb4d0621d89::user_manager::UserManagerInfo, arg3: &mut 0x5306f64e312b581766351c07af79c72fcb1cd25147157fdc2f8ad76de9a3fb6a::state::State, arg4: &mut 0x231d0ed62482f321f446dfc0ba02e01ca620df870da4c313b11e9cb4d0621d89::wormhole_adapter_core::CoreState, arg5: &mut 0x231d0ed62482f321f446dfc0ba02e01ca620df870da4c313b11e9cb4d0621d89::oracle::PriceOracle, arg6: &mut 0x231d0ed62482f321f446dfc0ba02e01ca620df870da4c313b11e9cb4d0621d89::lending_core_storage::Storage, arg7: vector<u8>, arg8: &0x2::clock::Clock, arg9: &mut 0x2::tx_context::TxContext) {
        0x231d0ed62482f321f446dfc0ba02e01ca620df870da4c313b11e9cb4d0621d89::genesis::check_latest_version(arg0);
        let (v0, v1, v2, v3) = 0x231d0ed62482f321f446dfc0ba02e01ca620df870da4c313b11e9cb4d0621d89::wormhole_adapter_core::receive_deposit(arg3, arg4, 0x231d0ed62482f321f446dfc0ba02e01ca620df870da4c313b11e9cb4d0621d89::lending_core_storage::get_app_cap(arg6), arg7, arg1, arg2, arg8, arg9);
        let v4 = 0x231d0ed62482f321f446dfc0ba02e01ca620df870da4c313b11e9cb4d0621d89::pool_manager::get_id_by_pool(arg1, v0);
        let v5 = 0x231d0ed62482f321f446dfc0ba02e01ca620df870da4c313b11e9cb4d0621d89::user_manager::get_dola_user_id(arg2, v1);
        0x231d0ed62482f321f446dfc0ba02e01ca620df870da4c313b11e9cb4d0621d89::lending_logic::execute_supply(arg1, arg6, arg5, arg8, v5, v4, v2);
        let (v6, v7, v8, v9) = 0x231d0ed62482f321f446dfc0ba02e01ca620df870da4c313b11e9cb4d0621d89::lending_codec::decode_deposit_payload(v3);
        let v10 = v8;
        assert!(v9 == 0x231d0ed62482f321f446dfc0ba02e01ca620df870da4c313b11e9cb4d0621d89::lending_codec::get_supply_type(), 1);
        let v11 = LendingCoreEvent{
            nonce             : v7,
            sender_user_id    : v5,
            source_chain_id   : v6,
            dst_chain_id      : 0x231d0ed62482f321f446dfc0ba02e01ca620df870da4c313b11e9cb4d0621d89::dola_address::get_dola_chain_id(&v10),
            dola_pool_id      : v4,
            receiver          : 0x231d0ed62482f321f446dfc0ba02e01ca620df870da4c313b11e9cb4d0621d89::dola_address::get_dola_address(&v10),
            amount            : v2,
            liquidate_user_id : 0,
            call_type         : v9,
        };
        0x2::event::emit<LendingCoreEvent>(v11);
    }

    public entry fun withdraw(arg0: &0x231d0ed62482f321f446dfc0ba02e01ca620df870da4c313b11e9cb4d0621d89::genesis::GovernanceGenesis, arg1: &mut 0x231d0ed62482f321f446dfc0ba02e01ca620df870da4c313b11e9cb4d0621d89::pool_manager::PoolManagerInfo, arg2: &mut 0x231d0ed62482f321f446dfc0ba02e01ca620df870da4c313b11e9cb4d0621d89::user_manager::UserManagerInfo, arg3: &mut 0x5306f64e312b581766351c07af79c72fcb1cd25147157fdc2f8ad76de9a3fb6a::state::State, arg4: &mut 0x231d0ed62482f321f446dfc0ba02e01ca620df870da4c313b11e9cb4d0621d89::wormhole_adapter_core::CoreState, arg5: &mut 0x231d0ed62482f321f446dfc0ba02e01ca620df870da4c313b11e9cb4d0621d89::oracle::PriceOracle, arg6: &mut 0x231d0ed62482f321f446dfc0ba02e01ca620df870da4c313b11e9cb4d0621d89::lending_core_storage::Storage, arg7: 0x2::coin::Coin<0x2::sui::SUI>, arg8: vector<u8>, arg9: &0x2::clock::Clock, arg10: &mut 0x2::tx_context::TxContext) {
        0x231d0ed62482f321f446dfc0ba02e01ca620df870da4c313b11e9cb4d0621d89::genesis::check_latest_version(arg0);
        let (v0, v1) = 0x231d0ed62482f321f446dfc0ba02e01ca620df870da4c313b11e9cb4d0621d89::wormhole_adapter_core::receive_withdraw(arg3, arg4, 0x231d0ed62482f321f446dfc0ba02e01ca620df870da4c313b11e9cb4d0621d89::lending_core_storage::get_app_cap(arg6), arg8, arg9, arg10);
        let (v2, v3, v4, v5, v6, v7) = 0x231d0ed62482f321f446dfc0ba02e01ca620df870da4c313b11e9cb4d0621d89::lending_codec::decode_withdraw_payload(v1);
        let v8 = v6;
        assert!(v7 == 0x231d0ed62482f321f446dfc0ba02e01ca620df870da4c313b11e9cb4d0621d89::lending_codec::get_withdraw_type(), 1);
        let v9 = 0x231d0ed62482f321f446dfc0ba02e01ca620df870da4c313b11e9cb4d0621d89::pool_manager::get_id_by_pool(arg1, v5);
        let v10 = 0x231d0ed62482f321f446dfc0ba02e01ca620df870da4c313b11e9cb4d0621d89::user_manager::get_dola_user_id(arg2, v0);
        let v11 = 0x231d0ed62482f321f446dfc0ba02e01ca620df870da4c313b11e9cb4d0621d89::lending_logic::execute_withdraw(arg1, arg6, arg5, arg9, v10, v9, (v4 as u256));
        assert!(0x231d0ed62482f321f446dfc0ba02e01ca620df870da4c313b11e9cb4d0621d89::pool_manager::get_pool_liquidity(arg1, v5) >= v11, 0);
        let v12 = RelayEvent{
            sequence           : 0x231d0ed62482f321f446dfc0ba02e01ca620df870da4c313b11e9cb4d0621d89::wormhole_adapter_core::send_withdraw(arg3, arg4, 0x231d0ed62482f321f446dfc0ba02e01ca620df870da4c313b11e9cb4d0621d89::lending_core_storage::get_app_cap(arg6), arg1, v5, v8, v2, v3, v11, arg7, arg9, arg10),
            source_chain_id    : v2,
            source_chain_nonce : v3,
            dst_pool           : v5,
            call_type          : v7,
        };
        0x2::event::emit<RelayEvent>(v12);
        let v13 = LendingCoreEvent{
            nonce             : v3,
            sender_user_id    : v10,
            source_chain_id   : v2,
            dst_chain_id      : 0x231d0ed62482f321f446dfc0ba02e01ca620df870da4c313b11e9cb4d0621d89::dola_address::get_dola_chain_id(&v8),
            dola_pool_id      : v9,
            receiver          : 0x231d0ed62482f321f446dfc0ba02e01ca620df870da4c313b11e9cb4d0621d89::dola_address::get_dola_address(&v8),
            amount            : v11,
            liquidate_user_id : 0,
            call_type         : v7,
        };
        0x2::event::emit<LendingCoreEvent>(v13);
    }

    // decompiled from Move bytecode v6
}

