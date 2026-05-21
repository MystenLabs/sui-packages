module 0x734b19fa1696dec30f8cae38f1cdbf0ab5a12720735f7c7b0d4935cab31732cc::registry {
    struct LighthouseRegistry has key {
        id: 0x2::object::UID,
        entries: 0x2::table::Table<0x2::object::ID, LighthouseEntry>,
        count: u64,
        last_added_at: u64,
    }

    struct LighthouseEntry has copy, drop, store {
        cast_id: 0x2::object::ID,
        vessel_id: 0x2::object::ID,
        lighthouse_id: 0x2::object::ID,
        registered_at: u64,
        birth_path: u8,
        total_reads_at_birth: u64,
        last_visit_at: u64,
    }

    struct LighthouseRegistered has copy, drop {
        cast_id: 0x2::object::ID,
        vessel_id: 0x2::object::ID,
        lighthouse_id: 0x2::object::ID,
        birth_path: u8,
        reads_at_birth: u64,
        registry_size: u64,
        registered_at: u64,
    }

    struct RegistryVisitRecorded has copy, drop {
        cast_id: 0x2::object::ID,
        lighthouse_id: 0x2::object::ID,
        visit_count: u64,
        last_visit_at: u64,
    }

    public fun contains(arg0: &LighthouseRegistry, arg1: 0x2::object::ID) : bool {
        0x2::table::contains<0x2::object::ID, LighthouseEntry>(&arg0.entries, arg1)
    }

    public fun count(arg0: &LighthouseRegistry) : u64 {
        arg0.count
    }

    public fun entry_birth_path(arg0: &LighthouseEntry) : u8 {
        arg0.birth_path
    }

    public fun entry_cast_id(arg0: &LighthouseEntry) : 0x2::object::ID {
        arg0.cast_id
    }

    public fun entry_last_visit(arg0: &LighthouseEntry) : u64 {
        arg0.last_visit_at
    }

    public fun entry_lighthouse_id(arg0: &LighthouseEntry) : 0x2::object::ID {
        arg0.lighthouse_id
    }

    public fun entry_reads(arg0: &LighthouseEntry) : u64 {
        arg0.total_reads_at_birth
    }

    public fun entry_registered_at(arg0: &LighthouseEntry) : u64 {
        arg0.registered_at
    }

    public fun entry_vessel_id(arg0: &LighthouseEntry) : 0x2::object::ID {
        arg0.vessel_id
    }

    fun init(arg0: &mut 0x2::tx_context::TxContext) {
        let v0 = LighthouseRegistry{
            id            : 0x2::object::new(arg0),
            entries       : 0x2::table::new<0x2::object::ID, LighthouseEntry>(arg0),
            count         : 0,
            last_added_at : 0,
        };
        0x2::transfer::share_object<LighthouseRegistry>(v0);
    }

    public fun last_added_at(arg0: &LighthouseRegistry) : u64 {
        arg0.last_added_at
    }

    public fun lookup(arg0: &LighthouseRegistry, arg1: 0x2::object::ID) : &LighthouseEntry {
        assert!(0x2::table::contains<0x2::object::ID, LighthouseEntry>(&arg0.entries, arg1), 2);
        0x2::table::borrow<0x2::object::ID, LighthouseEntry>(&arg0.entries, arg1)
    }

    public fun record_visit(arg0: &mut LighthouseRegistry, arg1: 0x2::object::ID, arg2: 0x2::object::ID, arg3: u64, arg4: u64) {
        if (!0x2::table::contains<0x2::object::ID, LighthouseEntry>(&arg0.entries, arg1)) {
            return
        };
        0x2::table::borrow_mut<0x2::object::ID, LighthouseEntry>(&mut arg0.entries, arg1).last_visit_at = arg4;
        let v0 = RegistryVisitRecorded{
            cast_id       : arg1,
            lighthouse_id : arg2,
            visit_count   : arg3,
            last_visit_at : arg4,
        };
        0x2::event::emit<RegistryVisitRecorded>(v0);
    }

    public fun register(arg0: &mut LighthouseRegistry, arg1: 0x2::object::ID, arg2: 0x2::object::ID, arg3: 0x2::object::ID, arg4: u8, arg5: u64, arg6: u64) {
        assert!(!0x2::table::contains<0x2::object::ID, LighthouseEntry>(&arg0.entries, arg1), 1);
        let v0 = LighthouseEntry{
            cast_id              : arg1,
            vessel_id            : arg2,
            lighthouse_id        : arg3,
            registered_at        : arg6,
            birth_path           : arg4,
            total_reads_at_birth : arg5,
            last_visit_at        : arg6,
        };
        0x2::table::add<0x2::object::ID, LighthouseEntry>(&mut arg0.entries, arg1, v0);
        arg0.count = arg0.count + 1;
        arg0.last_added_at = arg6;
        let v1 = LighthouseRegistered{
            cast_id        : arg1,
            vessel_id      : arg2,
            lighthouse_id  : arg3,
            birth_path     : arg4,
            reads_at_birth : arg5,
            registry_size  : arg0.count,
            registered_at  : arg6,
        };
        0x2::event::emit<LighthouseRegistered>(v1);
    }

    // decompiled from Move bytecode v7
}

