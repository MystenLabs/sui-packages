module 0xbd65783d52d7da3eef1df24145998b4e07daaa43ce00b2c13eeb29cfb9dd4703::aptos_module {
    struct AptosModule has key {
        id: 0x2::object::UID,
        cap: 0x8149631b2b88686a6ae1337c93939c0ed52f9b32dd0817612557dee54c8f1894::module_interface::ModuleCap,
    }

    struct AptosChainState has copy, drop, store {
        max_allowed_sequence_number: u64,
        max_gas: u64,
    }

    struct AptosTxData has copy, drop, store {
        sequence_number: u64,
        updated: bool,
    }

    struct AptosAction has copy, drop, store {
        payload: vector<u8>,
        chain_id: u8,
    }

    struct AptosPreparedSigning has copy, drop, store {
        sequence_number: u64,
        max_gas_amount: u64,
        gas_unit_price: u64,
        chain_id: u8,
        expiration_timestamp: u64,
        raw_tx: vector<u8>,
    }

    fun aptos_raw_txn_signing_blob(arg0: vector<u8>) : vector<u8> {
        let v0 = 0x1::vector::empty<u8>();
        0x1::vector::append<u8>(&mut v0, 0x1::hash::sha3_256(b"APTOS::RawTransaction"));
        0x1::vector::append<u8>(&mut v0, arg0);
        v0
    }

    public fun create_aptos_action(arg0: vector<u8>, arg1: u8) : AptosAction {
        AptosAction{
            payload  : arg0,
            chain_id : arg1,
        }
    }

    public fun create_aptos_chain_state(arg0: u64, arg1: u64) : AptosChainState {
        AptosChainState{
            max_allowed_sequence_number : arg0,
            max_gas                     : arg1,
        }
    }

    public fun create_module_shared_data_aptos(arg0: &AptosModule, arg1: 0x2::vec_map::VecMap<0x1::string::String, AptosChainState>, arg2: &mut 0x2::tx_context::TxContext) : 0x8149631b2b88686a6ae1337c93939c0ed52f9b32dd0817612557dee54c8f1894::module_interface::ModuleSharedData<AptosChainState> {
        0x8149631b2b88686a6ae1337c93939c0ed52f9b32dd0817612557dee54c8f1894::module_interface::create_module_shared_data<AptosChainState>(&arg0.cap, arg1, arg2)
    }

    fun create_raw_transaction(arg0: vector<u8>, arg1: u64, arg2: vector<u8>, arg3: u64, arg4: u64, arg5: u64, arg6: u8) : vector<u8> {
        let v0 = 0x1::vector::empty<u8>();
        let v1 = b"Payload bytes:";
        0x1::debug::print<vector<u8>>(&v1);
        0x1::debug::print<vector<u8>>(&arg2);
        0x1::vector::append<u8>(&mut v0, arg0);
        0x1::vector::append<u8>(&mut v0, 0x2::bcs::to_bytes<u64>(&arg1));
        0x1::vector::append<u8>(&mut v0, arg2);
        0x1::vector::append<u8>(&mut v0, 0x2::bcs::to_bytes<u64>(&arg3));
        0x1::vector::append<u8>(&mut v0, 0x2::bcs::to_bytes<u64>(&arg4));
        0x1::vector::append<u8>(&mut v0, 0x2::bcs::to_bytes<u64>(&arg5));
        0x1::vector::append<u8>(&mut v0, 0x2::bcs::to_bytes<u8>(&arg6));
        v0
    }

    public fun init_aptos_module(arg0: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::object::new(arg0);
        let v1 = AptosModule{
            id  : v0,
            cap : 0x8149631b2b88686a6ae1337c93939c0ed52f9b32dd0817612557dee54c8f1894::module_interface::create_module_cap(0x2::object::uid_to_inner(&v0), arg0),
        };
        0x2::transfer::share_object<AptosModule>(v1);
    }

    public fun prepare_signing(arg0: &mut 0x8149631b2b88686a6ae1337c93939c0ed52f9b32dd0817612557dee54c8f1894::module_interface::VaultContainer, arg1: &AptosModule, arg2: 0x8149631b2b88686a6ae1337c93939c0ed52f9b32dd0817612557dee54c8f1894::module_interface::ModuleActionRequest<AptosAction>, arg3: u64, arg4: u64, arg5: u64, arg6: u64) : 0x8149631b2b88686a6ae1337c93939c0ed52f9b32dd0817612557dee54c8f1894::module_interface::ModuleActionResult<AptosPreparedSigning> {
        let v0 = 0x8149631b2b88686a6ae1337c93939c0ed52f9b32dd0817612557dee54c8f1894::module_interface::get_state_borrow_mut<AptosChainState, AptosTxData, AptosAction>(arg0, &arg2, &arg1.cap);
        let (_, _, v3, _, _, v6, v7, v8) = 0x8149631b2b88686a6ae1337c93939c0ed52f9b32dd0817612557dee54c8f1894::module_interface::view_module_action_request<AptosAction>(&arg2);
        let v9 = v7;
        assert!(!v8, 0);
        assert!(arg4 * arg5 <= v0.max_gas, 2);
        assert!(arg3 <= v0.max_allowed_sequence_number, 1);
        if (arg3 == v0.max_allowed_sequence_number) {
            v0.max_allowed_sequence_number = v0.max_allowed_sequence_number + 1;
        };
        let v10 = create_raw_transaction(v3, arg3, v9.payload, arg4, arg5, arg6, v9.chain_id);
        let v11 = AptosTxData{
            sequence_number : arg3,
            updated         : false,
        };
        let v12 = AptosPreparedSigning{
            sequence_number      : arg3,
            max_gas_amount       : arg4,
            gas_unit_price       : arg5,
            chain_id             : v9.chain_id,
            expiration_timestamp : arg6,
            raw_tx               : v10,
        };
        0x8149631b2b88686a6ae1337c93939c0ed52f9b32dd0817612557dee54c8f1894::module_interface::add_transaction<AptosChainState, AptosTxData, AptosAction>(arg0, v6, v11, &arg2, &arg1.cap);
        0x8149631b2b88686a6ae1337c93939c0ed52f9b32dd0817612557dee54c8f1894::module_interface::create_module_action_result<AptosAction, AptosPreparedSigning>(arg2, v12, &arg1.cap, 0x1::vector::singleton<vector<u8>>(aptos_raw_txn_signing_blob(v10)))
    }

    fun test_util_create_aptos_module(arg0: 0x8149631b2b88686a6ae1337c93939c0ed52f9b32dd0817612557dee54c8f1894::module_interface::ModuleCap, arg1: &mut 0x2::tx_context::TxContext) : AptosModule {
        AptosModule{
            id  : 0x2::object::new(arg1),
            cap : arg0,
        }
    }

    public fun view_aptos_action(arg0: &AptosAction) : vector<u8> {
        arg0.payload
    }

    // decompiled from Move bytecode v6
}

