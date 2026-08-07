module 0xe70da5ac8e13225f8b4c12b6060dda15c2036612d476b0f76431fdc271d82ae::offramp_state_helper {
    struct OFFRAMP_STATE_HELPER has drop {
        dummy_field: bool,
    }

    struct ReceiverParams {
        token_transfer: 0x1::option::Option<DestTokenTransfer>,
        message: 0x1::option::Option<0xe70da5ac8e13225f8b4c12b6060dda15c2036612d476b0f76431fdc271d82ae::client::Any2SuiMessage>,
        source_chain_selector: u64,
        receipt: 0x1::option::Option<CompletedDestTokenTransfer>,
    }

    struct DestTransferCap has store, key {
        id: 0x2::object::UID,
    }

    struct CompletedDestTokenTransfer {
        token_receiver: address,
        dest_token_address: address,
    }

    struct DestTokenTransfer has copy, drop {
        token_receiver: address,
        remote_chain_selector: u64,
        source_amount: u256,
        dest_token_address: address,
        dest_token_pool_package_id: address,
        source_pool_address: vector<u8>,
        source_pool_data: vector<u8>,
        offchain_token_data: vector<u8>,
    }

    public fun consume_any2sui_message<T0: drop>(arg0: &0xe70da5ac8e13225f8b4c12b6060dda15c2036612d476b0f76431fdc271d82ae::state_object::CCIPObjectRef, arg1: 0xe70da5ac8e13225f8b4c12b6060dda15c2036612d476b0f76431fdc271d82ae::client::Any2SuiMessage, arg2: T0) : (vector<u8>, u64, vector<u8>, vector<u8>, address, address, vector<0xe70da5ac8e13225f8b4c12b6060dda15c2036612d476b0f76431fdc271d82ae::client::Any2SuiTokenAmount>) {
        let v0 = 0x1::type_name::with_original_ids<T0>();
        let v1 = 0x1::ascii::into_bytes(0x1::type_name::address_string(&v0));
        let v2 = 0x2::address::from_ascii_bytes(&v1);
        let (_, v4) = 0xe70da5ac8e13225f8b4c12b6060dda15c2036612d476b0f76431fdc271d82ae::receiver_registry::get_receiver_config_fields(0xe70da5ac8e13225f8b4c12b6060dda15c2036612d476b0f76431fdc271d82ae::receiver_registry::get_receiver_config(arg0, v2));
        assert!(v4 == 0x1::type_name::into_string(v0), 2);
        0xe70da5ac8e13225f8b4c12b6060dda15c2036612d476b0f76431fdc271d82ae::client::consume_any2sui_message(arg1, v2)
    }

    public fun new_any2sui_message(arg0: &DestTransferCap, arg1: vector<u8>, arg2: u64, arg3: vector<u8>, arg4: vector<u8>, arg5: address, arg6: address, arg7: vector<address>, arg8: vector<u256>) : 0xe70da5ac8e13225f8b4c12b6060dda15c2036612d476b0f76431fdc271d82ae::client::Any2SuiMessage {
        0xe70da5ac8e13225f8b4c12b6060dda15c2036612d476b0f76431fdc271d82ae::client::new_any2sui_message(arg1, arg2, arg3, arg4, arg5, arg6, 0xe70da5ac8e13225f8b4c12b6060dda15c2036612d476b0f76431fdc271d82ae::client::new_dest_token_amounts(arg7, arg8))
    }

    public fun add_dest_token_transfer(arg0: &DestTransferCap, arg1: &mut ReceiverParams, arg2: address, arg3: u64, arg4: u256, arg5: address, arg6: address, arg7: vector<u8>, arg8: vector<u8>, arg9: vector<u8>) {
        assert!(0x1::option::is_none<DestTokenTransfer>(&arg1.token_transfer), 6);
        let v0 = DestTokenTransfer{
            token_receiver             : arg2,
            remote_chain_selector      : arg3,
            source_amount              : arg4,
            dest_token_address         : arg5,
            dest_token_pool_package_id : arg6,
            source_pool_address        : arg7,
            source_pool_data           : arg8,
            offchain_token_data        : arg9,
        };
        0x1::option::fill<DestTokenTransfer>(&mut arg1.token_transfer, v0);
    }

    fun calculate_local_amount(arg0: u256, arg1: u8, arg2: u8) : u64 {
        let v0 = if (arg1 == arg2) {
            arg0
        } else if (arg1 > arg2) {
            let v1 = arg0;
            let v2 = 0;
            while (v2 < arg1 - arg2) {
                v1 = v1 / 10;
                v2 = v2 + 1;
            };
            v1
        } else {
            let v3 = arg2 - arg1;
            assert!(v3 <= 77, 13);
            let v4 = 1;
            let v5 = 0;
            while (v5 < v3) {
                v4 = v4 * 10;
                v5 = v5 + 1;
            };
            assert!(arg0 <= 115792089237316195423570985008687907853269984665640564039457584007913129639935 / v4, 13);
            arg0 * v4
        };
        assert!(v0 <= 18446744073709551615, 14);
        (v0 as u64)
    }

    public fun complete_token_transfer<T0: drop>(arg0: &0xe70da5ac8e13225f8b4c12b6060dda15c2036612d476b0f76431fdc271d82ae::state_object::CCIPObjectRef, arg1: &mut ReceiverParams, arg2: T0) {
        let v0 = 0x1::option::borrow<DestTokenTransfer>(&arg1.token_transfer);
        let v1 = v0.dest_token_address;
        let (_, _, _, _, _, v7, _, _) = 0xe70da5ac8e13225f8b4c12b6060dda15c2036612d476b0f76431fdc271d82ae::token_admin_registry::get_token_config_data(arg0, v1);
        assert!(v7 == 0x1::type_name::into_string(0x1::type_name::with_defining_ids<T0>()), 2);
        if (0x1::option::is_some<0xe70da5ac8e13225f8b4c12b6060dda15c2036612d476b0f76431fdc271d82ae::client::Any2SuiMessage>(&arg1.message)) {
            let v10 = 0xe70da5ac8e13225f8b4c12b6060dda15c2036612d476b0f76431fdc271d82ae::token_admin_registry::get_local_decimals_for_token(arg0, v1);
            0xe70da5ac8e13225f8b4c12b6060dda15c2036612d476b0f76431fdc271d82ae::client::set_dest_token_amount(0x1::option::borrow_mut<0xe70da5ac8e13225f8b4c12b6060dda15c2036612d476b0f76431fdc271d82ae::client::Any2SuiMessage>(&mut arg1.message), 0, (calculate_local_amount(v0.source_amount, parse_remote_decimals(v0.source_pool_data, v10), v10) as u256));
        };
        let v11 = CompletedDestTokenTransfer{
            token_receiver     : v0.token_receiver,
            dest_token_address : v1,
        };
        assert!(0x1::option::is_none<CompletedDestTokenTransfer>(&arg1.receipt), 8);
        0x1::option::fill<CompletedDestTokenTransfer>(&mut arg1.receipt, v11);
    }

    public fun create_receiver_params(arg0: &DestTransferCap, arg1: u64) : ReceiverParams {
        ReceiverParams{
            token_transfer        : 0x1::option::none<DestTokenTransfer>(),
            message               : 0x1::option::none<0xe70da5ac8e13225f8b4c12b6060dda15c2036612d476b0f76431fdc271d82ae::client::Any2SuiMessage>(),
            source_chain_selector : arg1,
            receipt               : 0x1::option::none<CompletedDestTokenTransfer>(),
        }
    }

    public fun deconstruct_receiver_params(arg0: &DestTransferCap, arg1: ReceiverParams) {
        let ReceiverParams {
            token_transfer        : v0,
            message               : v1,
            source_chain_selector : _,
            receipt               : v3,
        } = arg1;
        let v4 = v3;
        let v5 = v1;
        let v6 = v0;
        assert!(0x1::option::is_none<DestTokenTransfer>(&v6) && 0x1::option::is_none<CompletedDestTokenTransfer>(&v4) || 0x1::option::is_some<DestTokenTransfer>(&v6) && 0x1::option::is_some<CompletedDestTokenTransfer>(&v4), 4);
        if (0x1::option::is_some<DestTokenTransfer>(&v6)) {
            let v7 = 0x1::option::extract<DestTokenTransfer>(&mut v6);
            let CompletedDestTokenTransfer {
                token_receiver     : v8,
                dest_token_address : v9,
            } = 0x1::option::extract<CompletedDestTokenTransfer>(&mut v4);
            assert!(v8 == v7.token_receiver && v9 == v7.dest_token_address, 5);
        };
        0x1::option::destroy_none<DestTokenTransfer>(v6);
        0x1::option::destroy_none<CompletedDestTokenTransfer>(v4);
        assert!(0x1::option::is_none<0xe70da5ac8e13225f8b4c12b6060dda15c2036612d476b0f76431fdc271d82ae::client::Any2SuiMessage>(&v5), 3);
        0x1::option::destroy_none<0xe70da5ac8e13225f8b4c12b6060dda15c2036612d476b0f76431fdc271d82ae::client::Any2SuiMessage>(v5);
    }

    public fun extract_any2sui_message(arg0: &mut ReceiverParams) : 0xe70da5ac8e13225f8b4c12b6060dda15c2036612d476b0f76431fdc271d82ae::client::Any2SuiMessage {
        assert!(0x1::option::is_some<0xe70da5ac8e13225f8b4c12b6060dda15c2036612d476b0f76431fdc271d82ae::client::Any2SuiMessage>(&arg0.message), 1);
        if (0x1::option::is_some<DestTokenTransfer>(&arg0.token_transfer)) {
            assert!(0x1::option::is_some<CompletedDestTokenTransfer>(&arg0.receipt), 11);
        };
        0x1::option::extract<0xe70da5ac8e13225f8b4c12b6060dda15c2036612d476b0f76431fdc271d82ae::client::Any2SuiMessage>(&mut arg0.message)
    }

    public fun get_dest_token_transfer_data(arg0: &ReceiverParams) : (address, u64, u256, address, address, vector<u8>, vector<u8>, vector<u8>) {
        assert!(0x1::option::is_some<DestTokenTransfer>(&arg0.token_transfer), 7);
        let v0 = 0x1::option::borrow<DestTokenTransfer>(&arg0.token_transfer);
        (v0.token_receiver, v0.remote_chain_selector, v0.source_amount, v0.dest_token_address, v0.dest_token_pool_package_id, v0.source_pool_address, v0.source_pool_data, v0.offchain_token_data)
    }

    public fun get_source_chain_selector(arg0: &ReceiverParams) : u64 {
        arg0.source_chain_selector
    }

    public fun get_token_param_data(arg0: &ReceiverParams) : (address, u256, address, vector<u8>, vector<u8>, vector<u8>) {
        assert!(0x1::option::is_some<DestTokenTransfer>(&arg0.token_transfer), 7);
        let v0 = 0x1::option::borrow<DestTokenTransfer>(&arg0.token_transfer);
        (v0.token_receiver, v0.source_amount, v0.dest_token_address, v0.source_pool_address, v0.source_pool_data, v0.offchain_token_data)
    }

    fun init(arg0: OFFRAMP_STATE_HELPER, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = DestTransferCap{id: 0x2::object::new(arg1)};
        0x2::transfer::transfer<DestTransferCap>(v0, 0x2::tx_context::sender(arg1));
    }

    public fun new_dest_transfer_cap(arg0: &0xe70da5ac8e13225f8b4c12b6060dda15c2036612d476b0f76431fdc271d82ae::state_object::CCIPObjectRef, arg1: &0xe70da5ac8e13225f8b4c12b6060dda15c2036612d476b0f76431fdc271d82ae::ownable::OwnerCap, arg2: &mut 0x2::tx_context::TxContext) : DestTransferCap {
        0xe70da5ac8e13225f8b4c12b6060dda15c2036612d476b0f76431fdc271d82ae::upgrade_registry::verify_function_allowed(arg0, 0x1::string::utf8(b"offramp_state_helper"), 0x1::string::utf8(b"new_dest_transfer_cap"), 2);
        assert!(0x2::object::id<0xe70da5ac8e13225f8b4c12b6060dda15c2036612d476b0f76431fdc271d82ae::ownable::OwnerCap>(arg1) == 0xe70da5ac8e13225f8b4c12b6060dda15c2036612d476b0f76431fdc271d82ae::state_object::owner_cap_id(arg0), 10);
        DestTransferCap{id: 0x2::object::new(arg2)}
    }

    fun parse_remote_decimals(arg0: vector<u8>, arg1: u8) : u8 {
        let v0 = 0x1::vector::length<u8>(&arg0);
        if (v0 == 0) {
            return arg1
        };
        assert!(v0 == 32, 12);
        let v1 = 0xe70da5ac8e13225f8b4c12b6060dda15c2036612d476b0f76431fdc271d82ae::eth_abi::decode_u256_value(arg0);
        assert!(v1 <= 255, 12);
        (v1 as u8)
    }

    public fun populate_message(arg0: &DestTransferCap, arg1: &mut ReceiverParams, arg2: 0xe70da5ac8e13225f8b4c12b6060dda15c2036612d476b0f76431fdc271d82ae::client::Any2SuiMessage) {
        assert!(0x1::option::is_none<0xe70da5ac8e13225f8b4c12b6060dda15c2036612d476b0f76431fdc271d82ae::client::Any2SuiMessage>(&arg1.message), 9);
        0x1::option::fill<0xe70da5ac8e13225f8b4c12b6060dda15c2036612d476b0f76431fdc271d82ae::client::Any2SuiMessage>(&mut arg1.message, arg2);
    }

    // decompiled from Move bytecode v7
}

