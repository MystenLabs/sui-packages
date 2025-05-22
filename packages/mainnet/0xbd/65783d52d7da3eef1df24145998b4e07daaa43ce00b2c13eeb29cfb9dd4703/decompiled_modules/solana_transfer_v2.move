module 0xbd65783d52d7da3eef1df24145998b4e07daaa43ce00b2c13eeb29cfb9dd4703::solana_transfer_v2 {
    struct SolanaTransferModule has key {
        id: 0x2::object::UID,
        cap: 0x8149631b2b88686a6ae1337c93939c0ed52f9b32dd0817612557dee54c8f1894::module_interface::ModuleCap,
        solana_module_id: 0x2::object::ID,
        simulation_public_key: vector<u8>,
        maximum_delay: u64,
    }

    public fun get_effects_solana_transfer(arg0: &SolanaTransferModule, arg1: vector<u8>, arg2: 0x1::string::String, arg3: vector<u8>, arg4: 0x1::option::Option<0xbd65783d52d7da3eef1df24145998b4e07daaa43ce00b2c13eeb29cfb9dd4703::solana_module_v2::SolanaSplTransferData>, arg5: u256, arg6: 0x1::option::Option<0xbc813cf16f98aa811aebb4da2e997d38f5347042c9e46ebfabd44d0e83f31b72::signature_utils::SignedPrice>, arg7: &0x2::clock::Clock) : 0x8149631b2b88686a6ae1337c93939c0ed52f9b32dd0817612557dee54c8f1894::module_interface::TxEffectsResult<0xbd65783d52d7da3eef1df24145998b4e07daaa43ce00b2c13eeb29cfb9dd4703::solana_module_v2::SolanaAction> {
        if (0x1::option::is_none<0xbd65783d52d7da3eef1df24145998b4e07daaa43ce00b2c13eeb29cfb9dd4703::solana_module_v2::SolanaSplTransferData>(&arg4)) {
            let v0 = 0x1::string::utf8(b"solana:");
            0x1::string::append(&mut v0, arg2);
            let v1 = 0x1::vector::empty<0x8149631b2b88686a6ae1337c93939c0ed52f9b32dd0817612557dee54c8f1894::module_interface::BalanceChange>();
            0x1::vector::push_back<0x8149631b2b88686a6ae1337c93939c0ed52f9b32dd0817612557dee54c8f1894::module_interface::BalanceChange>(&mut v1, 0x8149631b2b88686a6ae1337c93939c0ed52f9b32dd0817612557dee54c8f1894::module_interface::create_balance_change(b"native", 0x1::option::some<vector<u8>>(arg3), v0, arg5, 0xbc813cf16f98aa811aebb4da2e997d38f5347042c9e46ebfabd44d0e83f31b72::signature_utils::validate_and_calculate_dollar_amount(0x1::string::utf8(b"solana"), arg2, b"native", arg5, arg6, arg0.simulation_public_key, arg0.maximum_delay, arg7), true));
            return 0x8149631b2b88686a6ae1337c93939c0ed52f9b32dd0817612557dee54c8f1894::module_interface::create_tx_effects<0xbd65783d52d7da3eef1df24145998b4e07daaa43ce00b2c13eeb29cfb9dd4703::solana_module_v2::SolanaAction>(&arg0.cap, arg1, arg0.solana_module_id, v0, 0x1::vector::empty<0x1::string::String>(), 0x1::option::none<vector<0x8149631b2b88686a6ae1337c93939c0ed52f9b32dd0817612557dee54c8f1894::library::NetworkAddress>>(), v1, 0xbd65783d52d7da3eef1df24145998b4e07daaa43ce00b2c13eeb29cfb9dd4703::solana_module_v2::assemble_solana_transfer_action(arg1, arg3, arg5, b"native", 0x1::option::none<0xbd65783d52d7da3eef1df24145998b4e07daaa43ce00b2c13eeb29cfb9dd4703::solana_module_v2::SolanaSplTransferData>(), 0x1::option::none<vector<u8>>()))
        };
        assert!(0x1::option::is_some<0xbd65783d52d7da3eef1df24145998b4e07daaa43ce00b2c13eeb29cfb9dd4703::solana_module_v2::SolanaSplTransferData>(&arg4), 21);
        let v2 = 0x1::option::borrow<0xbd65783d52d7da3eef1df24145998b4e07daaa43ce00b2c13eeb29cfb9dd4703::solana_module_v2::SolanaSplTransferData>(&arg4);
        let (v3, _, v5, _, v7) = 0xbd65783d52d7da3eef1df24145998b4e07daaa43ce00b2c13eeb29cfb9dd4703::solana_module_v2::get_solana_spl_transfer_data_fields(v2);
        let v8 = 0x1::string::utf8(b"solana:");
        0x1::string::append(&mut v8, arg2);
        let v9 = 0x1::vector::empty<vector<u8>>();
        0x1::vector::push_back<vector<u8>>(&mut v9, arg3);
        if (v7) {
            0x1::vector::push_back<vector<u8>>(&mut v9, 0xbd65783d52d7da3eef1df24145998b4e07daaa43ce00b2c13eeb29cfb9dd4703::solana_module_v2::get_token_program_2022_program_id_bytes());
        } else {
            0x1::vector::push_back<vector<u8>>(&mut v9, 0xbd65783d52d7da3eef1df24145998b4e07daaa43ce00b2c13eeb29cfb9dd4703::solana_module_v2::get_token_program_id_bytes());
        };
        0x1::vector::push_back<vector<u8>>(&mut v9, v5);
        let v10 = 0xbd65783d52d7da3eef1df24145998b4e07daaa43ce00b2c13eeb29cfb9dd4703::solana_module_v2::get_associated_token_account_program_id_bytes();
        let v11 = 0x1::vector::empty<0x8149631b2b88686a6ae1337c93939c0ed52f9b32dd0817612557dee54c8f1894::module_interface::BalanceChange>();
        0x1::vector::push_back<0x8149631b2b88686a6ae1337c93939c0ed52f9b32dd0817612557dee54c8f1894::module_interface::BalanceChange>(&mut v11, 0x8149631b2b88686a6ae1337c93939c0ed52f9b32dd0817612557dee54c8f1894::module_interface::create_balance_change(v5, 0x1::option::some<vector<u8>>(arg3), v8, arg5, 0xbc813cf16f98aa811aebb4da2e997d38f5347042c9e46ebfabd44d0e83f31b72::signature_utils::validate_and_calculate_dollar_amount(0x1::string::utf8(b"solana"), arg2, v5, arg5, arg6, arg0.simulation_public_key, arg0.maximum_delay, arg7), true));
        0x8149631b2b88686a6ae1337c93939c0ed52f9b32dd0817612557dee54c8f1894::module_interface::create_tx_effects<0xbd65783d52d7da3eef1df24145998b4e07daaa43ce00b2c13eeb29cfb9dd4703::solana_module_v2::SolanaAction>(&arg0.cap, arg1, arg0.solana_module_id, v8, 0x1::vector::empty<0x1::string::String>(), 0x1::option::none<vector<0x8149631b2b88686a6ae1337c93939c0ed52f9b32dd0817612557dee54c8f1894::library::NetworkAddress>>(), v11, 0xbd65783d52d7da3eef1df24145998b4e07daaa43ce00b2c13eeb29cfb9dd4703::solana_module_v2::assemble_solana_transfer_action(arg1, arg3, arg5, v5, 0x1::option::some<0xbd65783d52d7da3eef1df24145998b4e07daaa43ce00b2c13eeb29cfb9dd4703::solana_module_v2::SolanaSplTransferData>(*v2), 0x1::option::some<vector<u8>>(0xbd65783d52d7da3eef1df24145998b4e07daaa43ce00b2c13eeb29cfb9dd4703::solana_module_v2::derive_program_address_with_nonce(v9, &v10, v3))))
    }

    public fun init_solana_transfer_module(arg0: 0x2::object::ID, arg1: vector<u8>, arg2: u64, arg3: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::object::new(arg3);
        let v1 = SolanaTransferModule{
            id                    : v0,
            cap                   : 0x8149631b2b88686a6ae1337c93939c0ed52f9b32dd0817612557dee54c8f1894::module_interface::create_module_cap(0x2::object::uid_to_inner(&v0), arg3),
            solana_module_id      : arg0,
            simulation_public_key : arg1,
            maximum_delay         : arg2,
        };
        0x2::transfer::share_object<SolanaTransferModule>(v1);
    }

    fun test_util_create_solana_transfer_module(arg0: 0x2::object::ID, arg1: vector<u8>, arg2: u64, arg3: &mut 0x2::tx_context::TxContext) : SolanaTransferModule {
        let v0 = 0x2::object::new(arg3);
        SolanaTransferModule{
            id                    : v0,
            cap                   : 0x8149631b2b88686a6ae1337c93939c0ed52f9b32dd0817612557dee54c8f1894::module_interface::create_module_cap(0x2::object::uid_to_inner(&v0), arg3),
            solana_module_id      : arg0,
            simulation_public_key : arg1,
            maximum_delay         : arg2,
        }
    }

    // decompiled from Move bytecode v6
}

