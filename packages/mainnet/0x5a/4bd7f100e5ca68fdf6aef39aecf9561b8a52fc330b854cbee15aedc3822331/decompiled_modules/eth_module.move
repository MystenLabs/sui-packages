module 0x5a4bd7f100e5ca68fdf6aef39aecf9561b8a52fc330b854cbee15aedc3822331::eth_module {
    struct EVMModule has key {
        id: 0x2::object::UID,
        cap: 0x8149631b2b88686a6ae1337c93939c0ed52f9b32dd0817612557dee54c8f1894::module_interface::ModuleCap,
    }

    struct EVMChainState has copy, drop, store {
        max_nonce: u64,
        max_gas: u128,
    }

    struct EVMAction has copy, drop, store {
        data: vector<u8>,
        value: vector<u8>,
        to: vector<u8>,
        chain_id: vector<u8>,
    }

    struct EVMTxData has copy, drop, store {
        nonce: u64,
        dropped: bool,
        updated: bool,
    }

    struct EVMPreparedSigning has copy, drop, store {
        nonce: u64,
        gas_limit: vector<u8>,
        gas_price: vector<u8>,
        max_priority_fee_per_gas: vector<u8>,
        max_fee_per_gas: vector<u8>,
        to: vector<u8>,
        value: vector<u8>,
        chain_id: vector<u8>,
        data: vector<u8>,
    }

    struct EVMAccelerated has copy, drop, store {
        gas_price: vector<u8>,
        max_priority_fee_per_gas: vector<u8>,
        max_fee_per_gas: vector<u8>,
    }

    struct EVMDropped has copy, drop, store {
        gas_price: vector<u8>,
        max_priority_fee_per_gas: vector<u8>,
        max_fee_per_gas: vector<u8>,
    }

    fun add_length_bytes(arg0: vector<u8>) : vector<u8> {
        let v0 = encode_length(0x1::vector::length<u8>(&arg0), 192);
        0x1::vector::append<u8>(&mut v0, arg0);
        v0
    }

    public fun bytes4(arg0: vector<u8>) : vector<u8> {
        let v0 = 0x1::vector::empty<u8>();
        let v1 = 0;
        while (v1 < 4) {
            0x1::vector::push_back<u8>(&mut v0, *0x1::vector::borrow<u8>(&arg0, v1));
            v1 = v1 + 1;
        };
        v0
    }

    public fun char_to_num(arg0: u8) : u8 {
        if (arg0 == 48) {
            0
        } else if (arg0 == 49) {
            1
        } else if (arg0 == 50) {
            2
        } else if (arg0 == 51) {
            3
        } else if (arg0 == 52) {
            4
        } else if (arg0 == 53) {
            5
        } else if (arg0 == 54) {
            6
        } else if (arg0 == 55) {
            7
        } else if (arg0 == 56) {
            8
        } else {
            assert!(arg0 == 57, 0);
            9
        }
    }

    public fun create_evm_action(arg0: vector<u8>, arg1: vector<u8>, arg2: vector<u8>, arg3: vector<u8>) : EVMAction {
        EVMAction{
            data     : arg0,
            value    : arg1,
            to       : arg2,
            chain_id : arg3,
        }
    }

    public fun create_evm_chain_state(arg0: u64, arg1: u128) : EVMChainState {
        EVMChainState{
            max_nonce : arg0,
            max_gas   : arg1,
        }
    }

    public fun create_module_shared_data_ethereum(arg0: &EVMModule, arg1: 0x2::vec_map::VecMap<0x1::string::String, EVMChainState>, arg2: &mut 0x2::tx_context::TxContext) : 0x8149631b2b88686a6ae1337c93939c0ed52f9b32dd0817612557dee54c8f1894::module_interface::ModuleSharedData<EVMChainState> {
        0x8149631b2b88686a6ae1337c93939c0ed52f9b32dd0817612557dee54c8f1894::module_interface::create_module_shared_data<EVMChainState>(&arg0.cap, arg1, arg2)
    }

    fun encode_array_of_bytes(arg0: vector<vector<u8>>) : vector<u8> {
        let v0 = 0x1::vector::empty<u8>();
        let v1 = 0;
        let v2 = 0;
        while (v2 < 0x1::vector::length<vector<u8>>(&arg0)) {
            let v3 = encode_bytes(*0x1::vector::borrow<vector<u8>>(&arg0, v2));
            0x1::vector::append<u8>(&mut v0, v3);
            v1 = v1 + 0x1::vector::length<u8>(&v3);
            v2 = v2 + 1;
        };
        add_length_bytes(v0)
    }

    fun encode_bytes(arg0: vector<u8>) : vector<u8> {
        if (0x1::vector::length<u8>(&arg0) == 1 && *0x1::vector::borrow<u8>(&arg0, 0) < 128) {
            return arg0
        };
        let v0 = encode_length(0x1::vector::length<u8>(&arg0), 128);
        0x1::vector::append<u8>(&mut v0, arg0);
        v0
    }

    fun encode_length(arg0: u64, arg1: u8) : vector<u8> {
        if (arg0 < 56) {
            return 0x1::vector::singleton<u8>((arg0 as u8) + arg1)
        };
        let v0 = 0x2::hex::encode(to_minimal_be_bytes<u64>(&arg0));
        let v1 = (arg1 as u64) + 55 + 0x1::vector::length<u8>(&v0) / 2;
        let v2 = 0x2::hex::encode(to_minimal_be_bytes<u64>(&v1));
        0x1::vector::append<u8>(&mut v2, v0);
        0x2::hex::decode(v2)
    }

    public fun init_ethereum_module(arg0: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::object::new(arg0);
        let v1 = EVMModule{
            id  : v0,
            cap : 0x8149631b2b88686a6ae1337c93939c0ed52f9b32dd0817612557dee54c8f1894::module_interface::create_module_cap(0x2::object::uid_to_inner(&v0), arg0),
        };
        0x2::transfer::share_object<EVMModule>(v1);
    }

    public fun left_pad_address_to_32_bytes(arg0: vector<u8>) : vector<u8> {
        let v0 = 32;
        let v1 = 0x1::vector::length<u8>(&arg0);
        let v2 = if (v1 < v0) {
            v0 - v1
        } else {
            0
        };
        0x1::vector::reverse<u8>(&mut arg0);
        let v3 = 0;
        while (v3 < v2) {
            0x1::vector::push_back<u8>(&mut arg0, 0);
            v3 = v3 + 1;
        };
        0x1::vector::reverse<u8>(&mut arg0);
        arg0
    }

    public fun prepare_signing_accelerate_eip1559(arg0: &mut 0x8149631b2b88686a6ae1337c93939c0ed52f9b32dd0817612557dee54c8f1894::module_interface::VaultContainer, arg1: &EVMModule, arg2: 0x8149631b2b88686a6ae1337c93939c0ed52f9b32dd0817612557dee54c8f1894::module_interface::ModuleActionRequest<EVMAction>, arg3: u64, arg4: u64, arg5: u64) : 0x8149631b2b88686a6ae1337c93939c0ed52f9b32dd0817612557dee54c8f1894::module_interface::ModuleActionResult<EVMAccelerated> {
        let (_, _, _, _, _, v5, v6, v7) = 0x8149631b2b88686a6ae1337c93939c0ed52f9b32dd0817612557dee54c8f1894::module_interface::view_module_action_request<EVMAction>(&arg2);
        let v8 = v6;
        assert!(v7, 1);
        assert!(0x8149631b2b88686a6ae1337c93939c0ed52f9b32dd0817612557dee54c8f1894::module_interface::get_state_borrow_mut<EVMChainState, EVMTxData, EVMAction>(arg0, &arg2, &arg1.cap).max_gas >= (arg3 as u128) * (arg5 as u128), 2);
        let v9 = 0x8149631b2b88686a6ae1337c93939c0ed52f9b32dd0817612557dee54c8f1894::module_interface::get_transaction_borrow_mut<EVMChainState, EVMTxData, EVMAction>(arg0, v5, &arg2, &arg1.cap);
        v9.updated = true;
        let v10 = EVMAccelerated{
            gas_price                : 0x1::vector::empty<u8>(),
            max_priority_fee_per_gas : to_minimal_be_bytes<u64>(&arg4),
            max_fee_per_gas          : to_minimal_be_bytes<u64>(&arg5),
        };
        0x8149631b2b88686a6ae1337c93939c0ed52f9b32dd0817612557dee54c8f1894::module_interface::create_module_action_result<EVMAction, EVMAccelerated>(arg2, v10, &arg1.cap, 0x1::vector::singleton<vector<u8>>(to_signable_blob_eip1559(v8.chain_id, v8.to, v8.value, v8.data, v9.nonce, arg3, arg4, arg5)))
    }

    public fun prepare_signing_accelerate_legacy(arg0: &mut 0x8149631b2b88686a6ae1337c93939c0ed52f9b32dd0817612557dee54c8f1894::module_interface::VaultContainer, arg1: &EVMModule, arg2: 0x8149631b2b88686a6ae1337c93939c0ed52f9b32dd0817612557dee54c8f1894::module_interface::ModuleActionRequest<EVMAction>, arg3: u64, arg4: u64) : 0x8149631b2b88686a6ae1337c93939c0ed52f9b32dd0817612557dee54c8f1894::module_interface::ModuleActionResult<EVMAccelerated> {
        let (_, _, _, _, _, v5, v6, v7) = 0x8149631b2b88686a6ae1337c93939c0ed52f9b32dd0817612557dee54c8f1894::module_interface::view_module_action_request<EVMAction>(&arg2);
        let v8 = v6;
        assert!(v7, 1);
        assert!(0x8149631b2b88686a6ae1337c93939c0ed52f9b32dd0817612557dee54c8f1894::module_interface::get_state_borrow_mut<EVMChainState, EVMTxData, EVMAction>(arg0, &arg2, &arg1.cap).max_gas >= (arg3 as u128) * (arg4 as u128), 2);
        let v9 = 0x8149631b2b88686a6ae1337c93939c0ed52f9b32dd0817612557dee54c8f1894::module_interface::get_transaction_borrow_mut<EVMChainState, EVMTxData, EVMAction>(arg0, v5, &arg2, &arg1.cap);
        v9.updated = true;
        let v10 = EVMAccelerated{
            gas_price                : to_minimal_be_bytes<u64>(&arg4),
            max_priority_fee_per_gas : 0x1::vector::empty<u8>(),
            max_fee_per_gas          : 0x1::vector::empty<u8>(),
        };
        0x8149631b2b88686a6ae1337c93939c0ed52f9b32dd0817612557dee54c8f1894::module_interface::create_module_action_result<EVMAction, EVMAccelerated>(arg2, v10, &arg1.cap, 0x1::vector::singleton<vector<u8>>(to_signable_blob_legacy(v8.chain_id, v8.to, v8.value, v8.data, v9.nonce, arg3, arg4)))
    }

    public fun prepare_signing_drop_eip1559(arg0: &mut 0x8149631b2b88686a6ae1337c93939c0ed52f9b32dd0817612557dee54c8f1894::module_interface::VaultContainer, arg1: &EVMModule, arg2: 0x8149631b2b88686a6ae1337c93939c0ed52f9b32dd0817612557dee54c8f1894::module_interface::ModuleActionRequest<EVMAction>, arg3: u64, arg4: u64, arg5: u64) : 0x8149631b2b88686a6ae1337c93939c0ed52f9b32dd0817612557dee54c8f1894::module_interface::ModuleActionResult<EVMDropped> {
        let (_, _, _, _, _, v5, v6, v7) = 0x8149631b2b88686a6ae1337c93939c0ed52f9b32dd0817612557dee54c8f1894::module_interface::view_module_action_request<EVMAction>(&arg2);
        let v8 = v6;
        assert!(v7, 1);
        assert!(0x8149631b2b88686a6ae1337c93939c0ed52f9b32dd0817612557dee54c8f1894::module_interface::get_state_borrow_mut<EVMChainState, EVMTxData, EVMAction>(arg0, &arg2, &arg1.cap).max_gas >= (arg3 as u128) * (arg5 as u128), 2);
        let v9 = 0x8149631b2b88686a6ae1337c93939c0ed52f9b32dd0817612557dee54c8f1894::module_interface::get_transaction_borrow_mut<EVMChainState, EVMTxData, EVMAction>(arg0, v5, &arg2, &arg1.cap);
        v9.dropped = true;
        let v10 = EVMDropped{
            gas_price                : 0x1::vector::empty<u8>(),
            max_priority_fee_per_gas : to_minimal_be_bytes<u64>(&arg4),
            max_fee_per_gas          : to_minimal_be_bytes<u64>(&arg5),
        };
        0x8149631b2b88686a6ae1337c93939c0ed52f9b32dd0817612557dee54c8f1894::module_interface::create_module_action_result<EVMAction, EVMDropped>(arg2, v10, &arg1.cap, 0x1::vector::singleton<vector<u8>>(to_signable_blob_eip1559(v8.chain_id, x"0000000000000000000000000000000000000001", 0x1::vector::empty<u8>(), 0x1::vector::empty<u8>(), v9.nonce, arg3, arg4, arg5)))
    }

    public fun prepare_signing_drop_legacy(arg0: &mut 0x8149631b2b88686a6ae1337c93939c0ed52f9b32dd0817612557dee54c8f1894::module_interface::VaultContainer, arg1: &EVMModule, arg2: 0x8149631b2b88686a6ae1337c93939c0ed52f9b32dd0817612557dee54c8f1894::module_interface::ModuleActionRequest<EVMAction>, arg3: u64, arg4: u64) : 0x8149631b2b88686a6ae1337c93939c0ed52f9b32dd0817612557dee54c8f1894::module_interface::ModuleActionResult<EVMDropped> {
        let (_, _, _, _, _, v5, v6, v7) = 0x8149631b2b88686a6ae1337c93939c0ed52f9b32dd0817612557dee54c8f1894::module_interface::view_module_action_request<EVMAction>(&arg2);
        let v8 = v6;
        assert!(v7, 1);
        assert!(0x8149631b2b88686a6ae1337c93939c0ed52f9b32dd0817612557dee54c8f1894::module_interface::get_state_borrow_mut<EVMChainState, EVMTxData, EVMAction>(arg0, &arg2, &arg1.cap).max_gas >= (arg3 as u128) * (arg4 as u128), 2);
        let v9 = 0x8149631b2b88686a6ae1337c93939c0ed52f9b32dd0817612557dee54c8f1894::module_interface::get_transaction_borrow_mut<EVMChainState, EVMTxData, EVMAction>(arg0, v5, &arg2, &arg1.cap);
        v9.dropped = true;
        let v10 = EVMDropped{
            gas_price                : to_minimal_be_bytes<u64>(&arg4),
            max_priority_fee_per_gas : 0x1::vector::empty<u8>(),
            max_fee_per_gas          : 0x1::vector::empty<u8>(),
        };
        0x8149631b2b88686a6ae1337c93939c0ed52f9b32dd0817612557dee54c8f1894::module_interface::create_module_action_result<EVMAction, EVMDropped>(arg2, v10, &arg1.cap, 0x1::vector::singleton<vector<u8>>(to_signable_blob_legacy(v8.chain_id, x"0000000000000000000000000000000000000001", 0x1::vector::empty<u8>(), 0x1::vector::empty<u8>(), v9.nonce, arg3, arg4)))
    }

    public fun prepare_signing_eip1559(arg0: &mut 0x8149631b2b88686a6ae1337c93939c0ed52f9b32dd0817612557dee54c8f1894::module_interface::VaultContainer, arg1: &EVMModule, arg2: 0x8149631b2b88686a6ae1337c93939c0ed52f9b32dd0817612557dee54c8f1894::module_interface::ModuleActionRequest<EVMAction>, arg3: u64, arg4: u64, arg5: u64, arg6: u64) : 0x8149631b2b88686a6ae1337c93939c0ed52f9b32dd0817612557dee54c8f1894::module_interface::ModuleActionResult<EVMPreparedSigning> {
        let v0 = 0x8149631b2b88686a6ae1337c93939c0ed52f9b32dd0817612557dee54c8f1894::module_interface::get_state_borrow_mut<EVMChainState, EVMTxData, EVMAction>(arg0, &arg2, &arg1.cap);
        let (_, _, _, _, _, v6, v7, v8) = 0x8149631b2b88686a6ae1337c93939c0ed52f9b32dd0817612557dee54c8f1894::module_interface::view_module_action_request<EVMAction>(&arg2);
        let v9 = v7;
        assert!(!v8, 0);
        assert!(v0.max_gas >= (arg3 as u128) * (arg6 as u128), 2);
        if (arg4 == v0.max_nonce + 1) {
            v0.max_nonce = v0.max_nonce + 1;
        };
        assert!(arg4 <= v0.max_nonce, 3);
        let v10 = EVMTxData{
            nonce   : arg4,
            dropped : false,
            updated : false,
        };
        let v11 = EVMPreparedSigning{
            nonce                    : arg4,
            gas_limit                : to_minimal_be_bytes<u64>(&arg3),
            gas_price                : 0x1::vector::empty<u8>(),
            max_priority_fee_per_gas : to_minimal_be_bytes<u64>(&arg5),
            max_fee_per_gas          : to_minimal_be_bytes<u64>(&arg6),
            to                       : v9.to,
            value                    : v9.value,
            chain_id                 : v9.chain_id,
            data                     : v9.data,
        };
        0x8149631b2b88686a6ae1337c93939c0ed52f9b32dd0817612557dee54c8f1894::module_interface::add_transaction<EVMChainState, EVMTxData, EVMAction>(arg0, v6, v10, &arg2, &arg1.cap);
        0x8149631b2b88686a6ae1337c93939c0ed52f9b32dd0817612557dee54c8f1894::module_interface::create_module_action_result<EVMAction, EVMPreparedSigning>(arg2, v11, &arg1.cap, 0x1::vector::singleton<vector<u8>>(to_signable_blob_eip1559(v9.chain_id, v9.to, v9.value, v9.data, arg4, arg3, arg5, arg6)))
    }

    public fun prepare_signing_legacy(arg0: &mut 0x8149631b2b88686a6ae1337c93939c0ed52f9b32dd0817612557dee54c8f1894::module_interface::VaultContainer, arg1: &EVMModule, arg2: 0x8149631b2b88686a6ae1337c93939c0ed52f9b32dd0817612557dee54c8f1894::module_interface::ModuleActionRequest<EVMAction>, arg3: u64, arg4: u64, arg5: u64) : 0x8149631b2b88686a6ae1337c93939c0ed52f9b32dd0817612557dee54c8f1894::module_interface::ModuleActionResult<EVMPreparedSigning> {
        let v0 = 0x8149631b2b88686a6ae1337c93939c0ed52f9b32dd0817612557dee54c8f1894::module_interface::get_state_borrow_mut<EVMChainState, EVMTxData, EVMAction>(arg0, &arg2, &arg1.cap);
        let (_, _, _, _, _, v6, v7, v8) = 0x8149631b2b88686a6ae1337c93939c0ed52f9b32dd0817612557dee54c8f1894::module_interface::view_module_action_request<EVMAction>(&arg2);
        let v9 = v7;
        assert!(!v8, 0);
        assert!(v0.max_gas >= (arg3 as u128) * (arg5 as u128), 2);
        if (arg4 == v0.max_nonce + 1) {
            v0.max_nonce = v0.max_nonce + 1;
        };
        assert!(arg4 <= v0.max_nonce, 3);
        let v10 = EVMTxData{
            nonce   : arg4,
            dropped : false,
            updated : false,
        };
        let v11 = EVMPreparedSigning{
            nonce                    : arg4,
            gas_limit                : to_minimal_be_bytes<u64>(&arg3),
            gas_price                : to_minimal_be_bytes<u64>(&arg5),
            max_priority_fee_per_gas : 0x1::vector::empty<u8>(),
            max_fee_per_gas          : 0x1::vector::empty<u8>(),
            to                       : v9.to,
            value                    : v9.value,
            chain_id                 : v9.chain_id,
            data                     : v9.data,
        };
        0x8149631b2b88686a6ae1337c93939c0ed52f9b32dd0817612557dee54c8f1894::module_interface::add_transaction<EVMChainState, EVMTxData, EVMAction>(arg0, v6, v10, &arg2, &arg1.cap);
        0x8149631b2b88686a6ae1337c93939c0ed52f9b32dd0817612557dee54c8f1894::module_interface::create_module_action_result<EVMAction, EVMPreparedSigning>(arg2, v11, &arg1.cap, 0x1::vector::singleton<vector<u8>>(to_signable_blob_legacy(v9.chain_id, v9.to, v9.value, v9.data, arg4, arg3, arg5)))
    }

    public fun string_to_number(arg0: vector<u8>) : u32 {
        let v0 = 0;
        let v1 = 0;
        while (v1 < 0x1::vector::length<u8>(&arg0)) {
            let v2 = v0 * 10;
            v0 = v2 + (char_to_num(*0x1::vector::borrow<u8>(&arg0, v1)) as u32);
            v1 = v1 + 1;
        };
        v0
    }

    fun test_util_create_evm_module(arg0: 0x8149631b2b88686a6ae1337c93939c0ed52f9b32dd0817612557dee54c8f1894::module_interface::ModuleCap, arg1: &mut 0x2::tx_context::TxContext) : EVMModule {
        EVMModule{
            id  : 0x2::object::new(arg1),
            cap : arg0,
        }
    }

    fun test_util_create_evm_transaction(arg0: u64, arg1: bool, arg2: bool) : EVMTxData {
        EVMTxData{
            nonce   : arg0,
            dropped : arg1,
            updated : arg2,
        }
    }

    public fun to_minimal_be_bytes<T0>(arg0: &T0) : vector<u8> {
        let v0 = 0x2::bcs::to_bytes<T0>(arg0);
        while (0x1::vector::length<u8>(&v0) > 0 && *0x1::vector::borrow<u8>(&v0, 0x1::vector::length<u8>(&v0) - 1) == 0) {
            0x1::vector::pop_back<u8>(&mut v0);
        };
        0x1::vector::reverse<u8>(&mut v0);
        v0
    }

    public fun to_signable_blob_eip1559(arg0: vector<u8>, arg1: vector<u8>, arg2: vector<u8>, arg3: vector<u8>, arg4: u64, arg5: u64, arg6: u64, arg7: u64) : vector<u8> {
        let v0 = 0x1::vector::empty<u8>();
        0x1::vector::append<u8>(&mut v0, encode_bytes(arg0));
        0x1::vector::append<u8>(&mut v0, encode_bytes(to_minimal_be_bytes<u64>(&arg4)));
        0x1::vector::append<u8>(&mut v0, encode_bytes(to_minimal_be_bytes<u64>(&arg6)));
        0x1::vector::append<u8>(&mut v0, encode_bytes(to_minimal_be_bytes<u64>(&arg7)));
        0x1::vector::append<u8>(&mut v0, encode_bytes(to_minimal_be_bytes<u64>(&arg5)));
        0x1::vector::append<u8>(&mut v0, encode_bytes(arg1));
        0x1::vector::append<u8>(&mut v0, encode_bytes(arg2));
        0x1::vector::append<u8>(&mut v0, encode_bytes(arg3));
        0x1::vector::append<u8>(&mut v0, encode_array_of_bytes(0x1::vector::empty<vector<u8>>()));
        let v1 = 0x1::vector::singleton<u8>(2);
        0x1::vector::append<u8>(&mut v1, add_length_bytes(v0));
        v1
    }

    public fun to_signable_blob_legacy(arg0: vector<u8>, arg1: vector<u8>, arg2: vector<u8>, arg3: vector<u8>, arg4: u64, arg5: u64, arg6: u64) : vector<u8> {
        let v0 = 0x1::vector::empty<u8>();
        0x1::vector::append<u8>(&mut v0, encode_bytes(to_minimal_be_bytes<u64>(&arg4)));
        0x1::vector::append<u8>(&mut v0, encode_bytes(to_minimal_be_bytes<u64>(&arg6)));
        0x1::vector::append<u8>(&mut v0, encode_bytes(to_minimal_be_bytes<u64>(&arg5)));
        0x1::vector::append<u8>(&mut v0, encode_bytes(arg1));
        0x1::vector::append<u8>(&mut v0, encode_bytes(arg2));
        0x1::vector::append<u8>(&mut v0, encode_bytes(arg3));
        0x1::vector::append<u8>(&mut v0, encode_bytes(arg0));
        0x1::vector::append<u8>(&mut v0, encode_bytes(0x1::vector::empty<u8>()));
        0x1::vector::append<u8>(&mut v0, encode_bytes(0x1::vector::empty<u8>()));
        add_length_bytes(v0)
    }

    public fun u256_to_32_byte_vector(arg0: u256) : vector<u8> {
        let v0 = 0x1::vector::empty<u8>();
        let v1 = 0;
        while (v1 < 32) {
            0x1::vector::push_back<u8>(&mut v0, ((arg0 >> 8 * (31 - v1) & 255) as u8));
            v1 = v1 + 1;
        };
        v0
    }

    public fun view_evm_action(arg0: &EVMAction) : (vector<u8>, vector<u8>, vector<u8>, vector<u8>) {
        (arg0.data, arg0.value, arg0.to, arg0.chain_id)
    }

    // decompiled from Move bytecode v6
}

