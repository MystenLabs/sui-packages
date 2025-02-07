module 0x5a4bd7f100e5ca68fdf6aef39aecf9561b8a52fc330b854cbee15aedc3822331::cosmos_module {
    struct CosmosAction has copy, drop, store {
        encoded_messages: vector<vector<u8>>,
        cosmos_chain_id: 0x1::string::String,
        memo: 0x1::string::String,
    }

    struct CosmosChainState has copy, drop, store {
        max_sequence: u64,
        max_gas_per_fee_denom: 0x2::vec_map::VecMap<0x1::string::String, u128>,
    }

    struct CosmosTxData has copy, drop, store {
        sequence: u64,
    }

    struct Coin has copy, drop {
        denom: 0x1::string::String,
        amount: 0x1::string::String,
    }

    struct SignDoc has copy, drop {
        body_bytes: vector<u8>,
        auth_info_bytes: vector<u8>,
        cosmos_chain_id: 0x1::string::String,
        account_number: u64,
    }

    struct AuthInfo has copy, drop {
        signer_infos: vector<vector<u8>>,
        fee_opt: 0x1::option::Option<Fee>,
    }

    struct SignerInfo has copy, drop {
        public_key_bytes: vector<u8>,
        mode_info_bytes: vector<u8>,
        sequence: u64,
    }

    struct Fee has copy, drop {
        amount: vector<Coin>,
        gas_limit: u64,
    }

    struct MsgSend has copy, drop {
        from_address: 0x1::string::String,
        to_address: 0x1::string::String,
        amount: vector<Coin>,
    }

    struct TxBody has copy, drop {
        encoded_messages: vector<vector<u8>>,
        memo: 0x1::string::String,
    }

    struct ProtoAny has copy, drop, store {
        type_url: 0x1::string::String,
        value: vector<u8>,
    }

    struct CosmosModule has key {
        id: 0x2::object::UID,
        cap: 0x8149631b2b88686a6ae1337c93939c0ed52f9b32dd0817612557dee54c8f1894::module_interface::ModuleCap,
    }

    struct CosmosPreparedSigning has copy, drop, store {
        body_bytes: vector<u8>,
        auth_info_bytes: vector<u8>,
        gas_limit: u64,
        coin_fee_amount: 0x1::string::String,
        coin_fee_denom: 0x1::string::String,
    }

    struct CosmosAccelerated has copy, drop, store {
        gas_limit: u64,
        coin_fee_amount: 0x1::string::String,
        coin_fee_denom: 0x1::string::String,
    }

    struct CosmosDropped has copy, drop, store {
        gas_limit: u64,
        coin_fee_amount: 0x1::string::String,
        coin_fee_denom: 0x1::string::String,
    }

    public fun assemble_cosmos_transfer_action(arg0: vector<u8>, arg1: vector<u8>, arg2: 0x1::string::String, arg3: u256, arg4: 0x1::string::String, arg5: 0x1::string::String) : CosmosAction {
        let v0 = 0x1::vector::empty<Coin>();
        0x1::vector::push_back<Coin>(&mut v0, create_coin(arg2, 0x1::u256::to_string(arg3)));
        let v1 = create_message_send(0x1::string::utf8(arg0), 0x1::string::utf8(arg1), v0);
        let v2 = 0x1::vector::empty<u8>();
        let v3 = &mut v2;
        let v4 = &mut v1;
        encode_MsgSend(v3, v4);
        let v5 = 0x1::vector::empty<u8>();
        let v6 = &mut v5;
        encode_Any(v6, create_proto_any(0x1::string::utf8(b"/cosmos.bank.v1beta1.MsgSend"), v2));
        create_cosmos_action(0x1::vector::singleton<vector<u8>>(v5), arg4, arg5)
    }

    public fun create_coin(arg0: 0x1::string::String, arg1: 0x1::string::String) : Coin {
        Coin{
            denom  : arg0,
            amount : arg1,
        }
    }

    public fun create_cosmos_action(arg0: vector<vector<u8>>, arg1: 0x1::string::String, arg2: 0x1::string::String) : CosmosAction {
        CosmosAction{
            encoded_messages : arg0,
            cosmos_chain_id  : arg1,
            memo             : arg2,
        }
    }

    public fun create_cosmos_chain_state(arg0: u64, arg1: 0x2::vec_map::VecMap<0x1::string::String, u128>) : CosmosChainState {
        CosmosChainState{
            max_sequence          : arg0,
            max_gas_per_fee_denom : arg1,
        }
    }

    public fun create_message_send(arg0: 0x1::string::String, arg1: 0x1::string::String, arg2: vector<Coin>) : MsgSend {
        MsgSend{
            from_address : arg0,
            to_address   : arg1,
            amount       : arg2,
        }
    }

    public fun create_module_shared_data_cosmos(arg0: &CosmosModule, arg1: 0x2::vec_map::VecMap<0x1::string::String, CosmosChainState>, arg2: &mut 0x2::tx_context::TxContext) : 0x8149631b2b88686a6ae1337c93939c0ed52f9b32dd0817612557dee54c8f1894::module_interface::ModuleSharedData<CosmosChainState> {
        0x8149631b2b88686a6ae1337c93939c0ed52f9b32dd0817612557dee54c8f1894::module_interface::create_module_shared_data<CosmosChainState>(&arg0.cap, arg1, arg2)
    }

    public fun create_proto_any(arg0: 0x1::string::String, arg1: vector<u8>) : ProtoAny {
        ProtoAny{
            type_url : arg0,
            value    : arg1,
        }
    }

    public fun encode_Any(arg0: &mut vector<u8>, arg1: ProtoAny) {
        if (!0x1::string::is_empty(&arg1.type_url)) {
            encode_u32(arg0, 10);
            encode_utf8(arg0, &arg1.type_url);
        };
        if (0x1::vector::length<u8>(&arg1.value) != 0) {
            encode_u32(arg0, 18);
            encode_bytes(arg0, arg1.value);
        };
    }

    public fun encode_AuthInfo(arg0: &mut vector<u8>, arg1: &mut AuthInfo) {
        let v0 = 0x1::vector::length<vector<u8>>(&arg1.signer_infos);
        while (v0 > 0) {
            encode_with_len(arg0, 10, 0x1::vector::pop_back<vector<u8>>(&mut arg1.signer_infos));
            v0 = v0 - 1;
        };
        if (0x1::option::is_some<Fee>(&arg1.fee_opt)) {
            let v1 = 0x1::vector::empty<u8>();
            let v2 = 0x1::option::extract<Fee>(&mut arg1.fee_opt);
            let v3 = &mut v1;
            let v4 = &mut v2;
            encode_Fee(v3, v4);
            encode_with_len(arg0, 18, v1);
        };
    }

    public fun encode_Coin(arg0: &mut vector<u8>, arg1: Coin) {
        if (!0x1::string::is_empty(&arg1.denom)) {
            encode_u32(arg0, 10);
            encode_utf8(arg0, &arg1.denom);
        };
        if (!0x1::string::is_empty(&arg1.amount)) {
            encode_u32(arg0, 18);
            encode_utf8(arg0, &arg1.amount);
        };
    }

    public fun encode_Fee(arg0: &mut vector<u8>, arg1: &mut Fee) {
        if (0x1::vector::length<Coin>(&arg1.amount) != 0) {
            let v0 = 0x1::vector::empty<u8>();
            let v1 = &mut v0;
            encode_Coin(v1, 0x1::vector::remove<Coin>(&mut arg1.amount, 0));
            encode_with_len(arg0, 10, v0);
        };
        if (arg1.gas_limit != 0) {
            encode_u32(arg0, 16);
            encode_u64(arg0, arg1.gas_limit);
        };
    }

    public fun encode_MsgSend(arg0: &mut vector<u8>, arg1: &mut MsgSend) {
        if (!0x1::string::is_empty(&arg1.from_address)) {
            encode_u32(arg0, 10);
            encode_utf8(arg0, &arg1.from_address);
        };
        if (!0x1::string::is_empty(&arg1.to_address)) {
            encode_u32(arg0, 18);
            encode_utf8(arg0, &arg1.to_address);
        };
        let v0 = 0x1::vector::empty<u8>();
        let v1 = &mut v0;
        encode_Coin(v1, 0x1::vector::remove<Coin>(&mut arg1.amount, 0));
        encode_with_len(arg0, 26, v0);
    }

    public fun encode_SignDoc(arg0: &mut vector<u8>, arg1: SignDoc) {
        if (0x1::vector::length<u8>(&arg1.body_bytes) != 0) {
            encode_u32(arg0, 10);
            encode_bytes(arg0, arg1.body_bytes);
        };
        if (0x1::vector::length<u8>(&arg1.auth_info_bytes) != 0) {
            encode_u32(arg0, 18);
            encode_bytes(arg0, arg1.auth_info_bytes);
        };
        if (0x1::string::is_empty(&arg1.cosmos_chain_id) == false) {
            encode_u32(arg0, 26);
            encode_utf8(arg0, &arg1.cosmos_chain_id);
        };
        if (arg1.account_number != 0) {
            encode_u32(arg0, 32);
            encode_u64(arg0, arg1.account_number);
        };
    }

    public fun encode_SignerInfo(arg0: &mut vector<u8>, arg1: &mut SignerInfo) {
        if (0x1::vector::length<u8>(&arg1.public_key_bytes) != 0) {
            encode_with_len(arg0, 10, arg1.public_key_bytes);
        };
        if (0x1::vector::length<u8>(&arg1.mode_info_bytes) != 0) {
            encode_with_len(arg0, 18, arg1.mode_info_bytes);
        };
        if (arg1.sequence != 0) {
            encode_u32(arg0, 24);
            encode_u64(arg0, arg1.sequence);
        };
    }

    public fun encode_TxBody(arg0: &mut vector<u8>, arg1: &mut TxBody) {
        let v0 = 0x1::vector::length<vector<u8>>(&arg1.encoded_messages);
        while (v0 > 0) {
            encode_with_len(arg0, 10, 0x1::vector::remove<vector<u8>>(&mut arg1.encoded_messages, 0));
            v0 = v0 - 1;
        };
        if (!0x1::string::is_empty(&arg1.memo)) {
            encode_u32(arg0, 18);
            encode_utf8(arg0, &arg1.memo);
        };
    }

    public fun encode_bytes(arg0: &mut vector<u8>, arg1: vector<u8>) {
        let v0 = 0x1::vector::length<u8>(&arg1);
        assert!(v0 > 0, 0);
        encode_u32(arg0, (v0 as u32));
        0x1::vector::append<u8>(arg0, arg1);
    }

    public fun encode_u32(arg0: &mut vector<u8>, arg1: u32) {
        while (arg1 > 127) {
            0x1::vector::push_back<u8>(arg0, ((arg1 & 127 | 128) as u8));
            arg1 = arg1 >> 7;
        };
        0x1::vector::push_back<u8>(arg0, (arg1 as u8));
    }

    public fun encode_u64(arg0: &mut vector<u8>, arg1: u64) {
        let (v0, v1) = split_u64(arg1);
        encode_varint64(arg0, v0, v1);
    }

    public fun encode_utf8(arg0: &mut vector<u8>, arg1: &0x1::string::String) {
        encode_u32(arg0, (0x1::string::length(arg1) as u32));
        0x1::vector::append<u8>(arg0, *0x1::string::as_bytes(arg1));
    }

    fun encode_varint64(arg0: &mut vector<u8>, arg1: u32, arg2: u32) {
        while (arg2 != 0) {
            0x1::vector::push_back<u8>(arg0, ((arg1 & 127 | 128) as u8));
            let v0 = arg1 >> 7 | arg2 << 25;
            arg1 = v0 & 4294967295;
            arg2 = arg2 >> 7;
        };
        while (arg1 > 127) {
            0x1::vector::push_back<u8>(arg0, ((arg1 & 127 | 128) as u8));
            arg1 = arg1 >> 7;
        };
        0x1::vector::push_back<u8>(arg0, ((arg1 & 127) as u8));
    }

    public fun encode_with_len(arg0: &mut vector<u8>, arg1: u32, arg2: vector<u8>) {
        encode_u32(arg0, arg1);
        encode_u32(arg0, (0x1::vector::length<u8>(&arg2) as u32));
        0x1::vector::append<u8>(arg0, arg2);
    }

    public fun init_cosmos_module(arg0: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::object::new(arg0);
        let v1 = CosmosModule{
            id  : v0,
            cap : 0x8149631b2b88686a6ae1337c93939c0ed52f9b32dd0817612557dee54c8f1894::module_interface::create_module_cap(0x2::object::uid_to_inner(&v0), arg0),
        };
        0x2::transfer::share_object<CosmosModule>(v1);
    }

    fun make_auth_info_bytes(arg0: vector<u8>, arg1: vector<Coin>, arg2: u64) : vector<u8> {
        let v0 = Fee{
            amount    : arg1,
            gas_limit : arg2,
        };
        let v1 = AuthInfo{
            signer_infos : 0x1::vector::singleton<vector<u8>>(arg0),
            fee_opt      : 0x1::option::some<Fee>(v0),
        };
        let v2 = 0x1::vector::empty<u8>();
        let v3 = &mut v2;
        let v4 = &mut v1;
        encode_AuthInfo(v3, v4);
        v2
    }

    fun make_sign_bytes(arg0: vector<u8>, arg1: vector<u8>, arg2: 0x1::string::String, arg3: u64) : vector<u8> {
        let v0 = SignDoc{
            body_bytes      : arg0,
            auth_info_bytes : arg1,
            cosmos_chain_id : arg2,
            account_number  : arg3,
        };
        let v1 = 0x1::vector::empty<u8>();
        let v2 = &mut v1;
        encode_SignDoc(v2, v0);
        v1
    }

    fun make_sign_info_bytes(arg0: vector<u8>, arg1: vector<u8>, arg2: u64) : vector<u8> {
        let v0 = SignerInfo{
            public_key_bytes : arg0,
            mode_info_bytes  : arg1,
            sequence         : arg2,
        };
        let v1 = 0x1::vector::empty<u8>();
        let v2 = &mut v1;
        let v3 = &mut v0;
        encode_SignerInfo(v2, v3);
        v1
    }

    fun make_tx_body_bytes(arg0: vector<vector<u8>>, arg1: 0x1::string::String) : vector<u8> {
        let v0 = TxBody{
            encoded_messages : arg0,
            memo             : arg1,
        };
        let v1 = 0x1::vector::empty<u8>();
        let v2 = &mut v1;
        let v3 = &mut v0;
        encode_TxBody(v2, v3);
        v1
    }

    public fun prepare_signing(arg0: &mut 0x8149631b2b88686a6ae1337c93939c0ed52f9b32dd0817612557dee54c8f1894::module_interface::VaultContainer, arg1: &CosmosModule, arg2: 0x8149631b2b88686a6ae1337c93939c0ed52f9b32dd0817612557dee54c8f1894::module_interface::ModuleActionRequest<CosmosAction>, arg3: u64, arg4: 0x1::string::String, arg5: u128, arg6: vector<u8>, arg7: vector<u8>, arg8: u64, arg9: u64) : 0x8149631b2b88686a6ae1337c93939c0ed52f9b32dd0817612557dee54c8f1894::module_interface::ModuleActionResult<CosmosPreparedSigning> {
        let v0 = 0x8149631b2b88686a6ae1337c93939c0ed52f9b32dd0817612557dee54c8f1894::module_interface::get_state_borrow_mut<CosmosChainState, CosmosTxData, CosmosAction>(arg0, &arg2, &arg1.cap);
        let (_, _, _, _, _, v6, v7, v8) = 0x8149631b2b88686a6ae1337c93939c0ed52f9b32dd0817612557dee54c8f1894::module_interface::view_module_action_request<CosmosAction>(&arg2);
        let v9 = v7;
        assert!(!v8, 0);
        if (arg9 == v0.max_sequence + 1) {
            v0.max_sequence = v0.max_sequence + 1;
        };
        assert!(*0x2::vec_map::get<0x1::string::String, u128>(&v0.max_gas_per_fee_denom, &arg4) >= arg5, 2);
        assert!(arg9 <= v0.max_sequence, 3);
        let v10 = make_auth_info_bytes(make_sign_info_bytes(arg6, arg7, arg9), 0x1::vector::singleton<Coin>(create_coin(arg4, 0x1::u128::to_string(arg5))), arg3);
        let v11 = make_tx_body_bytes(v9.encoded_messages, v9.memo);
        let v12 = CosmosPreparedSigning{
            body_bytes      : v11,
            auth_info_bytes : v10,
            gas_limit       : arg3,
            coin_fee_amount : 0x1::u128::to_string(arg5),
            coin_fee_denom  : arg4,
        };
        let v13 = CosmosTxData{sequence: arg9};
        0x8149631b2b88686a6ae1337c93939c0ed52f9b32dd0817612557dee54c8f1894::module_interface::add_transaction<CosmosChainState, CosmosTxData, CosmosAction>(arg0, v6, v13, &arg2, &arg1.cap);
        0x8149631b2b88686a6ae1337c93939c0ed52f9b32dd0817612557dee54c8f1894::module_interface::create_module_action_result<CosmosAction, CosmosPreparedSigning>(arg2, v12, &arg1.cap, 0x1::vector::singleton<vector<u8>>(make_sign_bytes(v11, v10, v9.cosmos_chain_id, arg8)))
    }

    public fun prepare_signing_accelerate(arg0: &mut 0x8149631b2b88686a6ae1337c93939c0ed52f9b32dd0817612557dee54c8f1894::module_interface::VaultContainer, arg1: &CosmosModule, arg2: 0x8149631b2b88686a6ae1337c93939c0ed52f9b32dd0817612557dee54c8f1894::module_interface::ModuleActionRequest<CosmosAction>, arg3: u64, arg4: 0x1::string::String, arg5: u128, arg6: vector<u8>, arg7: vector<u8>, arg8: u64) : 0x8149631b2b88686a6ae1337c93939c0ed52f9b32dd0817612557dee54c8f1894::module_interface::ModuleActionResult<CosmosAccelerated> {
        let (_, _, _, _, _, v5, v6, v7) = 0x8149631b2b88686a6ae1337c93939c0ed52f9b32dd0817612557dee54c8f1894::module_interface::view_module_action_request<CosmosAction>(&arg2);
        let v8 = v6;
        assert!(v7, 1);
        assert!(*0x2::vec_map::get<0x1::string::String, u128>(&0x8149631b2b88686a6ae1337c93939c0ed52f9b32dd0817612557dee54c8f1894::module_interface::get_state_borrow_mut<CosmosChainState, CosmosTxData, CosmosAction>(arg0, &arg2, &arg1.cap).max_gas_per_fee_denom, &arg4) >= arg5, 2);
        let v9 = CosmosAccelerated{
            gas_limit       : arg3,
            coin_fee_amount : 0x1::u128::to_string(arg5),
            coin_fee_denom  : arg4,
        };
        0x8149631b2b88686a6ae1337c93939c0ed52f9b32dd0817612557dee54c8f1894::module_interface::create_module_action_result<CosmosAction, CosmosAccelerated>(arg2, v9, &arg1.cap, 0x1::vector::singleton<vector<u8>>(make_sign_bytes(make_tx_body_bytes(v8.encoded_messages, v8.memo), make_auth_info_bytes(make_sign_info_bytes(arg6, arg7, 0x8149631b2b88686a6ae1337c93939c0ed52f9b32dd0817612557dee54c8f1894::module_interface::get_transaction_borrow_mut<CosmosChainState, CosmosTxData, CosmosAction>(arg0, v5, &arg2, &arg1.cap).sequence), 0x1::vector::singleton<Coin>(create_coin(arg4, 0x1::u128::to_string(arg5))), arg3), v8.cosmos_chain_id, arg8)))
    }

    public fun prepare_signing_drop(arg0: &mut 0x8149631b2b88686a6ae1337c93939c0ed52f9b32dd0817612557dee54c8f1894::module_interface::VaultContainer, arg1: &CosmosModule, arg2: 0x8149631b2b88686a6ae1337c93939c0ed52f9b32dd0817612557dee54c8f1894::module_interface::ModuleActionRequest<CosmosAction>, arg3: u64, arg4: 0x1::string::String, arg5: u128, arg6: vector<u8>, arg7: vector<u8>, arg8: u64, arg9: 0x1::string::String) : 0x8149631b2b88686a6ae1337c93939c0ed52f9b32dd0817612557dee54c8f1894::module_interface::ModuleActionResult<CosmosDropped> {
        let (_, _, v2, _, _, v5, v6, v7) = 0x8149631b2b88686a6ae1337c93939c0ed52f9b32dd0817612557dee54c8f1894::module_interface::view_module_action_request<CosmosAction>(&arg2);
        let v8 = v6;
        assert!(v7, 1);
        assert!(*0x2::vec_map::get<0x1::string::String, u128>(&0x8149631b2b88686a6ae1337c93939c0ed52f9b32dd0817612557dee54c8f1894::module_interface::get_state_borrow_mut<CosmosChainState, CosmosTxData, CosmosAction>(arg0, &arg2, &arg1.cap).max_gas_per_fee_denom, &arg4) >= arg5, 2);
        let v9 = assemble_cosmos_transfer_action(v2, v2, arg9, 1, v8.cosmos_chain_id, 0x1::string::utf8(b""));
        let v10 = CosmosDropped{
            gas_limit       : arg3,
            coin_fee_amount : 0x1::u128::to_string(arg5),
            coin_fee_denom  : arg4,
        };
        0x8149631b2b88686a6ae1337c93939c0ed52f9b32dd0817612557dee54c8f1894::module_interface::create_module_action_result<CosmosAction, CosmosDropped>(arg2, v10, &arg1.cap, 0x1::vector::singleton<vector<u8>>(make_sign_bytes(make_tx_body_bytes(v9.encoded_messages, 0x1::string::utf8(b"")), make_auth_info_bytes(make_sign_info_bytes(arg6, arg7, 0x8149631b2b88686a6ae1337c93939c0ed52f9b32dd0817612557dee54c8f1894::module_interface::get_transaction_borrow_mut<CosmosChainState, CosmosTxData, CosmosAction>(arg0, v5, &arg2, &arg1.cap).sequence), 0x1::vector::singleton<Coin>(create_coin(arg4, 0x1::u128::to_string(arg5))), arg3), v8.cosmos_chain_id, arg8)))
    }

    public fun split_u64(arg0: u64) : (u32, u32) {
        (((arg0 & 4294967295) as u32), ((arg0 >> 32) as u32))
    }

    fun test_util_create_cosmos_module(arg0: 0x8149631b2b88686a6ae1337c93939c0ed52f9b32dd0817612557dee54c8f1894::module_interface::ModuleCap, arg1: &mut 0x2::tx_context::TxContext) : CosmosModule {
        CosmosModule{
            id  : 0x2::object::new(arg1),
            cap : arg0,
        }
    }

    fun test_util_create_cosmos_transaction(arg0: u64) : CosmosTxData {
        CosmosTxData{sequence: arg0}
    }

    // decompiled from Move bytecode v6
}

