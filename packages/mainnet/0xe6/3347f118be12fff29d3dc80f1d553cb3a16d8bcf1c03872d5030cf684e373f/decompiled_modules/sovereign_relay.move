module 0xe63347f118be12fff29d3dc80f1d553cb3a16d8bcf1c03872d5030cf684e373f::sovereign_relay {
    struct SovereignRelayState has store, key {
        id: 0x2::object::UID,
        owner: address,
        clock_phase: u64,
        entropy_state: u64,
        local_payload: vector<u8>,
        received_packet: vector<u8>,
        decoded_payload: vector<u8>,
        genesis_anchored: bool,
        total_packets_processed: u64,
        total_decompression_tax: u64,
        bridge_enabled: bool,
        stable_refinery_enabled: bool,
        total_refinery_fees: u64,
        shared_secret_hash: vector<u8>,
    }

    struct PacketRecord has store, key {
        id: 0x2::object::UID,
        sender: address,
        timestamp_ms: u64,
        clock_phase: u64,
        packet: vector<u8>,
        verified: bool,
    }

    struct AdminCap has store, key {
        id: 0x2::object::UID,
    }

    struct PayloadEncrypted has copy, drop {
        payload_size: u64,
        clock_phase: u64,
    }

    struct PacketDecrypted has copy, drop {
        total_processed: u64,
        clock_phase: u64,
    }

    struct GenesisAnchored has copy, drop {
        timestamp_ms: u64,
    }

    struct PacketRegistered has copy, drop {
        sender: address,
        total_packets: u64,
    }

    fun advance_clock(arg0: &mut SovereignRelayState, arg1: &0x2::clock::Clock) {
        arg0.clock_phase = (arg0.clock_phase + 1) % 65535;
        arg0.entropy_state = arg0.entropy_state ^ 0x2::clock::timestamp_ms(arg1);
    }

    public entry fun anchor_genesis(arg0: &AdminCap, arg1: &mut SovereignRelayState, arg2: vector<u8>, arg3: &0x2::clock::Clock) {
        assert!(!arg1.genesis_anchored, 2);
        let v0 = 0x2::hash::keccak256(&arg2);
        assert!(*0x1::vector::borrow<u8>(&v0, 0) < 16, 4);
        arg1.genesis_anchored = true;
        arg1.bridge_enabled = true;
        let v1 = GenesisAnchored{timestamp_ms: 0x2::clock::timestamp_ms(arg3)};
        0x2::event::emit<GenesisAnchored>(v1);
    }

    fun bcs_u64(arg0: u64) : vector<u8> {
        let v0 = 0x1::vector::empty<u8>();
        let v1 = 0;
        while (v1 < 8) {
            0x1::vector::push_back<u8>(&mut v0, ((arg0 & 255) as u8));
            arg0 = arg0 >> 8;
            v1 = v1 + 1;
        };
        v0
    }

    public fun calculate_decompression_tax(arg0: u64) : u64 {
        arg0 * 1 / 10000
    }

    public fun calculate_refinery_fee(arg0: u64) : (u64, u64) {
        (arg0 * 741 / 10000, arg0 * 963 / 10000)
    }

    public entry fun decrypt_packet(arg0: &mut SovereignRelayState, arg1: vector<u8>, arg2: &0x2::clock::Clock) {
        assert!(0x1::vector::length<u8>(&arg1) == 21, 1);
        arg0.received_packet = arg1;
        arg0.decoded_payload = xor_fold_168(arg0, &arg1);
        arg0.total_packets_processed = arg0.total_packets_processed + 1;
        advance_clock(arg0, arg2);
        let v0 = PacketDecrypted{
            total_processed : arg0.total_packets_processed,
            clock_phase     : arg0.clock_phase,
        };
        0x2::event::emit<PacketDecrypted>(v0);
    }

    fun derive_clock_key(arg0: &SovereignRelayState) : vector<u8> {
        let v0 = bcs_u64(arg0.clock_phase * 16180339887 ^ 90112);
        let v1 = 0x2::hash::keccak256(&v0);
        let v2 = 0x1::vector::empty<u8>();
        let v3 = 0;
        while (v3 < 21) {
            0x1::vector::push_back<u8>(&mut v2, *0x1::vector::borrow<u8>(&v1, v3));
            v3 = v3 + 1;
        };
        v2
    }

    public entry fun emergency_reset(arg0: &AdminCap, arg1: &mut SovereignRelayState) {
        arg1.local_payload = empty_packet();
        arg1.received_packet = empty_packet();
        arg1.decoded_payload = empty_packet();
        arg1.clock_phase = 0;
    }

    fun empty_packet() : vector<u8> {
        let v0 = 0x1::vector::empty<u8>();
        let v1 = 0;
        while (v1 < 21) {
            0x1::vector::push_back<u8>(&mut v0, 0);
            v1 = v1 + 1;
        };
        v0
    }

    public entry fun enable_refinery(arg0: &AdminCap, arg1: &mut SovereignRelayState) {
        arg1.stable_refinery_enabled = true;
    }

    public entry fun encrypt_payload(arg0: &AdminCap, arg1: &mut SovereignRelayState, arg2: vector<u8>, arg3: &0x2::clock::Clock) {
        assert!(0x1::vector::length<u8>(&arg2) == 21, 1);
        arg1.local_payload = arg2;
        advance_clock(arg1, arg3);
        let v0 = PayloadEncrypted{
            payload_size : 21,
            clock_phase  : arg1.clock_phase,
        };
        0x2::event::emit<PayloadEncrypted>(v0);
    }

    public fun extract_vector_origin(arg0: &vector<u8>) : u32 {
        assert!(0x1::vector::length<u8>(arg0) == 21, 1);
        (*0x1::vector::borrow<u8>(arg0, 0) as u32) << 16 | (*0x1::vector::borrow<u8>(arg0, 1) as u32) << 8 | (*0x1::vector::borrow<u8>(arg0, 2) as u32)
    }

    public fun extract_zeeman_factor(arg0: &vector<u8>) : u16 {
        assert!(0x1::vector::length<u8>(arg0) == 21, 1);
        (*0x1::vector::borrow<u8>(arg0, 3) as u16) << 8 | (*0x1::vector::borrow<u8>(arg0, 4) as u16)
    }

    public fun get_clock_phase(arg0: &SovereignRelayState) : u64 {
        arg0.clock_phase
    }

    public fun get_total_packets(arg0: &SovereignRelayState) : u64 {
        arg0.total_packets_processed
    }

    public fun get_version() : (u64, u64) {
        (168, 168)
    }

    fun init(arg0: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg0);
        let v1 = bcs_u64(90112);
        let v2 = SovereignRelayState{
            id                      : 0x2::object::new(arg0),
            owner                   : v0,
            clock_phase             : 0,
            entropy_state           : 0,
            local_payload           : empty_packet(),
            received_packet         : empty_packet(),
            decoded_payload         : empty_packet(),
            genesis_anchored        : false,
            total_packets_processed : 0,
            total_decompression_tax : 0,
            bridge_enabled          : false,
            stable_refinery_enabled : false,
            total_refinery_fees     : 0,
            shared_secret_hash      : 0x2::hash::keccak256(&v1),
        };
        let v3 = AdminCap{id: 0x2::object::new(arg0)};
        0x2::transfer::share_object<SovereignRelayState>(v2);
        0x2::transfer::transfer<AdminCap>(v3, v0);
    }

    public fun is_genesis_anchored(arg0: &SovereignRelayState) : bool {
        arg0.genesis_anchored
    }

    public entry fun register_packet(arg0: &mut SovereignRelayState, arg1: vector<u8>, arg2: &0x2::clock::Clock, arg3: &mut 0x2::tx_context::TxContext) {
        assert!(arg0.bridge_enabled, 3);
        assert!(0x1::vector::length<u8>(&arg1) == 21, 1);
        let v0 = 0x2::tx_context::sender(arg3);
        let v1 = PacketRecord{
            id           : 0x2::object::new(arg3),
            sender       : v0,
            timestamp_ms : 0x2::clock::timestamp_ms(arg2),
            clock_phase  : arg0.clock_phase,
            packet       : arg1,
            verified     : false,
        };
        arg0.total_packets_processed = arg0.total_packets_processed + 1;
        let v2 = PacketRegistered{
            sender        : v0,
            total_packets : arg0.total_packets_processed,
        };
        0x2::event::emit<PacketRegistered>(v2);
        0x2::transfer::transfer<PacketRecord>(v1, v0);
    }

    public fun verify_shared_secret(arg0: &SovereignRelayState, arg1: u64) : bool {
        let v0 = bcs_u64(arg1);
        0x2::hash::keccak256(&v0) == arg0.shared_secret_hash
    }

    public fun xor_fold_168(arg0: &SovereignRelayState, arg1: &vector<u8>) : vector<u8> {
        assert!(0x1::vector::length<u8>(arg1) == 21, 1);
        let v0 = derive_clock_key(arg0);
        let v1 = 0x1::vector::empty<u8>();
        let v2 = 0;
        while (v2 < 21) {
            0x1::vector::push_back<u8>(&mut v1, *0x1::vector::borrow<u8>(arg1, v2) ^ *0x1::vector::borrow<u8>(&v0, v2 % 0x1::vector::length<u8>(&v0)));
            v2 = v2 + 1;
        };
        v1
    }

    // decompiled from Move bytecode v6
}

