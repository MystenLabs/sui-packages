module 0xbc813cf16f98aa811aebb4da2e997d38f5347042c9e46ebfabd44d0e83f31b72::sui_personal_message {
    struct SuiPersonalMessageModule has key {
        id: 0x2::object::UID,
        cap: 0x8149631b2b88686a6ae1337c93939c0ed52f9b32dd0817612557dee54c8f1894::module_interface::ModuleCap,
        raw_signing_module_id: 0x2::object::ID,
    }

    public fun get_effects_personal_message(arg0: &SuiPersonalMessageModule, arg1: vector<u8>, arg2: vector<u8>, arg3: 0x1::string::String) : 0x8149631b2b88686a6ae1337c93939c0ed52f9b32dd0817612557dee54c8f1894::module_interface::TxEffectsResult<0x5a4bd7f100e5ca68fdf6aef39aecf9561b8a52fc330b854cbee15aedc3822331::raw_signing_module::RawSigningAction> {
        let v0 = 0x1::string::utf8(b"sui:");
        0x1::string::append(&mut v0, arg3);
        let v1 = 0x5a4bd7f100e5ca68fdf6aef39aecf9561b8a52fc330b854cbee15aedc3822331::sui_module::bcs_encode_intent_message(0x5a4bd7f100e5ca68fdf6aef39aecf9561b8a52fc330b854cbee15aedc3822331::sui_module::intent_sui_app(0x5a4bd7f100e5ca68fdf6aef39aecf9561b8a52fc330b854cbee15aedc3822331::sui_module::intent_scope_personal_message()), 0x2::bcs::to_bytes<vector<u8>>(&arg2));
        let v2 = b"SuiPersonalMessage";
        0x1::vector::append<u8>(&mut v2, b"-");
        0x1::vector::append<u8>(&mut v2, arg2);
        0x8149631b2b88686a6ae1337c93939c0ed52f9b32dd0817612557dee54c8f1894::module_interface::create_tx_effects<0x5a4bd7f100e5ca68fdf6aef39aecf9561b8a52fc330b854cbee15aedc3822331::raw_signing_module::RawSigningAction>(&arg0.cap, arg1, arg0.raw_signing_module_id, v0, 0x1::vector::empty<0x1::string::String>(), 0x1::option::none<vector<0x8149631b2b88686a6ae1337c93939c0ed52f9b32dd0817612557dee54c8f1894::library::NetworkAddress>>(), 0x1::vector::empty<0x8149631b2b88686a6ae1337c93939c0ed52f9b32dd0817612557dee54c8f1894::module_interface::BalanceChange>(), 0x5a4bd7f100e5ca68fdf6aef39aecf9561b8a52fc330b854cbee15aedc3822331::raw_signing_module::create_raw_signing_action(0x1::vector::singleton<vector<u8>>(0x2::hash::blake2b256(&v1)), v2, v0))
    }

    public fun init_personal_message_module(arg0: 0x2::object::ID, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::object::new(arg1);
        let v1 = SuiPersonalMessageModule{
            id                    : v0,
            cap                   : 0x8149631b2b88686a6ae1337c93939c0ed52f9b32dd0817612557dee54c8f1894::module_interface::create_module_cap(0x2::object::uid_to_inner(&v0), arg1),
            raw_signing_module_id : arg0,
        };
        0x2::transfer::share_object<SuiPersonalMessageModule>(v1);
    }

    // decompiled from Move bytecode v6
}

