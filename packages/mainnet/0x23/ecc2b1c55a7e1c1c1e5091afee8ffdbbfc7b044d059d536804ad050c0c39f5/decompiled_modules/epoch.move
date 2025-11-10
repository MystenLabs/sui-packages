module 0x23ecc2b1c55a7e1c1c1e5091afee8ffdbbfc7b044d059d536804ad050c0c39f5::epoch {
    struct EpochConfig has store, key {
        id: 0x2::object::UID,
        epoch_interval: u64,
    }

    public fun convert_to_epoch_end(arg0: &EpochConfig, arg1: u64) : u64 {
        epoch_end(arg0, epoch_id(arg0, arg1))
    }

    public fun convert_to_epoch_start(arg0: &EpochConfig, arg1: u64) : u64 {
        epoch_start(arg0, epoch_id(arg0, arg1))
    }

    public(friend) fun create(arg0: u64, arg1: &mut 0x2::tx_context::TxContext) : EpochConfig {
        EpochConfig{
            id             : 0x2::object::new(arg1),
            epoch_interval : arg0,
        }
    }

    public fun epoch_end(arg0: &EpochConfig, arg1: u64) : u64 {
        let v0 = arg0.epoch_interval;
        arg1 * v0 + v0
    }

    public fun epoch_id(arg0: &EpochConfig, arg1: u64) : u64 {
        arg1 / arg0.epoch_interval
    }

    public fun epoch_ids_for_range(arg0: &EpochConfig, arg1: u64, arg2: u64) : (u64, u64) {
        (epoch_id(arg0, arg1), epoch_id(arg0, arg2))
    }

    public fun epoch_interval_ms(arg0: &EpochConfig) : u64 {
        arg0.epoch_interval
    }

    public fun epoch_start(arg0: &EpochConfig, arg1: u64) : u64 {
        arg1 * arg0.epoch_interval
    }

    public fun is_epoch_start(arg0: &EpochConfig, arg1: u64) : bool {
        arg1 % arg0.epoch_interval == 0
    }

    // decompiled from Move bytecode v6
}

