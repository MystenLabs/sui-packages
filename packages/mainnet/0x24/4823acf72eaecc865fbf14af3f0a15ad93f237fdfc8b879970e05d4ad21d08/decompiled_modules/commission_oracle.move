module 0x244823acf72eaecc865fbf14af3f0a15ad93f237fdfc8b879970e05d4ad21d08::commission_oracle {
    struct CommissionOracle has store, key {
        id: 0x2::object::UID,
        validator_address: address,
        current_commission: u64,
        last_update: u64,
    }

    struct OwnerCap has store, key {
        id: 0x2::object::UID,
    }

    struct CommissionUpdated has copy, drop {
        validator_address: address,
        old_commission: u64,
        new_commission: u64,
        timestamp: u64,
    }

    public fun create_oracle(arg0: address, arg1: u64, arg2: &mut 0x2::tx_context::TxContext) {
        assert!(arg1 <= 10000, 0);
        let v0 = CommissionOracle{
            id                 : 0x2::object::new(arg2),
            validator_address  : arg0,
            current_commission : arg1,
            last_update        : 0,
        };
        let v1 = OwnerCap{id: 0x2::object::new(arg2)};
        0x2::transfer::share_object<CommissionOracle>(v0);
        0x2::transfer::transfer<OwnerCap>(v1, 0x2::tx_context::sender(arg2));
    }

    public fun destroy_oracle(arg0: CommissionOracle, arg1: OwnerCap) {
        let CommissionOracle {
            id                 : v0,
            validator_address  : _,
            current_commission : _,
            last_update        : _,
        } = arg0;
        let OwnerCap { id: v4 } = arg1;
        0x2::object::delete(v0);
        0x2::object::delete(v4);
    }

    public fun get_commission(arg0: &CommissionOracle) : u64 {
        arg0.current_commission
    }

    public fun get_last_update(arg0: &CommissionOracle) : u64 {
        arg0.last_update
    }

    public fun get_validator_address(arg0: &CommissionOracle) : address {
        arg0.validator_address
    }

    public fun update_commission(arg0: &mut CommissionOracle, arg1: u64, arg2: &OwnerCap, arg3: &0x2::clock::Clock, arg4: &mut 0x2::tx_context::TxContext) {
        assert!(arg1 <= 10000, 0);
        let v0 = 0x2::clock::timestamp_ms(arg3);
        assert!(v0 > arg0.last_update, 1);
        arg0.current_commission = arg1;
        arg0.last_update = v0;
        let v1 = CommissionUpdated{
            validator_address : arg0.validator_address,
            old_commission    : arg0.current_commission,
            new_commission    : arg1,
            timestamp         : v0,
        };
        0x2::event::emit<CommissionUpdated>(v1);
    }

    // decompiled from Move bytecode v6
}

