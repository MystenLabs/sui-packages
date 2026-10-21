module 0x1d2e4a268caf2c9a6cca996f9dfb5590b02628e8da5d5c92de89b386a3770af1::receive {
    struct BridgeReceived has copy, drop {
        cctp_nonce: u256,
        cctp_source_domain: u32,
        message_sender: address,
        local_token: address,
        amount: u64,
        fee_executed: u64,
        payload_type: u8,
        addr_dest: address,
        gas_drop: u64,
        fee_redeem: u64,
        addr_ref: address,
        fee_rate_ref: u8,
        custom_payload_hash: address,
    }

    struct OrderRegistered has copy, drop {
        cctp_nonce: u256,
        cctp_source_domain: u32,
        message_sender: address,
        local_token: address,
        amount: u64,
        fee_executed: u64,
        payload_type: u8,
        addr_dest: address,
        token_out: address,
        amount_out_min: u64,
        gas_drop: u64,
        fee_redeem: u64,
        fee_refund: u64,
        deadline: u64,
        addr_ref: address,
        fee_rate_ref: u8,
    }

    struct ReceiveRequest {
        cctp_nonce: u256,
        cctp_source_domain: u32,
        message_sender: address,
        local_token: address,
        mint_recipient: address,
        amount: u64,
        fee_executed: u64,
        payload_type: u8,
        hook_data: vector<u8>,
        bound: bool,
    }

    public fun begin_receive(arg0: &0x1d2e4a268caf2c9a6cca996f9dfb5590b02628e8da5d5c92de89b386a3770af1::state::State, arg1: &0x1d2e4a268caf2c9a6cca996f9dfb5590b02628e8da5d5c92de89b386a3770af1::state::FundsReceiver, arg2: &0xeb14978abfe93a37c5d5bf86a0623b923553a5f0e794daac7724f1e2fdbfb830::state::State, arg3: vector<u8>, arg4: vector<u8>) : (0x16bcfcfc465f96281663a344641c017de84529370e11aa3879d0dce43ad6db87::receive_message::ReceiveMessageTicket<0x1d2e4a268caf2c9a6cca996f9dfb5590b02628e8da5d5c92de89b386a3770af1::circle_auth::CircleAuth>, ReceiveRequest) {
        0x1d2e4a268caf2c9a6cca996f9dfb5590b02628e8da5d5c92de89b386a3770af1::state::assert_valid_version(arg0);
        let v0 = 0x1d2e4a268caf2c9a6cca996f9dfb5590b02628e8da5d5c92de89b386a3770af1::cctp_message::from_bytes(&arg3);
        assert!(0x1d2e4a268caf2c9a6cca996f9dfb5590b02628e8da5d5c92de89b386a3770af1::cctp_message::destination_caller(&v0) == 0x1d2e4a268caf2c9a6cca996f9dfb5590b02628e8da5d5c92de89b386a3770af1::circle_auth::identifier(), 0);
        assert!(0x1d2e4a268caf2c9a6cca996f9dfb5590b02628e8da5d5c92de89b386a3770af1::cctp_message::recipient(&v0) == 0x16bcfcfc465f96281663a344641c017de84529370e11aa3879d0dce43ad6db87::auth::auth_caller_identifier<0xeb14978abfe93a37c5d5bf86a0623b923553a5f0e794daac7724f1e2fdbfb830::message_transmitter_authenticator::MessageTransmitterAuthenticator>(), 1);
        let v1 = 0x2::object::id<0x1d2e4a268caf2c9a6cca996f9dfb5590b02628e8da5d5c92de89b386a3770af1::state::FundsReceiver>(arg1);
        let v2 = 0x2::object::id_to_address(&v1);
        assert!(0x1d2e4a268caf2c9a6cca996f9dfb5590b02628e8da5d5c92de89b386a3770af1::cctp_message::mint_recipient(&v0) == v2, 2);
        let v3 = 0x1d2e4a268caf2c9a6cca996f9dfb5590b02628e8da5d5c92de89b386a3770af1::cctp_message::hook_data(&v0);
        let v4 = 0x1d2e4a268caf2c9a6cca996f9dfb5590b02628e8da5d5c92de89b386a3770af1::cctp_message::source_domain(&v0);
        let v5 = 0x1d2e4a268caf2c9a6cca996f9dfb5590b02628e8da5d5c92de89b386a3770af1::cctp_message::burn_token(&v0);
        assert!(0xeb14978abfe93a37c5d5bf86a0623b923553a5f0e794daac7724f1e2fdbfb830::state::local_token_from_remote_token_exists(arg2, v4, v5), 8);
        let v6 = ReceiveRequest{
            cctp_nonce         : 0x1d2e4a268caf2c9a6cca996f9dfb5590b02628e8da5d5c92de89b386a3770af1::cctp_message::nonce(&v0),
            cctp_source_domain : v4,
            message_sender     : 0x1d2e4a268caf2c9a6cca996f9dfb5590b02628e8da5d5c92de89b386a3770af1::cctp_message::message_sender(&v0),
            local_token        : 0xeb14978abfe93a37c5d5bf86a0623b923553a5f0e794daac7724f1e2fdbfb830::state::local_token_from_remote_token(arg2, v4, v5),
            mint_recipient     : v2,
            amount             : 0x1d2e4a268caf2c9a6cca996f9dfb5590b02628e8da5d5c92de89b386a3770af1::cctp_message::amount_net(&v0),
            fee_executed       : 0x1d2e4a268caf2c9a6cca996f9dfb5590b02628e8da5d5c92de89b386a3770af1::cctp_message::fee_executed(&v0),
            payload_type       : validate_hook_data(&v3),
            hook_data          : v3,
            bound              : false,
        };
        (0x16bcfcfc465f96281663a344641c017de84529370e11aa3879d0dce43ad6db87::receive_message::create_receive_message_ticket<0x1d2e4a268caf2c9a6cca996f9dfb5590b02628e8da5d5c92de89b386a3770af1::circle_auth::CircleAuth>(0x1d2e4a268caf2c9a6cca996f9dfb5590b02628e8da5d5c92de89b386a3770af1::circle_auth::new(), arg3, arg4), v6)
    }

    public fun bind_receipt(arg0: &mut ReceiveRequest, arg1: &0x16bcfcfc465f96281663a344641c017de84529370e11aa3879d0dce43ad6db87::receive_message::Receipt) {
        assert!(!arg0.bound, 4);
        assert!(0x16bcfcfc465f96281663a344641c017de84529370e11aa3879d0dce43ad6db87::receive_message::nonce(arg1) == arg0.cctp_nonce, 5);
        assert!(0x16bcfcfc465f96281663a344641c017de84529370e11aa3879d0dce43ad6db87::receive_message::source_domain(arg1) == arg0.cctp_source_domain, 5);
        assert!(0x16bcfcfc465f96281663a344641c017de84529370e11aa3879d0dce43ad6db87::receive_message::caller(arg1) == 0x1d2e4a268caf2c9a6cca996f9dfb5590b02628e8da5d5c92de89b386a3770af1::circle_auth::identifier(), 5);
        arg0.bound = true;
    }

    public fun get_receive_request_amount(arg0: &ReceiveRequest) : u64 {
        arg0.amount
    }

    public fun get_receive_request_local_token(arg0: &ReceiveRequest) : address {
        arg0.local_token
    }

    public fun get_receive_request_nonce(arg0: &ReceiveRequest) : u256 {
        arg0.cctp_nonce
    }

    public fun get_receive_request_payload_type(arg0: &ReceiveRequest) : u8 {
        arg0.payload_type
    }

    public fun get_receive_request_source_domain(arg0: &ReceiveRequest) : u32 {
        arg0.cctp_source_domain
    }

    public fun settle<T0: drop>(arg0: &mut 0x1d2e4a268caf2c9a6cca996f9dfb5590b02628e8da5d5c92de89b386a3770af1::state::State, arg1: ReceiveRequest, arg2: &0xeb14978abfe93a37c5d5bf86a0623b923553a5f0e794daac7724f1e2fdbfb830::handle_receive_message::MintReceipt<T0>) {
        0x1d2e4a268caf2c9a6cca996f9dfb5590b02628e8da5d5c92de89b386a3770af1::state::assert_valid_version(arg0);
        let ReceiveRequest {
            cctp_nonce         : v0,
            cctp_source_domain : v1,
            message_sender     : v2,
            local_token        : v3,
            mint_recipient     : v4,
            amount             : v5,
            fee_executed       : v6,
            payload_type       : v7,
            hook_data          : v8,
            bound              : v9,
        } = arg1;
        let v10 = v8;
        assert!(v9, 6);
        let (v11, v12, v13, v14) = 0xeb14978abfe93a37c5d5bf86a0623b923553a5f0e794daac7724f1e2fdbfb830::handle_receive_message::get_mint_details<T0>(arg2);
        assert!(v11 == 0xeb14978abfe93a37c5d5bf86a0623b923553a5f0e794daac7724f1e2fdbfb830::token_utils::calculate_token_id<T0>(), 7);
        assert!(v11 == v3, 9);
        assert!(v12 == v4, 7);
        assert!(v13 == v5, 7);
        assert!(v14 == v6, 7);
        if (0x1d2e4a268caf2c9a6cca996f9dfb5590b02628e8da5d5c92de89b386a3770af1::bridge_payload::is_bridge_payload_type(v7)) {
            let v15 = 0x1d2e4a268caf2c9a6cca996f9dfb5590b02628e8da5d5c92de89b386a3770af1::bridge_payload::from_bytes(&v10);
            0x1d2e4a268caf2c9a6cca996f9dfb5590b02628e8da5d5c92de89b386a3770af1::state::add_pending_bridge(arg0, v0, v1, v2, v11, v5, v15);
            let v16 = BridgeReceived{
                cctp_nonce          : v0,
                cctp_source_domain  : v1,
                message_sender      : v2,
                local_token         : v11,
                amount              : v5,
                fee_executed        : v6,
                payload_type        : v7,
                addr_dest           : 0x1d2e4a268caf2c9a6cca996f9dfb5590b02628e8da5d5c92de89b386a3770af1::bridge_payload::addr_dest(&v15),
                gas_drop            : 0x1d2e4a268caf2c9a6cca996f9dfb5590b02628e8da5d5c92de89b386a3770af1::bridge_payload::gas_drop(&v15),
                fee_redeem          : 0x1d2e4a268caf2c9a6cca996f9dfb5590b02628e8da5d5c92de89b386a3770af1::bridge_payload::fee_redeem(&v15),
                addr_ref            : 0x1d2e4a268caf2c9a6cca996f9dfb5590b02628e8da5d5c92de89b386a3770af1::bridge_payload::addr_ref(&v15),
                fee_rate_ref        : 0x1d2e4a268caf2c9a6cca996f9dfb5590b02628e8da5d5c92de89b386a3770af1::bridge_payload::fee_rate_ref(&v15),
                custom_payload_hash : 0x1d2e4a268caf2c9a6cca996f9dfb5590b02628e8da5d5c92de89b386a3770af1::bridge_payload::custom_payload_hash(&v15),
            };
            0x2::event::emit<BridgeReceived>(v16);
        } else {
            let v17 = 0x1d2e4a268caf2c9a6cca996f9dfb5590b02628e8da5d5c92de89b386a3770af1::order_payload::from_bytes(&v10);
            0x1d2e4a268caf2c9a6cca996f9dfb5590b02628e8da5d5c92de89b386a3770af1::state::add_pending_order(arg0, v0, v1, v2, v11, v5, v17);
            let v18 = OrderRegistered{
                cctp_nonce         : v0,
                cctp_source_domain : v1,
                message_sender     : v2,
                local_token        : v11,
                amount             : v5,
                fee_executed       : v6,
                payload_type       : v7,
                addr_dest          : 0x1d2e4a268caf2c9a6cca996f9dfb5590b02628e8da5d5c92de89b386a3770af1::order_payload::addr_dest(&v17),
                token_out          : 0x1d2e4a268caf2c9a6cca996f9dfb5590b02628e8da5d5c92de89b386a3770af1::order_payload::token_out(&v17),
                amount_out_min     : 0x1d2e4a268caf2c9a6cca996f9dfb5590b02628e8da5d5c92de89b386a3770af1::order_payload::amount_out_min(&v17),
                gas_drop           : 0x1d2e4a268caf2c9a6cca996f9dfb5590b02628e8da5d5c92de89b386a3770af1::order_payload::gas_drop(&v17),
                fee_redeem         : 0x1d2e4a268caf2c9a6cca996f9dfb5590b02628e8da5d5c92de89b386a3770af1::order_payload::fee_redeem(&v17),
                fee_refund         : 0x1d2e4a268caf2c9a6cca996f9dfb5590b02628e8da5d5c92de89b386a3770af1::order_payload::fee_refund(&v17),
                deadline           : 0x1d2e4a268caf2c9a6cca996f9dfb5590b02628e8da5d5c92de89b386a3770af1::order_payload::deadline(&v17),
                addr_ref           : 0x1d2e4a268caf2c9a6cca996f9dfb5590b02628e8da5d5c92de89b386a3770af1::order_payload::addr_ref(&v17),
                fee_rate_ref       : 0x1d2e4a268caf2c9a6cca996f9dfb5590b02628e8da5d5c92de89b386a3770af1::order_payload::fee_rate_ref(&v17),
            };
            0x2::event::emit<OrderRegistered>(v18);
        };
    }

    fun validate_hook_data(arg0: &vector<u8>) : u8 {
        assert!(0x1::vector::length<u8>(arg0) > 0, 3);
        let v0 = *0x1::vector::borrow<u8>(arg0, 0);
        if (0x1d2e4a268caf2c9a6cca996f9dfb5590b02628e8da5d5c92de89b386a3770af1::bridge_payload::is_bridge_payload_type(v0)) {
            0x1d2e4a268caf2c9a6cca996f9dfb5590b02628e8da5d5c92de89b386a3770af1::bridge_payload::from_bytes(arg0);
        } else {
            assert!(0x1d2e4a268caf2c9a6cca996f9dfb5590b02628e8da5d5c92de89b386a3770af1::order_payload::is_order_payload_type(v0), 3);
            0x1d2e4a268caf2c9a6cca996f9dfb5590b02628e8da5d5c92de89b386a3770af1::order_payload::from_bytes(arg0);
        };
        v0
    }

    // decompiled from Move bytecode v7
}

