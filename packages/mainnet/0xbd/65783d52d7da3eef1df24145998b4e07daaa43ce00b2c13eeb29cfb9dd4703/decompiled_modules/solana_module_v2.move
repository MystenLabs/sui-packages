module 0xbd65783d52d7da3eef1df24145998b4e07daaa43ce00b2c13eeb29cfb9dd4703::solana_module_v2 {
    struct SolanaModule has key {
        id: 0x2::object::UID,
        cap: 0x8149631b2b88686a6ae1337c93939c0ed52f9b32dd0817612557dee54c8f1894::module_interface::ModuleCap,
    }

    struct SolanaChainState has copy, drop, store {
        max_priority_fee: u256,
    }

    struct SolanaTxData has copy, drop, store {
        updated: bool,
    }

    struct SolanaInstruction has copy, drop, store {
        program_id: vector<u8>,
        keys: vector<SolanaAccountMeta>,
        data: vector<u8>,
    }

    struct SolanaAccountMeta has copy, drop, store {
        pubkey: vector<u8>,
        is_signer: bool,
        is_writable: bool,
    }

    struct MessageHeader has copy, drop, store {
        num_required_signatures: u8,
        num_readonly_signed_accounts: u8,
        num_readonly_unsigned_accounts: u8,
    }

    struct MessageCompiledInstruction has copy, drop, store {
        program_id_index: u8,
        account_key_indexes: vector<u8>,
        data: vector<u8>,
    }

    struct MessageAddressTableLookup has copy, drop, store {
        account_key: vector<u8>,
        writable_indexes: vector<u8>,
        readonly_indexes: vector<u8>,
    }

    struct MessageV0Args has copy, drop, store {
        header: MessageHeader,
        static_account_keys: vector<vector<u8>>,
        recent_blockhash: vector<u8>,
        compiled_instructions: vector<MessageCompiledInstruction>,
        address_table_lookups: vector<MessageAddressTableLookup>,
    }

    struct KeyMeta has copy, drop, store {
        is_signer: bool,
        is_writable: bool,
        is_invoked: bool,
    }

    struct AtaCreationData has copy, drop, store {
        associated_token: vector<u8>,
        mint_token_address: vector<u8>,
        token_program_id: vector<u8>,
        owner: vector<u8>,
    }

    struct CompactAddressLookupTable has copy, drop, store {
        key: vector<u8>,
        writable_indexes: vector<u8>,
        readonly_indexes: vector<u8>,
        writable_addresses: vector<vector<u8>>,
        readonly_addresses: vector<vector<u8>>,
    }

    struct SolanaTransaction has copy, drop, store {
        instructions: vector<SolanaInstruction>,
        compact_lookup_tables: vector<CompactAddressLookupTable>,
        is_legacy: bool,
        signatures: 0x1::option::Option<vector<vector<u8>>>,
        recent_blockhash: 0x1::option::Option<vector<u8>>,
        compact_explicit_static_key_indices: 0x1::option::Option<vector<u8>>,
    }

    struct SolanaAction has copy, drop, store {
        transactions: vector<SolanaTransaction>,
    }

    struct SolanaSplTransferData has copy, drop, store {
        ata_nonce: u8,
        sender_ata_pubkey: vector<u8>,
        token_mint_address: vector<u8>,
        decimals: u8,
        is_token_2022: bool,
    }

    struct SolanaPreparedSigning has copy, drop, store {
        data: vector<SolanaPreparedSigningData>,
    }

    struct SolanaPreparedSigningData has copy, drop, store {
        signable_message: vector<u8>,
        override_gas_limits: 0x1::option::Option<SolanaGasArgs>,
        ata_account_creations: u64,
        signatures: 0x1::option::Option<vector<vector<u8>>>,
    }

    struct SolanaGasArgs has copy, drop, store {
        priority_fee_per_compute_unit: u256,
        max_compute_units: u32,
    }

    struct SolanaPrepareSigningExecutionArgs has copy, drop, store {
        ata_creations: vector<AtaCreationData>,
        override_gas_limits: 0x1::option::Option<SolanaGasArgs>,
        override_recent_blockhash: 0x1::option::Option<vector<u8>>,
        payer_key: vector<u8>,
    }

    struct MessageLegacyArgs has copy, drop, store {
        header: MessageHeader,
        account_keys: vector<vector<u8>>,
        recent_blockhash: vector<u8>,
        compiled_instructions: vector<MessageCompiledInstruction>,
    }

    fun append_le_u32(arg0: &mut vector<u8>, arg1: u32) {
        let v0 = 0;
        let v1 = 0;
        while (v0 < 4) {
            0x1::vector::push_back<u8>(arg0, ((arg1 >> v1 & 255) as u8));
            v1 = v1 + 8;
            v0 = v0 + 1;
        };
    }

    fun append_le_u64(arg0: &mut vector<u8>, arg1: u64) {
        let v0 = 0;
        let v1 = 0;
        while (v0 < 8) {
            0x1::vector::push_back<u8>(arg0, ((arg1 >> v1 & 255) as u8));
            v1 = v1 + 8;
            v0 = v0 + 1;
        };
    }

    public fun assemble_solana_transfer_action(arg0: vector<u8>, arg1: vector<u8>, arg2: u256, arg3: vector<u8>, arg4: 0x1::option::Option<SolanaSplTransferData>, arg5: 0x1::option::Option<vector<u8>>) : SolanaAction {
        let v0 = 0x1::vector::empty<SolanaInstruction>();
        if (arg3 == b"native") {
            assert!(0x1::option::is_none<SolanaSplTransferData>(&arg4), 28);
            assert!(0x1::option::is_none<vector<u8>>(&arg5), 29);
            let v1 = 0x1::vector::empty<SolanaAccountMeta>();
            let v2 = SolanaAccountMeta{
                pubkey      : arg0,
                is_signer   : true,
                is_writable : true,
            };
            0x1::vector::push_back<SolanaAccountMeta>(&mut v1, v2);
            let v3 = SolanaAccountMeta{
                pubkey      : arg1,
                is_signer   : false,
                is_writable : true,
            };
            0x1::vector::push_back<SolanaAccountMeta>(&mut v1, v3);
            let v4 = SolanaInstruction{
                program_id : get_system_program_id_bytes(),
                keys       : v1,
                data       : build_simple_transfer_data(arg2),
            };
            0x1::vector::push_back<SolanaInstruction>(&mut v0, v4);
        } else {
            assert!(0x1::option::is_some<SolanaSplTransferData>(&arg4), 28);
            assert!(0x1::option::is_some<vector<u8>>(&arg5), 29);
            let v5 = 0x1::option::borrow<SolanaSplTransferData>(&arg4);
            let v6 = if (v5.is_token_2022) {
                get_token_program_2022_program_id_bytes()
            } else {
                get_token_program_id_bytes()
            };
            let v7 = 0x1::vector::empty<SolanaAccountMeta>();
            let v8 = SolanaAccountMeta{
                pubkey      : v5.sender_ata_pubkey,
                is_signer   : false,
                is_writable : true,
            };
            0x1::vector::push_back<SolanaAccountMeta>(&mut v7, v8);
            let v9 = SolanaAccountMeta{
                pubkey      : arg3,
                is_signer   : false,
                is_writable : false,
            };
            0x1::vector::push_back<SolanaAccountMeta>(&mut v7, v9);
            let v10 = SolanaAccountMeta{
                pubkey      : *0x1::option::borrow<vector<u8>>(&arg5),
                is_signer   : false,
                is_writable : true,
            };
            0x1::vector::push_back<SolanaAccountMeta>(&mut v7, v10);
            let v11 = SolanaAccountMeta{
                pubkey      : arg0,
                is_signer   : true,
                is_writable : false,
            };
            0x1::vector::push_back<SolanaAccountMeta>(&mut v7, v11);
            let v12 = SolanaInstruction{
                program_id : v6,
                keys       : v7,
                data       : encode_u8_u256_as_u64_le_data(12, arg2, v5.decimals),
            };
            0x1::vector::push_back<SolanaInstruction>(&mut v0, v12);
        };
        let v13 = SolanaTransaction{
            instructions                        : v0,
            compact_lookup_tables               : 0x1::vector::empty<CompactAddressLookupTable>(),
            is_legacy                           : false,
            signatures                          : 0x1::option::none<vector<vector<u8>>>(),
            recent_blockhash                    : 0x1::option::none<vector<u8>>(),
            compact_explicit_static_key_indices : 0x1::option::none<vector<u8>>(),
        };
        SolanaAction{transactions: 0x1::vector::singleton<SolanaTransaction>(v13)}
    }

    fun build_create_associated_token_account_instruction(arg0: vector<u8>, arg1: vector<u8>, arg2: vector<u8>, arg3: vector<u8>, arg4: vector<u8>, arg5: vector<u8>, arg6: vector<u8>) : SolanaInstruction {
        let v0 = 0x1::vector::empty<SolanaAccountMeta>();
        let v1 = SolanaAccountMeta{
            pubkey      : arg0,
            is_signer   : true,
            is_writable : true,
        };
        0x1::vector::push_back<SolanaAccountMeta>(&mut v0, v1);
        let v2 = SolanaAccountMeta{
            pubkey      : arg1,
            is_signer   : false,
            is_writable : true,
        };
        0x1::vector::push_back<SolanaAccountMeta>(&mut v0, v2);
        let v3 = SolanaAccountMeta{
            pubkey      : arg2,
            is_signer   : false,
            is_writable : false,
        };
        0x1::vector::push_back<SolanaAccountMeta>(&mut v0, v3);
        let v4 = SolanaAccountMeta{
            pubkey      : arg3,
            is_signer   : false,
            is_writable : false,
        };
        0x1::vector::push_back<SolanaAccountMeta>(&mut v0, v4);
        let v5 = SolanaAccountMeta{
            pubkey      : arg4,
            is_signer   : false,
            is_writable : false,
        };
        0x1::vector::push_back<SolanaAccountMeta>(&mut v0, v5);
        let v6 = SolanaAccountMeta{
            pubkey      : arg5,
            is_signer   : false,
            is_writable : false,
        };
        0x1::vector::push_back<SolanaAccountMeta>(&mut v0, v6);
        SolanaInstruction{
            program_id : arg6,
            keys       : v0,
            data       : 0x1::vector::empty<u8>(),
        }
    }

    public fun build_set_compute_unit_limit_instruction(arg0: u32) : SolanaInstruction {
        let v0 = 0x1::vector::empty<u8>();
        0x1::vector::push_back<u8>(&mut v0, 2);
        let v1 = &mut v0;
        append_le_u32(v1, arg0);
        SolanaInstruction{
            program_id : get_compute_budget_program_id_bytes(),
            keys       : 0x1::vector::empty<SolanaAccountMeta>(),
            data       : v0,
        }
    }

    public fun build_set_compute_unit_price_instruction(arg0: u256) : SolanaInstruction {
        let v0 = 0x1::vector::empty<u8>();
        0x1::vector::append<u8>(&mut v0, encode_u8_and_u64_le_data(3, arg0));
        SolanaInstruction{
            program_id : get_compute_budget_program_id_bytes(),
            keys       : 0x1::vector::empty<SolanaAccountMeta>(),
            data       : v0,
        }
    }

    fun build_simple_transfer_data(arg0: u256) : vector<u8> {
        let v0 = 0x1::vector::empty<u8>();
        let v1 = &mut v0;
        append_le_u32(v1, 2);
        let v2 = &mut v0;
        append_le_u64(v2, ((arg0 & 18446744073709551615) as u64));
        v0
    }

    fun compare_pubkeys(arg0: &vector<u8>, arg1: &vector<u8>) : u8 {
        let v0 = 0x1::vector::length<u8>(arg0);
        let v1 = 0x1::vector::length<u8>(arg1);
        let v2 = if (v0 < v1) {
            v0
        } else {
            v1
        };
        let v3 = 0;
        while (v3 < v2) {
            let v4 = *0x1::vector::borrow<u8>(arg0, v3);
            let v5 = *0x1::vector::borrow<u8>(arg1, v3);
            if (v4 < v5) {
                return 0
            };
            if (v4 > v5) {
                return 2
            };
            v3 = v3 + 1;
        };
        if (v0 < v1) {
            return 0
        };
        if (v0 > v1) {
            return 2
        };
        1
    }

    fun compile_instructions(arg0: &vector<SolanaInstruction>, arg1: vector<vector<u8>>, arg2: vector<vector<u8>>, arg3: vector<vector<u8>>) : vector<MessageCompiledInstruction> {
        let v0 = 0x1::vector::empty<vector<u8>>();
        0x1::vector::append<vector<u8>>(&mut v0, arg1);
        0x1::vector::append<vector<u8>>(&mut v0, arg2);
        0x1::vector::append<vector<u8>>(&mut v0, arg3);
        let v1 = 0x1::vector::length<vector<u8>>(&v0);
        assert!(v1 <= 256, 16);
        let v2 = 0x2::vec_map::empty<vector<u8>, u8>();
        let v3 = 0;
        while (v3 < v1) {
            0x2::vec_map::insert<vector<u8>, u8>(&mut v2, *0x1::vector::borrow<vector<u8>>(&v0, v3), (v3 as u8));
            v3 = v3 + 1;
        };
        let v4 = 0x1::vector::empty<MessageCompiledInstruction>();
        let v5 = 0;
        while (v5 < 0x1::vector::length<SolanaInstruction>(arg0)) {
            let v6 = 0x1::vector::borrow<SolanaInstruction>(arg0, v5);
            let v7 = 0x2::vec_map::get_idx_opt<vector<u8>, u8>(&v2, &v6.program_id);
            assert!(0x1::option::is_some<u64>(&v7), 17);
            let v8 = 0x1::vector::empty<u8>();
            let v9 = 0;
            while (v9 < 0x1::vector::length<SolanaAccountMeta>(&v6.keys)) {
                let v10 = 0x2::vec_map::get_idx_opt<vector<u8>, u8>(&v2, &0x1::vector::borrow<SolanaAccountMeta>(&v6.keys, v9).pubkey);
                assert!(0x1::option::is_some<u64>(&v10), 18);
                0x1::vector::push_back<u8>(&mut v8, (0x1::option::destroy_some<u64>(v10) as u8));
                v9 = v9 + 1;
            };
            let v11 = MessageCompiledInstruction{
                program_id_index    : (0x1::option::destroy_some<u64>(v7) as u8),
                account_key_indexes : v8,
                data                : v6.data,
            };
            0x1::vector::push_back<MessageCompiledInstruction>(&mut v4, v11);
            v5 = v5 + 1;
        };
        v4
    }

    public fun compile_key_meta_map(arg0: &vector<SolanaInstruction>, arg1: &vector<u8>) : 0x2::vec_map::VecMap<vector<u8>, KeyMeta> {
        let v0 = 0x2::vec_map::empty<vector<u8>, KeyMeta>();
        let v1 = &mut v0;
        let v2 = get_or_insert_default(v1, arg1);
        v2.is_signer = true;
        v2.is_writable = true;
        let v3 = 0;
        while (v3 < 0x1::vector::length<SolanaInstruction>(arg0)) {
            let v4 = 0x1::vector::borrow<SolanaInstruction>(arg0, v3);
            let v5 = &mut v0;
            get_or_insert_default(v5, &v4.program_id).is_invoked = true;
            let v6 = 0;
            while (v6 < 0x1::vector::length<SolanaAccountMeta>(&v4.keys)) {
                let v7 = 0x1::vector::borrow<SolanaAccountMeta>(&v4.keys, v6);
                let v8 = &mut v0;
                let v9 = get_or_insert_default(v8, &v7.pubkey);
                let v10 = v9.is_signer || v7.is_signer;
                v9.is_signer = v10;
                let v11 = v9.is_writable || v7.is_writable;
                v9.is_writable = v11;
                v6 = v6 + 1;
            };
            v3 = v3 + 1;
        };
        v0
    }

    public fun compile_message_legacy(arg0: &vector<SolanaInstruction>, arg1: &vector<u8>, arg2: &vector<u8>, arg3: 0x1::option::Option<vector<u8>>) : MessageLegacyArgs {
        let (v0, v1) = get_message_components(compile_key_meta_map(arg0, arg1), arg1, arg3);
        MessageLegacyArgs{
            header                : v0,
            account_keys          : v1,
            recent_blockhash      : *arg2,
            compiled_instructions : compile_instructions(arg0, v1, 0x1::vector::empty<vector<u8>>(), 0x1::vector::empty<vector<u8>>()),
        }
    }

    public fun compile_message_v0(arg0: vector<SolanaInstruction>, arg1: vector<CompactAddressLookupTable>, arg2: vector<u8>, arg3: vector<u8>, arg4: 0x1::option::Option<vector<u8>>) : MessageV0Args {
        let v0 = compile_key_meta_map(&arg0, &arg2);
        let v1 = 0x1::vector::empty<MessageAddressTableLookup>();
        let v2 = 0x1::vector::empty<vector<u8>>();
        let v3 = 0x1::vector::empty<vector<u8>>();
        let v4 = 0;
        while (v4 < 0x1::vector::length<CompactAddressLookupTable>(&arg1)) {
            let v5 = 0x1::vector::borrow<CompactAddressLookupTable>(&arg1, v4);
            if (0x1::vector::is_empty<u8>(&v5.writable_indexes) && 0x1::vector::is_empty<u8>(&v5.readonly_indexes)) {
                v4 = v4 + 1;
                continue
            };
            let v6 = MessageAddressTableLookup{
                account_key      : v5.key,
                writable_indexes : v5.writable_indexes,
                readonly_indexes : v5.readonly_indexes,
            };
            0x1::vector::push_back<MessageAddressTableLookup>(&mut v1, v6);
            let v7 = 0;
            while (v7 < 0x1::vector::length<vector<u8>>(&v5.writable_addresses)) {
                let v8 = *0x1::vector::borrow<vector<u8>>(&v5.writable_addresses, v7);
                0x1::vector::push_back<vector<u8>>(&mut v2, v8);
                let v9 = &mut v0;
                remove_key_if_exists(v9, &v8);
                v7 = v7 + 1;
            };
            let v10 = 0;
            while (v10 < 0x1::vector::length<vector<u8>>(&v5.readonly_addresses)) {
                let v11 = *0x1::vector::borrow<vector<u8>>(&v5.readonly_addresses, v10);
                0x1::vector::push_back<vector<u8>>(&mut v3, v11);
                let v12 = &mut v0;
                remove_key_if_exists(v12, &v11);
                v10 = v10 + 1;
            };
            v4 = v4 + 1;
        };
        let (v13, v14) = get_message_components(v0, &arg2, arg4);
        MessageV0Args{
            header                : v13,
            static_account_keys   : v14,
            recent_blockhash      : arg3,
            compiled_instructions : compile_instructions(&arg0, v14, v2, v3),
            address_table_lookups : v1,
        }
    }

    fun concatenate_pubkeys(arg0: &mut vector<vector<u8>>, arg1: &vector<vector<u8>>, arg2: &vector<u64>) {
        let v0 = 0;
        while (v0 < 0x1::vector::length<u64>(arg2)) {
            0x1::vector::push_back<vector<u8>>(arg0, *0x1::vector::borrow<vector<u8>>(arg1, *0x1::vector::borrow<u64>(arg2, v0)));
            v0 = v0 + 1;
        };
    }

    public fun create_ata_creation_data(arg0: vector<u8>, arg1: vector<u8>, arg2: vector<u8>, arg3: vector<u8>) : AtaCreationData {
        AtaCreationData{
            associated_token   : arg0,
            mint_token_address : arg1,
            token_program_id   : arg2,
            owner              : arg3,
        }
    }

    public fun create_compact_address_lookup_table(arg0: vector<u8>, arg1: vector<u8>, arg2: vector<u8>, arg3: vector<vector<u8>>, arg4: vector<vector<u8>>) : CompactAddressLookupTable {
        CompactAddressLookupTable{
            key                : arg0,
            writable_indexes   : arg1,
            readonly_indexes   : arg2,
            writable_addresses : arg3,
            readonly_addresses : arg4,
        }
    }

    public fun create_module_shared_data_solana(arg0: &SolanaModule, arg1: 0x2::vec_map::VecMap<0x1::string::String, SolanaChainState>, arg2: &mut 0x2::tx_context::TxContext) : 0x8149631b2b88686a6ae1337c93939c0ed52f9b32dd0817612557dee54c8f1894::module_interface::ModuleSharedData<SolanaChainState> {
        0x8149631b2b88686a6ae1337c93939c0ed52f9b32dd0817612557dee54c8f1894::module_interface::create_module_shared_data<SolanaChainState>(&arg0.cap, arg1, arg2)
    }

    public fun create_solana_account_meta(arg0: vector<u8>, arg1: bool, arg2: bool) : SolanaAccountMeta {
        SolanaAccountMeta{
            pubkey      : arg0,
            is_signer   : arg1,
            is_writable : arg2,
        }
    }

    public fun create_solana_action(arg0: vector<SolanaTransaction>) : SolanaAction {
        SolanaAction{transactions: arg0}
    }

    public fun create_solana_address_table_lookup(arg0: vector<u8>, arg1: vector<u8>, arg2: vector<u8>) : MessageAddressTableLookup {
        MessageAddressTableLookup{
            account_key      : arg0,
            writable_indexes : arg1,
            readonly_indexes : arg2,
        }
    }

    public fun create_solana_chain_state(arg0: u256) : SolanaChainState {
        SolanaChainState{max_priority_fee: arg0}
    }

    public fun create_solana_gas_args(arg0: u256, arg1: u32) : SolanaGasArgs {
        SolanaGasArgs{
            priority_fee_per_compute_unit : arg0,
            max_compute_units             : arg1,
        }
    }

    public fun create_solana_instruction(arg0: vector<u8>, arg1: vector<SolanaAccountMeta>, arg2: vector<u8>) : SolanaInstruction {
        SolanaInstruction{
            program_id : arg0,
            keys       : arg1,
            data       : arg2,
        }
    }

    public fun create_solana_prepare_signing_execution_args(arg0: vector<AtaCreationData>, arg1: 0x1::option::Option<vector<u8>>, arg2: vector<u8>, arg3: 0x1::option::Option<SolanaGasArgs>) : SolanaPrepareSigningExecutionArgs {
        SolanaPrepareSigningExecutionArgs{
            ata_creations             : arg0,
            override_gas_limits       : arg3,
            override_recent_blockhash : arg1,
            payer_key                 : arg2,
        }
    }

    public fun create_solana_spl_transfer_data(arg0: u8, arg1: vector<u8>, arg2: vector<u8>, arg3: u8, arg4: bool) : SolanaSplTransferData {
        SolanaSplTransferData{
            ata_nonce          : arg0,
            sender_ata_pubkey  : arg1,
            token_mint_address : arg2,
            decimals           : arg3,
            is_token_2022      : arg4,
        }
    }

    public fun create_solana_transaction(arg0: vector<SolanaInstruction>, arg1: vector<CompactAddressLookupTable>, arg2: bool, arg3: 0x1::option::Option<vector<vector<u8>>>, arg4: 0x1::option::Option<vector<u8>>, arg5: 0x1::option::Option<vector<u8>>) : SolanaTransaction {
        SolanaTransaction{
            instructions                        : arg0,
            compact_lookup_tables               : arg1,
            is_legacy                           : arg2,
            signatures                          : arg3,
            recent_blockhash                    : arg4,
            compact_explicit_static_key_indices : arg5,
        }
    }

    fun derive_program_address(arg0: &vector<vector<u8>>, arg1: &vector<u8>) : vector<u8> {
        let v0 = 0x1::vector::empty<u8>();
        let v1 = 0;
        while (v1 < 0x1::vector::length<vector<u8>>(arg0)) {
            let v2 = 0x1::vector::borrow<vector<u8>>(arg0, v1);
            assert!(0x1::vector::length<u8>(v2) <= 32, 15);
            0x1::vector::append<u8>(&mut v0, *v2);
            v1 = v1 + 1;
        };
        0x1::vector::append<u8>(&mut v0, *arg1);
        0x1::vector::append<u8>(&mut v0, b"ProgramDerivedAddress");
        0x1::hash::sha2_256(v0)
    }

    public fun derive_program_address_with_nonce(arg0: vector<vector<u8>>, arg1: &vector<u8>, arg2: u8) : vector<u8> {
        0x1::vector::push_back<vector<u8>>(&mut arg0, 0x1::vector::singleton<u8>(arg2));
        derive_program_address(&arg0, arg1)
    }

    fun encode_u8_and_u64_le_data(arg0: u8, arg1: u256) : vector<u8> {
        let v0 = 0x1::vector::empty<u8>();
        0x1::vector::push_back<u8>(&mut v0, arg0);
        let v1 = &mut v0;
        append_le_u64(v1, ((arg1 & 18446744073709551615) as u64));
        v0
    }

    public fun encode_u8_u256_as_u64_le_data(arg0: u8, arg1: u256, arg2: u8) : vector<u8> {
        let v0 = 0x1::vector::empty<u8>();
        0x1::vector::push_back<u8>(&mut v0, arg0);
        let v1 = &mut v0;
        append_le_u64(v1, ((arg1 & 18446744073709551615) as u64));
        0x1::vector::push_back<u8>(&mut v0, arg2);
        v0
    }

    public fun get_associated_token_account_program_id_bytes() : vector<u8> {
        x"8c97258f4e2489f1bb3d1029148e0d830b5a1399daff1084048e7bd8dbe9f859"
    }

    public fun get_compute_budget_program_id_bytes() : vector<u8> {
        x"0306466fe5211732ffecadba72c39be7bc8ce5bbc5f7126b2c439b3a40000000"
    }

    public fun get_message_components(arg0: 0x2::vec_map::VecMap<vector<u8>, KeyMeta>, arg1: &vector<u8>, arg2: 0x1::option::Option<vector<u8>>) : (MessageHeader, vector<vector<u8>>) {
        if (0x1::option::is_some<vector<u8>>(&arg2)) {
            let v2 = 0x1::option::destroy_some<vector<u8>>(arg2);
            let (v3, _) = 0x2::vec_map::into_keys_values<vector<u8>, KeyMeta>(arg0);
            let v5 = v3;
            let v6 = &mut v5;
            sort_pubkeys_lexicographically(v6);
            let v7 = 0x1::vector::length<vector<u8>>(&v5);
            assert!(0x1::vector::length<u8>(&v2) == v7, 16);
            if (v7 > 0) {
                let v8 = 0x1::vector::empty<bool>();
                let v9 = 0;
                while (v9 < v7) {
                    0x1::vector::push_back<bool>(&mut v8, false);
                    v9 = v9 + 1;
                };
                let v10 = 0;
                while (v10 < 0x1::vector::length<u8>(&v2)) {
                    let v11 = (*0x1::vector::borrow<u8>(&v2, v10) as u64);
                    assert!(v11 < v7, 16);
                    let v12 = 0x1::vector::borrow_mut<bool>(&mut v8, v11);
                    assert!(!*v12, 16);
                    *v12 = true;
                    v10 = v10 + 1;
                };
            } else {
                assert!(0x1::vector::is_empty<u8>(&v2), 16);
            };
            let v13 = 0x1::vector::empty<vector<u8>>();
            let v14 = 0;
            while (v14 < 0x1::vector::length<u8>(&v2)) {
                0x1::vector::push_back<vector<u8>>(&mut v13, *0x1::vector::borrow<vector<u8>>(&v5, (*0x1::vector::borrow<u8>(&v2, v14) as u64)));
                v14 = v14 + 1;
            };
            assert!(!0x1::vector::is_empty<vector<u8>>(&v13), 13);
            assert!(0x1::vector::borrow<vector<u8>>(&v13, 0) == arg1, 13);
            assert!(0x2::vec_map::contains<vector<u8>, KeyMeta>(&arg0, arg1), 13);
            let v15 = 0x2::vec_map::get<vector<u8>, KeyMeta>(&arg0, arg1);
            assert!(v15.is_signer && v15.is_writable, 13);
            let v16 = 0;
            let v17 = 0;
            let v18 = 0;
            let v19 = 0;
            while (v19 < 0x1::vector::length<vector<u8>>(&v13)) {
                let v20 = 0x2::vec_map::get<vector<u8>, KeyMeta>(&arg0, 0x1::vector::borrow<vector<u8>>(&v13, v19));
                if (v20.is_signer) {
                    v16 = v16 + 1;
                    if (!v20.is_writable) {
                        v17 = v17 + 1;
                    };
                } else if (!v20.is_writable) {
                    v18 = v18 + 1;
                };
                v19 = v19 + 1;
            };
            let v21 = MessageHeader{
                num_required_signatures        : v16,
                num_readonly_signed_accounts   : v17,
                num_readonly_unsigned_accounts : v18,
            };
            (v21, v13)
        } else {
            let (v22, v23) = 0x2::vec_map::into_keys_values<vector<u8>, KeyMeta>(arg0);
            let v24 = v23;
            let v25 = v22;
            let v26 = 0x1::vector::empty<u64>();
            let v27 = 0x1::vector::empty<u64>();
            let v28 = 0x1::vector::empty<u64>();
            let v29 = 0x1::vector::empty<u64>();
            let v30 = 0;
            while (v30 < 0x1::vector::length<vector<u8>>(&v25)) {
                let v31 = 0x1::vector::borrow<KeyMeta>(&v24, v30);
                if (v31.is_signer && v31.is_writable) {
                    0x1::vector::push_back<u64>(&mut v26, v30);
                } else if (v31.is_signer && !v31.is_writable) {
                    0x1::vector::push_back<u64>(&mut v27, v30);
                } else if (!v31.is_signer && v31.is_writable) {
                    0x1::vector::push_back<u64>(&mut v28, v30);
                } else {
                    0x1::vector::push_back<u64>(&mut v29, v30);
                };
                v30 = v30 + 1;
            };
            let v32 = 0x1::vector::length<u64>(&v26);
            let v33 = 0x1::vector::length<u64>(&v27);
            let v34 = MessageHeader{
                num_required_signatures        : ((v32 + v33) as u8),
                num_readonly_signed_accounts   : (v33 as u8),
                num_readonly_unsigned_accounts : (0x1::vector::length<u64>(&v29) as u8),
            };
            assert!(v32 > 0, 13);
            if (v32 > 0) {
                assert!(arg1 == 0x1::vector::borrow<vector<u8>>(&v25, *0x1::vector::borrow<u64>(&v26, 0)), 13);
            };
            let v35 = 0x1::vector::empty<vector<u8>>();
            let v36 = &mut v35;
            concatenate_pubkeys(v36, &v25, &v26);
            let v37 = &mut v35;
            concatenate_pubkeys(v37, &v25, &v27);
            let v38 = &mut v35;
            concatenate_pubkeys(v38, &v25, &v28);
            let v39 = &mut v35;
            concatenate_pubkeys(v39, &v25, &v29);
            (v34, v35)
        }
    }

    fun get_or_insert_default(arg0: &mut 0x2::vec_map::VecMap<vector<u8>, KeyMeta>, arg1: &vector<u8>) : &mut KeyMeta {
        if (0x2::vec_map::contains<vector<u8>, KeyMeta>(arg0, arg1)) {
            0x2::vec_map::get_mut<vector<u8>, KeyMeta>(arg0, arg1)
        } else {
            let v1 = KeyMeta{
                is_signer   : false,
                is_writable : false,
                is_invoked  : false,
            };
            0x2::vec_map::insert<vector<u8>, KeyMeta>(arg0, *arg1, v1);
            0x2::vec_map::get_mut<vector<u8>, KeyMeta>(arg0, arg1)
        }
    }

    public fun get_solana_spl_transfer_data_fields(arg0: &SolanaSplTransferData) : (u8, vector<u8>, vector<u8>, u8, bool) {
        (arg0.ata_nonce, arg0.sender_ata_pubkey, arg0.token_mint_address, arg0.decimals, arg0.is_token_2022)
    }

    public fun get_system_program_id_bytes() : vector<u8> {
        let v0 = 0x1::vector::empty<u8>();
        let v1 = 0;
        while (v1 < 32) {
            0x1::vector::push_back<u8>(&mut v0, 0);
            v1 = v1 + 1;
        };
        v0
    }

    public fun get_token_program_2022_program_id_bytes() : vector<u8> {
        x"06ddf6e1ee758fde18425dbce46ccddab61afc4d83b90d27febdf928d8a18bfc"
    }

    public fun get_token_program_id_bytes() : vector<u8> {
        x"06ddf6e1d765a193d9cbe146ceeb79ac1cb485ed5f5b37913a8cf5857eff00a9"
    }

    public fun init_solana_module(arg0: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::object::new(arg0);
        let v1 = SolanaModule{
            id  : v0,
            cap : 0x8149631b2b88686a6ae1337c93939c0ed52f9b32dd0817612557dee54c8f1894::module_interface::create_module_cap(0x2::object::uid_to_inner(&v0), arg0),
        };
        0x2::transfer::share_object<SolanaModule>(v1);
    }

    public fun prepare_signing(arg0: &mut 0x8149631b2b88686a6ae1337c93939c0ed52f9b32dd0817612557dee54c8f1894::module_interface::VaultContainer, arg1: &SolanaModule, arg2: 0x8149631b2b88686a6ae1337c93939c0ed52f9b32dd0817612557dee54c8f1894::module_interface::ModuleActionRequest<SolanaAction>, arg3: vector<SolanaPrepareSigningExecutionArgs>) : 0x8149631b2b88686a6ae1337c93939c0ed52f9b32dd0817612557dee54c8f1894::module_interface::ModuleActionResult<SolanaPreparedSigning> {
        let (_, _, _, _, _, _, v6, v7) = 0x8149631b2b88686a6ae1337c93939c0ed52f9b32dd0817612557dee54c8f1894::module_interface::view_module_action_request<SolanaAction>(&arg2);
        let v8 = v6;
        assert!(!v7, 0);
        let v9 = 0x8149631b2b88686a6ae1337c93939c0ed52f9b32dd0817612557dee54c8f1894::module_interface::get_state_borrow_mut<SolanaChainState, SolanaTxData, SolanaAction>(arg0, &arg2, &arg1.cap);
        let v10 = 0x1::vector::empty<vector<u8>>();
        let v11 = 0x1::vector::empty<SolanaPreparedSigningData>();
        let v12 = &v8.transactions;
        let v13 = &arg3;
        let v14 = 0x1::vector::length<SolanaTransaction>(v12);
        assert!(v14 == 0x1::vector::length<SolanaPrepareSigningExecutionArgs>(v13), 9223378977521926143);
        let v15 = 0;
        while (v15 < v14) {
            let v16 = 0x1::vector::borrow<SolanaTransaction>(v12, v15);
            let v17 = 0x1::vector::borrow<SolanaPrepareSigningExecutionArgs>(v13, v15);
            let (v18, v19) = sign_solana_transaction(v9, v16, v17, v16.compact_explicit_static_key_indices);
            0x1::vector::push_back<vector<u8>>(&mut v10, v18);
            let v20 = SolanaPreparedSigningData{
                signable_message      : v18,
                override_gas_limits   : v17.override_gas_limits,
                ata_account_creations : v19,
                signatures            : v16.signatures,
            };
            0x1::vector::push_back<SolanaPreparedSigningData>(&mut v11, v20);
            v15 = v15 + 1;
        };
        SolanaTxData{updated: false};
        let v21 = SolanaPreparedSigning{data: v11};
        0x8149631b2b88686a6ae1337c93939c0ed52f9b32dd0817612557dee54c8f1894::module_interface::create_module_action_result<SolanaAction, SolanaPreparedSigning>(arg2, v21, &arg1.cap, v10)
    }

    fun remove_key_if_exists(arg0: &mut 0x2::vec_map::VecMap<vector<u8>, KeyMeta>, arg1: &vector<u8>) {
        if (0x2::vec_map::contains<vector<u8>, KeyMeta>(arg0, arg1)) {
            let (_, _) = 0x2::vec_map::remove<vector<u8>, KeyMeta>(arg0, arg1);
        };
    }

    public fun serialize_address_table_lookups(arg0: &vector<MessageAddressTableLookup>) : vector<u8> {
        let v0 = 0x1::vector::empty<u8>();
        let v1 = 0;
        while (v1 < 0x1::vector::length<MessageAddressTableLookup>(arg0)) {
            let v2 = 0x1::vector::borrow<MessageAddressTableLookup>(arg0, v1);
            let v3 = 0;
            while (v3 < 32) {
                0x1::vector::push_back<u8>(&mut v0, *0x1::vector::borrow<u8>(&v2.account_key, v3));
                v3 = v3 + 1;
            };
            let v4 = 0x1::vector::length<u8>(&v2.writable_indexes);
            0x1::vector::append<u8>(&mut v0, shortvec_encode_length(v4));
            let v5 = 0;
            while (v5 < v4) {
                0x1::vector::push_back<u8>(&mut v0, (*0x1::vector::borrow<u8>(&v2.writable_indexes, v5) as u8));
                v5 = v5 + 1;
            };
            let v6 = 0x1::vector::length<u8>(&v2.readonly_indexes);
            0x1::vector::append<u8>(&mut v0, shortvec_encode_length(v6));
            let v7 = 0;
            while (v7 < v6) {
                0x1::vector::push_back<u8>(&mut v0, (*0x1::vector::borrow<u8>(&v2.readonly_indexes, v7) as u8));
                v7 = v7 + 1;
            };
            v1 = v1 + 1;
        };
        v0
    }

    public fun serialize_instructions(arg0: &vector<MessageCompiledInstruction>) : vector<u8> {
        let v0 = 0x1::vector::empty<u8>();
        let v1 = 0;
        while (v1 < 0x1::vector::length<MessageCompiledInstruction>(arg0)) {
            let v2 = 0x1::vector::borrow<MessageCompiledInstruction>(arg0, v1);
            0x1::vector::push_back<u8>(&mut v0, v2.program_id_index);
            let v3 = 0x1::vector::length<u8>(&v2.account_key_indexes);
            0x1::vector::append<u8>(&mut v0, shortvec_encode_length(v3));
            let v4 = 0;
            while (v4 < v3) {
                0x1::vector::push_back<u8>(&mut v0, (*0x1::vector::borrow<u8>(&v2.account_key_indexes, v4) as u8));
                v4 = v4 + 1;
            };
            0x1::vector::append<u8>(&mut v0, shortvec_encode_length(0x1::vector::length<u8>(&v2.data)));
            0x1::vector::append<u8>(&mut v0, v2.data);
            v1 = v1 + 1;
        };
        v0
    }

    fun serialize_message_legacy(arg0: &MessageLegacyArgs) : vector<u8> {
        let v0 = 0x1::vector::empty<u8>();
        0x1::vector::push_back<u8>(&mut v0, arg0.header.num_required_signatures);
        0x1::vector::push_back<u8>(&mut v0, arg0.header.num_readonly_signed_accounts);
        0x1::vector::push_back<u8>(&mut v0, arg0.header.num_readonly_unsigned_accounts);
        let v1 = 0x1::vector::length<vector<u8>>(&arg0.account_keys);
        0x1::vector::append<u8>(&mut v0, shortvec_encode_length(v1));
        let v2 = 0;
        while (v2 < v1) {
            let v3 = 0x1::vector::borrow<vector<u8>>(&arg0.account_keys, v2);
            let v4 = 0;
            while (v4 < 0x1::vector::length<u8>(v3)) {
                0x1::vector::push_back<u8>(&mut v0, *0x1::vector::borrow<u8>(v3, v4));
                v4 = v4 + 1;
            };
            v2 = v2 + 1;
        };
        let v5 = 0;
        while (v5 < 0x1::vector::length<u8>(&arg0.recent_blockhash)) {
            0x1::vector::push_back<u8>(&mut v0, *0x1::vector::borrow<u8>(&arg0.recent_blockhash, v5));
            v5 = v5 + 1;
        };
        0x1::vector::append<u8>(&mut v0, shortvec_encode_length(0x1::vector::length<MessageCompiledInstruction>(&arg0.compiled_instructions)));
        0x1::vector::append<u8>(&mut v0, serialize_instructions(&arg0.compiled_instructions));
        v0
    }

    fun serialize_message_v0(arg0: &MessageV0Args) : vector<u8> {
        let v0 = 0x1::vector::empty<u8>();
        0x1::vector::push_back<u8>(&mut v0, 128);
        0x1::vector::push_back<u8>(&mut v0, arg0.header.num_required_signatures);
        0x1::vector::push_back<u8>(&mut v0, arg0.header.num_readonly_signed_accounts);
        0x1::vector::push_back<u8>(&mut v0, arg0.header.num_readonly_unsigned_accounts);
        let v1 = 0x1::vector::length<vector<u8>>(&arg0.static_account_keys);
        0x1::vector::append<u8>(&mut v0, shortvec_encode_length(v1));
        let v2 = 0;
        while (v2 < v1) {
            let v3 = 0x1::vector::borrow<vector<u8>>(&arg0.static_account_keys, v2);
            let v4 = 0;
            while (v4 < 0x1::vector::length<u8>(v3)) {
                0x1::vector::push_back<u8>(&mut v0, *0x1::vector::borrow<u8>(v3, v4));
                v4 = v4 + 1;
            };
            v2 = v2 + 1;
        };
        let v5 = 0;
        while (v5 < 0x1::vector::length<u8>(&arg0.recent_blockhash)) {
            0x1::vector::push_back<u8>(&mut v0, *0x1::vector::borrow<u8>(&arg0.recent_blockhash, v5));
            v5 = v5 + 1;
        };
        0x1::vector::append<u8>(&mut v0, shortvec_encode_length(0x1::vector::length<MessageCompiledInstruction>(&arg0.compiled_instructions)));
        0x1::vector::append<u8>(&mut v0, serialize_instructions(&arg0.compiled_instructions));
        0x1::vector::append<u8>(&mut v0, shortvec_encode_length(0x1::vector::length<MessageAddressTableLookup>(&arg0.address_table_lookups)));
        0x1::vector::append<u8>(&mut v0, serialize_address_table_lookups(&arg0.address_table_lookups));
        v0
    }

    public fun serialize_transaction(arg0: &vector<vector<u8>>, arg1: &vector<u8>) : vector<u8> {
        let v0 = 0x1::vector::empty<u8>();
        let v1 = 0x1::vector::length<vector<u8>>(arg0);
        0x1::vector::append<u8>(&mut v0, shortvec_encode_length(v1));
        let v2 = 0;
        while (v2 < v1) {
            let v3 = 0x1::vector::borrow<vector<u8>>(arg0, v2);
            let v4 = 0;
            while (v4 < 0x1::vector::length<u8>(v3)) {
                0x1::vector::push_back<u8>(&mut v0, *0x1::vector::borrow<u8>(v3, v4));
                v4 = v4 + 1;
            };
            v2 = v2 + 1;
        };
        0x1::vector::append<u8>(&mut v0, *arg1);
        v0
    }

    fun shortvec_encode_length(arg0: u64) : vector<u8> {
        let v0 = 0x1::vector::empty<u8>();
        let v1 = arg0;
        let v2;
        loop {
            v2 = v1 & 127;
            v1 = v1 >> 7;
            if (v1 == 0) {
                break
            };
            0x1::vector::push_back<u8>(&mut v0, (v2 as u8) | 128);
        };
        0x1::vector::push_back<u8>(&mut v0, (v2 as u8));
        v0
    }

    fun sign_solana_transaction(arg0: &mut SolanaChainState, arg1: &SolanaTransaction, arg2: &SolanaPrepareSigningExecutionArgs, arg3: 0x1::option::Option<vector<u8>>) : (vector<u8>, u64) {
        let v0 = 0;
        let v1 = false;
        let v2 = false;
        let v3 = 0x1::vector::empty<SolanaInstruction>();
        let v4 = 0x1::vector::empty<SolanaInstruction>();
        if (0x1::option::is_some<SolanaGasArgs>(&arg2.override_gas_limits)) {
            let v5 = 0x1::option::borrow<SolanaGasArgs>(&arg2.override_gas_limits);
            assert!(v5.priority_fee_per_compute_unit * (v5.max_compute_units as u256) / 1000000 <= arg0.max_priority_fee, 24);
            let v6 = 0;
            while (v6 < 0x1::vector::length<SolanaInstruction>(&arg1.instructions)) {
                let v7 = *0x1::vector::borrow<SolanaInstruction>(&arg1.instructions, v6);
                if (v7.program_id == get_compute_budget_program_id_bytes()) {
                    if (0x1::vector::length<u8>(&v7.data) > 0) {
                        let v8 = *0x1::vector::borrow<u8>(&v7.data, 0);
                        if (v8 == 2) {
                            let v9 = 0x1::vector::empty<u8>();
                            0x1::vector::push_back<u8>(&mut v9, 2);
                            let v10 = &mut v9;
                            append_le_u32(v10, v5.max_compute_units);
                            v7.data = v9;
                            v1 = true;
                        } else if (v8 == 3) {
                            v7.data = encode_u8_and_u64_le_data(3, v5.priority_fee_per_compute_unit);
                            v2 = true;
                        };
                    };
                };
                0x1::vector::push_back<SolanaInstruction>(&mut v4, v7);
                v6 = v6 + 1;
            };
            if (!v1) {
                0x1::vector::push_back<SolanaInstruction>(&mut v3, build_set_compute_unit_limit_instruction(v5.max_compute_units));
            };
            if (!v2) {
                0x1::vector::push_back<SolanaInstruction>(&mut v3, build_set_compute_unit_price_instruction(v5.priority_fee_per_compute_unit));
            };
        } else {
            v4 = arg1.instructions;
        };
        let v11 = 0;
        while (v11 < 0x1::vector::length<AtaCreationData>(&arg2.ata_creations)) {
            let v12 = 0x1::vector::borrow<AtaCreationData>(&arg2.ata_creations, v11);
            assert!(v12.token_program_id == get_token_program_2022_program_id_bytes() || v12.token_program_id == get_token_program_id_bytes(), 25);
            0x1::vector::push_back<SolanaInstruction>(&mut v3, build_create_associated_token_account_instruction(arg2.payer_key, v12.associated_token, v12.owner, v12.mint_token_address, get_system_program_id_bytes(), v12.token_program_id, get_associated_token_account_program_id_bytes()));
            v11 = v11 + 1;
        };
        0x1::vector::append<SolanaInstruction>(&mut v3, v4);
        let v13 = 0;
        while (v13 < 0x1::vector::length<SolanaInstruction>(&v3)) {
            if (0x1::vector::borrow<SolanaInstruction>(&v3, v13).program_id == get_associated_token_account_program_id_bytes()) {
                v0 = v0 + 1;
            };
            v13 = v13 + 1;
        };
        let v14 = if (0x1::option::is_some<vector<u8>>(&arg2.override_recent_blockhash)) {
            0x1::option::destroy_some<vector<u8>>(arg2.override_recent_blockhash)
        } else {
            0x1::option::destroy_some<vector<u8>>(arg1.recent_blockhash)
        };
        let v15 = if (arg1.is_legacy) {
            let v16 = compile_message_legacy(&v3, &arg2.payer_key, &v14, arg3);
            serialize_message_legacy(&v16)
        } else {
            let v17 = compile_message_v0(v3, arg1.compact_lookup_tables, arg2.payer_key, v14, arg3);
            serialize_message_v0(&v17)
        };
        (v15, v0)
    }

    fun sort_pubkeys_lexicographically(arg0: &mut vector<vector<u8>>) {
        let v0 = 0x1::vector::length<vector<u8>>(arg0);
        if (v0 <= 1) {
            return
        };
        let v1 = 1;
        while (v1 < v0) {
            let v2 = *0x1::vector::borrow<vector<u8>>(arg0, v1);
            let v3 = v1;
            while (v1 > 0) {
                if (compare_pubkeys(&v2, 0x1::vector::borrow<vector<u8>>(arg0, v1 - 1)) == 0) {
                    v3 = v1 - 1;
                    v1 = v1 - 1;
                } else {
                    break
                };
            };
            if (v3 != v1) {
                0x1::vector::insert<vector<u8>>(arg0, 0x1::vector::remove<vector<u8>>(arg0, v1), v3);
            };
            v1 = v1 + 1;
        };
    }

    fun test_util_create_solana_module(arg0: 0x8149631b2b88686a6ae1337c93939c0ed52f9b32dd0817612557dee54c8f1894::module_interface::ModuleCap, arg1: &mut 0x2::tx_context::TxContext) : SolanaModule {
        SolanaModule{
            id  : 0x2::object::new(arg1),
            cap : arg0,
        }
    }

    public fun u256_to_le_bytes(arg0: u256) : vector<u8> {
        let v0 = 0x1::vector::empty<u8>();
        let v1 = 0;
        while (v1 < 32) {
            0x1::vector::push_back<u8>(&mut v0, ((arg0 >> v1 * 8 & 255) as u8));
            v1 = v1 + 1;
        };
        v0
    }

    // decompiled from Move bytecode v6
}

