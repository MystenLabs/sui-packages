module 0x2daca359a68a04f3ed381b4427ffdb2ec1e464821c5098bbb4ddb9024e680845::lending_core_wormhole_adapter {
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
        dst_pool: 0x2daca359a68a04f3ed381b4427ffdb2ec1e464821c5098bbb4ddb9024e680845::dola_address::DolaAddress,
        source_chain_id: u16,
        source_chain_nonce: u64,
        call_type: u8,
    }

    public entry fun borrow(arg0: &0x2daca359a68a04f3ed381b4427ffdb2ec1e464821c5098bbb4ddb9024e680845::genesis::GovernanceGenesis, arg1: &mut 0x2daca359a68a04f3ed381b4427ffdb2ec1e464821c5098bbb4ddb9024e680845::pool_manager::PoolManagerInfo, arg2: &mut 0x2daca359a68a04f3ed381b4427ffdb2ec1e464821c5098bbb4ddb9024e680845::user_manager::UserManagerInfo, arg3: &mut 0x5306f64e312b581766351c07af79c72fcb1cd25147157fdc2f8ad76de9a3fb6a::state::State, arg4: &mut 0x2daca359a68a04f3ed381b4427ffdb2ec1e464821c5098bbb4ddb9024e680845::wormhole_adapter_core::CoreState, arg5: &mut 0x2daca359a68a04f3ed381b4427ffdb2ec1e464821c5098bbb4ddb9024e680845::oracle::PriceOracle, arg6: &mut 0x2daca359a68a04f3ed381b4427ffdb2ec1e464821c5098bbb4ddb9024e680845::lending_core_storage::Storage, arg7: 0x2::coin::Coin<0x2::sui::SUI>, arg8: vector<u8>, arg9: &0x2::clock::Clock, arg10: &mut 0x2::tx_context::TxContext) {
        0x2daca359a68a04f3ed381b4427ffdb2ec1e464821c5098bbb4ddb9024e680845::genesis::check_latest_version(arg0);
        let (v0, v1) = 0x2daca359a68a04f3ed381b4427ffdb2ec1e464821c5098bbb4ddb9024e680845::wormhole_adapter_core::receive_withdraw(arg3, arg4, 0x2daca359a68a04f3ed381b4427ffdb2ec1e464821c5098bbb4ddb9024e680845::lending_core_storage::get_app_cap(arg6), arg8, arg9, arg10);
        let (v2, v3, v4, v5, v6, v7) = 0x2daca359a68a04f3ed381b4427ffdb2ec1e464821c5098bbb4ddb9024e680845::lending_codec::decode_withdraw_payload(v1);
        let v8 = v6;
        assert!(v7 == 0x2daca359a68a04f3ed381b4427ffdb2ec1e464821c5098bbb4ddb9024e680845::lending_codec::get_borrow_type(), 1);
        let v9 = (v4 as u256);
        let v10 = 0x2daca359a68a04f3ed381b4427ffdb2ec1e464821c5098bbb4ddb9024e680845::pool_manager::get_id_by_pool(arg1, v5);
        let v11 = 0x2daca359a68a04f3ed381b4427ffdb2ec1e464821c5098bbb4ddb9024e680845::user_manager::get_dola_user_id(arg2, v0);
        let v12 = 0x2daca359a68a04f3ed381b4427ffdb2ec1e464821c5098bbb4ddb9024e680845::pool_manager::find_pool_by_chain(arg1, v10, 0x2daca359a68a04f3ed381b4427ffdb2ec1e464821c5098bbb4ddb9024e680845::dola_address::get_dola_chain_id(&v8));
        assert!(0x1::option::is_some<0x2daca359a68a04f3ed381b4427ffdb2ec1e464821c5098bbb4ddb9024e680845::dola_address::DolaAddress>(&v12), 2);
        let v13 = 0x1::option::destroy_some<0x2daca359a68a04f3ed381b4427ffdb2ec1e464821c5098bbb4ddb9024e680845::dola_address::DolaAddress>(v12);
        0x2daca359a68a04f3ed381b4427ffdb2ec1e464821c5098bbb4ddb9024e680845::lending_logic::execute_borrow(arg1, arg6, arg5, arg9, v11, v10, v9);
        assert!(0x2daca359a68a04f3ed381b4427ffdb2ec1e464821c5098bbb4ddb9024e680845::pool_manager::get_pool_liquidity(arg1, v13) >= v9, 0);
        let v14 = RelayEvent{
            sequence           : 0x2daca359a68a04f3ed381b4427ffdb2ec1e464821c5098bbb4ddb9024e680845::wormhole_adapter_core::send_withdraw(arg3, arg4, 0x2daca359a68a04f3ed381b4427ffdb2ec1e464821c5098bbb4ddb9024e680845::lending_core_storage::get_app_cap(arg6), arg1, v13, v8, v2, v3, v9, arg7, arg9),
            dst_pool           : v13,
            source_chain_id    : v2,
            source_chain_nonce : v3,
            call_type          : v7,
        };
        0x2::event::emit<RelayEvent>(v14);
        let v15 = LendingCoreEvent{
            nonce             : v3,
            sender_user_id    : v11,
            source_chain_id   : v2,
            dst_chain_id      : 0x2daca359a68a04f3ed381b4427ffdb2ec1e464821c5098bbb4ddb9024e680845::dola_address::get_dola_chain_id(&v8),
            dola_pool_id      : v10,
            receiver          : 0x2daca359a68a04f3ed381b4427ffdb2ec1e464821c5098bbb4ddb9024e680845::dola_address::get_dola_address(&v8),
            amount            : v9,
            liquidate_user_id : 0,
            call_type         : v7,
        };
        0x2::event::emit<LendingCoreEvent>(v15);
    }

    public entry fun as_collateral(arg0: &0x2daca359a68a04f3ed381b4427ffdb2ec1e464821c5098bbb4ddb9024e680845::genesis::GovernanceGenesis, arg1: &mut 0x2daca359a68a04f3ed381b4427ffdb2ec1e464821c5098bbb4ddb9024e680845::pool_manager::PoolManagerInfo, arg2: &mut 0x2daca359a68a04f3ed381b4427ffdb2ec1e464821c5098bbb4ddb9024e680845::user_manager::UserManagerInfo, arg3: &mut 0x5306f64e312b581766351c07af79c72fcb1cd25147157fdc2f8ad76de9a3fb6a::state::State, arg4: &mut 0x2daca359a68a04f3ed381b4427ffdb2ec1e464821c5098bbb4ddb9024e680845::wormhole_adapter_core::CoreState, arg5: &mut 0x2daca359a68a04f3ed381b4427ffdb2ec1e464821c5098bbb4ddb9024e680845::oracle::PriceOracle, arg6: &mut 0x2daca359a68a04f3ed381b4427ffdb2ec1e464821c5098bbb4ddb9024e680845::lending_core_storage::Storage, arg7: vector<u8>, arg8: &0x2::clock::Clock, arg9: &mut 0x2::tx_context::TxContext) {
        0x2daca359a68a04f3ed381b4427ffdb2ec1e464821c5098bbb4ddb9024e680845::genesis::check_latest_version(arg0);
        let (v0, v1) = 0x2daca359a68a04f3ed381b4427ffdb2ec1e464821c5098bbb4ddb9024e680845::wormhole_adapter_core::receive_message(arg3, arg4, 0x2daca359a68a04f3ed381b4427ffdb2ec1e464821c5098bbb4ddb9024e680845::lending_core_storage::get_app_cap(arg6), arg7, arg8, arg9);
        let (v2, v3) = 0x2daca359a68a04f3ed381b4427ffdb2ec1e464821c5098bbb4ddb9024e680845::lending_codec::decode_manage_collateral_payload(v1);
        let v4 = v2;
        assert!(v3 == 0x2daca359a68a04f3ed381b4427ffdb2ec1e464821c5098bbb4ddb9024e680845::lending_codec::get_as_colleteral_type(), 1);
        let v5 = 0;
        while (v5 < 0x1::vector::length<u16>(&v4)) {
            0x2daca359a68a04f3ed381b4427ffdb2ec1e464821c5098bbb4ddb9024e680845::lending_logic::as_collateral(arg1, arg6, arg5, arg8, 0x2daca359a68a04f3ed381b4427ffdb2ec1e464821c5098bbb4ddb9024e680845::user_manager::get_dola_user_id(arg2, v0), *0x1::vector::borrow<u16>(&v4, v5));
            v5 = v5 + 1;
        };
    }

    public entry fun cancel_as_collateral(arg0: &0x2daca359a68a04f3ed381b4427ffdb2ec1e464821c5098bbb4ddb9024e680845::genesis::GovernanceGenesis, arg1: &mut 0x2daca359a68a04f3ed381b4427ffdb2ec1e464821c5098bbb4ddb9024e680845::pool_manager::PoolManagerInfo, arg2: &mut 0x2daca359a68a04f3ed381b4427ffdb2ec1e464821c5098bbb4ddb9024e680845::user_manager::UserManagerInfo, arg3: &mut 0x5306f64e312b581766351c07af79c72fcb1cd25147157fdc2f8ad76de9a3fb6a::state::State, arg4: &mut 0x2daca359a68a04f3ed381b4427ffdb2ec1e464821c5098bbb4ddb9024e680845::wormhole_adapter_core::CoreState, arg5: &mut 0x2daca359a68a04f3ed381b4427ffdb2ec1e464821c5098bbb4ddb9024e680845::oracle::PriceOracle, arg6: &mut 0x2daca359a68a04f3ed381b4427ffdb2ec1e464821c5098bbb4ddb9024e680845::lending_core_storage::Storage, arg7: vector<u8>, arg8: &0x2::clock::Clock, arg9: &mut 0x2::tx_context::TxContext) {
        0x2daca359a68a04f3ed381b4427ffdb2ec1e464821c5098bbb4ddb9024e680845::genesis::check_latest_version(arg0);
        let (v0, v1) = 0x2daca359a68a04f3ed381b4427ffdb2ec1e464821c5098bbb4ddb9024e680845::wormhole_adapter_core::receive_message(arg3, arg4, 0x2daca359a68a04f3ed381b4427ffdb2ec1e464821c5098bbb4ddb9024e680845::lending_core_storage::get_app_cap(arg6), arg7, arg8, arg9);
        let (v2, v3) = 0x2daca359a68a04f3ed381b4427ffdb2ec1e464821c5098bbb4ddb9024e680845::lending_codec::decode_manage_collateral_payload(v1);
        let v4 = v2;
        assert!(v3 == 0x2daca359a68a04f3ed381b4427ffdb2ec1e464821c5098bbb4ddb9024e680845::lending_codec::get_cancel_as_colleteral_type(), 1);
        let v5 = 0;
        while (v5 < 0x1::vector::length<u16>(&v4)) {
            0x2daca359a68a04f3ed381b4427ffdb2ec1e464821c5098bbb4ddb9024e680845::lending_logic::cancel_as_collateral(arg1, arg6, arg5, arg8, 0x2daca359a68a04f3ed381b4427ffdb2ec1e464821c5098bbb4ddb9024e680845::user_manager::get_dola_user_id(arg2, v0), *0x1::vector::borrow<u16>(&v4, v5));
            v5 = v5 + 1;
        };
    }

    public entry fun liquidate(arg0: &0x2daca359a68a04f3ed381b4427ffdb2ec1e464821c5098bbb4ddb9024e680845::genesis::GovernanceGenesis, arg1: &mut 0x2daca359a68a04f3ed381b4427ffdb2ec1e464821c5098bbb4ddb9024e680845::pool_manager::PoolManagerInfo, arg2: &mut 0x2daca359a68a04f3ed381b4427ffdb2ec1e464821c5098bbb4ddb9024e680845::user_manager::UserManagerInfo, arg3: &mut 0x5306f64e312b581766351c07af79c72fcb1cd25147157fdc2f8ad76de9a3fb6a::state::State, arg4: &mut 0x2daca359a68a04f3ed381b4427ffdb2ec1e464821c5098bbb4ddb9024e680845::wormhole_adapter_core::CoreState, arg5: &mut 0x2daca359a68a04f3ed381b4427ffdb2ec1e464821c5098bbb4ddb9024e680845::oracle::PriceOracle, arg6: &mut 0x2daca359a68a04f3ed381b4427ffdb2ec1e464821c5098bbb4ddb9024e680845::lending_core_storage::Storage, arg7: vector<u8>, arg8: &0x2::clock::Clock, arg9: &mut 0x2::tx_context::TxContext) {
        0x2daca359a68a04f3ed381b4427ffdb2ec1e464821c5098bbb4ddb9024e680845::genesis::check_latest_version(arg0);
        let (v0, v1, v2, v3) = 0x2daca359a68a04f3ed381b4427ffdb2ec1e464821c5098bbb4ddb9024e680845::wormhole_adapter_core::receive_deposit(arg3, arg4, 0x2daca359a68a04f3ed381b4427ffdb2ec1e464821c5098bbb4ddb9024e680845::lending_core_storage::get_app_cap(arg6), arg7, arg1, arg2, arg8, arg9);
        let v4 = v1;
        let (v5, v6, v7, v8, v9) = 0x2daca359a68a04f3ed381b4427ffdb2ec1e464821c5098bbb4ddb9024e680845::lending_codec::decode_liquidate_payload(v3);
        let v10 = 0x2daca359a68a04f3ed381b4427ffdb2ec1e464821c5098bbb4ddb9024e680845::user_manager::get_dola_user_id(arg2, v4);
        let v11 = 0x2daca359a68a04f3ed381b4427ffdb2ec1e464821c5098bbb4ddb9024e680845::pool_manager::get_id_by_pool(arg1, v0);
        let v12 = 0x2daca359a68a04f3ed381b4427ffdb2ec1e464821c5098bbb4ddb9024e680845::pool_manager::get_id_by_pool(arg1, v7);
        0x2daca359a68a04f3ed381b4427ffdb2ec1e464821c5098bbb4ddb9024e680845::lending_logic::execute_supply(arg1, arg6, arg5, arg8, v10, v11, v2);
        0x2daca359a68a04f3ed381b4427ffdb2ec1e464821c5098bbb4ddb9024e680845::lending_logic::execute_liquidate(arg1, arg6, arg5, arg8, v10, v8, v12, v11);
        let v13 = LendingCoreEvent{
            nonce             : v6,
            sender_user_id    : v10,
            source_chain_id   : v5,
            dst_chain_id      : 0x2daca359a68a04f3ed381b4427ffdb2ec1e464821c5098bbb4ddb9024e680845::dola_address::get_dola_chain_id(&v4),
            dola_pool_id      : v12,
            receiver          : 0x2daca359a68a04f3ed381b4427ffdb2ec1e464821c5098bbb4ddb9024e680845::dola_address::get_dola_address(&v4),
            amount            : v2,
            liquidate_user_id : v8,
            call_type         : v9,
        };
        0x2::event::emit<LendingCoreEvent>(v13);
    }

    public entry fun repay(arg0: &0x2daca359a68a04f3ed381b4427ffdb2ec1e464821c5098bbb4ddb9024e680845::genesis::GovernanceGenesis, arg1: &mut 0x2daca359a68a04f3ed381b4427ffdb2ec1e464821c5098bbb4ddb9024e680845::pool_manager::PoolManagerInfo, arg2: &mut 0x2daca359a68a04f3ed381b4427ffdb2ec1e464821c5098bbb4ddb9024e680845::user_manager::UserManagerInfo, arg3: &mut 0x5306f64e312b581766351c07af79c72fcb1cd25147157fdc2f8ad76de9a3fb6a::state::State, arg4: &mut 0x2daca359a68a04f3ed381b4427ffdb2ec1e464821c5098bbb4ddb9024e680845::wormhole_adapter_core::CoreState, arg5: &mut 0x2daca359a68a04f3ed381b4427ffdb2ec1e464821c5098bbb4ddb9024e680845::oracle::PriceOracle, arg6: &mut 0x2daca359a68a04f3ed381b4427ffdb2ec1e464821c5098bbb4ddb9024e680845::lending_core_storage::Storage, arg7: vector<u8>, arg8: &0x2::clock::Clock, arg9: &mut 0x2::tx_context::TxContext) {
        0x2daca359a68a04f3ed381b4427ffdb2ec1e464821c5098bbb4ddb9024e680845::genesis::check_latest_version(arg0);
        let (v0, v1, v2, v3) = 0x2daca359a68a04f3ed381b4427ffdb2ec1e464821c5098bbb4ddb9024e680845::wormhole_adapter_core::receive_deposit(arg3, arg4, 0x2daca359a68a04f3ed381b4427ffdb2ec1e464821c5098bbb4ddb9024e680845::lending_core_storage::get_app_cap(arg6), arg7, arg1, arg2, arg8, arg9);
        let v4 = 0x2daca359a68a04f3ed381b4427ffdb2ec1e464821c5098bbb4ddb9024e680845::pool_manager::get_id_by_pool(arg1, v0);
        let v5 = 0x2daca359a68a04f3ed381b4427ffdb2ec1e464821c5098bbb4ddb9024e680845::user_manager::get_dola_user_id(arg2, v1);
        0x2daca359a68a04f3ed381b4427ffdb2ec1e464821c5098bbb4ddb9024e680845::lending_logic::execute_repay(arg1, arg6, arg5, arg8, v5, v4, v2);
        let (v6, v7, v8, v9) = 0x2daca359a68a04f3ed381b4427ffdb2ec1e464821c5098bbb4ddb9024e680845::lending_codec::decode_deposit_payload(v3);
        let v10 = v8;
        assert!(v9 == 0x2daca359a68a04f3ed381b4427ffdb2ec1e464821c5098bbb4ddb9024e680845::lending_codec::get_repay_type(), 1);
        let v11 = LendingCoreEvent{
            nonce             : v7,
            sender_user_id    : v5,
            source_chain_id   : v6,
            dst_chain_id      : 0x2daca359a68a04f3ed381b4427ffdb2ec1e464821c5098bbb4ddb9024e680845::dola_address::get_dola_chain_id(&v10),
            dola_pool_id      : v4,
            receiver          : 0x2daca359a68a04f3ed381b4427ffdb2ec1e464821c5098bbb4ddb9024e680845::dola_address::get_dola_address(&v10),
            amount            : v2,
            liquidate_user_id : 0,
            call_type         : v9,
        };
        0x2::event::emit<LendingCoreEvent>(v11);
    }

    public entry fun supply(arg0: &0x2daca359a68a04f3ed381b4427ffdb2ec1e464821c5098bbb4ddb9024e680845::genesis::GovernanceGenesis, arg1: &mut 0x2daca359a68a04f3ed381b4427ffdb2ec1e464821c5098bbb4ddb9024e680845::pool_manager::PoolManagerInfo, arg2: &mut 0x2daca359a68a04f3ed381b4427ffdb2ec1e464821c5098bbb4ddb9024e680845::user_manager::UserManagerInfo, arg3: &mut 0x5306f64e312b581766351c07af79c72fcb1cd25147157fdc2f8ad76de9a3fb6a::state::State, arg4: &mut 0x2daca359a68a04f3ed381b4427ffdb2ec1e464821c5098bbb4ddb9024e680845::wormhole_adapter_core::CoreState, arg5: &mut 0x2daca359a68a04f3ed381b4427ffdb2ec1e464821c5098bbb4ddb9024e680845::oracle::PriceOracle, arg6: &mut 0x2daca359a68a04f3ed381b4427ffdb2ec1e464821c5098bbb4ddb9024e680845::lending_core_storage::Storage, arg7: vector<u8>, arg8: &0x2::clock::Clock, arg9: &mut 0x2::tx_context::TxContext) {
        0x2daca359a68a04f3ed381b4427ffdb2ec1e464821c5098bbb4ddb9024e680845::genesis::check_latest_version(arg0);
        let (v0, v1, v2, v3) = 0x2daca359a68a04f3ed381b4427ffdb2ec1e464821c5098bbb4ddb9024e680845::wormhole_adapter_core::receive_deposit(arg3, arg4, 0x2daca359a68a04f3ed381b4427ffdb2ec1e464821c5098bbb4ddb9024e680845::lending_core_storage::get_app_cap(arg6), arg7, arg1, arg2, arg8, arg9);
        let v4 = 0x2daca359a68a04f3ed381b4427ffdb2ec1e464821c5098bbb4ddb9024e680845::pool_manager::get_id_by_pool(arg1, v0);
        let v5 = 0x2daca359a68a04f3ed381b4427ffdb2ec1e464821c5098bbb4ddb9024e680845::user_manager::get_dola_user_id(arg2, v1);
        0x2daca359a68a04f3ed381b4427ffdb2ec1e464821c5098bbb4ddb9024e680845::lending_logic::execute_supply(arg1, arg6, arg5, arg8, v5, v4, v2);
        let (v6, v7, v8, v9) = 0x2daca359a68a04f3ed381b4427ffdb2ec1e464821c5098bbb4ddb9024e680845::lending_codec::decode_deposit_payload(v3);
        let v10 = v8;
        assert!(v9 == 0x2daca359a68a04f3ed381b4427ffdb2ec1e464821c5098bbb4ddb9024e680845::lending_codec::get_supply_type(), 1);
        let v11 = LendingCoreEvent{
            nonce             : v7,
            sender_user_id    : v5,
            source_chain_id   : v6,
            dst_chain_id      : 0x2daca359a68a04f3ed381b4427ffdb2ec1e464821c5098bbb4ddb9024e680845::dola_address::get_dola_chain_id(&v10),
            dola_pool_id      : v4,
            receiver          : 0x2daca359a68a04f3ed381b4427ffdb2ec1e464821c5098bbb4ddb9024e680845::dola_address::get_dola_address(&v10),
            amount            : v2,
            liquidate_user_id : 0,
            call_type         : v9,
        };
        0x2::event::emit<LendingCoreEvent>(v11);
    }

    public entry fun withdraw(arg0: &0x2daca359a68a04f3ed381b4427ffdb2ec1e464821c5098bbb4ddb9024e680845::genesis::GovernanceGenesis, arg1: &mut 0x2daca359a68a04f3ed381b4427ffdb2ec1e464821c5098bbb4ddb9024e680845::pool_manager::PoolManagerInfo, arg2: &mut 0x2daca359a68a04f3ed381b4427ffdb2ec1e464821c5098bbb4ddb9024e680845::user_manager::UserManagerInfo, arg3: &mut 0x5306f64e312b581766351c07af79c72fcb1cd25147157fdc2f8ad76de9a3fb6a::state::State, arg4: &mut 0x2daca359a68a04f3ed381b4427ffdb2ec1e464821c5098bbb4ddb9024e680845::wormhole_adapter_core::CoreState, arg5: &mut 0x2daca359a68a04f3ed381b4427ffdb2ec1e464821c5098bbb4ddb9024e680845::oracle::PriceOracle, arg6: &mut 0x2daca359a68a04f3ed381b4427ffdb2ec1e464821c5098bbb4ddb9024e680845::lending_core_storage::Storage, arg7: 0x2::coin::Coin<0x2::sui::SUI>, arg8: vector<u8>, arg9: &0x2::clock::Clock, arg10: &mut 0x2::tx_context::TxContext) {
        0x2daca359a68a04f3ed381b4427ffdb2ec1e464821c5098bbb4ddb9024e680845::genesis::check_latest_version(arg0);
        let (v0, v1) = 0x2daca359a68a04f3ed381b4427ffdb2ec1e464821c5098bbb4ddb9024e680845::wormhole_adapter_core::receive_withdraw(arg3, arg4, 0x2daca359a68a04f3ed381b4427ffdb2ec1e464821c5098bbb4ddb9024e680845::lending_core_storage::get_app_cap(arg6), arg8, arg9, arg10);
        let (v2, v3, v4, v5, v6, v7) = 0x2daca359a68a04f3ed381b4427ffdb2ec1e464821c5098bbb4ddb9024e680845::lending_codec::decode_withdraw_payload(v1);
        let v8 = v6;
        assert!(v7 == 0x2daca359a68a04f3ed381b4427ffdb2ec1e464821c5098bbb4ddb9024e680845::lending_codec::get_withdraw_type(), 1);
        let v9 = 0x2daca359a68a04f3ed381b4427ffdb2ec1e464821c5098bbb4ddb9024e680845::pool_manager::get_id_by_pool(arg1, v5);
        let v10 = 0x2daca359a68a04f3ed381b4427ffdb2ec1e464821c5098bbb4ddb9024e680845::user_manager::get_dola_user_id(arg2, v0);
        let v11 = 0x2daca359a68a04f3ed381b4427ffdb2ec1e464821c5098bbb4ddb9024e680845::pool_manager::find_pool_by_chain(arg1, v9, 0x2daca359a68a04f3ed381b4427ffdb2ec1e464821c5098bbb4ddb9024e680845::dola_address::get_dola_chain_id(&v8));
        assert!(0x1::option::is_some<0x2daca359a68a04f3ed381b4427ffdb2ec1e464821c5098bbb4ddb9024e680845::dola_address::DolaAddress>(&v11), 2);
        let v12 = 0x1::option::destroy_some<0x2daca359a68a04f3ed381b4427ffdb2ec1e464821c5098bbb4ddb9024e680845::dola_address::DolaAddress>(v11);
        let v13 = 0x2daca359a68a04f3ed381b4427ffdb2ec1e464821c5098bbb4ddb9024e680845::lending_logic::execute_withdraw(arg1, arg6, arg5, arg9, v10, v9, (v4 as u256));
        assert!(0x2daca359a68a04f3ed381b4427ffdb2ec1e464821c5098bbb4ddb9024e680845::pool_manager::get_pool_liquidity(arg1, v12) >= v13, 0);
        let v14 = RelayEvent{
            sequence           : 0x2daca359a68a04f3ed381b4427ffdb2ec1e464821c5098bbb4ddb9024e680845::wormhole_adapter_core::send_withdraw(arg3, arg4, 0x2daca359a68a04f3ed381b4427ffdb2ec1e464821c5098bbb4ddb9024e680845::lending_core_storage::get_app_cap(arg6), arg1, v12, v8, v2, v3, v13, arg7, arg9),
            dst_pool           : v12,
            source_chain_id    : v2,
            source_chain_nonce : v3,
            call_type          : v7,
        };
        0x2::event::emit<RelayEvent>(v14);
        let v15 = LendingCoreEvent{
            nonce             : v3,
            sender_user_id    : v10,
            source_chain_id   : v2,
            dst_chain_id      : 0x2daca359a68a04f3ed381b4427ffdb2ec1e464821c5098bbb4ddb9024e680845::dola_address::get_dola_chain_id(&v8),
            dola_pool_id      : v9,
            receiver          : 0x2daca359a68a04f3ed381b4427ffdb2ec1e464821c5098bbb4ddb9024e680845::dola_address::get_dola_address(&v8),
            amount            : v13,
            liquidate_user_id : 0,
            call_type         : v7,
        };
        0x2::event::emit<LendingCoreEvent>(v15);
    }

    // decompiled from Move bytecode v6
}

