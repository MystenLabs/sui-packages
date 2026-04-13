module 0x7bdcfc15b008f89b67804c86f3368c4de5acba972eaf5acbabadc9d5aaa2bc0::triple_ledger {
    struct TripleLedgerEntry has store, key {
        id: 0x2::object::UID,
        transaction_id: 0x2::object::ID,
        timestamp: u64,
        block_number: u64,
        cryptographic_state: CryptographicState,
        phase_logic_state: PhaseLogicState,
        systemic_impact: SystemicImpact,
        triple_hash: vector<u8>,
        is_verified: bool,
    }

    struct CryptographicState has copy, drop, store {
        asset_type: 0x1::string::String,
        from_address: address,
        to_address: address,
        amount: u64,
        asset_id: 0x2::object::ID,
        transfer_signature: vector<u8>,
    }

    struct PhaseLogicState has copy, drop, store {
        void_island_id: 0x2::object::ID,
        ipfs_node_id: 0x1::string::String,
        mesh_chain_id: 0x1::string::String,
        ubh168_state_hash: vector<u8>,
        phase_epoch: u64,
        xor_key_position: u64,
        frequency_band: u64,
    }

    struct SystemicImpact has copy, drop, store {
        material_cost: u64,
        financial_cost: u64,
        intellectual_cost: u64,
        compute_cost: u64,
        social_cost: u64,
        experiential_cost: u64,
        natural_cost: u64,
        cultural_cost: u64,
        spiritual_cost: u64,
        total_thermodynamic_cost: u64,
        network_health_delta: u64,
        medici_fee_paid: u64,
    }

    struct TripleLedgerRegistry has key {
        id: 0x2::object::UID,
        entries: 0x2::table::Table<0x2::object::ID, TripleLedgerEntry>,
        total_entries: u64,
        current_block_number: u64,
        last_entry_timestamp: u64,
        ledger_root_hash: vector<u8>,
        ai_governor: address,
        is_paused: bool,
    }

    struct LedgerEntryCreated has copy, drop {
        entry_id: 0x2::object::ID,
        transaction_id: 0x2::object::ID,
        triple_hash: vector<u8>,
        block_number: u64,
        timestamp: u64,
    }

    struct LedgerRootUpdated has copy, drop {
        old_root: vector<u8>,
        new_root: vector<u8>,
        total_entries: u64,
    }

    fun calculate_triple_hash(arg0: &CryptographicState, arg1: &PhaseLogicState, arg2: &SystemicImpact) : vector<u8> {
        let v0 = 0x1::vector::empty<u8>();
        0x1::vector::append<u8>(&mut v0, serialize_crypto_state(arg0));
        0x1::vector::append<u8>(&mut v0, serialize_phase_state(arg1));
        0x1::vector::append<u8>(&mut v0, serialize_systemic_impact(arg2));
        let v1 = 0x2::hash::blake2b256(&v0);
        let v2 = 0x1::vector::empty<u8>();
        let v3 = 0;
        while (v3 < 21) {
            0x1::vector::push_back<u8>(&mut v2, *0x1::vector::borrow<u8>(&v1, v3));
            v3 = v3 + 1;
        };
        v2
    }

    public fun change_governor(arg0: &mut TripleLedgerRegistry, arg1: address, arg2: &mut 0x2::tx_context::TxContext) {
        assert!(0x2::tx_context::sender(arg2) == arg0.ai_governor, 0);
        arg0.ai_governor = arg1;
    }

    public fun create_ledger_entry(arg0: &mut TripleLedgerRegistry, arg1: 0x2::object::ID, arg2: CryptographicState, arg3: PhaseLogicState, arg4: SystemicImpact, arg5: &0x2::clock::Clock, arg6: &mut 0x2::tx_context::TxContext) {
        assert!(!arg0.is_paused, 0);
        let v0 = 0x2::clock::timestamp_ms(arg5);
        arg0.current_block_number = arg0.current_block_number + 1;
        let v1 = calculate_triple_hash(&arg2, &arg3, &arg4);
        let v2 = TripleLedgerEntry{
            id                  : 0x2::object::new(arg6),
            transaction_id      : arg1,
            timestamp           : v0,
            block_number        : arg0.current_block_number,
            cryptographic_state : arg2,
            phase_logic_state   : arg3,
            systemic_impact     : arg4,
            triple_hash         : v1,
            is_verified         : true,
        };
        let v3 = 0x2::object::uid_to_inner(&v2.id);
        0x2::table::add<0x2::object::ID, TripleLedgerEntry>(&mut arg0.entries, v3, v2);
        arg0.total_entries = arg0.total_entries + 1;
        arg0.last_entry_timestamp = v0;
        update_ledger_root(arg0);
        let v4 = LedgerEntryCreated{
            entry_id       : v3,
            transaction_id : arg1,
            triple_hash    : v1,
            block_number   : arg0.current_block_number,
            timestamp      : v0,
        };
        0x2::event::emit<LedgerEntryCreated>(v4);
    }

    public fun current_block_number(arg0: &TripleLedgerRegistry) : u64 {
        arg0.current_block_number
    }

    public fun get_ledger_entry(arg0: &TripleLedgerRegistry, arg1: 0x2::object::ID) : &TripleLedgerEntry {
        0x2::table::borrow<0x2::object::ID, TripleLedgerEntry>(&arg0.entries, arg1)
    }

    public fun increment_block_number(arg0: &mut TripleLedgerRegistry, arg1: &mut 0x2::tx_context::TxContext) {
        assert!(0x2::tx_context::sender(arg1) == arg0.ai_governor, 0);
        arg0.current_block_number = arg0.current_block_number + 1;
    }

    public fun initialize_triple_ledger(arg0: address, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = TripleLedgerRegistry{
            id                   : 0x2::object::new(arg1),
            entries              : 0x2::table::new<0x2::object::ID, TripleLedgerEntry>(arg1),
            total_entries        : 0,
            current_block_number : 0,
            last_entry_timestamp : 0x2::tx_context::epoch_timestamp_ms(arg1),
            ledger_root_hash     : 0x1::vector::empty<u8>(),
            ai_governor          : arg0,
            is_paused            : false,
        };
        0x2::transfer::share_object<TripleLedgerRegistry>(v0);
    }

    public fun ledger_root_hash(arg0: &TripleLedgerRegistry) : vector<u8> {
        arg0.ledger_root_hash
    }

    public fun pause_ledger(arg0: &mut TripleLedgerRegistry, arg1: &mut 0x2::tx_context::TxContext) {
        assert!(0x2::tx_context::sender(arg1) == arg0.ai_governor, 0);
        arg0.is_paused = true;
    }

    fun serialize_crypto_state(arg0: &CryptographicState) : vector<u8> {
        let v0 = 0x1::vector::empty<u8>();
        let v1 = 0x1::string::as_bytes(&arg0.asset_type);
        let v2 = 0;
        while (v2 < 0x1::vector::length<u8>(v1)) {
            0x1::vector::push_back<u8>(&mut v0, *0x1::vector::borrow<u8>(v1, v2));
            v2 = v2 + 1;
        };
        v0
    }

    fun serialize_phase_state(arg0: &PhaseLogicState) : vector<u8> {
        let v0 = 0x1::vector::empty<u8>();
        let v1 = 0x1::string::as_bytes(&arg0.ipfs_node_id);
        let v2 = 0;
        while (v2 < 0x1::vector::length<u8>(v1)) {
            0x1::vector::push_back<u8>(&mut v0, *0x1::vector::borrow<u8>(v1, v2));
            v2 = v2 + 1;
        };
        v0
    }

    fun serialize_systemic_impact(arg0: &SystemicImpact) : vector<u8> {
        0x1::vector::empty<u8>()
    }

    public fun total_entries(arg0: &TripleLedgerRegistry) : u64 {
        arg0.total_entries
    }

    public fun unpause_ledger(arg0: &mut TripleLedgerRegistry, arg1: &mut 0x2::tx_context::TxContext) {
        assert!(0x2::tx_context::sender(arg1) == arg0.ai_governor, 0);
        arg0.is_paused = false;
    }

    fun update_ledger_root(arg0: &mut TripleLedgerRegistry) {
        let v0 = x"016800000000000000000000000000000000000000000000";
        arg0.ledger_root_hash = v0;
        let v1 = LedgerRootUpdated{
            old_root      : arg0.ledger_root_hash,
            new_root      : v0,
            total_entries : arg0.total_entries,
        };
        0x2::event::emit<LedgerRootUpdated>(v1);
    }

    // decompiled from Move bytecode v6
}

