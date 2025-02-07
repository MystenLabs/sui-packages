module 0xbc813cf16f98aa811aebb4da2e997d38f5347042c9e46ebfabd44d0e83f31b72::erc20_native_transfer {
    struct EVMTransferModule has key {
        id: 0x2::object::UID,
        cap: 0x8149631b2b88686a6ae1337c93939c0ed52f9b32dd0817612557dee54c8f1894::module_interface::ModuleCap,
        eth_module_id: 0x2::object::ID,
        simulation_public_key: vector<u8>,
        maximum_delay: u64,
    }

    fun assemble_ethereum_erc20_action(arg0: vector<u8>, arg1: vector<u8>, arg2: 0x1::string::String, arg3: u256) : 0x5a4bd7f100e5ca68fdf6aef39aecf9561b8a52fc330b854cbee15aedc3822331::eth_module::EVMAction {
        let v0 = 0x1::vector::empty<u8>();
        let v1 = b"transfer(address,uint256)";
        0x1::vector::append<u8>(&mut v0, 0x5a4bd7f100e5ca68fdf6aef39aecf9561b8a52fc330b854cbee15aedc3822331::eth_module::bytes4(0x2::hash::keccak256(&v1)));
        0x1::vector::append<u8>(&mut v0, 0x5a4bd7f100e5ca68fdf6aef39aecf9561b8a52fc330b854cbee15aedc3822331::eth_module::left_pad_address_to_32_bytes(arg1));
        0x1::vector::append<u8>(&mut v0, 0x5a4bd7f100e5ca68fdf6aef39aecf9561b8a52fc330b854cbee15aedc3822331::eth_module::u256_to_32_byte_vector(arg3));
        let v2 = 0x1::string::utf8(b":");
        let v3 = 0x1::string::substring(&arg2, 0x1::string::index_of(&arg2, &v2) + 1, 0x1::string::length(&arg2));
        let v4 = 0x5a4bd7f100e5ca68fdf6aef39aecf9561b8a52fc330b854cbee15aedc3822331::eth_module::string_to_number(*0x1::string::as_bytes(&v3));
        0x5a4bd7f100e5ca68fdf6aef39aecf9561b8a52fc330b854cbee15aedc3822331::eth_module::create_evm_action(v0, 0x1::vector::empty<u8>(), arg0, 0x5a4bd7f100e5ca68fdf6aef39aecf9561b8a52fc330b854cbee15aedc3822331::eth_module::to_minimal_be_bytes<u32>(&v4))
    }

    fun assemble_ethereum_native_transfer_action(arg0: vector<u8>, arg1: 0x1::string::String, arg2: u256) : 0x5a4bd7f100e5ca68fdf6aef39aecf9561b8a52fc330b854cbee15aedc3822331::eth_module::EVMAction {
        let v0 = 0x1::string::utf8(b":");
        let v1 = 0x1::string::substring(&arg1, 0x1::string::index_of(&arg1, &v0) + 1, 0x1::string::length(&arg1));
        let v2 = 0x5a4bd7f100e5ca68fdf6aef39aecf9561b8a52fc330b854cbee15aedc3822331::eth_module::string_to_number(*0x1::string::as_bytes(&v1));
        0x5a4bd7f100e5ca68fdf6aef39aecf9561b8a52fc330b854cbee15aedc3822331::eth_module::create_evm_action(0x1::vector::empty<u8>(), 0x5a4bd7f100e5ca68fdf6aef39aecf9561b8a52fc330b854cbee15aedc3822331::eth_module::to_minimal_be_bytes<u256>(&arg2), arg0, 0x5a4bd7f100e5ca68fdf6aef39aecf9561b8a52fc330b854cbee15aedc3822331::eth_module::to_minimal_be_bytes<u32>(&v2))
    }

    public fun get_effects_ERC20_transfer(arg0: &EVMTransferModule, arg1: vector<u8>, arg2: 0x1::string::String, arg3: vector<u8>, arg4: vector<u8>, arg5: u256, arg6: 0x1::option::Option<0xbc813cf16f98aa811aebb4da2e997d38f5347042c9e46ebfabd44d0e83f31b72::signature_utils::SignedPrice>, arg7: &0x2::clock::Clock) : 0x8149631b2b88686a6ae1337c93939c0ed52f9b32dd0817612557dee54c8f1894::module_interface::TxEffectsResult<0x5a4bd7f100e5ca68fdf6aef39aecf9561b8a52fc330b854cbee15aedc3822331::eth_module::EVMAction> {
        let v0 = 0x1::string::utf8(b"ethereum:");
        0x1::string::append(&mut v0, arg2);
        let v1 = 0x1::vector::empty<0x8149631b2b88686a6ae1337c93939c0ed52f9b32dd0817612557dee54c8f1894::module_interface::BalanceChange>();
        0x1::vector::push_back<0x8149631b2b88686a6ae1337c93939c0ed52f9b32dd0817612557dee54c8f1894::module_interface::BalanceChange>(&mut v1, 0x8149631b2b88686a6ae1337c93939c0ed52f9b32dd0817612557dee54c8f1894::module_interface::create_balance_change(arg4, 0x1::option::some<vector<u8>>(arg3), v0, arg5, 0xbc813cf16f98aa811aebb4da2e997d38f5347042c9e46ebfabd44d0e83f31b72::signature_utils::validate_and_calculate_dollar_amount(0x1::string::utf8(b"ethereum"), arg2, arg4, arg5, arg6, arg0.simulation_public_key, arg0.maximum_delay, arg7), true));
        if (arg4 == b"native") {
            return 0x8149631b2b88686a6ae1337c93939c0ed52f9b32dd0817612557dee54c8f1894::module_interface::create_tx_effects<0x5a4bd7f100e5ca68fdf6aef39aecf9561b8a52fc330b854cbee15aedc3822331::eth_module::EVMAction>(&arg0.cap, arg1, arg0.eth_module_id, v0, 0x1::vector::empty<0x1::string::String>(), 0x1::option::none<vector<0x8149631b2b88686a6ae1337c93939c0ed52f9b32dd0817612557dee54c8f1894::library::NetworkAddress>>(), v1, assemble_ethereum_native_transfer_action(arg3, v0, arg5))
        };
        0x8149631b2b88686a6ae1337c93939c0ed52f9b32dd0817612557dee54c8f1894::module_interface::create_tx_effects<0x5a4bd7f100e5ca68fdf6aef39aecf9561b8a52fc330b854cbee15aedc3822331::eth_module::EVMAction>(&arg0.cap, arg1, arg0.eth_module_id, v0, 0x1::vector::empty<0x1::string::String>(), 0x1::option::some<vector<0x8149631b2b88686a6ae1337c93939c0ed52f9b32dd0817612557dee54c8f1894::library::NetworkAddress>>(0x1::vector::singleton<0x8149631b2b88686a6ae1337c93939c0ed52f9b32dd0817612557dee54c8f1894::library::NetworkAddress>(0x8149631b2b88686a6ae1337c93939c0ed52f9b32dd0817612557dee54c8f1894::library::create_network_address(v0, arg4))), v1, assemble_ethereum_erc20_action(arg4, arg3, v0, arg5))
    }

    public fun init_erc20_transfer_module(arg0: 0x2::object::ID, arg1: vector<u8>, arg2: u64, arg3: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::object::new(arg3);
        let v1 = EVMTransferModule{
            id                    : v0,
            cap                   : 0x8149631b2b88686a6ae1337c93939c0ed52f9b32dd0817612557dee54c8f1894::module_interface::create_module_cap(0x2::object::uid_to_inner(&v0), arg3),
            eth_module_id         : arg0,
            simulation_public_key : arg1,
            maximum_delay         : arg2,
        };
        0x2::transfer::share_object<EVMTransferModule>(v1);
    }

    fun test_util_create_erc20_transfer_module(arg0: 0x2::object::ID, arg1: vector<u8>, arg2: u64, arg3: &mut 0x2::tx_context::TxContext) : EVMTransferModule {
        let v0 = 0x2::object::new(arg3);
        EVMTransferModule{
            id                    : v0,
            cap                   : 0x8149631b2b88686a6ae1337c93939c0ed52f9b32dd0817612557dee54c8f1894::module_interface::create_module_cap(0x2::object::uid_to_inner(&v0), arg3),
            eth_module_id         : arg0,
            simulation_public_key : arg1,
            maximum_delay         : arg2,
        }
    }

    // decompiled from Move bytecode v6
}

