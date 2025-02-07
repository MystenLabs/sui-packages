module 0xbc813cf16f98aa811aebb4da2e997d38f5347042c9e46ebfabd44d0e83f31b72::simulate_raw {
    struct RawSimulationModule has key {
        id: 0x2::object::UID,
        cap: 0x8149631b2b88686a6ae1337c93939c0ed52f9b32dd0817612557dee54c8f1894::module_interface::ModuleCap,
        simulation_public_key: vector<u8>,
        maximum_delay: u64,
        raw_signing_module_id: 0x2::object::ID,
        type_: vector<u8>,
    }

    public fun get_effects_simulation_tx_raw(arg0: &RawSimulationModule, arg1: vector<vector<u8>>, arg2: vector<u8>, arg3: vector<u8>, arg4: vector<0x8149631b2b88686a6ae1337c93939c0ed52f9b32dd0817612557dee54c8f1894::module_interface::BalanceChange>, arg5: 0x1::option::Option<vector<0x8149631b2b88686a6ae1337c93939c0ed52f9b32dd0817612557dee54c8f1894::library::NetworkAddress>>, arg6: 0x1::string::String, arg7: vector<0x1::string::String>, arg8: u64, arg9: vector<u8>, arg10: &0x2::clock::Clock) : 0x8149631b2b88686a6ae1337c93939c0ed52f9b32dd0817612557dee54c8f1894::module_interface::TxEffectsResult<0x5a4bd7f100e5ca68fdf6aef39aecf9561b8a52fc330b854cbee15aedc3822331::raw_signing_module::RawSigningAction> {
        let v0 = arg0.type_;
        0x1::vector::append<u8>(&mut v0, b"-");
        0x1::vector::append<u8>(&mut v0, arg2);
        let v1 = 0x5a4bd7f100e5ca68fdf6aef39aecf9561b8a52fc330b854cbee15aedc3822331::raw_signing_module::create_raw_signing_action(arg1, v0, arg6);
        let v2 = 0x2::bcs::to_bytes<0x5a4bd7f100e5ca68fdf6aef39aecf9561b8a52fc330b854cbee15aedc3822331::raw_signing_module::RawSigningAction>(&v1);
        0x1::vector::append<u8>(&mut v2, 0x2::bcs::to_bytes<vector<u8>>(&arg0.type_));
        assert!(0xbc813cf16f98aa811aebb4da2e997d38f5347042c9e46ebfabd44d0e83f31b72::signature_utils::validate_signed_tx_effects(arg0.simulation_public_key, v2, arg3, &arg4, &arg6, &arg7, &arg5, arg8, arg0.maximum_delay, arg9, arg10), 0);
        0x8149631b2b88686a6ae1337c93939c0ed52f9b32dd0817612557dee54c8f1894::module_interface::create_tx_effects<0x5a4bd7f100e5ca68fdf6aef39aecf9561b8a52fc330b854cbee15aedc3822331::raw_signing_module::RawSigningAction>(&arg0.cap, arg3, arg0.raw_signing_module_id, arg6, arg7, arg5, arg4, v1)
    }

    public fun init_simulation_module(arg0: 0x2::object::ID, arg1: vector<u8>, arg2: u64, arg3: vector<u8>, arg4: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::object::new(arg4);
        let v1 = RawSimulationModule{
            id                    : v0,
            cap                   : 0x8149631b2b88686a6ae1337c93939c0ed52f9b32dd0817612557dee54c8f1894::module_interface::create_module_cap(0x2::object::uid_to_inner(&v0), arg4),
            simulation_public_key : arg1,
            maximum_delay         : arg2,
            raw_signing_module_id : arg0,
            type_                 : arg3,
        };
        0x2::transfer::share_object<RawSimulationModule>(v1);
    }

    // decompiled from Move bytecode v6
}

