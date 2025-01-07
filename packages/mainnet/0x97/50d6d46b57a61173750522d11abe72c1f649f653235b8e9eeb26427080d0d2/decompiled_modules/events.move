module 0x9750d6d46b57a61173750522d11abe72c1f649f653235b8e9eeb26427080d0d2::events {
    struct ISendEvent has copy, drop {
        version: u128,
        route_amount: u256,
        event_nonce: u256,
        request_sender: vector<u8>,
        src_chain_id: 0x1::string::String,
        dest_chain_id: 0x1::string::String,
        route_recipient: 0x1::string::String,
        request_metadata: vector<u8>,
        request_packet: vector<u8>,
    }

    struct ValsetUpdatedEvent has copy, drop {
        new_valset_nonce: u256,
        event_nonce: u256,
        src_chain_id: 0x1::string::String,
        validators: vector<vector<u8>>,
        powers: vector<u64>,
    }

    struct SetDappMetadataEvent has copy, drop {
        event_nonce: u256,
        dapp_address: vector<u8>,
        chain_id: 0x1::string::String,
        fee_payer_address: 0x1::string::String,
    }

    struct IReceiveEvent has copy, drop {
        request_identifier: u256,
        event_nonce: u256,
        src_chain_id: 0x1::string::String,
        dest_chain_id: 0x1::string::String,
        relayer_router_address: 0x1::string::String,
        request_sender: 0x1::string::String,
        exec_data: vector<u8>,
        exec_status: bool,
    }

    struct IAckEvent has copy, drop {
        ack_request_identifier: u256,
        ack_src_chain_id: 0x1::string::String,
        event_nonce: u256,
        request_identifier: u256,
        relayer_router_address: 0x1::string::String,
        chain_id: 0x1::string::String,
        data: vector<u8>,
        success: bool,
    }

    struct BridgeFeeUpdatedEvent has copy, drop {
        old_fee: u64,
        new_fee: u64,
    }

    struct SetVersionEvent has copy, drop {
        new_version: u128,
    }

    struct Paused has copy, drop {
        dummy_field: bool,
    }

    struct UnPausedEvent has copy, drop {
        dummy_field: bool,
    }

    struct SetChainIdEvent has copy, drop {
        chain_id: 0x1::string::String,
    }

    struct GrantRoleEvent has copy, drop {
        role_type: u8,
        to: address,
    }

    struct RenounceRoleEvent has copy, drop {
        role_type: u8,
    }

    struct TransferRouteTrasuryEvent has copy, drop {
        id: address,
        recipient: address,
    }

    struct SetRouteTrasuryEvent has copy, drop {
        id: address,
    }

    public(friend) fun emit_bridge_fee_updated_event(arg0: u64, arg1: u64) {
        let v0 = BridgeFeeUpdatedEvent{
            old_fee : arg0,
            new_fee : arg1,
        };
        0x2::event::emit<BridgeFeeUpdatedEvent>(v0);
    }

    public(friend) fun emit_grant_role_event(arg0: u8, arg1: address) {
        let v0 = GrantRoleEvent{
            role_type : arg0,
            to        : arg1,
        };
        0x2::event::emit<GrantRoleEvent>(v0);
    }

    public(friend) fun emit_i_ack_event(arg0: u256, arg1: 0x1::string::String, arg2: u256, arg3: u256, arg4: 0x1::string::String, arg5: 0x1::string::String, arg6: vector<u8>, arg7: bool) {
        let v0 = IAckEvent{
            ack_request_identifier : arg0,
            ack_src_chain_id       : arg1,
            event_nonce            : arg2,
            request_identifier     : arg3,
            relayer_router_address : arg4,
            chain_id               : arg5,
            data                   : arg6,
            success                : arg7,
        };
        0x2::event::emit<IAckEvent>(v0);
    }

    public(friend) fun emit_i_receive_event(arg0: u256, arg1: u256, arg2: 0x1::string::String, arg3: 0x1::string::String, arg4: 0x1::string::String, arg5: 0x1::string::String, arg6: vector<u8>, arg7: bool) {
        let v0 = IReceiveEvent{
            request_identifier     : arg0,
            event_nonce            : arg1,
            src_chain_id           : arg2,
            dest_chain_id          : arg3,
            relayer_router_address : arg4,
            request_sender         : arg5,
            exec_data              : arg6,
            exec_status            : arg7,
        };
        0x2::event::emit<IReceiveEvent>(v0);
    }

    public(friend) fun emit_i_send_event(arg0: u128, arg1: u256, arg2: u256, arg3: vector<u8>, arg4: 0x1::string::String, arg5: 0x1::string::String, arg6: 0x1::string::String, arg7: vector<u8>, arg8: vector<u8>) {
        let v0 = ISendEvent{
            version          : arg0,
            route_amount     : arg1,
            event_nonce      : arg2,
            request_sender   : arg3,
            src_chain_id     : arg4,
            dest_chain_id    : arg5,
            route_recipient  : arg6,
            request_metadata : arg7,
            request_packet   : arg8,
        };
        0x2::event::emit<ISendEvent>(v0);
    }

    public(friend) fun emit_paused_event() {
        let v0 = Paused{dummy_field: false};
        0x2::event::emit<Paused>(v0);
    }

    public(friend) fun emit_renounce_role_event(arg0: u8) {
        let v0 = RenounceRoleEvent{role_type: arg0};
        0x2::event::emit<RenounceRoleEvent>(v0);
    }

    public(friend) fun emit_set_chain_id_event(arg0: 0x1::string::String) {
        let v0 = SetChainIdEvent{chain_id: arg0};
        0x2::event::emit<SetChainIdEvent>(v0);
    }

    public(friend) fun emit_set_dapp_metadata_event(arg0: u256, arg1: vector<u8>, arg2: 0x1::string::String, arg3: 0x1::string::String) {
        let v0 = SetDappMetadataEvent{
            event_nonce       : arg0,
            dapp_address      : arg1,
            chain_id          : arg2,
            fee_payer_address : arg3,
        };
        0x2::event::emit<SetDappMetadataEvent>(v0);
    }

    public(friend) fun emit_set_route_treasury_event(arg0: address) {
        let v0 = SetRouteTrasuryEvent{id: arg0};
        0x2::event::emit<SetRouteTrasuryEvent>(v0);
    }

    public(friend) fun emit_set_version_event(arg0: u128) {
        let v0 = SetVersionEvent{new_version: arg0};
        0x2::event::emit<SetVersionEvent>(v0);
    }

    public(friend) fun emit_trasfer_route_treasury_event(arg0: address, arg1: address) {
        let v0 = TransferRouteTrasuryEvent{
            id        : arg0,
            recipient : arg1,
        };
        0x2::event::emit<TransferRouteTrasuryEvent>(v0);
    }

    public(friend) fun emit_unpaused_event() {
        let v0 = UnPausedEvent{dummy_field: false};
        0x2::event::emit<UnPausedEvent>(v0);
    }

    public(friend) fun emit_valset_update_event(arg0: u256, arg1: 0x1::string::String, arg2: &0x9750d6d46b57a61173750522d11abe72c1f649f653235b8e9eeb26427080d0d2::types::ValsetArgs) {
        let v0 = ValsetUpdatedEvent{
            new_valset_nonce : 0x9750d6d46b57a61173750522d11abe72c1f649f653235b8e9eeb26427080d0d2::types::valset_nonce(arg2),
            event_nonce      : arg0,
            src_chain_id     : arg1,
            validators       : 0x9750d6d46b57a61173750522d11abe72c1f649f653235b8e9eeb26427080d0d2::types::validators(arg2),
            powers           : 0x9750d6d46b57a61173750522d11abe72c1f649f653235b8e9eeb26427080d0d2::types::powers(arg2),
        };
        0x2::event::emit<ValsetUpdatedEvent>(v0);
    }

    // decompiled from Move bytecode v6
}

