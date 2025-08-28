module 0xfead11346a6274b1a2927f6f71daf98479a7100b65ec201b5bd65b381ab4604c::commission_oracle {
    struct CommissionUpdated has copy, drop {
        validator_address: address,
        old_commission: u64,
        new_commission: u64,
        timestamp: u64,
        epoch: u64,
    }

    struct OracleCreated has copy, drop {
        oracle_id: address,
        owner: address,
        validator_address: address,
    }

    struct CommissionOracle has key {
        id: 0x2::object::UID,
        validator_address: address,
        current_commission: u64,
        last_update_timestamp: u64,
        last_update_epoch: u64,
        update_count: u64,
    }

    struct OwnerCap has store, key {
        id: 0x2::object::UID,
        oracle_id: address,
    }

    public fun check_owner_cap(arg0: &CommissionOracle, arg1: &OwnerCap) : bool {
        arg1.oracle_id == 0x2::object::uid_to_address(&arg0.id)
    }

    public fun create_oracle(arg0: address, arg1: u64, arg2: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::object::new(arg2);
        let v1 = 0x2::object::uid_to_address(&v0);
        let v2 = CommissionOracle{
            id                    : v0,
            validator_address     : arg0,
            current_commission    : arg1,
            last_update_timestamp : 0,
            last_update_epoch     : 0x2::tx_context::epoch(arg2),
            update_count          : 0,
        };
        let v3 = OwnerCap{
            id        : 0x2::object::new(arg2),
            oracle_id : v1,
        };
        let v4 = OracleCreated{
            oracle_id         : v1,
            owner             : 0x2::tx_context::sender(arg2),
            validator_address : arg0,
        };
        0x2::event::emit<OracleCreated>(v4);
        0x2::transfer::share_object<CommissionOracle>(v2);
        0x2::transfer::transfer<OwnerCap>(v3, 0x2::tx_context::sender(arg2));
    }

    public fun format_commission_sui(arg0: u64) : vector<u8> {
        b"commission_value"
    }

    public fun get_current_commission(arg0: &CommissionOracle) : u64 {
        arg0.current_commission
    }

    public fun get_last_update_epoch(arg0: &CommissionOracle) : u64 {
        arg0.last_update_epoch
    }

    public fun get_last_update_timestamp(arg0: &CommissionOracle) : u64 {
        arg0.last_update_timestamp
    }

    public fun get_oracle_id(arg0: &CommissionOracle) : address {
        0x2::object::uid_to_address(&arg0.id)
    }

    public fun get_update_count(arg0: &CommissionOracle) : u64 {
        arg0.update_count
    }

    public fun get_validator_address(arg0: &CommissionOracle) : address {
        arg0.validator_address
    }

    public fun update_commission(arg0: &mut CommissionOracle, arg1: &OwnerCap, arg2: u64, arg3: u64, arg4: &mut 0x2::tx_context::TxContext) {
        assert!(arg1.oracle_id == 0x2::object::uid_to_address(&arg0.id), 2);
        assert!(arg3 > arg0.last_update_timestamp, 3);
        let v0 = 0x2::tx_context::epoch(arg4);
        let v1 = CommissionUpdated{
            validator_address : arg0.validator_address,
            old_commission    : arg0.current_commission,
            new_commission    : arg2,
            timestamp         : arg3,
            epoch             : v0,
        };
        0x2::event::emit<CommissionUpdated>(v1);
        arg0.current_commission = arg2;
        arg0.last_update_timestamp = arg3;
        arg0.last_update_epoch = v0;
        arg0.update_count = arg0.update_count + 1;
    }

    // decompiled from Move bytecode v6
}

