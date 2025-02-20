module 0xbc813cf16f98aa811aebb4da2e997d38f5347042c9e46ebfabd44d0e83f31b72::sui_transfer {
    struct SuiTransferModule has key {
        id: 0x2::object::UID,
        cap: 0x8149631b2b88686a6ae1337c93939c0ed52f9b32dd0817612557dee54c8f1894::module_interface::ModuleCap,
        sui_module_id: 0x2::object::ID,
        simulation_public_key: vector<u8>,
        maximum_delay: u64,
    }

    public fun get_effects_sui_transfer(arg0: &SuiTransferModule, arg1: vector<u8>, arg2: vector<u8>, arg3: vector<u8>, arg4: u64, arg5: 0x1::string::String, arg6: 0x1::option::Option<0xbc813cf16f98aa811aebb4da2e997d38f5347042c9e46ebfabd44d0e83f31b72::signature_utils::SignedPrice>, arg7: &0x2::clock::Clock) : 0x8149631b2b88686a6ae1337c93939c0ed52f9b32dd0817612557dee54c8f1894::module_interface::TxEffectsResult<0x5a4bd7f100e5ca68fdf6aef39aecf9561b8a52fc330b854cbee15aedc3822331::sui_module::SuiAction> {
        let v0 = 0x1::string::utf8(b"sui:");
        0x1::string::append(&mut v0, arg5);
        let v1 = 0x1::vector::empty<0x8149631b2b88686a6ae1337c93939c0ed52f9b32dd0817612557dee54c8f1894::module_interface::BalanceChange>();
        0x1::vector::push_back<0x8149631b2b88686a6ae1337c93939c0ed52f9b32dd0817612557dee54c8f1894::module_interface::BalanceChange>(&mut v1, 0x8149631b2b88686a6ae1337c93939c0ed52f9b32dd0817612557dee54c8f1894::module_interface::create_balance_change(arg3, 0x1::option::some<vector<u8>>(arg2), v0, (arg4 as u256), 0xbc813cf16f98aa811aebb4da2e997d38f5347042c9e46ebfabd44d0e83f31b72::signature_utils::validate_and_calculate_dollar_amount(0x1::string::utf8(b"sui"), arg5, arg3, (arg4 as u256), arg6, arg0.simulation_public_key, arg0.maximum_delay, arg7), true));
        let v2 = 0x1::vector::empty<0x5a4bd7f100e5ca68fdf6aef39aecf9561b8a52fc330b854cbee15aedc3822331::sui_module::CommandX>();
        let v3 = 0x1::vector::empty<0x5a4bd7f100e5ca68fdf6aef39aecf9561b8a52fc330b854cbee15aedc3822331::sui_module::ArgumentX>();
        0x1::vector::push_back<0x5a4bd7f100e5ca68fdf6aef39aecf9561b8a52fc330b854cbee15aedc3822331::sui_module::ArgumentX>(&mut v3, 0x5a4bd7f100e5ca68fdf6aef39aecf9561b8a52fc330b854cbee15aedc3822331::sui_module::create_argument_input(1));
        0x1::vector::push_back<0x5a4bd7f100e5ca68fdf6aef39aecf9561b8a52fc330b854cbee15aedc3822331::sui_module::CommandX>(&mut v2, 0x5a4bd7f100e5ca68fdf6aef39aecf9561b8a52fc330b854cbee15aedc3822331::sui_module::create_command_transfer(v3, 0x5a4bd7f100e5ca68fdf6aef39aecf9561b8a52fc330b854cbee15aedc3822331::sui_module::create_argument_input(0)));
        let v4 = 0x1::vector::empty<0x5a4bd7f100e5ca68fdf6aef39aecf9561b8a52fc330b854cbee15aedc3822331::sui_module::VirtualInput>();
        let v5 = &mut v4;
        0x1::vector::push_back<0x5a4bd7f100e5ca68fdf6aef39aecf9561b8a52fc330b854cbee15aedc3822331::sui_module::VirtualInput>(v5, 0x5a4bd7f100e5ca68fdf6aef39aecf9561b8a52fc330b854cbee15aedc3822331::sui_module::create_virtual_input_pure(arg2));
        0x1::vector::push_back<0x5a4bd7f100e5ca68fdf6aef39aecf9561b8a52fc330b854cbee15aedc3822331::sui_module::VirtualInput>(v5, 0x5a4bd7f100e5ca68fdf6aef39aecf9561b8a52fc330b854cbee15aedc3822331::sui_module::create_virtual_input_coin(0x1::string::utf8(arg3), arg4, false));
        0x8149631b2b88686a6ae1337c93939c0ed52f9b32dd0817612557dee54c8f1894::module_interface::create_tx_effects<0x5a4bd7f100e5ca68fdf6aef39aecf9561b8a52fc330b854cbee15aedc3822331::sui_module::SuiAction>(&arg0.cap, arg1, arg0.sui_module_id, v0, 0x1::vector::empty<0x1::string::String>(), 0x1::option::none<vector<0x8149631b2b88686a6ae1337c93939c0ed52f9b32dd0817612557dee54c8f1894::library::NetworkAddress>>(), v1, 0x5a4bd7f100e5ca68fdf6aef39aecf9561b8a52fc330b854cbee15aedc3822331::sui_module::create_sui_action(v4, v2))
    }

    public fun init_sui_transfer_module(arg0: 0x2::object::ID, arg1: vector<u8>, arg2: u64, arg3: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::object::new(arg3);
        let v1 = SuiTransferModule{
            id                    : v0,
            cap                   : 0x8149631b2b88686a6ae1337c93939c0ed52f9b32dd0817612557dee54c8f1894::module_interface::create_module_cap(0x2::object::uid_to_inner(&v0), arg3),
            sui_module_id         : arg0,
            simulation_public_key : arg1,
            maximum_delay         : arg2,
        };
        0x2::transfer::share_object<SuiTransferModule>(v1);
    }

    // decompiled from Move bytecode v6
}

