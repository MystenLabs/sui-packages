module 0x8ce9c6f9f0206ffb7940e52d712965ad3f1a0b27572c9aab1ad065e218ef6c35::epoch {
    struct EpochConfig has store, key {
        id: 0x2::object::UID,
        epoch_interval: u64,
        epoch_prologue: u64,
        epoch_finale: u64,
    }

    public fun convert_to_epoch_end(arg0: &EpochConfig, arg1: u64) : u64 {
        epoch_end(arg0, epoch_id(arg0, arg1))
    }

    public fun convert_to_epoch_start(arg0: &EpochConfig, arg1: u64) : u64 {
        epoch_start(arg0, epoch_id(arg0, arg1))
    }

    public(friend) fun create(arg0: u64, arg1: u64, arg2: u64, arg3: &mut 0x2::tx_context::TxContext) : EpochConfig {
        assert!(arg0 > arg1, 0);
        assert!(arg0 > arg2, 1);
        assert!(arg0 > arg1 + arg2, 2);
        EpochConfig{
            id             : 0x2::object::new(arg3),
            epoch_interval : arg0,
            epoch_prologue : arg1,
            epoch_finale   : arg2,
        }
    }

    public fun epoch_end(arg0: &EpochConfig, arg1: u64) : u64 {
        arg1 * arg0.epoch_interval + arg0.epoch_interval
    }

    public fun epoch_finale_ms(arg0: &EpochConfig) : u64 {
        arg0.epoch_finale
    }

    public fun epoch_finale_start(arg0: &EpochConfig, arg1: u64) : u64 {
        epoch_end(arg0, arg1) - arg0.epoch_finale
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

    public fun epoch_main_start(arg0: &EpochConfig, arg1: u64) : u64 {
        epoch_start(arg0, arg1) + arg0.epoch_prologue
    }

    public fun epoch_prologue_ms(arg0: &EpochConfig) : u64 {
        arg0.epoch_prologue
    }

    public fun epoch_start(arg0: &EpochConfig, arg1: u64) : u64 {
        arg1 * arg0.epoch_interval
    }

    public fun is_epoch_start(arg0: &EpochConfig, arg1: u64) : bool {
        arg1 % arg0.epoch_interval == 0
    }

    public(friend) fun set_finale_ms(arg0: &mut EpochConfig, arg1: u64) {
        assert!(arg0.epoch_interval > arg0.epoch_prologue + arg1, 1);
        arg0.epoch_finale = arg1;
    }

    public(friend) fun set_prologue_ms(arg0: &mut EpochConfig, arg1: u64) {
        assert!(arg0.epoch_interval > arg1 + arg0.epoch_finale, 0);
        arg0.epoch_prologue = arg1;
    }

    // decompiled from Move bytecode v6
}

