module 0x826915f8ca6d11597dfe6599b8aa02a4c08bd8d39674855254a06ee83fe7220e::lending_portal_v2 {
    struct LendingPortalEvent has copy, drop {
        nonce: u64,
        sender: address,
        dola_pool_address: vector<u8>,
        source_chain_id: u16,
        dst_chain_id: u16,
        receiver: vector<u8>,
        amount: u64,
        call_type: u8,
    }

    struct ClaimRewardEvent has copy, drop {
        nonce: u64,
        sender: address,
        reward_pool: vector<u8>,
        withdraw_pool: vector<u8>,
        receiver: vector<u8>,
        source_chain_id: u16,
        dst_chain_id: u16,
        boost_pool_id: u16,
        boost_action: u8,
    }

    entry fun borrow(arg0: &0x826915f8ca6d11597dfe6599b8aa02a4c08bd8d39674855254a06ee83fe7220e::genesis::GovernanceGenesis, arg1: &mut 0x826915f8ca6d11597dfe6599b8aa02a4c08bd8d39674855254a06ee83fe7220e::wormhole_adapter_pool::PoolState, arg2: &mut 0x5306f64e312b581766351c07af79c72fcb1cd25147157fdc2f8ad76de9a3fb6a::state::State, arg3: u16, arg4: vector<u8>, arg5: vector<u8>, arg6: u64, arg7: 0x2::coin::Coin<0x2::sui::SUI>, arg8: &0x2::clock::Clock, arg9: &mut 0x2::tx_context::TxContext) {
        0x826915f8ca6d11597dfe6599b8aa02a4c08bd8d39674855254a06ee83fe7220e::genesis::check_latest_version(arg0);
        let v0 = 0x826915f8ca6d11597dfe6599b8aa02a4c08bd8d39674855254a06ee83fe7220e::wormhole_adapter_pool::get_nonce(arg1);
        let (v1, v2) = 0x826915f8ca6d11597dfe6599b8aa02a4c08bd8d39674855254a06ee83fe7220e::wormhole_adapter_pool::get_relay_fee_amount(arg2, arg1, v0, arg7, arg9);
        0x826915f8ca6d11597dfe6599b8aa02a4c08bd8d39674855254a06ee83fe7220e::wormhole_adapter_pool::emit_relay_event(0x826915f8ca6d11597dfe6599b8aa02a4c08bd8d39674855254a06ee83fe7220e::wormhole_adapter_pool::send_message(arg1, arg2, v1, 1, 0x826915f8ca6d11597dfe6599b8aa02a4c08bd8d39674855254a06ee83fe7220e::lending_codec::encode_withdraw_payload(arg3, v0, arg6, 0x826915f8ca6d11597dfe6599b8aa02a4c08bd8d39674855254a06ee83fe7220e::dola_address::create_dola_address(arg3, arg4), 0x826915f8ca6d11597dfe6599b8aa02a4c08bd8d39674855254a06ee83fe7220e::dola_address::create_dola_address(arg3, arg5), 0x826915f8ca6d11597dfe6599b8aa02a4c08bd8d39674855254a06ee83fe7220e::lending_codec::get_borrow_type()), arg8, arg9), v0, v2, 1, 0x826915f8ca6d11597dfe6599b8aa02a4c08bd8d39674855254a06ee83fe7220e::lending_codec::get_borrow_type());
        let v3 = LendingPortalEvent{
            nonce             : v0,
            sender            : 0x2::tx_context::sender(arg9),
            dola_pool_address : arg4,
            source_chain_id   : 0x826915f8ca6d11597dfe6599b8aa02a4c08bd8d39674855254a06ee83fe7220e::dola_address::get_native_dola_chain_id(),
            dst_chain_id      : arg3,
            receiver          : arg5,
            amount            : arg6,
            call_type         : 0x826915f8ca6d11597dfe6599b8aa02a4c08bd8d39674855254a06ee83fe7220e::lending_codec::get_borrow_type(),
        };
        0x2::event::emit<LendingPortalEvent>(v3);
    }

    entry fun claim<T0>(arg0: &0x826915f8ca6d11597dfe6599b8aa02a4c08bd8d39674855254a06ee83fe7220e::user_manager::UserManagerInfo, arg1: &mut 0x826915f8ca6d11597dfe6599b8aa02a4c08bd8d39674855254a06ee83fe7220e::lending_core_storage::Storage, arg2: u16, arg3: u8, arg4: &mut 0x826915f8ca6d11597dfe6599b8aa02a4c08bd8d39674855254a06ee83fe7220e::boost::RewardPool<T0>, arg5: &0x2::clock::Clock, arg6: &mut 0x2::tx_context::TxContext) {
        0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(0x826915f8ca6d11597dfe6599b8aa02a4c08bd8d39674855254a06ee83fe7220e::boost::claim<T0>(arg1, arg2, 0x826915f8ca6d11597dfe6599b8aa02a4c08bd8d39674855254a06ee83fe7220e::user_manager::get_dola_user_id(arg0, 0x826915f8ca6d11597dfe6599b8aa02a4c08bd8d39674855254a06ee83fe7220e::dola_address::convert_address_to_dola(0x2::tx_context::sender(arg6))), arg3, arg4, arg5, arg6), 0x2::tx_context::sender(arg6));
    }

    entry fun as_collateral(arg0: &0x826915f8ca6d11597dfe6599b8aa02a4c08bd8d39674855254a06ee83fe7220e::genesis::GovernanceGenesis, arg1: &mut 0x826915f8ca6d11597dfe6599b8aa02a4c08bd8d39674855254a06ee83fe7220e::wormhole_adapter_pool::PoolState, arg2: &mut 0x5306f64e312b581766351c07af79c72fcb1cd25147157fdc2f8ad76de9a3fb6a::state::State, arg3: vector<u16>, arg4: 0x2::coin::Coin<0x2::sui::SUI>, arg5: &0x2::clock::Clock, arg6: &mut 0x2::tx_context::TxContext) {
        0x826915f8ca6d11597dfe6599b8aa02a4c08bd8d39674855254a06ee83fe7220e::genesis::check_latest_version(arg0);
        let v0 = 0x2::tx_context::sender(arg6);
        let v1 = 0x826915f8ca6d11597dfe6599b8aa02a4c08bd8d39674855254a06ee83fe7220e::dola_address::convert_address_to_dola(v0);
        let v2 = 0x826915f8ca6d11597dfe6599b8aa02a4c08bd8d39674855254a06ee83fe7220e::wormhole_adapter_pool::get_nonce(arg1);
        let (v3, v4) = 0x826915f8ca6d11597dfe6599b8aa02a4c08bd8d39674855254a06ee83fe7220e::wormhole_adapter_pool::get_relay_fee_amount(arg2, arg1, v2, arg4, arg6);
        0x826915f8ca6d11597dfe6599b8aa02a4c08bd8d39674855254a06ee83fe7220e::wormhole_adapter_pool::emit_relay_event(0x826915f8ca6d11597dfe6599b8aa02a4c08bd8d39674855254a06ee83fe7220e::wormhole_adapter_pool::send_message(arg1, arg2, v3, 1, 0x826915f8ca6d11597dfe6599b8aa02a4c08bd8d39674855254a06ee83fe7220e::lending_codec::encode_manage_collateral_payload(arg3, 0x826915f8ca6d11597dfe6599b8aa02a4c08bd8d39674855254a06ee83fe7220e::lending_codec::get_as_colleteral_type()), arg5, arg6), v2, v4, 1, 0x826915f8ca6d11597dfe6599b8aa02a4c08bd8d39674855254a06ee83fe7220e::lending_codec::get_as_colleteral_type());
        let v5 = LendingPortalEvent{
            nonce             : v2,
            sender            : v0,
            dola_pool_address : 0x826915f8ca6d11597dfe6599b8aa02a4c08bd8d39674855254a06ee83fe7220e::dola_address::get_dola_address(&v1),
            source_chain_id   : 0x826915f8ca6d11597dfe6599b8aa02a4c08bd8d39674855254a06ee83fe7220e::dola_address::get_native_dola_chain_id(),
            dst_chain_id      : 0x826915f8ca6d11597dfe6599b8aa02a4c08bd8d39674855254a06ee83fe7220e::dola_address::get_native_dola_chain_id(),
            receiver          : 0x826915f8ca6d11597dfe6599b8aa02a4c08bd8d39674855254a06ee83fe7220e::dola_address::get_dola_address(&v1),
            amount            : 0,
            call_type         : 0x826915f8ca6d11597dfe6599b8aa02a4c08bd8d39674855254a06ee83fe7220e::lending_codec::get_as_colleteral_type(),
        };
        0x2::event::emit<LendingPortalEvent>(v5);
    }

    entry fun cancel_as_collateral(arg0: &0x826915f8ca6d11597dfe6599b8aa02a4c08bd8d39674855254a06ee83fe7220e::genesis::GovernanceGenesis, arg1: &mut 0x826915f8ca6d11597dfe6599b8aa02a4c08bd8d39674855254a06ee83fe7220e::wormhole_adapter_pool::PoolState, arg2: &mut 0x5306f64e312b581766351c07af79c72fcb1cd25147157fdc2f8ad76de9a3fb6a::state::State, arg3: vector<u16>, arg4: 0x2::coin::Coin<0x2::sui::SUI>, arg5: &0x2::clock::Clock, arg6: &mut 0x2::tx_context::TxContext) {
        0x826915f8ca6d11597dfe6599b8aa02a4c08bd8d39674855254a06ee83fe7220e::genesis::check_latest_version(arg0);
        let v0 = 0x2::tx_context::sender(arg6);
        let v1 = 0x826915f8ca6d11597dfe6599b8aa02a4c08bd8d39674855254a06ee83fe7220e::dola_address::convert_address_to_dola(v0);
        let v2 = 0x826915f8ca6d11597dfe6599b8aa02a4c08bd8d39674855254a06ee83fe7220e::wormhole_adapter_pool::get_nonce(arg1);
        let (v3, v4) = 0x826915f8ca6d11597dfe6599b8aa02a4c08bd8d39674855254a06ee83fe7220e::wormhole_adapter_pool::get_relay_fee_amount(arg2, arg1, v2, arg4, arg6);
        0x826915f8ca6d11597dfe6599b8aa02a4c08bd8d39674855254a06ee83fe7220e::wormhole_adapter_pool::emit_relay_event(0x826915f8ca6d11597dfe6599b8aa02a4c08bd8d39674855254a06ee83fe7220e::wormhole_adapter_pool::send_message(arg1, arg2, v3, 1, 0x826915f8ca6d11597dfe6599b8aa02a4c08bd8d39674855254a06ee83fe7220e::lending_codec::encode_manage_collateral_payload(arg3, 0x826915f8ca6d11597dfe6599b8aa02a4c08bd8d39674855254a06ee83fe7220e::lending_codec::get_cancel_as_colleteral_type()), arg5, arg6), v2, v4, 1, 0x826915f8ca6d11597dfe6599b8aa02a4c08bd8d39674855254a06ee83fe7220e::lending_codec::get_cancel_as_colleteral_type());
        let v5 = LendingPortalEvent{
            nonce             : v2,
            sender            : v0,
            dola_pool_address : 0x826915f8ca6d11597dfe6599b8aa02a4c08bd8d39674855254a06ee83fe7220e::dola_address::get_dola_address(&v1),
            source_chain_id   : 0x826915f8ca6d11597dfe6599b8aa02a4c08bd8d39674855254a06ee83fe7220e::dola_address::get_native_dola_chain_id(),
            dst_chain_id      : 0x826915f8ca6d11597dfe6599b8aa02a4c08bd8d39674855254a06ee83fe7220e::dola_address::get_native_dola_chain_id(),
            receiver          : 0x826915f8ca6d11597dfe6599b8aa02a4c08bd8d39674855254a06ee83fe7220e::dola_address::get_dola_address(&v1),
            amount            : 0,
            call_type         : 0x826915f8ca6d11597dfe6599b8aa02a4c08bd8d39674855254a06ee83fe7220e::lending_codec::get_cancel_as_colleteral_type(),
        };
        0x2::event::emit<LendingPortalEvent>(v5);
    }

    entry fun claim_reward(arg0: &0x826915f8ca6d11597dfe6599b8aa02a4c08bd8d39674855254a06ee83fe7220e::genesis::GovernanceGenesis, arg1: &mut 0x826915f8ca6d11597dfe6599b8aa02a4c08bd8d39674855254a06ee83fe7220e::wormhole_adapter_pool::PoolState, arg2: &mut 0x5306f64e312b581766351c07af79c72fcb1cd25147157fdc2f8ad76de9a3fb6a::state::State, arg3: vector<u8>, arg4: vector<u8>, arg5: vector<u8>, arg6: u16, arg7: u16, arg8: u8, arg9: 0x2::coin::Coin<0x2::sui::SUI>, arg10: &0x2::clock::Clock, arg11: &mut 0x2::tx_context::TxContext) {
        0x826915f8ca6d11597dfe6599b8aa02a4c08bd8d39674855254a06ee83fe7220e::genesis::check_latest_version(arg0);
        let v0 = 0x826915f8ca6d11597dfe6599b8aa02a4c08bd8d39674855254a06ee83fe7220e::dola_address::create_dola_address(0x826915f8ca6d11597dfe6599b8aa02a4c08bd8d39674855254a06ee83fe7220e::dola_address::get_native_dola_chain_id(), arg3);
        let v1 = 0x826915f8ca6d11597dfe6599b8aa02a4c08bd8d39674855254a06ee83fe7220e::dola_address::create_dola_address(arg6, arg4);
        let v2 = 0x826915f8ca6d11597dfe6599b8aa02a4c08bd8d39674855254a06ee83fe7220e::wormhole_adapter_pool::get_nonce(arg1);
        let (v3, v4) = 0x826915f8ca6d11597dfe6599b8aa02a4c08bd8d39674855254a06ee83fe7220e::wormhole_adapter_pool::get_relay_fee_amount(arg2, arg1, v2, arg9, arg11);
        0x826915f8ca6d11597dfe6599b8aa02a4c08bd8d39674855254a06ee83fe7220e::wormhole_adapter_pool::emit_relay_event(0x826915f8ca6d11597dfe6599b8aa02a4c08bd8d39674855254a06ee83fe7220e::wormhole_adapter_pool::send_message(arg1, arg2, v3, 1, 0x826915f8ca6d11597dfe6599b8aa02a4c08bd8d39674855254a06ee83fe7220e::lending_codec::encode_claim_reward_payload(0x826915f8ca6d11597dfe6599b8aa02a4c08bd8d39674855254a06ee83fe7220e::dola_address::get_native_dola_chain_id(), v2, v0, v1, 0x826915f8ca6d11597dfe6599b8aa02a4c08bd8d39674855254a06ee83fe7220e::dola_address::create_dola_address(arg6, arg5), arg7, arg8, 0x826915f8ca6d11597dfe6599b8aa02a4c08bd8d39674855254a06ee83fe7220e::lending_codec::get_claim_reward_type()), arg10, arg11), v2, v4, 1, 0x826915f8ca6d11597dfe6599b8aa02a4c08bd8d39674855254a06ee83fe7220e::lending_codec::get_claim_reward_type());
        let v5 = ClaimRewardEvent{
            nonce           : v2,
            sender          : 0x2::tx_context::sender(arg11),
            reward_pool     : 0x826915f8ca6d11597dfe6599b8aa02a4c08bd8d39674855254a06ee83fe7220e::dola_address::get_dola_address(&v0),
            withdraw_pool   : 0x826915f8ca6d11597dfe6599b8aa02a4c08bd8d39674855254a06ee83fe7220e::dola_address::get_dola_address(&v1),
            receiver        : arg5,
            source_chain_id : 0x826915f8ca6d11597dfe6599b8aa02a4c08bd8d39674855254a06ee83fe7220e::dola_address::get_native_dola_chain_id(),
            dst_chain_id    : arg6,
            boost_pool_id   : arg7,
            boost_action    : arg8,
        };
        0x2::event::emit<ClaimRewardEvent>(v5);
    }

    entry fun liquidate(arg0: &0x826915f8ca6d11597dfe6599b8aa02a4c08bd8d39674855254a06ee83fe7220e::genesis::GovernanceGenesis, arg1: &mut 0x826915f8ca6d11597dfe6599b8aa02a4c08bd8d39674855254a06ee83fe7220e::wormhole_adapter_pool::PoolState, arg2: &mut 0x5306f64e312b581766351c07af79c72fcb1cd25147157fdc2f8ad76de9a3fb6a::state::State, arg3: u16, arg4: u64, arg5: u16, arg6: 0x2::coin::Coin<0x2::sui::SUI>, arg7: &0x2::clock::Clock, arg8: &mut 0x2::tx_context::TxContext) {
        0x826915f8ca6d11597dfe6599b8aa02a4c08bd8d39674855254a06ee83fe7220e::genesis::check_latest_version(arg0);
        let v0 = 0x2::tx_context::sender(arg8);
        let v1 = 0x826915f8ca6d11597dfe6599b8aa02a4c08bd8d39674855254a06ee83fe7220e::dola_address::convert_address_to_dola(v0);
        let v2 = 0x826915f8ca6d11597dfe6599b8aa02a4c08bd8d39674855254a06ee83fe7220e::wormhole_adapter_pool::get_nonce(arg1);
        let (v3, v4) = 0x826915f8ca6d11597dfe6599b8aa02a4c08bd8d39674855254a06ee83fe7220e::wormhole_adapter_pool::get_relay_fee_amount(arg2, arg1, v2, arg6, arg8);
        0x826915f8ca6d11597dfe6599b8aa02a4c08bd8d39674855254a06ee83fe7220e::wormhole_adapter_pool::emit_relay_event(0x826915f8ca6d11597dfe6599b8aa02a4c08bd8d39674855254a06ee83fe7220e::wormhole_adapter_pool::send_message(arg1, arg2, v3, 1, 0x826915f8ca6d11597dfe6599b8aa02a4c08bd8d39674855254a06ee83fe7220e::lending_codec::encode_liquidate_payload_v2(0x826915f8ca6d11597dfe6599b8aa02a4c08bd8d39674855254a06ee83fe7220e::dola_address::get_native_dola_chain_id(), v2, arg3, arg4, arg5), arg7, arg8), v2, v4, 1, 0x826915f8ca6d11597dfe6599b8aa02a4c08bd8d39674855254a06ee83fe7220e::lending_codec::get_liquidate_type());
        let v5 = LendingPortalEvent{
            nonce             : v2,
            sender            : v0,
            dola_pool_address : 0x826915f8ca6d11597dfe6599b8aa02a4c08bd8d39674855254a06ee83fe7220e::dola_address::get_dola_address(&v1),
            source_chain_id   : 0x826915f8ca6d11597dfe6599b8aa02a4c08bd8d39674855254a06ee83fe7220e::dola_address::get_native_dola_chain_id(),
            dst_chain_id      : 0x826915f8ca6d11597dfe6599b8aa02a4c08bd8d39674855254a06ee83fe7220e::dola_address::get_native_dola_chain_id(),
            receiver          : 0x826915f8ca6d11597dfe6599b8aa02a4c08bd8d39674855254a06ee83fe7220e::dola_address::get_dola_address(&v1),
            amount            : 0,
            call_type         : 0x826915f8ca6d11597dfe6599b8aa02a4c08bd8d39674855254a06ee83fe7220e::lending_codec::get_liquidate_type(),
        };
        0x2::event::emit<LendingPortalEvent>(v5);
    }

    public entry fun repay<T0>(arg0: &0x826915f8ca6d11597dfe6599b8aa02a4c08bd8d39674855254a06ee83fe7220e::genesis::GovernanceGenesis, arg1: &mut 0x826915f8ca6d11597dfe6599b8aa02a4c08bd8d39674855254a06ee83fe7220e::wormhole_adapter_pool::PoolState, arg2: &mut 0x5306f64e312b581766351c07af79c72fcb1cd25147157fdc2f8ad76de9a3fb6a::state::State, arg3: &mut 0x826915f8ca6d11597dfe6599b8aa02a4c08bd8d39674855254a06ee83fe7220e::dola_pool::Pool<T0>, arg4: vector<0x2::coin::Coin<T0>>, arg5: u64, arg6: 0x2::coin::Coin<0x2::sui::SUI>, arg7: &0x2::clock::Clock, arg8: &mut 0x2::tx_context::TxContext) {
        0x826915f8ca6d11597dfe6599b8aa02a4c08bd8d39674855254a06ee83fe7220e::genesis::check_latest_version(arg0);
        assert!(arg5 > 0, 0);
        let v0 = 0x826915f8ca6d11597dfe6599b8aa02a4c08bd8d39674855254a06ee83fe7220e::dola_address::convert_address_to_dola(0x2::tx_context::sender(arg8));
        let v1 = 0x826915f8ca6d11597dfe6599b8aa02a4c08bd8d39674855254a06ee83fe7220e::dola_address::convert_pool_to_dola<T0>();
        let v2 = 0x826915f8ca6d11597dfe6599b8aa02a4c08bd8d39674855254a06ee83fe7220e::wormhole_adapter_pool::get_nonce(arg1);
        let (v3, v4) = 0x826915f8ca6d11597dfe6599b8aa02a4c08bd8d39674855254a06ee83fe7220e::wormhole_adapter_pool::get_relay_fee_amount(arg2, arg1, v2, arg6, arg8);
        0x826915f8ca6d11597dfe6599b8aa02a4c08bd8d39674855254a06ee83fe7220e::wormhole_adapter_pool::emit_relay_event(0x826915f8ca6d11597dfe6599b8aa02a4c08bd8d39674855254a06ee83fe7220e::wormhole_adapter_pool::send_deposit<T0>(arg1, arg2, v3, arg3, 0x826915f8ca6d11597dfe6599b8aa02a4c08bd8d39674855254a06ee83fe7220e::merge_coins::merge_coin<T0>(arg4, arg5, arg8), 1, 0x826915f8ca6d11597dfe6599b8aa02a4c08bd8d39674855254a06ee83fe7220e::lending_codec::encode_deposit_payload(0x826915f8ca6d11597dfe6599b8aa02a4c08bd8d39674855254a06ee83fe7220e::dola_address::get_native_dola_chain_id(), v2, v0, 0x826915f8ca6d11597dfe6599b8aa02a4c08bd8d39674855254a06ee83fe7220e::lending_codec::get_repay_type()), arg7, arg8), v2, v4, 1, 0x826915f8ca6d11597dfe6599b8aa02a4c08bd8d39674855254a06ee83fe7220e::lending_codec::get_repay_type());
        let v5 = LendingPortalEvent{
            nonce             : v2,
            sender            : 0x2::tx_context::sender(arg8),
            dola_pool_address : 0x826915f8ca6d11597dfe6599b8aa02a4c08bd8d39674855254a06ee83fe7220e::dola_address::get_dola_address(&v1),
            source_chain_id   : 0x826915f8ca6d11597dfe6599b8aa02a4c08bd8d39674855254a06ee83fe7220e::dola_address::get_native_dola_chain_id(),
            dst_chain_id      : 0x826915f8ca6d11597dfe6599b8aa02a4c08bd8d39674855254a06ee83fe7220e::dola_address::get_native_dola_chain_id(),
            receiver          : 0x826915f8ca6d11597dfe6599b8aa02a4c08bd8d39674855254a06ee83fe7220e::dola_address::get_dola_address(&v0),
            amount            : arg5,
            call_type         : 0x826915f8ca6d11597dfe6599b8aa02a4c08bd8d39674855254a06ee83fe7220e::lending_codec::get_repay_type(),
        };
        0x2::event::emit<LendingPortalEvent>(v5);
    }

    entry fun sponsor<T0>(arg0: &0x826915f8ca6d11597dfe6599b8aa02a4c08bd8d39674855254a06ee83fe7220e::genesis::GovernanceGenesis, arg1: &mut 0x826915f8ca6d11597dfe6599b8aa02a4c08bd8d39674855254a06ee83fe7220e::wormhole_adapter_pool::PoolState, arg2: &mut 0x5306f64e312b581766351c07af79c72fcb1cd25147157fdc2f8ad76de9a3fb6a::state::State, arg3: &mut 0x826915f8ca6d11597dfe6599b8aa02a4c08bd8d39674855254a06ee83fe7220e::dola_pool::Pool<T0>, arg4: vector<0x2::coin::Coin<T0>>, arg5: u64, arg6: 0x2::coin::Coin<0x2::sui::SUI>, arg7: &0x2::clock::Clock, arg8: &mut 0x2::tx_context::TxContext) {
        0x826915f8ca6d11597dfe6599b8aa02a4c08bd8d39674855254a06ee83fe7220e::genesis::check_latest_version(arg0);
        assert!(arg5 > 0, 0);
        let v0 = 0x826915f8ca6d11597dfe6599b8aa02a4c08bd8d39674855254a06ee83fe7220e::dola_address::convert_address_to_dola(@0x0);
        let v1 = 0x826915f8ca6d11597dfe6599b8aa02a4c08bd8d39674855254a06ee83fe7220e::dola_address::convert_pool_to_dola<T0>();
        let v2 = 0x826915f8ca6d11597dfe6599b8aa02a4c08bd8d39674855254a06ee83fe7220e::wormhole_adapter_pool::get_nonce(arg1);
        let (v3, v4) = 0x826915f8ca6d11597dfe6599b8aa02a4c08bd8d39674855254a06ee83fe7220e::wormhole_adapter_pool::get_relay_fee_amount(arg2, arg1, v2, arg6, arg8);
        0x826915f8ca6d11597dfe6599b8aa02a4c08bd8d39674855254a06ee83fe7220e::wormhole_adapter_pool::emit_relay_event(0x826915f8ca6d11597dfe6599b8aa02a4c08bd8d39674855254a06ee83fe7220e::wormhole_adapter_pool::send_deposit<T0>(arg1, arg2, v3, arg3, 0x826915f8ca6d11597dfe6599b8aa02a4c08bd8d39674855254a06ee83fe7220e::merge_coins::merge_coin<T0>(arg4, arg5, arg8), 1, 0x826915f8ca6d11597dfe6599b8aa02a4c08bd8d39674855254a06ee83fe7220e::lending_codec::encode_deposit_payload(0x826915f8ca6d11597dfe6599b8aa02a4c08bd8d39674855254a06ee83fe7220e::dola_address::get_native_dola_chain_id(), v2, v0, 0x826915f8ca6d11597dfe6599b8aa02a4c08bd8d39674855254a06ee83fe7220e::lending_codec::get_sponsor_type()), arg7, arg8), v2, v4, 1, 0x826915f8ca6d11597dfe6599b8aa02a4c08bd8d39674855254a06ee83fe7220e::lending_codec::get_sponsor_type());
        let v5 = LendingPortalEvent{
            nonce             : v2,
            sender            : 0x2::tx_context::sender(arg8),
            dola_pool_address : 0x826915f8ca6d11597dfe6599b8aa02a4c08bd8d39674855254a06ee83fe7220e::dola_address::get_dola_address(&v1),
            source_chain_id   : 0x826915f8ca6d11597dfe6599b8aa02a4c08bd8d39674855254a06ee83fe7220e::dola_address::get_native_dola_chain_id(),
            dst_chain_id      : 0x826915f8ca6d11597dfe6599b8aa02a4c08bd8d39674855254a06ee83fe7220e::dola_address::get_native_dola_chain_id(),
            receiver          : 0x826915f8ca6d11597dfe6599b8aa02a4c08bd8d39674855254a06ee83fe7220e::dola_address::get_dola_address(&v0),
            amount            : arg5,
            call_type         : 0x826915f8ca6d11597dfe6599b8aa02a4c08bd8d39674855254a06ee83fe7220e::lending_codec::get_sponsor_type(),
        };
        0x2::event::emit<LendingPortalEvent>(v5);
    }

    entry fun supply<T0>(arg0: &0x826915f8ca6d11597dfe6599b8aa02a4c08bd8d39674855254a06ee83fe7220e::genesis::GovernanceGenesis, arg1: &mut 0x826915f8ca6d11597dfe6599b8aa02a4c08bd8d39674855254a06ee83fe7220e::wormhole_adapter_pool::PoolState, arg2: &mut 0x5306f64e312b581766351c07af79c72fcb1cd25147157fdc2f8ad76de9a3fb6a::state::State, arg3: &mut 0x826915f8ca6d11597dfe6599b8aa02a4c08bd8d39674855254a06ee83fe7220e::dola_pool::Pool<T0>, arg4: vector<0x2::coin::Coin<T0>>, arg5: u64, arg6: 0x2::coin::Coin<0x2::sui::SUI>, arg7: &0x2::clock::Clock, arg8: &mut 0x2::tx_context::TxContext) {
        0x826915f8ca6d11597dfe6599b8aa02a4c08bd8d39674855254a06ee83fe7220e::genesis::check_latest_version(arg0);
        assert!(arg5 > 0, 0);
        let v0 = 0x826915f8ca6d11597dfe6599b8aa02a4c08bd8d39674855254a06ee83fe7220e::dola_address::convert_address_to_dola(0x2::tx_context::sender(arg8));
        let v1 = 0x826915f8ca6d11597dfe6599b8aa02a4c08bd8d39674855254a06ee83fe7220e::dola_address::convert_pool_to_dola<T0>();
        let v2 = 0x826915f8ca6d11597dfe6599b8aa02a4c08bd8d39674855254a06ee83fe7220e::wormhole_adapter_pool::get_nonce(arg1);
        let (v3, v4) = 0x826915f8ca6d11597dfe6599b8aa02a4c08bd8d39674855254a06ee83fe7220e::wormhole_adapter_pool::get_relay_fee_amount(arg2, arg1, v2, arg6, arg8);
        0x826915f8ca6d11597dfe6599b8aa02a4c08bd8d39674855254a06ee83fe7220e::wormhole_adapter_pool::emit_relay_event(0x826915f8ca6d11597dfe6599b8aa02a4c08bd8d39674855254a06ee83fe7220e::wormhole_adapter_pool::send_deposit<T0>(arg1, arg2, v3, arg3, 0x826915f8ca6d11597dfe6599b8aa02a4c08bd8d39674855254a06ee83fe7220e::merge_coins::merge_coin<T0>(arg4, arg5, arg8), 1, 0x826915f8ca6d11597dfe6599b8aa02a4c08bd8d39674855254a06ee83fe7220e::lending_codec::encode_deposit_payload(0x826915f8ca6d11597dfe6599b8aa02a4c08bd8d39674855254a06ee83fe7220e::dola_address::get_native_dola_chain_id(), v2, v0, 0x826915f8ca6d11597dfe6599b8aa02a4c08bd8d39674855254a06ee83fe7220e::lending_codec::get_supply_type()), arg7, arg8), v2, v4, 1, 0x826915f8ca6d11597dfe6599b8aa02a4c08bd8d39674855254a06ee83fe7220e::lending_codec::get_supply_type());
        let v5 = LendingPortalEvent{
            nonce             : v2,
            sender            : 0x2::tx_context::sender(arg8),
            dola_pool_address : 0x826915f8ca6d11597dfe6599b8aa02a4c08bd8d39674855254a06ee83fe7220e::dola_address::get_dola_address(&v1),
            source_chain_id   : 0x826915f8ca6d11597dfe6599b8aa02a4c08bd8d39674855254a06ee83fe7220e::dola_address::get_native_dola_chain_id(),
            dst_chain_id      : 0x826915f8ca6d11597dfe6599b8aa02a4c08bd8d39674855254a06ee83fe7220e::dola_address::get_native_dola_chain_id(),
            receiver          : 0x826915f8ca6d11597dfe6599b8aa02a4c08bd8d39674855254a06ee83fe7220e::dola_address::get_dola_address(&v0),
            amount            : arg5,
            call_type         : 0x826915f8ca6d11597dfe6599b8aa02a4c08bd8d39674855254a06ee83fe7220e::lending_codec::get_supply_type(),
        };
        0x2::event::emit<LendingPortalEvent>(v5);
    }

    entry fun withdraw(arg0: &0x826915f8ca6d11597dfe6599b8aa02a4c08bd8d39674855254a06ee83fe7220e::genesis::GovernanceGenesis, arg1: &mut 0x826915f8ca6d11597dfe6599b8aa02a4c08bd8d39674855254a06ee83fe7220e::wormhole_adapter_pool::PoolState, arg2: &mut 0x5306f64e312b581766351c07af79c72fcb1cd25147157fdc2f8ad76de9a3fb6a::state::State, arg3: u16, arg4: vector<u8>, arg5: vector<u8>, arg6: u64, arg7: 0x2::coin::Coin<0x2::sui::SUI>, arg8: &0x2::clock::Clock, arg9: &mut 0x2::tx_context::TxContext) {
        0x826915f8ca6d11597dfe6599b8aa02a4c08bd8d39674855254a06ee83fe7220e::genesis::check_latest_version(arg0);
        let v0 = 0x826915f8ca6d11597dfe6599b8aa02a4c08bd8d39674855254a06ee83fe7220e::wormhole_adapter_pool::get_nonce(arg1);
        let (v1, v2) = 0x826915f8ca6d11597dfe6599b8aa02a4c08bd8d39674855254a06ee83fe7220e::wormhole_adapter_pool::get_relay_fee_amount(arg2, arg1, v0, arg7, arg9);
        0x826915f8ca6d11597dfe6599b8aa02a4c08bd8d39674855254a06ee83fe7220e::wormhole_adapter_pool::emit_relay_event(0x826915f8ca6d11597dfe6599b8aa02a4c08bd8d39674855254a06ee83fe7220e::wormhole_adapter_pool::send_message(arg1, arg2, v1, 1, 0x826915f8ca6d11597dfe6599b8aa02a4c08bd8d39674855254a06ee83fe7220e::lending_codec::encode_withdraw_payload(arg3, v0, arg6, 0x826915f8ca6d11597dfe6599b8aa02a4c08bd8d39674855254a06ee83fe7220e::dola_address::create_dola_address(arg3, arg4), 0x826915f8ca6d11597dfe6599b8aa02a4c08bd8d39674855254a06ee83fe7220e::dola_address::create_dola_address(arg3, arg5), 0x826915f8ca6d11597dfe6599b8aa02a4c08bd8d39674855254a06ee83fe7220e::lending_codec::get_withdraw_type()), arg8, arg9), v0, v2, 1, 0x826915f8ca6d11597dfe6599b8aa02a4c08bd8d39674855254a06ee83fe7220e::lending_codec::get_withdraw_type());
        let v3 = LendingPortalEvent{
            nonce             : v0,
            sender            : 0x2::tx_context::sender(arg9),
            dola_pool_address : arg4,
            source_chain_id   : 0x826915f8ca6d11597dfe6599b8aa02a4c08bd8d39674855254a06ee83fe7220e::dola_address::get_native_dola_chain_id(),
            dst_chain_id      : arg3,
            receiver          : arg5,
            amount            : arg6,
            call_type         : 0x826915f8ca6d11597dfe6599b8aa02a4c08bd8d39674855254a06ee83fe7220e::lending_codec::get_withdraw_type(),
        };
        0x2::event::emit<LendingPortalEvent>(v3);
    }

    // decompiled from Move bytecode v6
}

