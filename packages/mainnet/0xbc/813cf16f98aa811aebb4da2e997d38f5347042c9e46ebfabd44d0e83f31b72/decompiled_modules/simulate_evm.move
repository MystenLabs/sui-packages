module 0xbc813cf16f98aa811aebb4da2e997d38f5347042c9e46ebfabd44d0e83f31b72::simulate_evm {
    struct EvmSimulationModule has key {
        id: 0x2::object::UID,
        cap: 0x8149631b2b88686a6ae1337c93939c0ed52f9b32dd0817612557dee54c8f1894::module_interface::ModuleCap,
        simulation_public_key: vector<u8>,
        maximum_delay: u64,
        eth_module_id: 0x2::object::ID,
        type_: vector<u8>,
    }

    public fun get_effects_simulation(arg0: &EvmSimulationModule, arg1: vector<u8>, arg2: vector<u8>, arg3: vector<u8>, arg4: 0x1::string::String, arg5: vector<0x1::string::String>, arg6: vector<0x8149631b2b88686a6ae1337c93939c0ed52f9b32dd0817612557dee54c8f1894::module_interface::BalanceChange>, arg7: vector<u8>, arg8: 0x1::option::Option<vector<0x8149631b2b88686a6ae1337c93939c0ed52f9b32dd0817612557dee54c8f1894::library::NetworkAddress>>, arg9: u64, arg10: vector<u8>, arg11: &0x2::clock::Clock) : 0x8149631b2b88686a6ae1337c93939c0ed52f9b32dd0817612557dee54c8f1894::module_interface::TxEffectsResult<0x5a4bd7f100e5ca68fdf6aef39aecf9561b8a52fc330b854cbee15aedc3822331::eth_module::EVMAction> {
        let v0 = 0x5a4bd7f100e5ca68fdf6aef39aecf9561b8a52fc330b854cbee15aedc3822331::eth_module::string_to_number(*0x1::string::as_bytes(&arg4));
        let v1 = 0x5a4bd7f100e5ca68fdf6aef39aecf9561b8a52fc330b854cbee15aedc3822331::eth_module::create_evm_action(arg1, arg2, arg3, 0x5a4bd7f100e5ca68fdf6aef39aecf9561b8a52fc330b854cbee15aedc3822331::eth_module::to_minimal_be_bytes<u32>(&v0));
        let v2 = 0x1::string::utf8(b"ethereum:");
        0x1::string::append(&mut v2, arg4);
        let v3 = arg0.type_;
        0x1::vector::append<u8>(&mut v3, 0x2::bcs::to_bytes<0x5a4bd7f100e5ca68fdf6aef39aecf9561b8a52fc330b854cbee15aedc3822331::eth_module::EVMAction>(&v1));
        assert!(0xbc813cf16f98aa811aebb4da2e997d38f5347042c9e46ebfabd44d0e83f31b72::signature_utils::validate_signed_tx_effects(arg0.simulation_public_key, v3, arg7, &arg6, &v2, &arg5, &arg8, arg9, arg0.maximum_delay, arg10, arg11), 0);
        0x8149631b2b88686a6ae1337c93939c0ed52f9b32dd0817612557dee54c8f1894::module_interface::create_tx_effects<0x5a4bd7f100e5ca68fdf6aef39aecf9561b8a52fc330b854cbee15aedc3822331::eth_module::EVMAction>(&arg0.cap, arg7, arg0.eth_module_id, v2, arg5, arg8, arg6, v1)
    }

    public fun init_simulation_module(arg0: 0x2::object::ID, arg1: vector<u8>, arg2: u64, arg3: vector<u8>, arg4: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::object::new(arg4);
        let v1 = EvmSimulationModule{
            id                    : v0,
            cap                   : 0x8149631b2b88686a6ae1337c93939c0ed52f9b32dd0817612557dee54c8f1894::module_interface::create_module_cap(0x2::object::uid_to_inner(&v0), arg4),
            simulation_public_key : arg1,
            maximum_delay         : arg2,
            eth_module_id         : arg0,
            type_                 : arg3,
        };
        0x2::transfer::share_object<EvmSimulationModule>(v1);
    }

    // decompiled from Move bytecode v6
}

