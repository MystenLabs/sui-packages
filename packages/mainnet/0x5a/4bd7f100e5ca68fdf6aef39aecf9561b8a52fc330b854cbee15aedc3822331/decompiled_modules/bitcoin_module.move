module 0x5a4bd7f100e5ca68fdf6aef39aecf9561b8a52fc330b854cbee15aedc3822331::bitcoin_module {
    struct BTCModule has key {
        id: 0x2::object::UID,
        cap: 0x8149631b2b88686a6ae1337c93939c0ed52f9b32dd0817612557dee54c8f1894::module_interface::ModuleCap,
    }

    struct BTCChainState has copy, drop, store {
        max_value_loss: u64,
    }

    struct BTCAction has copy, drop, store {
        outputs: vector<TxOutput>,
    }

    struct BTCTxData has copy, drop, store {
        p2wpkh_inputs: vector<P2WPKHTxInput>,
    }

    struct TxOutput has copy, drop, store {
        value: u64,
        scriptpubkey: vector<u8>,
    }

    struct TxOutpoint has copy, drop, store {
        txid: vector<u8>,
        out_idx: u32,
    }

    struct P2WPKHTxInput has copy, drop, store {
        witness_utxo: TxOutput,
        prevout: TxOutpoint,
        precalculated_preimage_script: vector<u8>,
    }

    struct BTCPreparedSigning has copy, drop, store {
        outputs: vector<TxOutput>,
        p2wpkh_inputs: vector<P2WPKHTxInput>,
        change_output: 0x1::option::Option<TxOutput>,
    }

    struct BTCAccelerated has copy, drop, store {
        create_change_output: bool,
        change_amount: u64,
    }

    struct BTCDropped has copy, drop, store {
        change_amount: u64,
    }

    fun add_number_to_script(arg0: u8) : vector<u8> {
        0x2::hex::decode(push_script(0x2::hex::encode(0x2::bcs::to_bytes<u8>(&arg0))))
    }

    fun address_to_script_hex(arg0: vector<u8>) : vector<u8> {
        let (v0, v1) = decode_segwit_address(0x1::ascii::string(arg0));
        construct_script(v0, v1)
    }

    fun bech32_decode(arg0: 0x1::ascii::String) : vector<u8> {
        let v0 = 0x1::ascii::string(0x1::vector::empty<u8>());
        let v1 = 0x1::ascii::length(&arg0) - 1;
        while (v1 > 0) {
            let v2 = 0x1::ascii::pop_char(&mut arg0);
            if (v2 == 0x1::ascii::char(49)) {
                break
            };
            0x1::ascii::push_char(&mut v0, v2);
            v1 = v1 - 1;
        };
        let v3 = 0x1::ascii::into_bytes(v0);
        let v4 = 0x1::vector::empty<u8>();
        let v5 = 0x1::ascii::length(&v0) - 1;
        while (v5 > 5) {
            let v6 = b"qpzry9x8gf2tvdw0s3jn54khce6mua7l";
            let (v7, v8) = 0x1::vector::index_of<u8>(&v6, 0x1::vector::borrow<u8>(&v3, v5));
            assert!(v7, 1);
            0x1::vector::push_back<u8>(&mut v4, (v8 as u8));
            v5 = v5 - 1;
        };
        v4
    }

    fun construct_script(arg0: u8, arg1: vector<u8>) : vector<u8> {
        let v0 = 0x1::vector::empty<u8>();
        0x1::vector::append<u8>(&mut v0, 0x2::hex::encode(add_number_to_script(arg0)));
        0x1::vector::append<u8>(&mut v0, push_script(0x2::hex::encode(arg1)));
        v0
    }

    fun convert_bits(arg0: vector<u8>, arg1: u8, arg2: u8, arg3: bool) : vector<u8> {
        let v0 = 0;
        let v1 = 0;
        let v2 = 0x1::vector::empty<u8>();
        let v3 = (1 << arg2) - 1;
        let v4 = 0;
        while (v4 < 0x1::vector::length<u8>(&arg0)) {
            let v5 = 0x1::vector::borrow<u8>(&arg0, v4);
            if (*v5 >> arg1 != 0) {
                return 0x1::vector::empty<u8>()
            };
            let v6 = (((v0 << arg1) as u64) | (*v5 as u64)) & (1 << arg1 + arg2 - 1) - 1;
            v0 = v6;
            v1 = v1 + arg1;
            while (v1 >= arg2) {
                let v7 = v1 - arg2;
                v1 = v7;
                0x1::vector::push_back<u8>(&mut v2, ((v6 >> v7 & v3) as u8));
            };
            v4 = v4 + 1;
        };
        if (arg3) {
            if (v1 > 0) {
                0x1::vector::push_back<u8>(&mut v2, ((((v0 << arg2 - v1) as u64) & v3) as u8));
            };
        } else if (v1 >= arg1 || ((v0 << arg2 - v1) as u64) & v3 != 0) {
            return 0x1::vector::empty<u8>()
        };
        v2
    }

    public fun create_btc_action(arg0: vector<TxOutput>) : BTCAction {
        BTCAction{outputs: arg0}
    }

    public fun create_btc_chain_state(arg0: u64) : BTCChainState {
        BTCChainState{max_value_loss: arg0}
    }

    public fun create_module_shared_data_bitcoin(arg0: &BTCModule, arg1: 0x2::vec_map::VecMap<0x1::string::String, BTCChainState>, arg2: &mut 0x2::tx_context::TxContext) : 0x8149631b2b88686a6ae1337c93939c0ed52f9b32dd0817612557dee54c8f1894::module_interface::ModuleSharedData<BTCChainState> {
        0x8149631b2b88686a6ae1337c93939c0ed52f9b32dd0817612557dee54c8f1894::module_interface::create_module_shared_data<BTCChainState>(&arg0.cap, arg1, arg2)
    }

    public fun create_p2wpkh_tx_input(arg0: TxOutput, arg1: TxOutpoint, arg2: vector<u8>) : P2WPKHTxInput {
        P2WPKHTxInput{
            witness_utxo                  : arg0,
            prevout                       : arg1,
            precalculated_preimage_script : arg2,
        }
    }

    public fun create_tx_outpoint(arg0: vector<u8>, arg1: u32) : TxOutpoint {
        TxOutpoint{
            txid    : arg0,
            out_idx : arg1,
        }
    }

    public fun create_tx_output(arg0: vector<u8>, arg1: u64) : TxOutput {
        TxOutput{
            value        : arg1,
            scriptpubkey : arg0,
        }
    }

    fun decode_segwit_address(arg0: 0x1::ascii::String) : (u8, vector<u8>) {
        let v0 = bech32_decode(arg0);
        (0x1::vector::remove<u8>(&mut v0, 0), convert_bits(v0, 5, 8, false))
    }

    public fun init_btc_module(arg0: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::object::new(arg0);
        let v1 = BTCModule{
            id  : v0,
            cap : 0x8149631b2b88686a6ae1337c93939c0ed52f9b32dd0817612557dee54c8f1894::module_interface::create_module_cap(0x2::object::uid_to_inner(&v0), arg0),
        };
        0x2::transfer::share_object<BTCModule>(v1);
    }

    fun op_push(arg0: u32) : vector<u8> {
        if (arg0 < (76 as u32)) {
            let v0 = (arg0 as u8);
            return 0x2::hex::encode(0x2::bcs::to_bytes<u8>(&v0))
        };
        if (arg0 <= 255) {
            let v1 = 0x2::hex::encode(0x1::vector::singleton<u8>(76));
            let v2 = (arg0 as u8);
            0x1::vector::append<u8>(&mut v1, 0x2::hex::encode(0x2::bcs::to_bytes<u8>(&v2)));
            return v1
        };
        if (arg0 <= 65535) {
            let v3 = 0x2::hex::encode(0x1::vector::singleton<u8>(77));
            let v4 = (arg0 as u16);
            0x1::vector::append<u8>(&mut v3, 0x2::hex::encode(0x2::bcs::to_bytes<u16>(&v4)));
            return v3
        };
        let v5 = 0x2::hex::encode(0x1::vector::singleton<u8>(78));
        0x1::vector::append<u8>(&mut v5, 0x2::hex::encode(0x2::bcs::to_bytes<u32>(&arg0)));
        v5
    }

    public fun prepare_signing(arg0: &mut 0x8149631b2b88686a6ae1337c93939c0ed52f9b32dd0817612557dee54c8f1894::module_interface::VaultContainer, arg1: &BTCModule, arg2: 0x8149631b2b88686a6ae1337c93939c0ed52f9b32dd0817612557dee54c8f1894::module_interface::ModuleActionRequest<BTCAction>, arg3: vector<P2WPKHTxInput>, arg4: u64, arg5: bool) : 0x8149631b2b88686a6ae1337c93939c0ed52f9b32dd0817612557dee54c8f1894::module_interface::ModuleActionResult<BTCPreparedSigning> {
        let v0 = 0x8149631b2b88686a6ae1337c93939c0ed52f9b32dd0817612557dee54c8f1894::module_interface::get_state_borrow_mut<BTCChainState, BTCTxData, BTCAction>(arg0, &arg2, &arg1.cap);
        let (_, _, v3, _, _, v6, v7, v8) = 0x8149631b2b88686a6ae1337c93939c0ed52f9b32dd0817612557dee54c8f1894::module_interface::view_module_action_request<BTCAction>(&arg2);
        let v9 = v7;
        assert!(!v8, 2);
        let v10 = 0;
        let v11 = 0;
        while (v11 < 0x1::vector::length<P2WPKHTxInput>(&arg3)) {
            v10 = v10 + 0x1::vector::borrow<P2WPKHTxInput>(&arg3, v11).witness_utxo.value;
            v11 = v11 + 1;
        };
        let v12 = 0;
        let v13 = 0;
        while (v13 < 0x1::vector::length<TxOutput>(&v9.outputs)) {
            v12 = v12 + 0x1::vector::borrow<TxOutput>(&v9.outputs, v13).value;
            v13 = v13 + 1;
        };
        let v14 = if (arg5) {
            assert!(arg4 <= v0.max_value_loss, 3);
            let v15 = TxOutput{
                value        : v10 - v12 - arg4,
                scriptpubkey : v3,
            };
            let v16 = BTCPreparedSigning{
                outputs       : v9.outputs,
                p2wpkh_inputs : arg3,
                change_output : 0x1::option::some<TxOutput>(v15),
            };
            0x1::vector::push_back<TxOutput>(&mut v9.outputs, v15);
            v16
        } else {
            assert!(v10 - v12 - arg4 + arg4 <= v0.max_value_loss, 3);
            BTCPreparedSigning{outputs: v9.outputs, p2wpkh_inputs: arg3, change_output: 0x1::option::none<TxOutput>()}
        };
        let v17 = BTCTxData{p2wpkh_inputs: arg3};
        0x8149631b2b88686a6ae1337c93939c0ed52f9b32dd0817612557dee54c8f1894::module_interface::add_transaction<BTCChainState, BTCTxData, BTCAction>(arg0, v6, v17, &arg2, &arg1.cap);
        0x8149631b2b88686a6ae1337c93939c0ed52f9b32dd0817612557dee54c8f1894::module_interface::create_module_action_result<BTCAction, BTCPreparedSigning>(arg2, v14, &arg1.cap, to_signable_blobs_p2wpkh(arg3, v9.outputs))
    }

    public fun prepare_signing_accelerate(arg0: &mut 0x8149631b2b88686a6ae1337c93939c0ed52f9b32dd0817612557dee54c8f1894::module_interface::VaultContainer, arg1: &BTCModule, arg2: 0x8149631b2b88686a6ae1337c93939c0ed52f9b32dd0817612557dee54c8f1894::module_interface::ModuleActionRequest<BTCAction>, arg3: u64, arg4: bool) : 0x8149631b2b88686a6ae1337c93939c0ed52f9b32dd0817612557dee54c8f1894::module_interface::ModuleActionResult<BTCAccelerated> {
        let (_, _, v2, _, _, v5, v6, v7) = 0x8149631b2b88686a6ae1337c93939c0ed52f9b32dd0817612557dee54c8f1894::module_interface::view_module_action_request<BTCAction>(&arg2);
        let v8 = v6;
        assert!(v7, 0);
        let v9 = 0x8149631b2b88686a6ae1337c93939c0ed52f9b32dd0817612557dee54c8f1894::module_interface::get_transaction_borrow_mut<BTCChainState, BTCTxData, BTCAction>(arg0, v5, &arg2, &arg1.cap);
        let v10 = 0;
        let v11 = 0;
        while (v11 < 0x1::vector::length<P2WPKHTxInput>(&v9.p2wpkh_inputs)) {
            v10 = v10 + 0x1::vector::borrow<P2WPKHTxInput>(&v9.p2wpkh_inputs, v11).witness_utxo.value;
            v11 = v11 + 1;
        };
        let v12 = 0;
        let v13 = 0;
        while (v13 < 0x1::vector::length<TxOutput>(&v8.outputs)) {
            v12 = v12 + 0x1::vector::borrow<TxOutput>(&v8.outputs, v13).value;
            v13 = v13 + 1;
        };
        let v14 = v10 - v12 - arg3;
        let v15 = if (arg4) {
            assert!(arg3 <= 0x8149631b2b88686a6ae1337c93939c0ed52f9b32dd0817612557dee54c8f1894::module_interface::get_state_borrow_mut<BTCChainState, BTCTxData, BTCAction>(arg0, &arg2, &arg1.cap).max_value_loss, 3);
            let v16 = TxOutput{
                value        : v14,
                scriptpubkey : v2,
            };
            let v17 = BTCAccelerated{
                create_change_output : arg4,
                change_amount        : v14,
            };
            0x1::vector::push_back<TxOutput>(&mut v8.outputs, v16);
            v17
        } else {
            assert!(v14 + arg3 <= 0x8149631b2b88686a6ae1337c93939c0ed52f9b32dd0817612557dee54c8f1894::module_interface::get_state_borrow_mut<BTCChainState, BTCTxData, BTCAction>(arg0, &arg2, &arg1.cap).max_value_loss, 3);
            BTCAccelerated{create_change_output: arg4, change_amount: v14}
        };
        0x8149631b2b88686a6ae1337c93939c0ed52f9b32dd0817612557dee54c8f1894::module_interface::create_module_action_result<BTCAction, BTCAccelerated>(arg2, v15, &arg1.cap, to_signable_blobs_p2wpkh(v9.p2wpkh_inputs, v8.outputs))
    }

    public fun prepare_signing_drop(arg0: &mut 0x8149631b2b88686a6ae1337c93939c0ed52f9b32dd0817612557dee54c8f1894::module_interface::VaultContainer, arg1: &BTCModule, arg2: 0x8149631b2b88686a6ae1337c93939c0ed52f9b32dd0817612557dee54c8f1894::module_interface::ModuleActionRequest<BTCAction>, arg3: u64) : 0x8149631b2b88686a6ae1337c93939c0ed52f9b32dd0817612557dee54c8f1894::module_interface::ModuleActionResult<BTCDropped> {
        let (_, _, v2, _, _, v5, _, v7) = 0x8149631b2b88686a6ae1337c93939c0ed52f9b32dd0817612557dee54c8f1894::module_interface::view_module_action_request<BTCAction>(&arg2);
        assert!(v7, 0);
        let v8 = 0x8149631b2b88686a6ae1337c93939c0ed52f9b32dd0817612557dee54c8f1894::module_interface::get_transaction_borrow_mut<BTCChainState, BTCTxData, BTCAction>(arg0, v5, &arg2, &arg1.cap);
        let v9 = 0;
        let v10 = 0;
        while (v10 < 0x1::vector::length<P2WPKHTxInput>(&v8.p2wpkh_inputs)) {
            v9 = v9 + 0x1::vector::borrow<P2WPKHTxInput>(&v8.p2wpkh_inputs, v10).witness_utxo.value;
            v10 = v10 + 1;
        };
        let v11 = v9 - arg3;
        assert!(arg3 <= 0x8149631b2b88686a6ae1337c93939c0ed52f9b32dd0817612557dee54c8f1894::module_interface::get_state_borrow_mut<BTCChainState, BTCTxData, BTCAction>(arg0, &arg2, &arg1.cap).max_value_loss, 3);
        let v12 = TxOutput{
            value        : v11,
            scriptpubkey : v2,
        };
        let v13 = BTCDropped{change_amount: v11};
        0x8149631b2b88686a6ae1337c93939c0ed52f9b32dd0817612557dee54c8f1894::module_interface::create_module_action_result<BTCAction, BTCDropped>(arg2, v13, &arg1.cap, to_signable_blobs_p2wpkh(v8.p2wpkh_inputs, 0x1::vector::singleton<TxOutput>(v12)))
    }

    fun push_script(arg0: vector<u8>) : vector<u8> {
        let v0 = 0x2::hex::decode(arg0);
        let v1 = 0x1::vector::length<u8>(&v0);
        if (v1 == 0 || v1 == 1 && *0x1::vector::borrow<u8>(&v0, 0) == 0) {
            return 0x2::hex::encode(0x1::vector::singleton<u8>(0))
        };
        if (v1 == 1 && *0x1::vector::borrow<u8>(&v0, 0) <= 16) {
            return 0x2::hex::encode(0x1::vector::singleton<u8>(81 + *0x1::vector::borrow<u8>(&v0, 0) - 1))
        };
        if (v1 == 1 && *0x1::vector::borrow<u8>(&v0, 0) == 129) {
            return 0x2::hex::encode(0x1::vector::singleton<u8>(79))
        };
        let v2 = op_push((v1 as u32));
        0x1::vector::append<u8>(&mut v2, arg0);
        v2
    }

    fun sha256d(arg0: vector<u8>) : vector<u8> {
        0x1::hash::sha2_256(0x1::hash::sha2_256(arg0))
    }

    fun test_util_create_bitcoin_module(arg0: 0x8149631b2b88686a6ae1337c93939c0ed52f9b32dd0817612557dee54c8f1894::module_interface::ModuleCap, arg1: &mut 0x2::tx_context::TxContext) : BTCModule {
        BTCModule{
            id  : 0x2::object::new(arg1),
            cap : arg0,
        }
    }

    fun to_signable_blobs_p2wpkh(arg0: vector<P2WPKHTxInput>, arg1: vector<TxOutput>) : vector<vector<u8>> {
        let v0 = 0;
        let v1 = 0x1::vector::empty<vector<u8>>();
        while (v0 < 0x1::vector::length<P2WPKHTxInput>(&arg0)) {
            0x1::vector::push_back<vector<u8>>(&mut v1, 0x1::hash::sha2_256(0x2::hex::decode(transaction_serialize_preimage(arg0, arg1, v0))));
            v0 = v0 + 1;
        };
        v1
    }

    fun transaction_calc_bip143_shared_txdigest_fields(arg0: vector<P2WPKHTxInput>, arg1: vector<TxOutput>) : (vector<u8>, vector<u8>, vector<u8>) {
        let v0 = 0x1::vector::empty<u8>();
        let v1 = 0x1::vector::empty<u8>();
        let v2 = 0x1::vector::empty<u8>();
        let v3 = 0;
        while (v3 < 0x1::vector::length<P2WPKHTxInput>(&arg0)) {
            0x1::vector::append<u8>(&mut v0, tx_outpoint_serialize_to_network(0x1::vector::borrow<P2WPKHTxInput>(&arg0, v3).prevout));
            let v4 = 4294967293;
            0x1::vector::append<u8>(&mut v1, 0x2::hex::encode(0x2::bcs::to_bytes<u32>(&v4)));
            v3 = v3 + 1;
        };
        let v5 = 0;
        while (v5 < 0x1::vector::length<TxOutput>(&arg1)) {
            0x1::vector::append<u8>(&mut v2, 0x2::hex::encode(tx_output_serialize_to_network(0x1::vector::borrow<TxOutput>(&arg1, v5))));
            v5 = v5 + 1;
        };
        (0x2::hex::encode(sha256d(v0)), 0x2::hex::encode(sha256d(0x2::hex::decode(v1))), 0x2::hex::encode(sha256d(0x2::hex::decode(v2))))
    }

    fun transaction_serialize_preimage(arg0: vector<P2WPKHTxInput>, arg1: vector<TxOutput>, arg2: u64) : vector<u8> {
        let (v0, v1, v2) = transaction_calc_bip143_shared_txdigest_fields(arg0, arg1);
        let v3 = 1;
        let v4 = 0;
        let v5 = 0x1::vector::borrow<P2WPKHTxInput>(&arg0, arg2);
        let v6 = 0x2::hex::encode(v5.precalculated_preimage_script);
        let v7 = 1;
        let v8 = var_int(0x1::vector::length<u8>(&v6) / 2);
        0x1::vector::append<u8>(&mut v8, v6);
        let v9 = 4294967293;
        let v10 = 0x1::vector::empty<u8>();
        0x1::vector::append<u8>(&mut v10, 0x2::hex::encode(0x2::bcs::to_bytes<u32>(&v3)));
        0x1::vector::append<u8>(&mut v10, v0);
        0x1::vector::append<u8>(&mut v10, v1);
        0x1::vector::append<u8>(&mut v10, 0x2::hex::encode(tx_outpoint_serialize_to_network(v5.prevout)));
        0x1::vector::append<u8>(&mut v10, v8);
        0x1::vector::append<u8>(&mut v10, 0x2::hex::encode(0x2::bcs::to_bytes<u64>(&v5.witness_utxo.value)));
        0x1::vector::append<u8>(&mut v10, 0x2::hex::encode(0x2::bcs::to_bytes<u32>(&v9)));
        0x1::vector::append<u8>(&mut v10, v2);
        0x1::vector::append<u8>(&mut v10, 0x2::hex::encode(0x2::bcs::to_bytes<u32>(&v4)));
        0x1::vector::append<u8>(&mut v10, 0x2::hex::encode(0x2::bcs::to_bytes<u32>(&v7)));
        v10
    }

    fun tx_outpoint_serialize_to_network(arg0: TxOutpoint) : vector<u8> {
        let v0 = arg0.txid;
        0x1::vector::append<u8>(&mut v0, 0x2::bcs::to_bytes<u32>(&arg0.out_idx));
        v0
    }

    fun tx_output_serialize_to_network(arg0: &TxOutput) : vector<u8> {
        let v0 = 0x2::bcs::to_bytes<u64>(&arg0.value);
        let v1 = 0x2::hex::encode(arg0.scriptpubkey);
        0x1::vector::append<u8>(&mut v0, 0x2::hex::decode(var_int(0x1::vector::length<u8>(&v1) / 2)));
        0x1::vector::append<u8>(&mut v0, arg0.scriptpubkey);
        v0
    }

    fun var_int(arg0: u64) : vector<u8> {
        let v0 = if (arg0 < 253) {
            let v1 = (arg0 as u8);
            0x2::bcs::to_bytes<u8>(&v1)
        } else if (arg0 <= 65535) {
            let v2 = 253;
            let v3 = 0x2::bcs::to_bytes<u8>(&v2);
            let v4 = (arg0 as u16);
            0x1::vector::append<u8>(&mut v3, 0x2::bcs::to_bytes<u16>(&v4));
            v3
        } else if (arg0 <= 4294967295) {
            let v5 = 254;
            let v6 = 0x2::bcs::to_bytes<u8>(&v5);
            let v7 = (arg0 as u32);
            0x1::vector::append<u8>(&mut v6, 0x2::bcs::to_bytes<u32>(&v7));
            v6
        } else {
            let v8 = 255;
            let v9 = 0x2::bcs::to_bytes<u8>(&v8);
            0x1::vector::append<u8>(&mut v9, 0x2::bcs::to_bytes<u64>(&arg0));
            v9
        };
        0x2::hex::encode(v0)
    }

    public fun view_tx_output(arg0: &TxOutput) : (vector<u8>, u64) {
        (arg0.scriptpubkey, arg0.value)
    }

    // decompiled from Move bytecode v6
}

