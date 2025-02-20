module 0xbc813cf16f98aa811aebb4da2e997d38f5347042c9e46ebfabd44d0e83f31b72::simulation_cosmos {
    struct CosmosSimulationModule has key {
        id: 0x2::object::UID,
        cap: 0x8149631b2b88686a6ae1337c93939c0ed52f9b32dd0817612557dee54c8f1894::module_interface::ModuleCap,
        simulation_public_key: vector<u8>,
        maximum_delay: u64,
        cosmos_module_id: 0x2::object::ID,
        type_: vector<u8>,
    }

    public fun get_effects_simulation(arg0: &CosmosSimulationModule, arg1: vector<vector<u8>>, arg2: 0x1::string::String, arg3: vector<0x1::string::String>, arg4: 0x1::string::String, arg5: vector<u8>, arg6: vector<0x8149631b2b88686a6ae1337c93939c0ed52f9b32dd0817612557dee54c8f1894::module_interface::BalanceChange>, arg7: 0x1::option::Option<vector<0x8149631b2b88686a6ae1337c93939c0ed52f9b32dd0817612557dee54c8f1894::library::NetworkAddress>>, arg8: u64, arg9: vector<u8>, arg10: &0x2::clock::Clock) : 0x8149631b2b88686a6ae1337c93939c0ed52f9b32dd0817612557dee54c8f1894::module_interface::TxEffectsResult<0x5a4bd7f100e5ca68fdf6aef39aecf9561b8a52fc330b854cbee15aedc3822331::cosmos_module::CosmosAction> {
        let v0 = 0x5a4bd7f100e5ca68fdf6aef39aecf9561b8a52fc330b854cbee15aedc3822331::cosmos_module::create_cosmos_action(arg1, arg2, arg4);
        let v1 = 0x1::string::utf8(b"cosmos:");
        0x1::string::append(&mut v1, arg2);
        let v2 = arg0.type_;
        0x1::vector::append<u8>(&mut v2, 0x2::bcs::to_bytes<0x5a4bd7f100e5ca68fdf6aef39aecf9561b8a52fc330b854cbee15aedc3822331::cosmos_module::CosmosAction>(&v0));
        assert!(0xbc813cf16f98aa811aebb4da2e997d38f5347042c9e46ebfabd44d0e83f31b72::signature_utils::validate_signed_tx_effects(arg0.simulation_public_key, v2, arg5, &arg6, &v1, &arg3, &arg7, arg8, arg0.maximum_delay, arg9, arg10), 0);
        0x8149631b2b88686a6ae1337c93939c0ed52f9b32dd0817612557dee54c8f1894::module_interface::create_tx_effects<0x5a4bd7f100e5ca68fdf6aef39aecf9561b8a52fc330b854cbee15aedc3822331::cosmos_module::CosmosAction>(&arg0.cap, arg5, arg0.cosmos_module_id, v1, arg3, arg7, arg6, v0)
    }

    public fun init_simulation_module(arg0: 0x2::object::ID, arg1: vector<u8>, arg2: u64, arg3: vector<u8>, arg4: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::object::new(arg4);
        let v1 = CosmosSimulationModule{
            id                    : v0,
            cap                   : 0x8149631b2b88686a6ae1337c93939c0ed52f9b32dd0817612557dee54c8f1894::module_interface::create_module_cap(0x2::object::uid_to_inner(&v0), arg4),
            simulation_public_key : arg1,
            maximum_delay         : arg2,
            cosmos_module_id      : arg0,
            type_                 : arg3,
        };
        0x2::transfer::share_object<CosmosSimulationModule>(v1);
    }

    // decompiled from Move bytecode v6
}

