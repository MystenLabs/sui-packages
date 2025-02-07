module 0x5a4bd7f100e5ca68fdf6aef39aecf9561b8a52fc330b854cbee15aedc3822331::raw_signing_module {
    struct RawSigningModule has key {
        id: 0x2::object::UID,
        cap: 0x8149631b2b88686a6ae1337c93939c0ed52f9b32dd0817612557dee54c8f1894::module_interface::ModuleCap,
    }

    struct RawChainState has copy, drop, store {
        dummy_field: bool,
    }

    struct RawTxData has copy, drop, store {
        dummy_field: bool,
    }

    struct RawSigningAction has copy, drop, store {
        raw_tx: vector<vector<u8>>,
    }

    struct RawSigningActionCreated has copy, drop, store {
        raw_tx: vector<vector<u8>>,
        display_data: vector<u8>,
        network_id: 0x1::string::String,
    }

    struct RawPreparedSigning has copy, drop, store {
        dummy_field: bool,
    }

    public fun create_module_shared_data_raw(arg0: &RawSigningModule, arg1: 0x2::vec_map::VecMap<0x1::string::String, RawChainState>, arg2: &mut 0x2::tx_context::TxContext) : 0x8149631b2b88686a6ae1337c93939c0ed52f9b32dd0817612557dee54c8f1894::module_interface::ModuleSharedData<RawChainState> {
        0x8149631b2b88686a6ae1337c93939c0ed52f9b32dd0817612557dee54c8f1894::module_interface::create_module_shared_data<RawChainState>(&arg0.cap, arg1, arg2)
    }

    public fun create_raw_chain_state() : RawChainState {
        RawChainState{dummy_field: false}
    }

    public fun create_raw_signing_action(arg0: vector<vector<u8>>, arg1: vector<u8>, arg2: 0x1::string::String) : RawSigningAction {
        let v0 = RawSigningActionCreated{
            raw_tx       : arg0,
            display_data : arg1,
            network_id   : arg2,
        };
        0x2::event::emit<RawSigningActionCreated>(v0);
        RawSigningAction{raw_tx: arg0}
    }

    public fun init_raw_signing_module(arg0: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::object::new(arg0);
        let v1 = RawSigningModule{
            id  : v0,
            cap : 0x8149631b2b88686a6ae1337c93939c0ed52f9b32dd0817612557dee54c8f1894::module_interface::create_module_cap(0x2::object::uid_to_inner(&v0), arg0),
        };
        0x2::transfer::share_object<RawSigningModule>(v1);
    }

    public fun prepare_signing(arg0: &RawSigningModule, arg1: 0x8149631b2b88686a6ae1337c93939c0ed52f9b32dd0817612557dee54c8f1894::module_interface::ModuleActionRequest<RawSigningAction>) : 0x8149631b2b88686a6ae1337c93939c0ed52f9b32dd0817612557dee54c8f1894::module_interface::ModuleActionResult<RawPreparedSigning> {
        let (_, _, _, _, _, _, v6, v7) = 0x8149631b2b88686a6ae1337c93939c0ed52f9b32dd0817612557dee54c8f1894::module_interface::view_module_action_request<RawSigningAction>(&arg1);
        let v8 = v6;
        assert!(!v7, 0);
        let v9 = RawPreparedSigning{dummy_field: false};
        0x8149631b2b88686a6ae1337c93939c0ed52f9b32dd0817612557dee54c8f1894::module_interface::create_module_action_result<RawSigningAction, RawPreparedSigning>(arg1, v9, &arg0.cap, v8.raw_tx)
    }

    // decompiled from Move bytecode v6
}

