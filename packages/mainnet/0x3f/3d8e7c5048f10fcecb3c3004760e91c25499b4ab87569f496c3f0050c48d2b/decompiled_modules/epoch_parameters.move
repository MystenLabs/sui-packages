module 0x3f3d8e7c5048f10fcecb3c3004760e91c25499b4ab87569f496c3f0050c48d2b::epoch_parameters {
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

