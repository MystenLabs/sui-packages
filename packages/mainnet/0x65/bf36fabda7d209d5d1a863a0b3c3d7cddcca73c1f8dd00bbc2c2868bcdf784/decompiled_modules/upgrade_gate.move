module 0xf9dacb778acd871ca929c7c6c71db90c086634018dcdb20bd820cff3423d0878::upgrade_gate {
    struct UpgradeGate has key {
        id: 0x2::object::UID,
        cap: 0x2::package::UpgradeCap,
        delay_ms: u64,
        pending: 0x1::option::Option<Proposal>,
    }

    struct Proposal has copy, drop, store {
        digest: vector<u8>,
        policy: u8,
        proposed_at_ms: u64,
        earliest_ms: u64,
    }

    struct UpgradeProposed has copy, drop {
        gate_id: 0x2::object::ID,
        digest: vector<u8>,
        policy: u8,
        proposed_at_ms: u64,
        earliest_ms: u64,
    }

    struct UpgradeCancelled has copy, drop {
        gate_id: 0x2::object::ID,
        digest: vector<u8>,
    }

    struct UpgradeExecuted has copy, drop {
        gate_id: 0x2::object::ID,
        digest: vector<u8>,
        executed_at_ms: u64,
    }

    struct DelayIncreased has copy, drop {
        gate_id: 0x2::object::ID,
        from_ms: u64,
        to_ms: u64,
    }

    struct PolicyRestricted has copy, drop {
        gate_id: 0x2::object::ID,
        policy: u8,
    }

    public fun authorize(arg0: &mut UpgradeGate, arg1: &0xf9dacb778acd871ca929c7c6c71db90c086634018dcdb20bd820cff3423d0878::launchpad::AdminCap, arg2: &0x2::clock::Clock) : 0x2::package::UpgradeTicket {
        assert!(0x1::option::is_some<Proposal>(&arg0.pending), 3);
        let v0 = *0x1::option::borrow<Proposal>(&arg0.pending);
        assert!(0x2::clock::timestamp_ms(arg2) >= v0.earliest_ms, 5);
        arg0.pending = 0x1::option::none<Proposal>();
        let v1 = UpgradeExecuted{
            gate_id        : 0x2::object::id<UpgradeGate>(arg0),
            digest         : v0.digest,
            executed_at_ms : 0x2::clock::timestamp_ms(arg2),
        };
        0x2::event::emit<UpgradeExecuted>(v1);
        0x2::package::authorize_upgrade(&mut arg0.cap, v0.policy, v0.digest)
    }

    public fun cancel(arg0: &mut UpgradeGate, arg1: &0xf9dacb778acd871ca929c7c6c71db90c086634018dcdb20bd820cff3423d0878::launchpad::AdminCap) {
        assert!(0x1::option::is_some<Proposal>(&arg0.pending), 3);
        let Proposal {
            digest         : v0,
            policy         : _,
            proposed_at_ms : _,
            earliest_ms    : _,
        } = 0x1::option::extract<Proposal>(&mut arg0.pending);
        let v4 = UpgradeCancelled{
            gate_id : 0x2::object::id<UpgradeGate>(arg0),
            digest  : v0,
        };
        0x2::event::emit<UpgradeCancelled>(v4);
    }

    public fun commit(arg0: &mut UpgradeGate, arg1: 0x2::package::UpgradeReceipt) {
        0x2::package::commit_upgrade(&mut arg0.cap, arg1);
    }

    public fun create(arg0: 0x2::package::UpgradeCap, arg1: u64, arg2: &mut 0x2::tx_context::TxContext) {
        assert!(arg1 >= 3600000, 1);
        let v0 = UpgradeGate{
            id       : 0x2::object::new(arg2),
            cap      : arg0,
            delay_ms : arg1,
            pending  : 0x1::option::none<Proposal>(),
        };
        0x2::transfer::share_object<UpgradeGate>(v0);
    }

    public fun delay_ms(arg0: &UpgradeGate) : u64 {
        arg0.delay_ms
    }

    public fun has_proposal(arg0: &UpgradeGate) : bool {
        0x1::option::is_some<Proposal>(&arg0.pending)
    }

    public fun increase_delay(arg0: &mut UpgradeGate, arg1: &0xf9dacb778acd871ca929c7c6c71db90c086634018dcdb20bd820cff3423d0878::launchpad::AdminCap, arg2: u64) {
        assert!(arg2 > arg0.delay_ms, 2);
        arg0.delay_ms = arg2;
        let v0 = DelayIncreased{
            gate_id : 0x2::object::id<UpgradeGate>(arg0),
            from_ms : arg0.delay_ms,
            to_ms   : arg2,
        };
        0x2::event::emit<DelayIncreased>(v0);
    }

    public fun package_id(arg0: &UpgradeGate) : 0x2::object::ID {
        0x2::package::upgrade_package(&arg0.cap)
    }

    public fun policy(arg0: &UpgradeGate) : u8 {
        0x2::package::upgrade_policy(&arg0.cap)
    }

    public fun proposal(arg0: &UpgradeGate) : (vector<u8>, u8, u64, u64) {
        let v0 = 0x1::option::borrow<Proposal>(&arg0.pending);
        (v0.digest, v0.policy, v0.proposed_at_ms, v0.earliest_ms)
    }

    public fun propose(arg0: &mut UpgradeGate, arg1: &0xf9dacb778acd871ca929c7c6c71db90c086634018dcdb20bd820cff3423d0878::launchpad::AdminCap, arg2: vector<u8>, arg3: u8, arg4: &0x2::clock::Clock) {
        assert!(0x1::option::is_none<Proposal>(&arg0.pending), 4);
        let v0 = 0x2::clock::timestamp_ms(arg4);
        let v1 = Proposal{
            digest         : arg2,
            policy         : arg3,
            proposed_at_ms : v0,
            earliest_ms    : v0 + arg0.delay_ms,
        };
        arg0.pending = 0x1::option::some<Proposal>(v1);
        let v2 = UpgradeProposed{
            gate_id        : 0x2::object::id<UpgradeGate>(arg0),
            digest         : v1.digest,
            policy         : arg3,
            proposed_at_ms : v0,
            earliest_ms    : v1.earliest_ms,
        };
        0x2::event::emit<UpgradeProposed>(v2);
    }

    public fun restrict_to_additive(arg0: &mut UpgradeGate, arg1: &0xf9dacb778acd871ca929c7c6c71db90c086634018dcdb20bd820cff3423d0878::launchpad::AdminCap) {
        0x2::package::only_additive_upgrades(&mut arg0.cap);
        let v0 = PolicyRestricted{
            gate_id : 0x2::object::id<UpgradeGate>(arg0),
            policy  : 128,
        };
        0x2::event::emit<PolicyRestricted>(v0);
    }

    public fun restrict_to_dep_only(arg0: &mut UpgradeGate, arg1: &0xf9dacb778acd871ca929c7c6c71db90c086634018dcdb20bd820cff3423d0878::launchpad::AdminCap) {
        0x2::package::only_dep_upgrades(&mut arg0.cap);
        let v0 = PolicyRestricted{
            gate_id : 0x2::object::id<UpgradeGate>(arg0),
            policy  : 192,
        };
        0x2::event::emit<PolicyRestricted>(v0);
    }

    // decompiled from Move bytecode v7
}

