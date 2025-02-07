module 0xbc813cf16f98aa811aebb4da2e997d38f5347042c9e46ebfabd44d0e83f31b72::cosmos_transfer {
    struct CosmosTransferModule has key {
        id: 0x2::object::UID,
        cap: 0x8149631b2b88686a6ae1337c93939c0ed52f9b32dd0817612557dee54c8f1894::module_interface::ModuleCap,
        cosmos_module_id: 0x2::object::ID,
        simulation_public_key: vector<u8>,
        maximum_delay: u64,
    }

    public fun get_effects_cosmos_transfer(arg0: &CosmosTransferModule, arg1: vector<u8>, arg2: 0x1::string::String, arg3: vector<u8>, arg4: vector<u8>, arg5: vector<u8>, arg6: u256, arg7: 0x1::string::String, arg8: 0x1::option::Option<0xbc813cf16f98aa811aebb4da2e997d38f5347042c9e46ebfabd44d0e83f31b72::signature_utils::SignedPrice>, arg9: &0x2::clock::Clock) : 0x8149631b2b88686a6ae1337c93939c0ed52f9b32dd0817612557dee54c8f1894::module_interface::TxEffectsResult<0x5a4bd7f100e5ca68fdf6aef39aecf9561b8a52fc330b854cbee15aedc3822331::cosmos_module::CosmosAction> {
        let v0 = 0x1::string::utf8(b"cosmos:");
        0x1::string::append(&mut v0, arg2);
        let v1 = 0x1::vector::empty<0x8149631b2b88686a6ae1337c93939c0ed52f9b32dd0817612557dee54c8f1894::module_interface::BalanceChange>();
        0x1::vector::push_back<0x8149631b2b88686a6ae1337c93939c0ed52f9b32dd0817612557dee54c8f1894::module_interface::BalanceChange>(&mut v1, 0x8149631b2b88686a6ae1337c93939c0ed52f9b32dd0817612557dee54c8f1894::module_interface::create_balance_change(arg5, 0x1::option::some<vector<u8>>(arg4), v0, arg6, 0xbc813cf16f98aa811aebb4da2e997d38f5347042c9e46ebfabd44d0e83f31b72::signature_utils::validate_and_calculate_dollar_amount(0x1::string::utf8(b"cosmos"), arg2, arg5, arg6, arg8, arg0.simulation_public_key, arg0.maximum_delay, arg9), true));
        0x8149631b2b88686a6ae1337c93939c0ed52f9b32dd0817612557dee54c8f1894::module_interface::create_tx_effects<0x5a4bd7f100e5ca68fdf6aef39aecf9561b8a52fc330b854cbee15aedc3822331::cosmos_module::CosmosAction>(&arg0.cap, arg1, arg0.cosmos_module_id, v0, 0x1::vector::empty<0x1::string::String>(), 0x1::option::none<vector<0x8149631b2b88686a6ae1337c93939c0ed52f9b32dd0817612557dee54c8f1894::library::NetworkAddress>>(), v1, 0x5a4bd7f100e5ca68fdf6aef39aecf9561b8a52fc330b854cbee15aedc3822331::cosmos_module::assemble_cosmos_transfer_action(arg3, arg4, 0x1::string::utf8(arg5), arg6, arg2, arg7))
    }

    public fun init_cosmos_transfer_module(arg0: 0x2::object::ID, arg1: vector<u8>, arg2: u64, arg3: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::object::new(arg3);
        let v1 = CosmosTransferModule{
            id                    : v0,
            cap                   : 0x8149631b2b88686a6ae1337c93939c0ed52f9b32dd0817612557dee54c8f1894::module_interface::create_module_cap(0x2::object::uid_to_inner(&v0), arg3),
            cosmos_module_id      : arg0,
            simulation_public_key : arg1,
            maximum_delay         : arg2,
        };
        0x2::transfer::share_object<CosmosTransferModule>(v1);
    }

    fun test_util_create_cosmos_transfer_module(arg0: 0x2::object::ID, arg1: vector<u8>, arg2: u64, arg3: &mut 0x2::tx_context::TxContext) : CosmosTransferModule {
        let v0 = 0x2::object::new(arg3);
        CosmosTransferModule{
            id                    : v0,
            cap                   : 0x8149631b2b88686a6ae1337c93939c0ed52f9b32dd0817612557dee54c8f1894::module_interface::create_module_cap(0x2::object::uid_to_inner(&v0), arg3),
            cosmos_module_id      : arg0,
            simulation_public_key : arg1,
            maximum_delay         : arg2,
        }
    }

    // decompiled from Move bytecode v6
}

