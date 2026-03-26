module 0x90179caad5686477002196af0f1e1107038eedc9dd529418add5d9b644e42b4::energy {
    struct EnergyConfig has key {
        id: 0x2::object::UID,
        assembly_energy: 0x2::table::Table<u64, u64>,
    }

    struct EnergySource has store {
        max_energy_production: u64,
        current_energy_production: u64,
        total_reserved_energy: u64,
    }

    struct StartEnergyProductionEvent has copy, drop {
        energy_source_id: 0x2::object::ID,
        current_energy_production: u64,
    }

    struct StopEnergyProductionEvent has copy, drop {
        energy_source_id: 0x2::object::ID,
    }

    struct EnergyReservedEvent has copy, drop {
        energy_source_id: 0x2::object::ID,
        assembly_type_id: u64,
        energy_reserved: u64,
        total_reserved_energy: u64,
    }

    struct EnergyReleasedEvent has copy, drop {
        energy_source_id: 0x2::object::ID,
        assembly_type_id: u64,
        energy_released: u64,
        total_reserved_energy: u64,
    }

    public fun id(arg0: &EnergyConfig) : 0x2::object::ID {
        0x2::object::id<EnergyConfig>(arg0)
    }

    public fun assembly_energy(arg0: &EnergyConfig, arg1: u64) : u64 {
        assert!(arg1 != 0, 13835058338750005249);
        if (0x2::table::contains<u64, u64>(&arg0.assembly_energy, arg1)) {
            *0x2::table::borrow<u64, u64>(&arg0.assembly_energy, arg1)
        } else {
            0
        }
    }

    public fun available_energy(arg0: &EnergySource) : u64 {
        if (arg0.current_energy_production > arg0.total_reserved_energy) {
            arg0.current_energy_production - arg0.total_reserved_energy
        } else {
            0
        }
    }

    public(friend) fun create(arg0: u64) : EnergySource {
        assert!(arg0 > 0, 13836184526420181001);
        EnergySource{
            max_energy_production     : arg0,
            current_energy_production : 0,
            total_reserved_energy     : 0,
        }
    }

    public fun current_energy_production(arg0: &EnergySource) : u64 {
        arg0.current_energy_production
    }

    public(friend) fun delete(arg0: EnergySource) {
        let EnergySource {
            max_energy_production     : _,
            current_energy_production : _,
            total_reserved_energy     : _,
        } = arg0;
    }

    fun init(arg0: &mut 0x2::tx_context::TxContext) {
        let v0 = EnergyConfig{
            id              : 0x2::object::new(arg0),
            assembly_energy : 0x2::table::new<u64, u64>(arg0),
        };
        0x2::transfer::share_object<EnergyConfig>(v0);
    }

    public fun max_energy_production(arg0: &EnergySource) : u64 {
        arg0.max_energy_production
    }

    public(friend) fun release_energy(arg0: &mut EnergySource, arg1: 0x2::object::ID, arg2: &EnergyConfig, arg3: u64) {
        assert!(arg3 != 0, 13835058892800786433);
        let v0 = assembly_energy(arg2, arg3);
        if (arg0.total_reserved_energy == 0 || arg0.total_reserved_energy < v0) {
            return
        };
        arg0.total_reserved_energy = arg0.total_reserved_energy - v0;
        let v1 = EnergyReleasedEvent{
            energy_source_id      : arg1,
            assembly_type_id      : arg3,
            energy_released       : v0,
            total_reserved_energy : arg0.total_reserved_energy,
        };
        0x2::event::emit<EnergyReleasedEvent>(v1);
    }

    public fun remove_energy_config(arg0: &mut EnergyConfig, arg1: &0x90179caad5686477002196af0f1e1107038eedc9dd529418add5d9b644e42b4::access::AdminACL, arg2: u64, arg3: &0x2::tx_context::TxContext) {
        0x90179caad5686477002196af0f1e1107038eedc9dd529418add5d9b644e42b4::access::verify_sponsor(arg1, arg3);
        assert!(arg2 != 0, 13835058592153075713);
        assert!(0x2::table::contains<u64, u64>(&arg0.assembly_energy, arg2), 13835621546401726469);
        0x2::table::remove<u64, u64>(&mut arg0.assembly_energy, arg2);
    }

    public(friend) fun reserve_energy(arg0: &mut EnergySource, arg1: 0x2::object::ID, arg2: &EnergyConfig, arg3: u64) {
        assert!(arg3 != 0, 13835058789721571329);
        assert!(arg0.current_energy_production > 0, 13836466168900747275);
        let v0 = assembly_energy(arg2, arg3);
        assert!(available_energy(arg0) >= v0, 13835903236126932999);
        arg0.total_reserved_energy = arg0.total_reserved_energy + v0;
        let v1 = EnergyReservedEvent{
            energy_source_id      : arg1,
            assembly_type_id      : arg3,
            energy_reserved       : v0,
            total_reserved_energy : arg0.total_reserved_energy,
        };
        0x2::event::emit<EnergyReservedEvent>(v1);
    }

    public fun set_energy_config(arg0: &mut EnergyConfig, arg1: &0x90179caad5686477002196af0f1e1107038eedc9dd529418add5d9b644e42b4::access::AdminACL, arg2: u64, arg3: u64, arg4: &0x2::tx_context::TxContext) {
        0x90179caad5686477002196af0f1e1107038eedc9dd529418add5d9b644e42b4::access::verify_sponsor(arg1, arg4);
        assert!(arg2 != 0, 13835058519138631681);
        assert!(arg3 > 0, 13835339998410440707);
        if (0x2::table::contains<u64, u64>(&arg0.assembly_energy, arg2)) {
            0x2::table::remove<u64, u64>(&mut arg0.assembly_energy, arg2);
        };
        0x2::table::add<u64, u64>(&mut arg0.assembly_energy, arg2, arg3);
    }

    public(friend) fun start_energy_production(arg0: &mut EnergySource, arg1: 0x2::object::ID) {
        assert!(arg0.current_energy_production == 0, 13836747532208439309);
        arg0.current_energy_production = arg0.max_energy_production;
        let v0 = StartEnergyProductionEvent{
            energy_source_id          : arg1,
            current_energy_production : arg0.current_energy_production,
        };
        0x2::event::emit<StartEnergyProductionEvent>(v0);
    }

    public(friend) fun stop_energy_production(arg0: &mut EnergySource, arg1: 0x2::object::ID) {
        assert!(arg0.current_energy_production > 0, 13836466095886303243);
        arg0.current_energy_production = 0;
        arg0.total_reserved_energy = 0;
        let v0 = StopEnergyProductionEvent{energy_source_id: arg1};
        0x2::event::emit<StopEnergyProductionEvent>(v0);
    }

    public fun total_reserved_energy(arg0: &EnergySource) : u64 {
        arg0.total_reserved_energy
    }

    // decompiled from Move bytecode v6
}

