module 0xbe9e8a86c9ee03d8e9f1fe5c2301702a85b79cf2a99920fc244adb86fe4bd3ab::solana_module {
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

    struct PriorityFeeData has copy, drop, store {
        priority_fee_per_compute_unit: u256,
    }

    struct ComputeUnitLimitData has copy, drop, store {
        compute_unit_limit: u32,
    }

    struct CompactAddressLookupTable has copy, drop, store {
        key: vector<u8>,
        writable_indexes: vector<u8>,
        readonly_indexes: vector<u8>,
        writable_addresses: vector<vector<u8>>,
        readonly_addresses: vector<vector<u8>>,
    }

    struct SolanaAction has copy, drop, store {
        instructions: vector<SolanaInstruction>,
        compact_lookup_tables: vector<CompactAddressLookupTable>,
    }

    struct SolanaSplTransferData has copy, drop, store {
        ata_nonce: u8,
        sender_ata_pubkey: vector<u8>,
        token_mint_address: vector<u8>,
        decimals: u8,
        is_token_2022: bool,
    }

    struct SolanaPreparedSigning has copy, drop, store {
        signable_message: vector<u8>,
        max_compute_units: u256,
        priority_fee_per_compute_unit: u256,
        ata_account_creations: u64,
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
        SolanaAction{
            instructions          : v0,
            compact_lookup_tables : 0x1::vector::empty<CompactAddressLookupTable>(),
        }
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

    public fun compile_message_v0(arg0: vector<SolanaInstruction>, arg1: vector<CompactAddressLookupTable>, arg2: vector<u8>, arg3: vector<u8>) : MessageV0Args {
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
        let (v13, v14) = get_message_components(v0, &arg2);
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

    public fun create_compute_unit_limit_data(arg0: u32) : ComputeUnitLimitData {
        ComputeUnitLimitData{compute_unit_limit: arg0}
    }

    public fun create_module_shared_data_solana(arg0: &SolanaModule, arg1: 0x2::vec_map::VecMap<0x1::string::String, SolanaChainState>, arg2: &mut 0x2::tx_context::TxContext) : 0x8149631b2b88686a6ae1337c93939c0ed52f9b32dd0817612557dee54c8f1894::module_interface::ModuleSharedData<SolanaChainState> {
        0x8149631b2b88686a6ae1337c93939c0ed52f9b32dd0817612557dee54c8f1894::module_interface::create_module_shared_data<SolanaChainState>(&arg0.cap, arg1, arg2)
    }

    public fun create_priority_fee_data(arg0: u256) : PriorityFeeData {
        PriorityFeeData{priority_fee_per_compute_unit: arg0}
    }

    public fun create_solana_account_meta(arg0: vector<u8>, arg1: bool, arg2: bool) : SolanaAccountMeta {
        SolanaAccountMeta{
            pubkey      : arg0,
            is_signer   : arg1,
            is_writable : arg2,
        }
    }

    public fun create_solana_action(arg0: vector<SolanaInstruction>, arg1: vector<CompactAddressLookupTable>) : SolanaAction {
        SolanaAction{
            instructions          : arg0,
            compact_lookup_tables : arg1,
        }
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

    public fun create_solana_instruction(arg0: vector<u8>, arg1: vector<SolanaAccountMeta>, arg2: vector<u8>) : SolanaInstruction {
        SolanaInstruction{
            program_id : arg0,
            keys       : arg1,
            data       : arg2,
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

    public fun get_message_components(arg0: 0x2::vec_map::VecMap<vector<u8>, KeyMeta>, arg1: &vector<u8>) : (MessageHeader, vector<vector<u8>>) {
        let (v0, v1) = 0x2::vec_map::into_keys_values<vector<u8>, KeyMeta>(arg0);
        let v2 = v1;
        let v3 = v0;
        let v4 = 0x1::vector::empty<u64>();
        let v5 = 0x1::vector::empty<u64>();
        let v6 = 0x1::vector::empty<u64>();
        let v7 = 0x1::vector::empty<u64>();
        let v8 = 0;
        while (v8 < 0x1::vector::length<vector<u8>>(&v3)) {
            let v9 = 0x1::vector::borrow<KeyMeta>(&v2, v8);
            if (v9.is_signer && v9.is_writable) {
                0x1::vector::push_back<u64>(&mut v4, v8);
            } else if (v9.is_signer && !v9.is_writable) {
                0x1::vector::push_back<u64>(&mut v5, v8);
            } else if (!v9.is_signer && v9.is_writable) {
                0x1::vector::push_back<u64>(&mut v6, v8);
            } else {
                0x1::vector::push_back<u64>(&mut v7, v8);
            };
            v8 = v8 + 1;
        };
        let v10 = 0x1::vector::length<u64>(&v4);
        let v11 = 0x1::vector::length<u64>(&v5);
        let v12 = MessageHeader{
            num_required_signatures        : ((v10 + v11) as u8),
            num_readonly_signed_accounts   : (v11 as u8),
            num_readonly_unsigned_accounts : (0x1::vector::length<u64>(&v7) as u8),
        };
        assert!(v10 > 0, 13);
        assert!(arg1 == 0x1::vector::borrow<vector<u8>>(&v3, *0x1::vector::borrow<u64>(&v4, 0)), 13);
        let v13 = 0x1::vector::empty<vector<u8>>();
        let v14 = &mut v13;
        concatenate_pubkeys(v14, &v3, &v4);
        let v15 = &mut v13;
        concatenate_pubkeys(v15, &v3, &v5);
        let v16 = &mut v13;
        concatenate_pubkeys(v16, &v3, &v6);
        let v17 = &mut v13;
        concatenate_pubkeys(v17, &v3, &v7);
        (v12, v13)
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

    public fun prepare_signing(arg0: &mut 0x8149631b2b88686a6ae1337c93939c0ed52f9b32dd0817612557dee54c8f1894::module_interface::VaultContainer, arg1: &SolanaModule, arg2: 0x8149631b2b88686a6ae1337c93939c0ed52f9b32dd0817612557dee54c8f1894::module_interface::ModuleActionRequest<SolanaAction>, arg3: vector<AtaCreationData>, arg4: u256, arg5: bool, arg6: bool, arg7: vector<u8>, arg8: vector<u8>, arg9: u32) : 0x8149631b2b88686a6ae1337c93939c0ed52f9b32dd0817612557dee54c8f1894::module_interface::ModuleActionResult<SolanaPreparedSigning> {
        let (_, _, _, _, _, v5, v6, v7) = 0x8149631b2b88686a6ae1337c93939c0ed52f9b32dd0817612557dee54c8f1894::module_interface::view_module_action_request<SolanaAction>(&arg2);
        let v8 = v6;
        let v9 = 0;
        assert!(!v7, 0);
        assert!(arg4 * (arg9 as u256) / 1000000 <= 0x8149631b2b88686a6ae1337c93939c0ed52f9b32dd0817612557dee54c8f1894::module_interface::get_state_borrow_mut<SolanaChainState, SolanaTxData, SolanaAction>(arg0, &arg2, &arg1.cap).max_priority_fee, 24);
        let v10 = 0x1::vector::empty<SolanaInstruction>();
        if (arg6) {
            0x1::vector::push_back<SolanaInstruction>(&mut v10, build_set_compute_unit_limit_instruction(arg9));
        };
        if (arg5) {
            0x1::vector::push_back<SolanaInstruction>(&mut v10, build_set_compute_unit_price_instruction(arg4));
        };
        let v11 = 0;
        while (v11 < 0x1::vector::length<AtaCreationData>(&arg3)) {
            let v12 = 0x1::vector::borrow<AtaCreationData>(&arg3, v11);
            assert!(v12.token_program_id == get_token_program_2022_program_id_bytes() || v12.token_program_id == get_token_program_id_bytes(), 25);
            0x1::vector::push_back<SolanaInstruction>(&mut v10, build_create_associated_token_account_instruction(arg8, v12.associated_token, v12.owner, v12.mint_token_address, get_system_program_id_bytes(), v12.token_program_id, get_associated_token_account_program_id_bytes()));
            v11 = v11 + 1;
        };
        0x1::vector::append<SolanaInstruction>(&mut v10, v8.instructions);
        let v13 = 0;
        while (v13 < 0x1::vector::length<SolanaInstruction>(&v10)) {
            if (0x1::vector::borrow<SolanaInstruction>(&v10, v13).program_id == get_associated_token_account_program_id_bytes()) {
                v9 = v9 + 1;
            };
            v13 = v13 + 1;
        };
        let v14 = compile_message_v0(v10, v8.compact_lookup_tables, arg8, arg7);
        let v15 = SolanaTxData{updated: false};
        0x8149631b2b88686a6ae1337c93939c0ed52f9b32dd0817612557dee54c8f1894::module_interface::add_transaction<SolanaChainState, SolanaTxData, SolanaAction>(arg0, v5, v15, &arg2, &arg1.cap);
        let v16 = SolanaPreparedSigning{
            signable_message              : serialize_message_v0(&v14),
            max_compute_units             : (arg9 as u256),
            priority_fee_per_compute_unit : arg4,
            ata_account_creations         : v9,
        };
        0x8149631b2b88686a6ae1337c93939c0ed52f9b32dd0817612557dee54c8f1894::module_interface::create_module_action_result<SolanaAction, SolanaPreparedSigning>(arg2, v16, &arg1.cap, 0x1::vector::singleton<vector<u8>>(v16.signable_message))
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

