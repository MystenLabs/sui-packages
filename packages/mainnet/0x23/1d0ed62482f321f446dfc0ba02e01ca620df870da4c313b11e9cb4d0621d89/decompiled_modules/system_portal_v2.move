module 0x231d0ed62482f321f446dfc0ba02e01ca620df870da4c313b11e9cb4d0621d89::system_portal_v2 {
    struct SystemPortalEvent has copy, drop {
        nonce: u64,
        sender: address,
        user_chain_id: u16,
        user_address: vector<u8>,
        call_type: u8,
    }

    entry fun binding(arg0: &0x231d0ed62482f321f446dfc0ba02e01ca620df870da4c313b11e9cb4d0621d89::genesis::GovernanceGenesis, arg1: &mut 0x231d0ed62482f321f446dfc0ba02e01ca620df870da4c313b11e9cb4d0621d89::wormhole_adapter_pool::PoolState, arg2: &mut 0x5306f64e312b581766351c07af79c72fcb1cd25147157fdc2f8ad76de9a3fb6a::state::State, arg3: u16, arg4: vector<u8>, arg5: 0x2::coin::Coin<0x2::sui::SUI>, arg6: &0x2::clock::Clock, arg7: &mut 0x2::tx_context::TxContext) {
        0x231d0ed62482f321f446dfc0ba02e01ca620df870da4c313b11e9cb4d0621d89::genesis::check_latest_version(arg0);
        let v0 = 0x231d0ed62482f321f446dfc0ba02e01ca620df870da4c313b11e9cb4d0621d89::wormhole_adapter_pool::get_nonce(arg1);
        let (v1, v2) = 0x231d0ed62482f321f446dfc0ba02e01ca620df870da4c313b11e9cb4d0621d89::wormhole_adapter_pool::get_relay_fee_amount(arg2, arg1, v0, arg5, arg7);
        0x231d0ed62482f321f446dfc0ba02e01ca620df870da4c313b11e9cb4d0621d89::wormhole_adapter_pool::emit_relay_event(0x231d0ed62482f321f446dfc0ba02e01ca620df870da4c313b11e9cb4d0621d89::wormhole_adapter_pool::send_message(arg1, arg2, v1, 0, 0x231d0ed62482f321f446dfc0ba02e01ca620df870da4c313b11e9cb4d0621d89::system_codec::encode_bind_payload(0x231d0ed62482f321f446dfc0ba02e01ca620df870da4c313b11e9cb4d0621d89::dola_address::get_native_dola_chain_id(), v0, 0x231d0ed62482f321f446dfc0ba02e01ca620df870da4c313b11e9cb4d0621d89::dola_address::create_dola_address(arg3, arg4), 0x231d0ed62482f321f446dfc0ba02e01ca620df870da4c313b11e9cb4d0621d89::system_codec::get_binding_type()), arg6, arg7), v0, v2, 0, 0x231d0ed62482f321f446dfc0ba02e01ca620df870da4c313b11e9cb4d0621d89::system_codec::get_binding_type());
        let v3 = SystemPortalEvent{
            nonce         : v0,
            sender        : 0x2::tx_context::sender(arg7),
            user_chain_id : arg3,
            user_address  : arg4,
            call_type     : 0x231d0ed62482f321f446dfc0ba02e01ca620df870da4c313b11e9cb4d0621d89::system_codec::get_binding_type(),
        };
        0x2::event::emit<SystemPortalEvent>(v3);
    }

    entry fun unbinding(arg0: &0x231d0ed62482f321f446dfc0ba02e01ca620df870da4c313b11e9cb4d0621d89::genesis::GovernanceGenesis, arg1: &mut 0x231d0ed62482f321f446dfc0ba02e01ca620df870da4c313b11e9cb4d0621d89::wormhole_adapter_pool::PoolState, arg2: &mut 0x5306f64e312b581766351c07af79c72fcb1cd25147157fdc2f8ad76de9a3fb6a::state::State, arg3: u16, arg4: vector<u8>, arg5: 0x2::coin::Coin<0x2::sui::SUI>, arg6: &0x2::clock::Clock, arg7: &mut 0x2::tx_context::TxContext) {
        0x231d0ed62482f321f446dfc0ba02e01ca620df870da4c313b11e9cb4d0621d89::genesis::check_latest_version(arg0);
        let v0 = 0x231d0ed62482f321f446dfc0ba02e01ca620df870da4c313b11e9cb4d0621d89::wormhole_adapter_pool::get_nonce(arg1);
        let (v1, v2) = 0x231d0ed62482f321f446dfc0ba02e01ca620df870da4c313b11e9cb4d0621d89::wormhole_adapter_pool::get_relay_fee_amount(arg2, arg1, v0, arg5, arg7);
        0x231d0ed62482f321f446dfc0ba02e01ca620df870da4c313b11e9cb4d0621d89::wormhole_adapter_pool::emit_relay_event(0x231d0ed62482f321f446dfc0ba02e01ca620df870da4c313b11e9cb4d0621d89::wormhole_adapter_pool::send_message(arg1, arg2, v1, 0, 0x231d0ed62482f321f446dfc0ba02e01ca620df870da4c313b11e9cb4d0621d89::system_codec::encode_bind_payload(0x231d0ed62482f321f446dfc0ba02e01ca620df870da4c313b11e9cb4d0621d89::dola_address::get_native_dola_chain_id(), v0, 0x231d0ed62482f321f446dfc0ba02e01ca620df870da4c313b11e9cb4d0621d89::dola_address::create_dola_address(arg3, arg4), 0x231d0ed62482f321f446dfc0ba02e01ca620df870da4c313b11e9cb4d0621d89::system_codec::get_unbinding_type()), arg6, arg7), v0, v2, 0, 0x231d0ed62482f321f446dfc0ba02e01ca620df870da4c313b11e9cb4d0621d89::system_codec::get_unbinding_type());
        let v3 = SystemPortalEvent{
            nonce         : v0,
            sender        : 0x2::tx_context::sender(arg7),
            user_chain_id : arg3,
            user_address  : arg4,
            call_type     : 0x231d0ed62482f321f446dfc0ba02e01ca620df870da4c313b11e9cb4d0621d89::system_codec::get_unbinding_type(),
        };
        0x2::event::emit<SystemPortalEvent>(v3);
    }

    // decompiled from Move bytecode v6
}

