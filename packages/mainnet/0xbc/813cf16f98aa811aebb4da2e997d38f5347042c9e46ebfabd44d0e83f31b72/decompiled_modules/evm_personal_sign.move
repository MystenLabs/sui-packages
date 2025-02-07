module 0xbc813cf16f98aa811aebb4da2e997d38f5347042c9e46ebfabd44d0e83f31b72::evm_personal_sign {
    struct EVMPersonalSignModule has key {
        id: 0x2::object::UID,
        cap: 0x8149631b2b88686a6ae1337c93939c0ed52f9b32dd0817612557dee54c8f1894::module_interface::ModuleCap,
        raw_signing_module_id: 0x2::object::ID,
    }

    public fun get_effects_personal_sign(arg0: &EVMPersonalSignModule, arg1: vector<u8>, arg2: vector<u8>, arg3: 0x1::string::String) : 0x8149631b2b88686a6ae1337c93939c0ed52f9b32dd0817612557dee54c8f1894::module_interface::TxEffectsResult<0x5a4bd7f100e5ca68fdf6aef39aecf9561b8a52fc330b854cbee15aedc3822331::raw_signing_module::RawSigningAction> {
        let v0 = 0x1::string::utf8(b"ethereum:");
        0x1::string::append(&mut v0, arg3);
        let v1 = x"19457468657265756d205369676e6564204d6573736167653a0a";
        0x1::vector::append<u8>(&mut v1, int_to_ascii_bytes(0x1::vector::length<u8>(&arg2)));
        0x1::vector::append<u8>(&mut v1, arg2);
        0x8149631b2b88686a6ae1337c93939c0ed52f9b32dd0817612557dee54c8f1894::module_interface::create_tx_effects<0x5a4bd7f100e5ca68fdf6aef39aecf9561b8a52fc330b854cbee15aedc3822331::raw_signing_module::RawSigningAction>(&arg0.cap, arg1, arg0.raw_signing_module_id, v0, 0x1::vector::empty<0x1::string::String>(), 0x1::option::none<vector<0x8149631b2b88686a6ae1337c93939c0ed52f9b32dd0817612557dee54c8f1894::library::NetworkAddress>>(), 0x1::vector::empty<0x8149631b2b88686a6ae1337c93939c0ed52f9b32dd0817612557dee54c8f1894::module_interface::BalanceChange>(), 0x5a4bd7f100e5ca68fdf6aef39aecf9561b8a52fc330b854cbee15aedc3822331::raw_signing_module::create_raw_signing_action(0x1::vector::singleton<vector<u8>>(v1), b"EVMPersonalSign-", v0))
    }

    public fun init_personal_sign_module(arg0: 0x2::object::ID, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::object::new(arg1);
        let v1 = EVMPersonalSignModule{
            id                    : v0,
            cap                   : 0x8149631b2b88686a6ae1337c93939c0ed52f9b32dd0817612557dee54c8f1894::module_interface::create_module_cap(0x2::object::uid_to_inner(&v0), arg1),
            raw_signing_module_id : arg0,
        };
        0x2::transfer::share_object<EVMPersonalSignModule>(v1);
    }

    public fun int_to_ascii_bytes(arg0: u64) : vector<u8> {
        let v0 = 0x1::vector::empty<u8>();
        if (arg0 == 0) {
            0x1::vector::push_back<u8>(&mut v0, 48);
            return v0
        };
        while (arg0 > 0) {
            0x1::vector::push_back<u8>(&mut v0, ((arg0 % 10) as u8) + 48);
            arg0 = arg0 / 10;
        };
        0x1::vector::reverse<u8>(&mut v0);
        v0
    }

    // decompiled from Move bytecode v6
}

