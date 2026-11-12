module 0xd2bd9146732b0fbe436aa111981f94b22b6c51485d04a566788e685535548930::spend_cap {
    struct SPEND_CAP has drop {
        dummy_field: bool,
    }

    struct WorkerCap has store, key {
        id: 0x2::object::UID,
    }

    struct SpendCeiling has store, key {
        id: 0x2::object::UID,
        owner: address,
        agent_id: 0x1::string::String,
        max_per_tx_usd_cents: u64,
        max_total_usd_cents: u64,
        total_spend_usd_cents: u64,
        enabled: bool,
    }

    struct CeilingCreated has copy, drop {
        ceiling_id: 0x2::object::ID,
        owner: address,
        agent_id: 0x1::string::String,
        max_per_tx_usd_cents: u64,
        max_total_usd_cents: u64,
    }

    struct CeilingUpdated has copy, drop {
        ceiling_id: 0x2::object::ID,
        max_per_tx_usd_cents: u64,
        max_total_usd_cents: u64,
        enabled: bool,
    }

    struct CeilingOwnershipTransferred has copy, drop {
        ceiling_id: 0x2::object::ID,
        previous_owner: address,
        new_owner: address,
        max_per_tx_usd_cents: u64,
        max_total_usd_cents: u64,
        total_spend_usd_cents: u64,
        was_enabled: bool,
    }

    struct SpendRecorded has copy, drop {
        ceiling_id: 0x2::object::ID,
        amount_usd_cents: u64,
        total_spend_usd_cents: u64,
    }

    public fun check_ceiling(arg0: &SpendCeiling, arg1: u64) : bool {
        if (!arg0.enabled) {
            return false
        };
        if (arg1 > arg0.max_per_tx_usd_cents) {
            return false
        };
        if (arg0.max_total_usd_cents > 0 && arg0.total_spend_usd_cents + arg1 > arg0.max_total_usd_cents) {
            return false
        };
        true
    }

    public entry fun create_ceiling(arg0: 0x1::string::String, arg1: u64, arg2: u64, arg3: &mut 0x2::tx_context::TxContext) {
        assert!(arg1 > 0, 2);
        let v0 = SpendCeiling{
            id                    : 0x2::object::new(arg3),
            owner                 : 0x2::tx_context::sender(arg3),
            agent_id              : arg0,
            max_per_tx_usd_cents  : arg1,
            max_total_usd_cents   : arg2,
            total_spend_usd_cents : 0,
            enabled               : true,
        };
        let v1 = CeilingCreated{
            ceiling_id           : 0x2::object::id<SpendCeiling>(&v0),
            owner                : 0x2::tx_context::sender(arg3),
            agent_id             : v0.agent_id,
            max_per_tx_usd_cents : arg1,
            max_total_usd_cents  : arg2,
        };
        0x2::event::emit<CeilingCreated>(v1);
        0x2::transfer::share_object<SpendCeiling>(v0);
    }

    public fun get_agent_id(arg0: &SpendCeiling) : &0x1::string::String {
        &arg0.agent_id
    }

    public fun get_max(arg0: &SpendCeiling) : u64 {
        arg0.max_per_tx_usd_cents
    }

    public fun get_max_total(arg0: &SpendCeiling) : u64 {
        arg0.max_total_usd_cents
    }

    public fun get_owner(arg0: &SpendCeiling) : address {
        arg0.owner
    }

    public fun get_total_spend(arg0: &SpendCeiling) : u64 {
        arg0.total_spend_usd_cents
    }

    fun init(arg0: SPEND_CAP, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = WorkerCap{id: 0x2::object::new(arg1)};
        0x2::transfer::transfer<WorkerCap>(v0, 0x2::tx_context::sender(arg1));
    }

    public fun is_enabled(arg0: &SpendCeiling) : bool {
        arg0.enabled
    }

    public entry fun record_spend(arg0: &mut SpendCeiling, arg1: u64, arg2: &WorkerCap) {
        assert!(arg0.enabled, 5);
        assert!(arg1 <= arg0.max_per_tx_usd_cents, 3);
        if (arg0.max_total_usd_cents > 0) {
            assert!(arg0.total_spend_usd_cents + arg1 <= arg0.max_total_usd_cents, 4);
        };
        arg0.total_spend_usd_cents = arg0.total_spend_usd_cents + arg1;
        let v0 = SpendRecorded{
            ceiling_id            : 0x2::object::id<SpendCeiling>(arg0),
            amount_usd_cents      : arg1,
            total_spend_usd_cents : arg0.total_spend_usd_cents,
        };
        0x2::event::emit<SpendRecorded>(v0);
    }

    public entry fun transfer_ownership(arg0: &mut SpendCeiling, arg1: address, arg2: &0x2::tx_context::TxContext) {
        assert!(arg0.owner == 0x2::tx_context::sender(arg2), 1);
        assert!(arg1 != @0x0, 6);
        assert!(arg1 != arg0.owner, 7);
        arg0.owner = arg1;
        arg0.enabled = false;
        let v0 = CeilingOwnershipTransferred{
            ceiling_id            : 0x2::object::id<SpendCeiling>(arg0),
            previous_owner        : arg0.owner,
            new_owner             : arg1,
            max_per_tx_usd_cents  : arg0.max_per_tx_usd_cents,
            max_total_usd_cents   : arg0.max_total_usd_cents,
            total_spend_usd_cents : arg0.total_spend_usd_cents,
            was_enabled           : arg0.enabled,
        };
        0x2::event::emit<CeilingOwnershipTransferred>(v0);
    }

    public entry fun update_ceiling(arg0: &mut SpendCeiling, arg1: u64, arg2: u64, arg3: bool, arg4: &0x2::tx_context::TxContext) {
        assert!(arg0.owner == 0x2::tx_context::sender(arg4), 1);
        assert!(arg1 > 0, 2);
        arg0.max_per_tx_usd_cents = arg1;
        arg0.max_total_usd_cents = arg2;
        arg0.enabled = arg3;
        let v0 = CeilingUpdated{
            ceiling_id           : 0x2::object::id<SpendCeiling>(arg0),
            max_per_tx_usd_cents : arg1,
            max_total_usd_cents  : arg2,
            enabled              : arg3,
        };
        0x2::event::emit<CeilingUpdated>(v0);
    }

    // decompiled from Move bytecode v7
}

