module 0xd3a2960aaf137bf5c47680304ff07c0ea159b62a37fd315dac57bdcd14af1cb2::orchestrator {
    struct SealSigned has copy, drop {
        source_chain: u16,
        nft_contract: vector<u8>,
        token_id: vector<u8>,
        token_uri: vector<u8>,
        receiver: vector<u8>,
        deposit_address: vector<u8>,
        dwallet_pubkey: vector<u8>,
        message_hash: vector<u8>,
        signature: vector<u8>,
        vaa_hash: vector<u8>,
        timestamp: u64,
    }

    struct SealPending has copy, drop {
        vaa_hash: vector<u8>,
        source_chain: u16,
        deposit_address: vector<u8>,
        receiver: vector<u8>,
        message_hash: vector<u8>,
        timestamp: u64,
    }

    struct EmitterRegistered has copy, drop {
        chain_id: u16,
        emitter_address: vector<u8>,
    }

    struct PendingSeal has drop, store {
        source_chain: u16,
        nft_contract: vector<u8>,
        token_id: vector<u8>,
        token_uri: vector<u8>,
        receiver: vector<u8>,
        deposit_address: vector<u8>,
        dwallet_pubkey: vector<u8>,
        message_hash: vector<u8>,
        dwallet_id_bytes: vector<u8>,
        timestamp: u64,
        completed: bool,
    }

    struct OrchestratorState has key {
        id: 0x2::object::UID,
        processed_vaas: 0x2::table::Table<vector<u8>, bool>,
        known_emitters: 0x2::table::Table<u16, vector<u8>>,
        pending_seals: 0x2::table::Table<vector<u8>, PendingSeal>,
        used_dwallets: 0x2::table::Table<vector<u8>, bool>,
        total_processed: u64,
        treasury: 0xd3a2960aaf137bf5c47680304ff07c0ea159b62a37fd315dac57bdcd14af1cb2::treasury::Treasury,
    }

    struct OrchestratorAdminCap has store, key {
        id: 0x2::object::UID,
    }

    struct MintingAuthority has key {
        id: 0x2::object::UID,
        minting_pubkey: vector<u8>,
    }

    public fun add_ika_payment(arg0: &mut OrchestratorState, arg1: &OrchestratorAdminCap, arg2: 0x2::coin::Coin<0x7262fb2f7a3a14c888c438a3cd9b912469a58cf60f367352c46584262e8299aa::ika::IKA>) {
        0xd3a2960aaf137bf5c47680304ff07c0ea159b62a37fd315dac57bdcd14af1cb2::treasury::add_ika(&mut arg0.treasury, arg2);
    }

    public fun add_sui_payment(arg0: &mut OrchestratorState, arg1: &OrchestratorAdminCap, arg2: 0x2::coin::Coin<0x2::sui::SUI>) {
        0xd3a2960aaf137bf5c47680304ff07c0ea159b62a37fd315dac57bdcd14af1cb2::treasury::add_sui(&mut arg0.treasury, arg2);
    }

    public fun complete_seal(arg0: &mut OrchestratorState, arg1: &mut 0xd3a2960aaf137bf5c47680304ff07c0ea159b62a37fd315dac57bdcd14af1cb2::dwallet_registry::DWalletRegistry, arg2: &MintingAuthority, arg3: vector<u8>, arg4: vector<u8>, arg5: &0x2::clock::Clock, arg6: &mut 0x2::tx_context::TxContext) {
        assert!(0x2::table::contains<vector<u8>, PendingSeal>(&arg0.pending_seals, arg3), 9);
        let v0 = 0x2::table::borrow_mut<vector<u8>, PendingSeal>(&mut arg0.pending_seals, arg3);
        assert!(!v0.completed, 10);
        assert!(0x1::vector::length<u8>(&arg4) == 64, 4);
        assert!(0x1::vector::length<u8>(&arg2.minting_pubkey) == 32, 4);
        assert!(0x2::ed25519::ed25519_verify(&arg4, &arg2.minting_pubkey, &v0.message_hash), 4);
        v0.completed = true;
        arg0.total_processed = arg0.total_processed + 1;
        0x2::table::add<vector<u8>, bool>(&mut arg0.used_dwallets, v0.deposit_address, true);
        if (0xd3a2960aaf137bf5c47680304ff07c0ea159b62a37fd315dac57bdcd14af1cb2::dwallet_registry::is_registered(arg1, &v0.deposit_address)) {
            0xd3a2960aaf137bf5c47680304ff07c0ea159b62a37fd315dac57bdcd14af1cb2::dwallet_registry::mark_dwallet_used(arg1, &v0.deposit_address);
        };
        let v1 = SealSigned{
            source_chain    : v0.source_chain,
            nft_contract    : v0.nft_contract,
            token_id        : v0.token_id,
            token_uri       : v0.token_uri,
            receiver        : v0.receiver,
            deposit_address : v0.deposit_address,
            dwallet_pubkey  : arg2.minting_pubkey,
            message_hash    : v0.message_hash,
            signature       : arg4,
            vaa_hash        : arg3,
            timestamp       : 0x2::clock::timestamp_ms(arg5) / 1000,
        };
        0x2::event::emit<SealSigned>(v1);
    }

    public fun create_minting_dwallet(arg0: &mut OrchestratorState, arg1: &mut 0xd3a2960aaf137bf5c47680304ff07c0ea159b62a37fd315dac57bdcd14af1cb2::signing::SigningState, arg2: &OrchestratorAdminCap, arg3: &mut 0xdd24c62739923fbf582f49ef190b4a007f981ca6eb209ca94f3a8eaf7c611317::coordinator::DWalletCoordinator, arg4: 0x2::object::ID, arg5: vector<u8>, arg6: vector<u8>, arg7: vector<u8>, arg8: vector<u8>, arg9: &mut 0x2::tx_context::TxContext) {
        0xd3a2960aaf137bf5c47680304ff07c0ea159b62a37fd315dac57bdcd14af1cb2::signing::create_minting_dwallet(arg1, &mut arg0.treasury, arg3, arg4, arg5, arg6, arg7, arg8, arg9);
    }

    public fun deposit_nft<T0: store + key>(arg0: &mut OrchestratorState, arg1: &MintingAuthority, arg2: T0, arg3: vector<u8>, arg4: vector<u8>, arg5: &0x2::clock::Clock, arg6: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::clock::timestamp_ms(arg5) / 1000;
        assert!(0x1::vector::length<u8>(&arg3) == 32, 12);
        let v1 = 0x2::object::id<T0>(&arg2);
        let v2 = 0x2::object::id_to_bytes(&v1);
        let v3 = 0x1::hash::sha2_256(0x1::ascii::into_bytes(0x1::type_name::into_string(0x1::type_name::with_defining_ids<T0>())));
        let v4 = 21;
        let v5 = 0x1::vector::empty<u8>();
        0x1::vector::push_back<u8>(&mut v5, ((v4 >> 8) as u8));
        0x1::vector::push_back<u8>(&mut v5, ((v4 & 255) as u8));
        0x1::vector::append<u8>(&mut v5, v3);
        0x1::vector::append<u8>(&mut v5, v2);
        0x1::vector::append<u8>(&mut v5, arg3);
        let v6 = 0x1::hash::sha2_256(v5);
        assert!(!0x2::table::contains<vector<u8>, bool>(&arg0.processed_vaas, v6), 7);
        assert!(!0x2::table::contains<vector<u8>, bool>(&arg0.used_dwallets, v2), 11);
        let v7 = 0xd3a2960aaf137bf5c47680304ff07c0ea159b62a37fd315dac57bdcd14af1cb2::payload::construct_signing_message(&arg4, &v2, &arg3);
        let v8 = PendingSeal{
            source_chain     : v4,
            nft_contract     : v3,
            token_id         : v2,
            token_uri        : arg4,
            receiver         : arg3,
            deposit_address  : v2,
            dwallet_pubkey   : arg1.minting_pubkey,
            message_hash     : v7,
            dwallet_id_bytes : 0x1::vector::empty<u8>(),
            timestamp        : v0,
            completed        : false,
        };
        0x2::table::add<vector<u8>, PendingSeal>(&mut arg0.pending_seals, v6, v8);
        0x2::table::add<vector<u8>, bool>(&mut arg0.processed_vaas, v6, true);
        0x2::dynamic_object_field::add<0x2::object::ID, T0>(&mut arg0.id, v1, arg2);
        let v9 = SealPending{
            vaa_hash        : v6,
            source_chain    : v4,
            deposit_address : v2,
            receiver        : arg3,
            message_hash    : v7,
            timestamp       : v0,
        };
        0x2::event::emit<SealPending>(v9);
    }

    public fun get_known_emitter(arg0: &OrchestratorState, arg1: u16) : vector<u8> {
        *0x2::table::borrow<u16, vector<u8>>(&arg0.known_emitters, arg1)
    }

    public fun get_minting_pubkey(arg0: &MintingAuthority) : vector<u8> {
        arg0.minting_pubkey
    }

    public fun has_known_emitter(arg0: &OrchestratorState, arg1: u16) : bool {
        0x2::table::contains<u16, vector<u8>>(&arg0.known_emitters, arg1)
    }

    fun init(arg0: &mut 0x2::tx_context::TxContext) {
        let v0 = OrchestratorState{
            id              : 0x2::object::new(arg0),
            processed_vaas  : 0x2::table::new<vector<u8>, bool>(arg0),
            known_emitters  : 0x2::table::new<u16, vector<u8>>(arg0),
            pending_seals   : 0x2::table::new<vector<u8>, PendingSeal>(arg0),
            used_dwallets   : 0x2::table::new<vector<u8>, bool>(arg0),
            total_processed : 0,
            treasury        : 0xd3a2960aaf137bf5c47680304ff07c0ea159b62a37fd315dac57bdcd14af1cb2::treasury::new(),
        };
        0x2::transfer::share_object<OrchestratorState>(v0);
        let v1 = MintingAuthority{
            id             : 0x2::object::new(arg0),
            minting_pubkey : 0x1::vector::empty<u8>(),
        };
        0x2::transfer::share_object<MintingAuthority>(v1);
        let v2 = OrchestratorAdminCap{id: 0x2::object::new(arg0)};
        0x2::transfer::public_transfer<OrchestratorAdminCap>(v2, 0x2::tx_context::sender(arg0));
    }

    public fun is_dwallet_used(arg0: &OrchestratorState, arg1: &vector<u8>) : bool {
        0x2::table::contains<vector<u8>, bool>(&arg0.used_dwallets, *arg1)
    }

    public fun is_seal_completed(arg0: &OrchestratorState, arg1: &vector<u8>) : bool {
        0x2::table::contains<vector<u8>, PendingSeal>(&arg0.pending_seals, *arg1) && 0x2::table::borrow<vector<u8>, PendingSeal>(&arg0.pending_seals, *arg1).completed
    }

    public fun is_seal_pending(arg0: &OrchestratorState, arg1: &vector<u8>) : bool {
        0x2::table::contains<vector<u8>, PendingSeal>(&arg0.pending_seals, *arg1) && !0x2::table::borrow<vector<u8>, PendingSeal>(&arg0.pending_seals, *arg1).completed
    }

    public fun is_vaa_processed(arg0: &OrchestratorState, arg1: &vector<u8>) : bool {
        0x2::table::contains<vector<u8>, bool>(&arg0.processed_vaas, *arg1)
    }

    public fun process_vaa(arg0: &mut OrchestratorState, arg1: &0x5306f64e312b581766351c07af79c72fcb1cd25147157fdc2f8ad76de9a3fb6a::state::State, arg2: &0xd3a2960aaf137bf5c47680304ff07c0ea159b62a37fd315dac57bdcd14af1cb2::dwallet_registry::DWalletRegistry, arg3: vector<u8>, arg4: 0x2::object::ID, arg5: &0x2::clock::Clock, arg6: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::clock::timestamp_ms(arg5) / 1000;
        let v1 = 0x5306f64e312b581766351c07af79c72fcb1cd25147157fdc2f8ad76de9a3fb6a::vaa::parse_and_verify(arg1, arg3, arg5);
        let v2 = 0x5306f64e312b581766351c07af79c72fcb1cd25147157fdc2f8ad76de9a3fb6a::vaa::emitter_chain(&v1);
        let v3 = 0x5306f64e312b581766351c07af79c72fcb1cd25147157fdc2f8ad76de9a3fb6a::bytes32::to_bytes(0x5306f64e312b581766351c07af79c72fcb1cd25147157fdc2f8ad76de9a3fb6a::vaa::digest(&v1));
        let (_, _, v6) = 0x5306f64e312b581766351c07af79c72fcb1cd25147157fdc2f8ad76de9a3fb6a::vaa::take_emitter_info_and_payload(v1);
        let v7 = v6;
        assert!(0x2::table::contains<u16, vector<u8>>(&arg0.known_emitters, v2), 6);
        assert!(*0x2::table::borrow<u16, vector<u8>>(&arg0.known_emitters, v2) == 0x5306f64e312b581766351c07af79c72fcb1cd25147157fdc2f8ad76de9a3fb6a::external_address::to_bytes(0x5306f64e312b581766351c07af79c72fcb1cd25147157fdc2f8ad76de9a3fb6a::vaa::emitter_address(&v1)), 8);
        assert!(!0x2::table::contains<vector<u8>, bool>(&arg0.processed_vaas, v3), 7);
        let v8 = 0xd3a2960aaf137bf5c47680304ff07c0ea159b62a37fd315dac57bdcd14af1cb2::payload::decode_seal_payload(&v7);
        let v9 = *0xd3a2960aaf137bf5c47680304ff07c0ea159b62a37fd315dac57bdcd14af1cb2::payload::get_deposit_address(&v8);
        assert!(!0x2::table::contains<vector<u8>, bool>(&arg0.used_dwallets, v9), 11);
        assert!(0xd3a2960aaf137bf5c47680304ff07c0ea159b62a37fd315dac57bdcd14af1cb2::dwallet_registry::is_registered(arg2, &v9), 2);
        let v10 = 0x2::object::id_to_bytes(&arg4);
        assert!(0xd3a2960aaf137bf5c47680304ff07c0ea159b62a37fd315dac57bdcd14af1cb2::dwallet_registry::get_dwallet_id(arg2, &v9) == v10, 3);
        let v11 = 0xd3a2960aaf137bf5c47680304ff07c0ea159b62a37fd315dac57bdcd14af1cb2::payload::construct_signing_message(0xd3a2960aaf137bf5c47680304ff07c0ea159b62a37fd315dac57bdcd14af1cb2::payload::get_token_uri(&v8), 0xd3a2960aaf137bf5c47680304ff07c0ea159b62a37fd315dac57bdcd14af1cb2::payload::get_token_id(&v8), 0xd3a2960aaf137bf5c47680304ff07c0ea159b62a37fd315dac57bdcd14af1cb2::payload::get_receiver(&v8));
        let v12 = PendingSeal{
            source_chain     : 0xd3a2960aaf137bf5c47680304ff07c0ea159b62a37fd315dac57bdcd14af1cb2::payload::get_source_chain(&v8),
            nft_contract     : *0xd3a2960aaf137bf5c47680304ff07c0ea159b62a37fd315dac57bdcd14af1cb2::payload::get_nft_contract(&v8),
            token_id         : *0xd3a2960aaf137bf5c47680304ff07c0ea159b62a37fd315dac57bdcd14af1cb2::payload::get_token_id(&v8),
            token_uri        : *0xd3a2960aaf137bf5c47680304ff07c0ea159b62a37fd315dac57bdcd14af1cb2::payload::get_token_uri(&v8),
            receiver         : *0xd3a2960aaf137bf5c47680304ff07c0ea159b62a37fd315dac57bdcd14af1cb2::payload::get_receiver(&v8),
            deposit_address  : v9,
            dwallet_pubkey   : 0xd3a2960aaf137bf5c47680304ff07c0ea159b62a37fd315dac57bdcd14af1cb2::dwallet_registry::get_dwallet_pubkey(arg2, &v9),
            message_hash     : v11,
            dwallet_id_bytes : v10,
            timestamp        : v0,
            completed        : false,
        };
        0x2::table::add<vector<u8>, PendingSeal>(&mut arg0.pending_seals, v3, v12);
        0x2::table::add<vector<u8>, bool>(&mut arg0.processed_vaas, v3, true);
        let v13 = SealPending{
            vaa_hash        : v3,
            source_chain    : 0xd3a2960aaf137bf5c47680304ff07c0ea159b62a37fd315dac57bdcd14af1cb2::payload::get_source_chain(&v8),
            deposit_address : v9,
            receiver        : *0xd3a2960aaf137bf5c47680304ff07c0ea159b62a37fd315dac57bdcd14af1cb2::payload::get_receiver(&v8),
            message_hash    : v11,
            timestamp       : v0,
        };
        0x2::event::emit<SealPending>(v13);
    }

    public fun register_emitter(arg0: &mut OrchestratorState, arg1: &OrchestratorAdminCap, arg2: u16, arg3: vector<u8>) {
        assert!(0x1::vector::length<u8>(&arg3) == 32, 8);
        if (0x2::table::contains<u16, vector<u8>>(&arg0.known_emitters, arg2)) {
            *0x2::table::borrow_mut<u16, vector<u8>>(&mut arg0.known_emitters, arg2) = arg3;
        } else {
            0x2::table::add<u16, vector<u8>>(&mut arg0.known_emitters, arg2, arg3);
        };
        let v0 = EmitterRegistered{
            chain_id        : arg2,
            emitter_address : arg3,
        };
        0x2::event::emit<EmitterRegistered>(v0);
    }

    public fun remove_emitter(arg0: &mut OrchestratorState, arg1: &OrchestratorAdminCap, arg2: u16) {
        if (0x2::table::contains<u16, vector<u8>>(&arg0.known_emitters, arg2)) {
            0x2::table::remove<u16, vector<u8>>(&mut arg0.known_emitters, arg2);
        };
    }

    public fun request_presign(arg0: &mut OrchestratorState, arg1: &mut 0xdd24c62739923fbf582f49ef190b4a007f981ca6eb209ca94f3a8eaf7c611317::coordinator::DWalletCoordinator, arg2: &OrchestratorAdminCap, arg3: 0x2::object::ID, arg4: u64, arg5: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0xd3a2960aaf137bf5c47680304ff07c0ea159b62a37fd315dac57bdcd14af1cb2::treasury::withdraw_coins(&mut arg0.treasury, arg5);
        let v2 = v1;
        let v3 = v0;
        0xd3a2960aaf137bf5c47680304ff07c0ea159b62a37fd315dac57bdcd14af1cb2::signing::request_presign(arg1, arg3, arg4, &mut v3, &mut v2, arg5);
        0xd3a2960aaf137bf5c47680304ff07c0ea159b62a37fd315dac57bdcd14af1cb2::treasury::return_coins(&mut arg0.treasury, v3, v2);
    }

    public fun request_sign_seal(arg0: &mut OrchestratorState, arg1: &mut 0xd3a2960aaf137bf5c47680304ff07c0ea159b62a37fd315dac57bdcd14af1cb2::signing::SigningState, arg2: &mut 0xdd24c62739923fbf582f49ef190b4a007f981ca6eb209ca94f3a8eaf7c611317::coordinator::DWalletCoordinator, arg3: vector<u8>, arg4: vector<u8>, arg5: 0xdd24c62739923fbf582f49ef190b4a007f981ca6eb209ca94f3a8eaf7c611317::coordinator_inner::UnverifiedPresignCap, arg6: u64, arg7: &mut 0x2::tx_context::TxContext) {
        assert!(0x2::table::contains<vector<u8>, PendingSeal>(&arg0.pending_seals, arg3), 9);
        let v0 = 0x2::table::borrow<vector<u8>, PendingSeal>(&arg0.pending_seals, arg3);
        assert!(!v0.completed, 10);
        let v1 = v0.message_hash;
        let (v2, v3) = 0xd3a2960aaf137bf5c47680304ff07c0ea159b62a37fd315dac57bdcd14af1cb2::treasury::withdraw_coins(&mut arg0.treasury, arg7);
        let v4 = v3;
        let v5 = v2;
        0xd3a2960aaf137bf5c47680304ff07c0ea159b62a37fd315dac57bdcd14af1cb2::signing::request_sign(arg1, arg2, v1, arg4, arg5, arg3, arg6, &mut v5, &mut v4, arg7);
        0xd3a2960aaf137bf5c47680304ff07c0ea159b62a37fd315dac57bdcd14af1cb2::treasury::return_coins(&mut arg0.treasury, v5, v4);
    }

    public fun reset_minting_cap(arg0: &mut 0xd3a2960aaf137bf5c47680304ff07c0ea159b62a37fd315dac57bdcd14af1cb2::signing::SigningState, arg1: &OrchestratorAdminCap, arg2: &mut 0x2::tx_context::TxContext) {
        0xd3a2960aaf137bf5c47680304ff07c0ea159b62a37fd315dac57bdcd14af1cb2::signing::reset_minting_cap(arg0, arg2);
    }

    public fun set_minting_pubkey(arg0: &mut MintingAuthority, arg1: &OrchestratorAdminCap, arg2: vector<u8>) {
        assert!(0x1::vector::length<u8>(&arg2) == 32, 4);
        arg0.minting_pubkey = arg2;
    }

    public fun total_processed(arg0: &OrchestratorState) : u64 {
        arg0.total_processed
    }

    public fun treasury_ika_balance(arg0: &OrchestratorState) : u64 {
        0xd3a2960aaf137bf5c47680304ff07c0ea159b62a37fd315dac57bdcd14af1cb2::treasury::ika_balance(&arg0.treasury)
    }

    public fun treasury_sui_balance(arg0: &OrchestratorState) : u64 {
        0xd3a2960aaf137bf5c47680304ff07c0ea159b62a37fd315dac57bdcd14af1cb2::treasury::sui_balance(&arg0.treasury)
    }

    public fun update_signing_params(arg0: &mut 0xd3a2960aaf137bf5c47680304ff07c0ea159b62a37fd315dac57bdcd14af1cb2::signing::SigningState, arg1: &OrchestratorAdminCap, arg2: u32, arg3: u32, arg4: u32) {
        0xd3a2960aaf137bf5c47680304ff07c0ea159b62a37fd315dac57bdcd14af1cb2::signing::update_params(arg0, arg2, arg3, arg4);
    }

    public fun verify_signature(arg0: &vector<u8>, arg1: &vector<u8>, arg2: &vector<u8>) : bool {
        if (0x1::vector::length<u8>(arg2) != 64) {
            return false
        };
        0x2::ed25519::ed25519_verify(arg2, arg0, arg1)
    }

    // decompiled from Move bytecode v6
}

