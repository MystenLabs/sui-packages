module 0xbc813cf16f98aa811aebb4da2e997d38f5347042c9e46ebfabd44d0e83f31b72::simulate_sui {
    struct SuiSimulationModule has key {
        id: 0x2::object::UID,
        cap: 0x8149631b2b88686a6ae1337c93939c0ed52f9b32dd0817612557dee54c8f1894::module_interface::ModuleCap,
        sui_module_id: 0x2::object::ID,
        simulation_public_key: vector<u8>,
        maximum_delay: u64,
        type_: vector<u8>,
    }

    public fun get_effects_sui_simulation(arg0: &SuiSimulationModule, arg1: vector<0x5a4bd7f100e5ca68fdf6aef39aecf9561b8a52fc330b854cbee15aedc3822331::sui_module::CommandX>, arg2: vector<0x5a4bd7f100e5ca68fdf6aef39aecf9561b8a52fc330b854cbee15aedc3822331::sui_module::VirtualInput>, arg3: 0x1::option::Option<vector<0x8149631b2b88686a6ae1337c93939c0ed52f9b32dd0817612557dee54c8f1894::library::NetworkAddress>>, arg4: 0x1::string::String, arg5: vector<0x1::string::String>, arg6: vector<u8>, arg7: vector<0x8149631b2b88686a6ae1337c93939c0ed52f9b32dd0817612557dee54c8f1894::module_interface::BalanceChange>, arg8: u64, arg9: vector<u8>, arg10: &0x2::clock::Clock) : 0x8149631b2b88686a6ae1337c93939c0ed52f9b32dd0817612557dee54c8f1894::module_interface::TxEffectsResult<0x5a4bd7f100e5ca68fdf6aef39aecf9561b8a52fc330b854cbee15aedc3822331::sui_module::SuiAction> {
        let v0 = 0x5a4bd7f100e5ca68fdf6aef39aecf9561b8a52fc330b854cbee15aedc3822331::sui_module::create_sui_action(arg2, arg1);
        let v1 = 0x1::string::utf8(b"sui:");
        0x1::string::append(&mut v1, arg4);
        let v2 = arg0.type_;
        0x1::vector::append<u8>(&mut v2, 0x2::bcs::to_bytes<0x5a4bd7f100e5ca68fdf6aef39aecf9561b8a52fc330b854cbee15aedc3822331::sui_module::SuiAction>(&v0));
        assert!(0xbc813cf16f98aa811aebb4da2e997d38f5347042c9e46ebfabd44d0e83f31b72::signature_utils::validate_signed_tx_effects(arg0.simulation_public_key, v2, arg6, &arg7, &v1, &arg5, &arg3, arg8, arg0.maximum_delay, arg9, arg10), 0);
        0x8149631b2b88686a6ae1337c93939c0ed52f9b32dd0817612557dee54c8f1894::module_interface::create_tx_effects<0x5a4bd7f100e5ca68fdf6aef39aecf9561b8a52fc330b854cbee15aedc3822331::sui_module::SuiAction>(&arg0.cap, arg6, arg0.sui_module_id, v1, arg5, arg3, arg7, v0)
    }

    public fun init_sui_txb_module(arg0: 0x2::object::ID, arg1: vector<u8>, arg2: u64, arg3: vector<u8>, arg4: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::object::new(arg4);
        let v1 = SuiSimulationModule{
            id                    : v0,
            cap                   : 0x8149631b2b88686a6ae1337c93939c0ed52f9b32dd0817612557dee54c8f1894::module_interface::create_module_cap(0x2::object::uid_to_inner(&v0), arg4),
            sui_module_id         : arg0,
            simulation_public_key : arg1,
            maximum_delay         : arg2,
            type_                 : arg3,
        };
        0x2::transfer::share_object<SuiSimulationModule>(v1);
    }

    // decompiled from Move bytecode v6
}

