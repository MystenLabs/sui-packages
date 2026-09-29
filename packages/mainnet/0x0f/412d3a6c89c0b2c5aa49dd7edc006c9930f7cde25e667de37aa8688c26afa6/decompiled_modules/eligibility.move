module 0xf412d3a6c89c0b2c5aa49dd7edc006c9930f7cde25e667de37aa8688c26afa6::eligibility {
    struct EligibilityRecord has store {
        status: u8,
        policy_version: u16,
        decided_seq: u64,
    }

    struct EligibilityRegistry has key {
        id: 0x2::object::UID,
        policy_version: u16,
        records: 0x2::table::Table<address, EligibilityRecord>,
    }

    struct EligibilityAuthorityCap has key {
        id: 0x2::object::UID,
        registry_id: 0x2::object::ID,
    }

    struct WalletRegistered has copy, drop {
        wallet: address,
        policy_version: u16,
    }

    struct EligibilityDecided has copy, drop {
        wallet: address,
        status: u8,
        policy_version: u16,
    }

    fun assert_bound_cap(arg0: &EligibilityAuthorityCap, arg1: &EligibilityRegistry) {
        assert!(arg0.registry_id == 0x2::object::id<EligibilityRegistry>(arg1), 13906835016157233157);
    }

    public(friend) fun authority_cap_registry_id(arg0: &EligibilityAuthorityCap) : 0x2::object::ID {
        arg0.registry_id
    }

    public(friend) fun create_registry(arg0: &mut 0x2::tx_context::TxContext) : 0x2::object::ID {
        let v0 = 0x2::object::new(arg0);
        let v1 = 0x2::object::uid_to_inner(&v0);
        let v2 = EligibilityAuthorityCap{
            id          : 0x2::object::new(arg0),
            registry_id : v1,
        };
        0x2::transfer::transfer<EligibilityAuthorityCap>(v2, 0x2::tx_context::sender(arg0));
        let v3 = EligibilityRegistry{
            id             : v0,
            policy_version : 1,
            records        : 0x2::table::new<address, EligibilityRecord>(arg0),
        };
        0x2::transfer::share_object<EligibilityRegistry>(v3);
        v1
    }

    public fun decide(arg0: &mut EligibilityRegistry, arg1: &EligibilityAuthorityCap, arg2: address, arg3: bool, arg4: &mut 0x2::tx_context::TxContext) {
        assert_bound_cap(arg1, arg0);
        if (!0x2::table::contains<address, EligibilityRecord>(&arg0.records, arg2)) {
            let v0 = EligibilityRecord{
                status         : 0,
                policy_version : arg0.policy_version,
                decided_seq    : 0,
            };
            0x2::table::add<address, EligibilityRecord>(&mut arg0.records, arg2, v0);
        };
        let v1 = if (arg3) {
            1
        } else {
            2
        };
        let v2 = 0x2::table::borrow_mut<address, EligibilityRecord>(&mut arg0.records, arg2);
        assert!(v2.status != v1, 13906834913078149127);
        v2.status = v1;
        v2.policy_version = arg0.policy_version;
        v2.decided_seq = v2.decided_seq + 1;
        let v3 = EligibilityDecided{
            wallet         : arg2,
            status         : v1,
            policy_version : arg0.policy_version,
        };
        0x2::event::emit<EligibilityDecided>(v3);
    }

    public(friend) fun decided_seq_of(arg0: &EligibilityRegistry, arg1: address) : u64 {
        if (0x2::table::contains<address, EligibilityRecord>(&arg0.records, arg1)) {
            0x2::table::borrow<address, EligibilityRecord>(&arg0.records, arg1).decided_seq
        } else {
            0
        }
    }

    public(friend) fun eligibility_status(arg0: &EligibilityRegistry, arg1: address) : u8 {
        if (0x2::table::contains<address, EligibilityRecord>(&arg0.records, arg1)) {
            0x2::table::borrow<address, EligibilityRecord>(&arg0.records, arg1).status
        } else {
            0
        }
    }

    public(friend) fun is_eligible(arg0: &EligibilityRegistry, arg1: address) : bool {
        0x2::table::contains<address, EligibilityRecord>(&arg0.records, arg1) && 0x2::table::borrow<address, EligibilityRecord>(&arg0.records, arg1).status == 1
    }

    public fun is_excluded(arg0: &EligibilityRegistry, arg1: address) : bool {
        0x2::table::contains<address, EligibilityRecord>(&arg0.records, arg1) && 0x2::table::borrow<address, EligibilityRecord>(&arg0.records, arg1).status == 2
    }

    public(friend) fun is_registered(arg0: &EligibilityRegistry, arg1: address) : bool {
        0x2::table::contains<address, EligibilityRecord>(&arg0.records, arg1)
    }

    public fun policy_version(arg0: &EligibilityRegistry) : u16 {
        arg0.policy_version
    }

    public(friend) fun record_policy_version_of(arg0: &EligibilityRegistry, arg1: address) : u16 {
        if (0x2::table::contains<address, EligibilityRecord>(&arg0.records, arg1)) {
            0x2::table::borrow<address, EligibilityRecord>(&arg0.records, arg1).policy_version
        } else {
            0
        }
    }

    public fun register(arg0: &mut EligibilityRegistry, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg1);
        if (!0x2::table::contains<address, EligibilityRecord>(&arg0.records, v0)) {
            let v1 = EligibilityRecord{
                status         : 0,
                policy_version : arg0.policy_version,
                decided_seq    : 0,
            };
            0x2::table::add<address, EligibilityRecord>(&mut arg0.records, v0, v1);
        };
        let v2 = WalletRegistered{
            wallet         : v0,
            policy_version : arg0.policy_version,
        };
        0x2::event::emit<WalletRegistered>(v2);
    }

    public fun set_policy_version(arg0: &mut EligibilityRegistry, arg1: &EligibilityAuthorityCap, arg2: u16) {
        assert_bound_cap(arg1, arg0);
        assert!(arg2 > arg0.policy_version, 13906834994682658825);
        arg0.policy_version = arg2;
    }

    public(friend) fun status_eligible() : u8 {
        1
    }

    public(friend) fun status_ineligible() : u8 {
        2
    }

    public(friend) fun status_provisional() : u8 {
        0
    }

    // decompiled from Move bytecode v7
}

