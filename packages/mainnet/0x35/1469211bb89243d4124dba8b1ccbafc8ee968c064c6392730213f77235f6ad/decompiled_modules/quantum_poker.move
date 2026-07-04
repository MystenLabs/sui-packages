module 0x351469211bb89243d4124dba8b1ccbafc8ee968c064c6392730213f77235f6ad::quantum_poker {
    struct PokerSession has store, key {
        id: 0x2::object::UID,
        tunnel_id: 0x2::object::ID,
        rules_hash: vector<u8>,
        protocol_version: u64,
        circuit_id: vector<u8>,
        input_schema_hash: vector<u8>,
        five_of_a_kind_enabled: bool,
        created_by: address,
        params_agreed: bool,
    }

    struct PokerSessionCreated has copy, drop {
        session_id: 0x2::object::ID,
        tunnel_id: 0x2::object::ID,
        circuit_id: vector<u8>,
        input_schema_hash: vector<u8>,
        created_by: address,
    }

    public fun circuit_params_agreed(arg0: &PokerSession) : bool {
        arg0.params_agreed
    }

    public fun confirm_session_params<T0>(arg0: &mut PokerSession, arg1: &0x351469211bb89243d4124dba8b1ccbafc8ee968c064c6392730213f77235f6ad::tunnel::Tunnel<T0>, arg2: vector<u8>, arg3: vector<u8>, arg4: vector<u8>, arg5: &0x2::tx_context::TxContext) {
        assert!(arg0.tunnel_id == 0x351469211bb89243d4124dba8b1ccbafc8ee968c064c6392730213f77235f6ad::tunnel::id<T0>(arg1), 13906834758459326471);
        let v0 = 0x2::tx_context::sender(arg5);
        assert!(v0 == 0x351469211bb89243d4124dba8b1ccbafc8ee968c064c6392730213f77235f6ad::tunnel::party_address(0x351469211bb89243d4124dba8b1ccbafc8ee968c064c6392730213f77235f6ad::tunnel::party_a<T0>(arg1)) || v0 == 0x351469211bb89243d4124dba8b1ccbafc8ee968c064c6392730213f77235f6ad::tunnel::party_address(0x351469211bb89243d4124dba8b1ccbafc8ee968c064c6392730213f77235f6ad::tunnel::party_b<T0>(arg1)), 13906834779934031877);
        assert!(v0 != arg0.created_by, 13906834784229261321);
        assert!(arg2 == arg0.rules_hash, 13906834792819326987);
        assert!(arg3 == arg0.circuit_id, 13906834797114294283);
        assert!(arg4 == arg0.input_schema_hash, 13906834801409261579);
        arg0.params_agreed = true;
    }

    public fun create_session<T0>(arg0: &0x351469211bb89243d4124dba8b1ccbafc8ee968c064c6392730213f77235f6ad::tunnel::Tunnel<T0>, arg1: vector<u8>, arg2: vector<u8>, arg3: vector<u8>, arg4: &mut 0x2::tx_context::TxContext) : PokerSession {
        assert!(0x1::vector::length<u8>(&arg1) == 32, 13906834492170960897);
        assert!(0x1::vector::length<u8>(&arg3) == 32, 13906834496465928193);
        assert!(0x1::vector::length<u8>(&arg2) == 32, 13906834500761026563);
        let v0 = 0x2::tx_context::sender(arg4);
        assert!(v0 == 0x351469211bb89243d4124dba8b1ccbafc8ee968c064c6392730213f77235f6ad::tunnel::party_address(0x351469211bb89243d4124dba8b1ccbafc8ee968c064c6392730213f77235f6ad::tunnel::party_a<T0>(arg0)) || v0 == 0x351469211bb89243d4124dba8b1ccbafc8ee968c064c6392730213f77235f6ad::tunnel::party_address(0x351469211bb89243d4124dba8b1ccbafc8ee968c064c6392730213f77235f6ad::tunnel::party_b<T0>(arg0)), 13906834522235994117);
        let v1 = PokerSession{
            id                     : 0x2::object::new(arg4),
            tunnel_id              : 0x351469211bb89243d4124dba8b1ccbafc8ee968c064c6392730213f77235f6ad::tunnel::id<T0>(arg0),
            rules_hash             : arg1,
            protocol_version       : 1,
            circuit_id             : arg2,
            input_schema_hash      : arg3,
            five_of_a_kind_enabled : true,
            created_by             : v0,
            params_agreed          : false,
        };
        let v2 = PokerSessionCreated{
            session_id        : 0x2::object::id<PokerSession>(&v1),
            tunnel_id         : v1.tunnel_id,
            circuit_id        : v1.circuit_id,
            input_schema_hash : v1.input_schema_hash,
            created_by        : v0,
        };
        0x2::event::emit<PokerSessionCreated>(v2);
        v1
    }

    entry fun entry_create_session<T0>(arg0: &0x351469211bb89243d4124dba8b1ccbafc8ee968c064c6392730213f77235f6ad::tunnel::Tunnel<T0>, arg1: vector<u8>, arg2: vector<u8>, arg3: vector<u8>, arg4: &mut 0x2::tx_context::TxContext) {
        0x2::transfer::share_object<PokerSession>(create_session<T0>(arg0, arg1, arg2, arg3, arg4));
    }

    public fun protocol_version() : u64 {
        1
    }

    public fun session_circuit_id(arg0: &PokerSession) : &vector<u8> {
        &arg0.circuit_id
    }

    public fun session_created_by(arg0: &PokerSession) : address {
        arg0.created_by
    }

    public fun session_five_of_a_kind_enabled(arg0: &PokerSession) : bool {
        arg0.five_of_a_kind_enabled
    }

    public fun session_input_schema_hash(arg0: &PokerSession) : &vector<u8> {
        &arg0.input_schema_hash
    }

    public fun session_protocol_version(arg0: &PokerSession) : u64 {
        arg0.protocol_version
    }

    public fun session_rules_hash(arg0: &PokerSession) : &vector<u8> {
        &arg0.rules_hash
    }

    public fun session_tunnel_id(arg0: &PokerSession) : 0x2::object::ID {
        arg0.tunnel_id
    }

    public fun winner_a() : u64 {
        0
    }

    public fun winner_b() : u64 {
        1
    }

    public fun winner_tie() : u64 {
        2
    }

    // decompiled from Move bytecode v7
}

