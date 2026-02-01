module 0x2ad5fa7c2c9184b7406955fbbb9e279076a69b2c9b25d92e6c1528a9d2b1af92::claim {
    struct ClaimGenerated has copy, drop {
        claim_id: 0x2::object::ID,
        agent_id: 0x2::object::ID,
        verification_code: 0x1::string::String,
        created_at: u64,
    }

    struct ClaimVerified has copy, drop {
        claim_id: 0x2::object::ID,
        agent_id: 0x2::object::ID,
        claim_type: u8,
        claimed_by: 0x1::string::String,
        verified_at: u64,
    }

    struct ClaimRevoked has copy, drop {
        claim_id: 0x2::object::ID,
        agent_id: 0x2::object::ID,
        revoked_at: u64,
    }

    struct VerifierAdded has copy, drop {
        registry_id: 0x2::object::ID,
        verifier: address,
        added_at: u64,
    }

    struct VerifierRemoved has copy, drop {
        registry_id: 0x2::object::ID,
        verifier: address,
        removed_at: u64,
    }

    struct VerifierRegistry has key {
        id: 0x2::object::UID,
        admin: address,
        pending_admin: 0x1::option::Option<address>,
        verifiers: 0x2::table::Table<address, bool>,
        verifier_count: u64,
        created_at: u64,
    }

    struct Claim has store, key {
        id: 0x2::object::UID,
        agent_id: 0x2::object::ID,
        verification_code: 0x1::string::String,
        claimed_by: 0x1::option::Option<0x1::string::String>,
        claim_type: u8,
        created_at: u64,
        verified_at: 0x1::option::Option<u64>,
        signature: 0x1::option::Option<vector<u8>>,
        status: u8,
    }

    public fun id(arg0: &Claim) : 0x2::object::ID {
        0x2::object::id<Claim>(arg0)
    }

    public fun accept_registry_admin_transfer(arg0: &mut VerifierRegistry, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg1);
        assert!(0x1::option::contains<address>(&arg0.pending_admin, &v0), 1);
        arg0.admin = v0;
        arg0.pending_admin = 0x1::option::none<address>();
    }

    public fun add_verifier(arg0: &mut VerifierRegistry, arg1: address, arg2: &mut 0x2::tx_context::TxContext) {
        assert!(arg0.admin == 0x2::tx_context::sender(arg2), 1);
        if (!0x2::table::contains<address, bool>(&arg0.verifiers, arg1)) {
            0x2::table::add<address, bool>(&mut arg0.verifiers, arg1, true);
            arg0.verifier_count = arg0.verifier_count + 1;
            let v0 = VerifierAdded{
                registry_id : 0x2::object::id<VerifierRegistry>(arg0),
                verifier    : arg1,
                added_at    : 0x2::tx_context::epoch_timestamp_ms(arg2),
            };
            0x2::event::emit<VerifierAdded>(v0);
        };
    }

    public fun agent_id(arg0: &Claim) : 0x2::object::ID {
        arg0.agent_id
    }

    public fun claim_type(arg0: &Claim) : u8 {
        arg0.claim_type
    }

    public fun claimed_by(arg0: &Claim) : 0x1::option::Option<0x1::string::String> {
        arg0.claimed_by
    }

    public(friend) fun create_registry(arg0: address, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = VerifierRegistry{
            id             : 0x2::object::new(arg1),
            admin          : arg0,
            pending_admin  : 0x1::option::none<address>(),
            verifiers      : 0x2::table::new<address, bool>(arg1),
            verifier_count : 0,
            created_at     : 0x2::tx_context::epoch_timestamp_ms(arg1),
        };
        0x2::transfer::share_object<VerifierRegistry>(v0);
    }

    public fun created_at(arg0: &Claim) : u64 {
        arg0.created_at
    }

    public fun generate(arg0: &0x2ad5fa7c2c9184b7406955fbbb9e279076a69b2c9b25d92e6c1528a9d2b1af92::agent::Agent, arg1: 0x1::string::String, arg2: &mut 0x2::tx_context::TxContext) : Claim {
        assert!(0x2ad5fa7c2c9184b7406955fbbb9e279076a69b2c9b25d92e6c1528a9d2b1af92::agent::owner(arg0) == 0x2::tx_context::sender(arg2), 0);
        let v0 = 0x2::tx_context::epoch_timestamp_ms(arg2);
        let v1 = Claim{
            id                : 0x2::object::new(arg2),
            agent_id          : 0x2::object::id<0x2ad5fa7c2c9184b7406955fbbb9e279076a69b2c9b25d92e6c1528a9d2b1af92::agent::Agent>(arg0),
            verification_code : arg1,
            claimed_by        : 0x1::option::none<0x1::string::String>(),
            claim_type        : 0,
            created_at        : v0,
            verified_at       : 0x1::option::none<u64>(),
            signature         : 0x1::option::none<vector<u8>>(),
            status            : 0,
        };
        let v2 = ClaimGenerated{
            claim_id          : 0x2::object::id<Claim>(&v1),
            agent_id          : v1.agent_id,
            verification_code : v1.verification_code,
            created_at        : v0,
        };
        0x2::event::emit<ClaimGenerated>(v2);
        v1
    }

    public fun generate_and_share(arg0: &0x2ad5fa7c2c9184b7406955fbbb9e279076a69b2c9b25d92e6c1528a9d2b1af92::agent::Agent, arg1: 0x1::string::String, arg2: &mut 0x2::tx_context::TxContext) {
        0x2::transfer::share_object<Claim>(generate(arg0, arg1, arg2));
    }

    public fun generate_and_transfer(arg0: &0x2ad5fa7c2c9184b7406955fbbb9e279076a69b2c9b25d92e6c1528a9d2b1af92::agent::Agent, arg1: 0x1::string::String, arg2: &mut 0x2::tx_context::TxContext) {
        let v0 = generate(arg0, arg1, arg2);
        0x2::transfer::transfer<Claim>(v0, 0x2::tx_context::sender(arg2));
    }

    public fun is_pending(arg0: &Claim) : bool {
        arg0.status == 0
    }

    public fun is_revoked(arg0: &Claim) : bool {
        arg0.status == 2
    }

    public fun is_verified(arg0: &Claim) : bool {
        arg0.status == 1
    }

    public fun is_verifier(arg0: &VerifierRegistry, arg1: address) : bool {
        0x2::table::contains<address, bool>(&arg0.verifiers, arg1)
    }

    public fun propose_registry_admin_transfer(arg0: &mut VerifierRegistry, arg1: address, arg2: &mut 0x2::tx_context::TxContext) {
        assert!(arg0.admin == 0x2::tx_context::sender(arg2), 1);
        arg0.pending_admin = 0x1::option::some<address>(arg1);
    }

    public fun registry_admin(arg0: &VerifierRegistry) : address {
        arg0.admin
    }

    public fun remove_verifier(arg0: &mut VerifierRegistry, arg1: address, arg2: &mut 0x2::tx_context::TxContext) {
        assert!(arg0.admin == 0x2::tx_context::sender(arg2), 1);
        if (0x2::table::contains<address, bool>(&arg0.verifiers, arg1)) {
            0x2::table::remove<address, bool>(&mut arg0.verifiers, arg1);
            arg0.verifier_count = arg0.verifier_count - 1;
            let v0 = VerifierRemoved{
                registry_id : 0x2::object::id<VerifierRegistry>(arg0),
                verifier    : arg1,
                removed_at  : 0x2::tx_context::epoch_timestamp_ms(arg2),
            };
            0x2::event::emit<VerifierRemoved>(v0);
        };
    }

    public fun revoke(arg0: &mut Claim, arg1: &0x2ad5fa7c2c9184b7406955fbbb9e279076a69b2c9b25d92e6c1528a9d2b1af92::agent::Agent, arg2: &mut 0x2::tx_context::TxContext) {
        assert!(0x2ad5fa7c2c9184b7406955fbbb9e279076a69b2c9b25d92e6c1528a9d2b1af92::agent::owner(arg1) == 0x2::tx_context::sender(arg2), 0);
        assert!(0x2::object::id<0x2ad5fa7c2c9184b7406955fbbb9e279076a69b2c9b25d92e6c1528a9d2b1af92::agent::Agent>(arg1) == arg0.agent_id, 1);
        arg0.status = 2;
        let v0 = ClaimRevoked{
            claim_id   : 0x2::object::id<Claim>(arg0),
            agent_id   : arg0.agent_id,
            revoked_at : 0x2::tx_context::epoch_timestamp_ms(arg2),
        };
        0x2::event::emit<ClaimRevoked>(v0);
    }

    public fun status(arg0: &Claim) : u8 {
        arg0.status
    }

    public fun verification_code(arg0: &Claim) : 0x1::string::String {
        arg0.verification_code
    }

    public fun verified_at(arg0: &Claim) : 0x1::option::Option<u64> {
        arg0.verified_at
    }

    public fun verifier_count(arg0: &VerifierRegistry) : u64 {
        arg0.verifier_count
    }

    public fun verify_external(arg0: &mut Claim, arg1: &VerifierRegistry, arg2: u8, arg3: 0x1::string::String, arg4: &mut 0x2::tx_context::TxContext) {
        assert!(0x2::table::contains<address, bool>(&arg1.verifiers, 0x2::tx_context::sender(arg4)), 31);
        assert!(arg0.status == 0, 14);
        assert!(arg2 >= 1 && arg2 <= 3, 21);
        let v0 = 0x2::tx_context::epoch_timestamp_ms(arg4);
        arg0.claim_type = arg2;
        arg0.claimed_by = 0x1::option::some<0x1::string::String>(arg3);
        arg0.verified_at = 0x1::option::some<u64>(v0);
        arg0.status = 1;
        let v1 = ClaimVerified{
            claim_id    : 0x2::object::id<Claim>(arg0),
            agent_id    : arg0.agent_id,
            claim_type  : arg2,
            claimed_by  : *0x1::option::borrow<0x1::string::String>(&arg0.claimed_by),
            verified_at : v0,
        };
        0x2::event::emit<ClaimVerified>(v1);
    }

    public fun verify_with_signature(arg0: &mut Claim, arg1: 0x1::string::String, arg2: vector<u8>, arg3: vector<u8>, arg4: &mut 0x2::tx_context::TxContext) {
        assert!(arg0.status == 0, 14);
        let v0 = b"TASKNET_CLAIM_V1";
        let v1 = 0x2::object::id<Claim>(arg0);
        0x1::vector::append<u8>(&mut v0, 0x2::object::id_to_bytes(&v1));
        0x1::vector::append<u8>(&mut v0, *0x1::string::as_bytes(&arg0.verification_code));
        let v2 = 0x2::hash::blake2b256(&v0);
        assert!(0x2::ed25519::ed25519_verify(&arg2, &arg3, &v2), 15);
        let v3 = 0x2::tx_context::epoch_timestamp_ms(arg4);
        arg0.claim_type = 4;
        arg0.claimed_by = 0x1::option::some<0x1::string::String>(arg1);
        arg0.signature = 0x1::option::some<vector<u8>>(arg2);
        arg0.verified_at = 0x1::option::some<u64>(v3);
        arg0.status = 1;
        let v4 = ClaimVerified{
            claim_id    : 0x2::object::id<Claim>(arg0),
            agent_id    : arg0.agent_id,
            claim_type  : 4,
            claimed_by  : *0x1::option::borrow<0x1::string::String>(&arg0.claimed_by),
            verified_at : v3,
        };
        0x2::event::emit<ClaimVerified>(v4);
    }

    // decompiled from Move bytecode v6
}

