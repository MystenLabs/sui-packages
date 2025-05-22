module 0xbd65783d52d7da3eef1df24145998b4e07daaa43ce00b2c13eeb29cfb9dd4703::aptos_transfer {
    struct AptosTransferModule has key {
        id: 0x2::object::UID,
        cap: 0x8149631b2b88686a6ae1337c93939c0ed52f9b32dd0817612557dee54c8f1894::module_interface::ModuleCap,
        aptos_module_id: 0x2::object::ID,
        simulation_public_key: vector<u8>,
        maximum_delay: u64,
    }

    fun assemble_aptos_transfer_action(arg0: vector<u8>, arg1: vector<u8>, arg2: bool, arg3: u64, arg4: u8) : 0xbd65783d52d7da3eef1df24145998b4e07daaa43ce00b2c13eeb29cfb9dd4703::aptos_module::AptosAction {
        let v0 = 0x1::vector::empty<u8>();
        0x1::vector::push_back<u8>(&mut v0, 2);
        0x1::vector::append<u8>(&mut v0, x"0000000000000000000000000000000000000000000000000000000000000001");
        if (arg2) {
            0x1::vector::push_back<u8>(&mut v0, 22);
            0x1::vector::append<u8>(&mut v0, b"primary_fungible_store");
            0x1::vector::push_back<u8>(&mut v0, 8);
            0x1::vector::append<u8>(&mut v0, b"transfer");
            0x1::vector::push_back<u8>(&mut v0, 1);
            0x1::vector::push_back<u8>(&mut v0, 7);
            0x1::vector::append<u8>(&mut v0, x"0000000000000000000000000000000000000000000000000000000000000001");
            0x1::vector::push_back<u8>(&mut v0, 14);
            0x1::vector::append<u8>(&mut v0, b"fungible_asset");
            0x1::vector::push_back<u8>(&mut v0, 8);
            0x1::vector::append<u8>(&mut v0, b"Metadata");
            0x1::vector::push_back<u8>(&mut v0, 0);
            0x1::vector::push_back<u8>(&mut v0, 3);
            0x1::vector::push_back<u8>(&mut v0, 32);
            0x1::vector::append<u8>(&mut v0, arg1);
        } else {
            0x1::vector::push_back<u8>(&mut v0, 13);
            0x1::vector::append<u8>(&mut v0, b"aptos_account");
            0x1::vector::push_back<u8>(&mut v0, 14);
            0x1::vector::append<u8>(&mut v0, b"transfer_coins");
            0x1::vector::push_back<u8>(&mut v0, 1);
            0x1::vector::append<u8>(&mut v0, arg1);
            0x1::vector::push_back<u8>(&mut v0, 2);
        };
        0x1::vector::push_back<u8>(&mut v0, 32);
        0x1::vector::append<u8>(&mut v0, arg0);
        0x1::vector::push_back<u8>(&mut v0, 8);
        0x1::vector::append<u8>(&mut v0, 0x2::bcs::to_bytes<u64>(&arg3));
        0xbd65783d52d7da3eef1df24145998b4e07daaa43ce00b2c13eeb29cfb9dd4703::aptos_module::create_aptos_action(v0, arg4)
    }

    public fun get_effects_aptos_transfer(arg0: &AptosTransferModule, arg1: vector<u8>, arg2: vector<u8>, arg3: vector<u8>, arg4: bool, arg5: u64, arg6: u8, arg7: 0x1::option::Option<0xbc813cf16f98aa811aebb4da2e997d38f5347042c9e46ebfabd44d0e83f31b72::signature_utils::SignedPrice>, arg8: &0x2::clock::Clock) : 0x8149631b2b88686a6ae1337c93939c0ed52f9b32dd0817612557dee54c8f1894::module_interface::TxEffectsResult<0xbd65783d52d7da3eef1df24145998b4e07daaa43ce00b2c13eeb29cfb9dd4703::aptos_module::AptosAction> {
        let v0 = 0x1::u8::to_string(arg6);
        let v1 = 0x1::string::utf8(b"aptos:");
        0x1::string::append(&mut v1, v0);
        let v2 = 0x1::vector::empty<0x8149631b2b88686a6ae1337c93939c0ed52f9b32dd0817612557dee54c8f1894::module_interface::BalanceChange>();
        0x1::vector::push_back<0x8149631b2b88686a6ae1337c93939c0ed52f9b32dd0817612557dee54c8f1894::module_interface::BalanceChange>(&mut v2, 0x8149631b2b88686a6ae1337c93939c0ed52f9b32dd0817612557dee54c8f1894::module_interface::create_balance_change(arg3, 0x1::option::some<vector<u8>>(arg2), v1, (arg5 as u256), 0xbc813cf16f98aa811aebb4da2e997d38f5347042c9e46ebfabd44d0e83f31b72::signature_utils::validate_and_calculate_dollar_amount(0x1::string::utf8(b"aptos"), v0, arg3, (arg5 as u256), arg7, arg0.simulation_public_key, arg0.maximum_delay, arg8), true));
        0x8149631b2b88686a6ae1337c93939c0ed52f9b32dd0817612557dee54c8f1894::module_interface::create_tx_effects<0xbd65783d52d7da3eef1df24145998b4e07daaa43ce00b2c13eeb29cfb9dd4703::aptos_module::AptosAction>(&arg0.cap, arg1, arg0.aptos_module_id, v1, 0x1::vector::empty<0x1::string::String>(), 0x1::option::none<vector<0x8149631b2b88686a6ae1337c93939c0ed52f9b32dd0817612557dee54c8f1894::library::NetworkAddress>>(), v2, assemble_aptos_transfer_action(arg2, arg3, arg4, arg5, arg6))
    }

    public fun init_aptos_transfer_module(arg0: 0x2::object::ID, arg1: vector<u8>, arg2: u64, arg3: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::object::new(arg3);
        let v1 = AptosTransferModule{
            id                    : v0,
            cap                   : 0x8149631b2b88686a6ae1337c93939c0ed52f9b32dd0817612557dee54c8f1894::module_interface::create_module_cap(0x2::object::uid_to_inner(&v0), arg3),
            aptos_module_id       : arg0,
            simulation_public_key : arg1,
            maximum_delay         : arg2,
        };
        0x2::transfer::share_object<AptosTransferModule>(v1);
    }

    fun test_util_create_aptos_transfer_module(arg0: 0x2::object::ID, arg1: vector<u8>, arg2: u64, arg3: &mut 0x2::tx_context::TxContext) : AptosTransferModule {
        let v0 = 0x2::object::new(arg3);
        AptosTransferModule{
            id                    : v0,
            cap                   : 0x8149631b2b88686a6ae1337c93939c0ed52f9b32dd0817612557dee54c8f1894::module_interface::create_module_cap(0x2::object::uid_to_inner(&v0), arg3),
            aptos_module_id       : arg0,
            simulation_public_key : arg1,
            maximum_delay         : arg2,
        }
    }

    // decompiled from Move bytecode v6
}

