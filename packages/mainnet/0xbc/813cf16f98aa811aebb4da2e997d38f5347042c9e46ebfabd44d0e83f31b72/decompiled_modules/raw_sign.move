module 0xbc813cf16f98aa811aebb4da2e997d38f5347042c9e46ebfabd44d0e83f31b72::raw_sign {
    struct RawSignModule has key {
        id: 0x2::object::UID,
        cap: 0x8149631b2b88686a6ae1337c93939c0ed52f9b32dd0817612557dee54c8f1894::module_interface::ModuleCap,
        raw_signing_module_id: 0x2::object::ID,
    }

    public fun get_effects_raw_sign(arg0: &RawSignModule, arg1: vector<u8>, arg2: vector<vector<u8>>, arg3: vector<u8>, arg4: 0x1::string::String) : 0x8149631b2b88686a6ae1337c93939c0ed52f9b32dd0817612557dee54c8f1894::module_interface::TxEffectsResult<0x5a4bd7f100e5ca68fdf6aef39aecf9561b8a52fc330b854cbee15aedc3822331::raw_signing_module::RawSigningAction> {
        0x8149631b2b88686a6ae1337c93939c0ed52f9b32dd0817612557dee54c8f1894::module_interface::create_tx_effects<0x5a4bd7f100e5ca68fdf6aef39aecf9561b8a52fc330b854cbee15aedc3822331::raw_signing_module::RawSigningAction>(&arg0.cap, arg1, arg0.raw_signing_module_id, arg4, 0x1::vector::empty<0x1::string::String>(), 0x1::option::none<vector<0x8149631b2b88686a6ae1337c93939c0ed52f9b32dd0817612557dee54c8f1894::library::NetworkAddress>>(), 0x1::vector::empty<0x8149631b2b88686a6ae1337c93939c0ed52f9b32dd0817612557dee54c8f1894::module_interface::BalanceChange>(), 0x5a4bd7f100e5ca68fdf6aef39aecf9561b8a52fc330b854cbee15aedc3822331::raw_signing_module::create_raw_signing_action(arg2, arg3, arg4))
    }

    public fun init_raw_sign_module(arg0: 0x2::object::ID, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::object::new(arg1);
        let v1 = RawSignModule{
            id                    : v0,
            cap                   : 0x8149631b2b88686a6ae1337c93939c0ed52f9b32dd0817612557dee54c8f1894::module_interface::create_module_cap(0x2::object::uid_to_inner(&v0), arg1),
            raw_signing_module_id : arg0,
        };
        0x2::transfer::share_object<RawSignModule>(v1);
    }

    // decompiled from Move bytecode v6
}

