module 0xe1cbd92c6ef6bf04f905f5c2caf7fa754f41480618eac2e2a59b24551f8d2d08::epoch_parameters {
    struct EpochParams has copy, drop, store {
        total_capacity_size: u64,
        storage_price_per_unit_size: u64,
        write_price_per_unit_size: u64,
    }

    public(friend) fun capacity(arg0: &EpochParams) : u64 {
        arg0.total_capacity_size
    }

    public(friend) fun new(arg0: u64, arg1: u64, arg2: u64) : EpochParams {
        EpochParams{
            total_capacity_size         : arg0,
            storage_price_per_unit_size : arg1,
            write_price_per_unit_size   : arg2,
        }
    }

    public(friend) fun storage_price(arg0: &EpochParams) : u64 {
        arg0.storage_price_per_unit_size
    }

    public(friend) fun write_price(arg0: &EpochParams) : u64 {
        arg0.write_price_per_unit_size
    }

    // decompiled from Move bytecode v6
}

