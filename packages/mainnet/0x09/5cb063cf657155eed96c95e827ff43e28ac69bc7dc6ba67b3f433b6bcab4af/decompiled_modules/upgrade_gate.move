module 0x970c0cd496040910cb74f0872e7f29e825d750c525aba00b46de4fb74a9d49ef::upgrade_gate {
    struct Proposal has store {
        nonce: u64,
        digest: vector<u8>,
        proposed_at_ms: u64,
        executable_after_ms: u64,
        proposer_cap: 0x2::object::ID,
    }

    struct UpgradeGate has key {
        id: 0x2::object::UID,
        cap: 0x2::package::UpgradeCap,
        pending: 0x1::option::Option<Proposal>,
        next_nonce: u64,
        registry: 0x2::object::ID,
        timelock_ms: u64,
    }

    struct UpgradeProposed has copy, drop {
        nonce: u64,
        digest: vector<u8>,
        earliest_ms: u64,
        proposed_at_ms: u64,
        proposer_cap: 0x2::object::ID,
    }

    struct UpgradeAuthorized has copy, drop {
        nonce: u64,
        digest: vector<u8>,
        timestamp_ms: u64,
    }

    struct EmergencyUpgradeAuthorized has copy, drop {
        digest: vector<u8>,
        timestamp_ms: u64,
        emergency_cap: 0x2::object::ID,
        preserved_nonce: 0x1::option::Option<u64>,
    }

    struct UpgradeCommitted has copy, drop {
        timestamp_ms: u64,
    }

    struct UpgradeCancelled has copy, drop {
        nonce: u64,
        digest: vector<u8>,
    }

    struct ProposalDeadlineExtended has copy, drop {
        nonce: u64,
        previous_ms: u64,
        executable_after_ms: u64,
    }

    struct BindWitness has drop {
        dummy_field: bool,
    }

    public fun authorize(arg0: &mut UpgradeGate, arg1: &0xc13c241cdcb32ce410dba013bc77590b51c62b6e4cf463a5f0d48fbec6d31b14::registry::Registry, arg2: &0xc13c241cdcb32ce410dba013bc77590b51c62b6e4cf463a5f0d48fbec6d31b14::authorities::GovernanceCap, arg3: vector<u8>, arg4: &0x2::clock::Clock) : 0x2::package::UpgradeTicket {
        authorized(arg0, arg1, arg2);
        assert!(0x1::option::is_some<Proposal>(&arg0.pending), 1801);
        let v0 = 0x2::clock::timestamp_ms(arg4);
        let v1 = 0x1::option::borrow<Proposal>(&arg0.pending);
        assert!(v0 >= v1.executable_after_ms, 1803);
        assert!(arg3 == v1.digest, 1804);
        assert!(v1.proposer_cap == 0x2::object::id<0xc13c241cdcb32ce410dba013bc77590b51c62b6e4cf463a5f0d48fbec6d31b14::authorities::GovernanceCap>(arg2), 1809);
        let Proposal {
            nonce               : v2,
            digest              : _,
            proposed_at_ms      : _,
            executable_after_ms : _,
            proposer_cap        : _,
        } = 0x1::option::extract<Proposal>(&mut arg0.pending);
        let v7 = UpgradeAuthorized{
            nonce        : v2,
            digest       : arg3,
            timestamp_ms : v0,
        };
        0x2::event::emit<UpgradeAuthorized>(v7);
        0x2::package::authorize_upgrade(&mut arg0.cap, 0x2::package::upgrade_policy(&arg0.cap), arg3)
    }

    public fun authorize_emergency(arg0: &mut UpgradeGate, arg1: &0xc13c241cdcb32ce410dba013bc77590b51c62b6e4cf463a5f0d48fbec6d31b14::registry::Registry, arg2: &0xc13c241cdcb32ce410dba013bc77590b51c62b6e4cf463a5f0d48fbec6d31b14::authorities::GovernanceCap, arg3: &0xc13c241cdcb32ce410dba013bc77590b51c62b6e4cf463a5f0d48fbec6d31b14::authorities::EmergencyUpgradeCap, arg4: vector<u8>, arg5: &0x2::clock::Clock) : 0x2::package::UpgradeTicket {
        authorized(arg0, arg1, arg2);
        0xc13c241cdcb32ce410dba013bc77590b51c62b6e4cf463a5f0d48fbec6d31b14::registry::assert_emergency_cap(arg1, arg3);
        assert!(0xc13c241cdcb32ce410dba013bc77590b51c62b6e4cf463a5f0d48fbec6d31b14::registry::status(arg1) == 0xc13c241cdcb32ce410dba013bc77590b51c62b6e4cf463a5f0d48fbec6d31b14::registry::status_frozen(), 1805);
        assert!(!0x1::vector::is_empty<u8>(&arg4), 1806);
        let v0 = if (0x1::option::is_some<Proposal>(&arg0.pending)) {
            0x1::option::some<u64>(0x1::option::borrow<Proposal>(&arg0.pending).nonce)
        } else {
            0x1::option::none<u64>()
        };
        let v1 = EmergencyUpgradeAuthorized{
            digest          : arg4,
            timestamp_ms    : 0x2::clock::timestamp_ms(arg5),
            emergency_cap   : 0x2::object::id<0xc13c241cdcb32ce410dba013bc77590b51c62b6e4cf463a5f0d48fbec6d31b14::authorities::EmergencyUpgradeCap>(arg3),
            preserved_nonce : v0,
        };
        0x2::event::emit<EmergencyUpgradeAuthorized>(v1);
        0x2::package::authorize_upgrade(&mut arg0.cap, 0x2::package::upgrade_policy(&arg0.cap), arg4)
    }

    fun authorized(arg0: &UpgradeGate, arg1: &0xc13c241cdcb32ce410dba013bc77590b51c62b6e4cf463a5f0d48fbec6d31b14::registry::Registry, arg2: &0xc13c241cdcb32ce410dba013bc77590b51c62b6e4cf463a5f0d48fbec6d31b14::authorities::GovernanceCap) {
        assert!(0x2::object::id<0xc13c241cdcb32ce410dba013bc77590b51c62b6e4cf463a5f0d48fbec6d31b14::registry::Registry>(arg1) == arg0.registry, 1800);
        0xc13c241cdcb32ce410dba013bc77590b51c62b6e4cf463a5f0d48fbec6d31b14::registry::assert_governance_cap(arg1, arg2);
    }

    entry fun bind_from_vault(arg0: &mut 0x21fe7f81e7e4b9d9cbd32cd94dca7a68d04b8d3371c3923241635a8b3de2e61a::vault::Vault, arg1: 0x2::object::ID, arg2: &0xc13c241cdcb32ce410dba013bc77590b51c62b6e4cf463a5f0d48fbec6d31b14::registry::Registry, arg3: &0xc13c241cdcb32ce410dba013bc77590b51c62b6e4cf463a5f0d48fbec6d31b14::authorities::GovernanceCap, arg4: &mut 0x2::tx_context::TxContext) {
        0xc13c241cdcb32ce410dba013bc77590b51c62b6e4cf463a5f0d48fbec6d31b14::registry::assert_governance_cap(arg2, arg3);
        let v0 = BindWitness{dummy_field: false};
        let v1 = UpgradeGate{
            id          : 0x2::object::new(arg4),
            cap         : 0x21fe7f81e7e4b9d9cbd32cd94dca7a68d04b8d3371c3923241635a8b3de2e61a::vault::release<BindWitness>(arg0, v0, arg1, arg4),
            pending     : 0x1::option::none<Proposal>(),
            next_nonce  : 0,
            registry    : 0x2::object::id<0xc13c241cdcb32ce410dba013bc77590b51c62b6e4cf463a5f0d48fbec6d31b14::registry::Registry>(arg2),
            timelock_ms : 172800000,
        };
        0x2::transfer::share_object<UpgradeGate>(v1);
    }

    entry fun cancel(arg0: &mut UpgradeGate, arg1: &0xc13c241cdcb32ce410dba013bc77590b51c62b6e4cf463a5f0d48fbec6d31b14::registry::Registry, arg2: &0xc13c241cdcb32ce410dba013bc77590b51c62b6e4cf463a5f0d48fbec6d31b14::authorities::GovernanceCap) {
        authorized(arg0, arg1, arg2);
        assert!(0x1::option::is_some<Proposal>(&arg0.pending), 1801);
        let Proposal {
            nonce               : v0,
            digest              : v1,
            proposed_at_ms      : _,
            executable_after_ms : _,
            proposer_cap        : _,
        } = 0x1::option::extract<Proposal>(&mut arg0.pending);
        let v5 = UpgradeCancelled{
            nonce  : v0,
            digest : v1,
        };
        0x2::event::emit<UpgradeCancelled>(v5);
    }

    public fun commit(arg0: &mut UpgradeGate, arg1: 0x2::package::UpgradeReceipt, arg2: &0x2::clock::Clock) {
        0x2::package::commit_upgrade(&mut arg0.cap, arg1);
        let v0 = UpgradeCommitted{timestamp_ms: 0x2::clock::timestamp_ms(arg2)};
        0x2::event::emit<UpgradeCommitted>(v0);
    }

    public fun earliest_ms(arg0: &UpgradeGate) : u64 {
        if (0x1::option::is_some<Proposal>(&arg0.pending)) {
            0x1::option::borrow<Proposal>(&arg0.pending).executable_after_ms
        } else {
            0
        }
    }

    public fun has_pending(arg0: &UpgradeGate) : bool {
        0x1::option::is_some<Proposal>(&arg0.pending)
    }

    public fun next_nonce(arg0: &UpgradeGate) : u64 {
        arg0.next_nonce
    }

    public fun pending_digest(arg0: &UpgradeGate) : vector<u8> {
        if (0x1::option::is_some<Proposal>(&arg0.pending)) {
            0x1::option::borrow<Proposal>(&arg0.pending).digest
        } else {
            b""
        }
    }

    public fun pending_nonce(arg0: &UpgradeGate) : 0x1::option::Option<u64> {
        if (0x1::option::is_some<Proposal>(&arg0.pending)) {
            0x1::option::some<u64>(0x1::option::borrow<Proposal>(&arg0.pending).nonce)
        } else {
            0x1::option::none<u64>()
        }
    }

    public fun pending_proposer_cap(arg0: &UpgradeGate) : 0x1::option::Option<0x2::object::ID> {
        if (0x1::option::is_some<Proposal>(&arg0.pending)) {
            0x1::option::some<0x2::object::ID>(0x1::option::borrow<Proposal>(&arg0.pending).proposer_cap)
        } else {
            0x1::option::none<0x2::object::ID>()
        }
    }

    entry fun propose(arg0: &mut UpgradeGate, arg1: &0xc13c241cdcb32ce410dba013bc77590b51c62b6e4cf463a5f0d48fbec6d31b14::registry::Registry, arg2: &0xc13c241cdcb32ce410dba013bc77590b51c62b6e4cf463a5f0d48fbec6d31b14::authorities::GovernanceCap, arg3: vector<u8>, arg4: &0x2::clock::Clock) {
        authorized(arg0, arg1, arg2);
        assert!(0x1::option::is_none<Proposal>(&arg0.pending), 1802);
        assert!(!0x1::vector::is_empty<u8>(&arg3), 1806);
        let v0 = 0x2::clock::timestamp_ms(arg4);
        let v1 = arg0.next_nonce;
        arg0.next_nonce = v1 + 1;
        let v2 = v0 + arg0.timelock_ms;
        let v3 = 0x2::object::id<0xc13c241cdcb32ce410dba013bc77590b51c62b6e4cf463a5f0d48fbec6d31b14::authorities::GovernanceCap>(arg2);
        let v4 = Proposal{
            nonce               : v1,
            digest              : arg3,
            proposed_at_ms      : v0,
            executable_after_ms : v2,
            proposer_cap        : v3,
        };
        0x1::option::fill<Proposal>(&mut arg0.pending, v4);
        let v5 = UpgradeProposed{
            nonce          : v1,
            digest         : arg3,
            earliest_ms    : v2,
            proposed_at_ms : v0,
            proposer_cap   : v3,
        };
        0x2::event::emit<UpgradeProposed>(v5);
    }

    entry fun raise_timelock(arg0: &mut UpgradeGate, arg1: &0xc13c241cdcb32ce410dba013bc77590b51c62b6e4cf463a5f0d48fbec6d31b14::registry::Registry, arg2: &0xc13c241cdcb32ce410dba013bc77590b51c62b6e4cf463a5f0d48fbec6d31b14::authorities::GovernanceCap, arg3: u64) {
        authorized(arg0, arg1, arg2);
        assert!(arg3 >= arg0.timelock_ms, 1807);
        arg0.timelock_ms = arg3;
        if (0x1::option::is_some<Proposal>(&arg0.pending)) {
            let v0 = 0x1::option::borrow_mut<Proposal>(&mut arg0.pending);
            let v1 = v0.proposed_at_ms + arg3;
            if (v1 > v0.executable_after_ms) {
                v0.executable_after_ms = v1;
                let v2 = ProposalDeadlineExtended{
                    nonce               : v0.nonce,
                    previous_ms         : v0.executable_after_ms,
                    executable_after_ms : v1,
                };
                0x2::event::emit<ProposalDeadlineExtended>(v2);
            };
        };
    }

    public fun registry_id(arg0: &UpgradeGate) : 0x2::object::ID {
        arg0.registry
    }

    public fun timelock_ms(arg0: &UpgradeGate) : u64 {
        arg0.timelock_ms
    }

    // decompiled from Move bytecode v7
}

