module 0x2966e887323884088fc606cd195cdb2f97199f15896910222cd39d0d10eb2d92::events {
    struct FundsDeposited has copy, drop {
        partner_id: u128,
        amount: u64,
        dest_chain_id_bytes: vector<u8>,
        dest_amount: u256,
        deposit_id: u256,
        src_token: 0x1::string::String,
        recipient: vector<u8>,
        depositor: address,
        dest_token: vector<u8>,
    }

    struct FundsDepositedWithMessage has copy, drop {
        partner_id: u128,
        amount: u64,
        dest_chain_id_bytes: vector<u8>,
        dest_amount: u256,
        deposit_id: u256,
        src_token: 0x1::string::String,
        recipient: vector<u8>,
        depositor: address,
        dest_token: vector<u8>,
        message: vector<u8>,
    }

    struct FundsPaid has copy, drop {
        message_hash: vector<u8>,
        forwarder: address,
        nonce: u256,
        deposit_id: u256,
        src_chain_id: vector<u8>,
        dest_token: 0x1::string::String,
        dest_amount: u64,
        actual_amount: u64,
        forwarder_router_address: 0x1::string::String,
    }

    struct FundsPaidWithMessage has copy, drop {
        message_hash: vector<u8>,
        forwarder: address,
        nonce: u256,
        deposit_id: u256,
        src_chain_id: vector<u8>,
        dest_token: 0x1::string::String,
        dest_amount: u64,
        actual_amount: u64,
        exec_data: vector<u8>,
        exec_flag: bool,
        forwarder_router_address: 0x1::string::String,
    }

    struct DepositInfoUpdate has copy, drop {
        src_token: 0x1::string::String,
        fee_amount: u64,
        deposit_id: u256,
        event_nonce: u256,
        initiate_withdrawal: bool,
        depositor: address,
    }

    public(friend) fun emit_deposit_info_update_event(arg0: 0x1::string::String, arg1: u64, arg2: u256, arg3: u256, arg4: bool, arg5: address) {
        let v0 = DepositInfoUpdate{
            src_token           : arg0,
            fee_amount          : arg1,
            deposit_id          : arg2,
            event_nonce         : arg3,
            initiate_withdrawal : arg4,
            depositor           : arg5,
        };
        0x2::event::emit<DepositInfoUpdate>(v0);
    }

    public(friend) fun emit_funds_deposited_event(arg0: u128, arg1: u64, arg2: vector<u8>, arg3: u256, arg4: u256, arg5: 0x1::string::String, arg6: vector<u8>, arg7: address, arg8: vector<u8>) {
        let v0 = FundsDeposited{
            partner_id          : arg0,
            amount              : arg1,
            dest_chain_id_bytes : arg2,
            dest_amount         : arg3,
            deposit_id          : arg4,
            src_token           : arg5,
            recipient           : arg6,
            depositor           : arg7,
            dest_token          : arg8,
        };
        0x2::event::emit<FundsDeposited>(v0);
    }

    public(friend) fun emit_funds_deposited_with_message_event(arg0: u128, arg1: u64, arg2: vector<u8>, arg3: u256, arg4: u256, arg5: 0x1::string::String, arg6: vector<u8>, arg7: address, arg8: vector<u8>, arg9: vector<u8>) {
        let v0 = FundsDepositedWithMessage{
            partner_id          : arg0,
            amount              : arg1,
            dest_chain_id_bytes : arg2,
            dest_amount         : arg3,
            deposit_id          : arg4,
            src_token           : arg5,
            recipient           : arg6,
            depositor           : arg7,
            dest_token          : arg8,
            message             : arg9,
        };
        0x2::event::emit<FundsDepositedWithMessage>(v0);
    }

    public(friend) fun emit_funds_paid_event(arg0: vector<u8>, arg1: address, arg2: u256, arg3: u256, arg4: vector<u8>, arg5: 0x1::string::String, arg6: u64, arg7: u64, arg8: 0x1::string::String) {
        let v0 = FundsPaid{
            message_hash             : arg0,
            forwarder                : arg1,
            nonce                    : arg2,
            deposit_id               : arg3,
            src_chain_id             : arg4,
            dest_token               : arg5,
            dest_amount              : arg6,
            actual_amount            : arg7,
            forwarder_router_address : arg8,
        };
        0x2::event::emit<FundsPaid>(v0);
    }

    public(friend) fun emit_funds_paid_with_message_event(arg0: vector<u8>, arg1: address, arg2: u256, arg3: u256, arg4: vector<u8>, arg5: 0x1::string::String, arg6: u64, arg7: u64, arg8: vector<u8>, arg9: bool, arg10: 0x1::string::String) {
        let v0 = FundsPaidWithMessage{
            message_hash             : arg0,
            forwarder                : arg1,
            nonce                    : arg2,
            deposit_id               : arg3,
            src_chain_id             : arg4,
            dest_token               : arg5,
            dest_amount              : arg6,
            actual_amount            : arg7,
            exec_data                : arg8,
            exec_flag                : arg9,
            forwarder_router_address : arg10,
        };
        0x2::event::emit<FundsPaidWithMessage>(v0);
    }

    // decompiled from Move bytecode v6
}

