module 0x7d30f6c265b25255d33de0ed09eec5fb8747cf1a2622646fc8f594cce2180523::epoch {
    struct Epoch has store, key {
        id: 0x2::object::UID,
        value: u64,
        timestamp: u64,
        duration: u64,
    }

    public fun epoch(arg0: &Epoch) : u64 {
        arg0.value
    }

    public fun check_epoch(arg0: &Epoch, arg1: &0x2::clock::Clock) {
        assert!(0x2::clock::timestamp_ms(arg1) >= next_epoch_timestamp(arg0), 1);
    }

    public(friend) fun create(arg0: u64, arg1: u64, arg2: &0x2::clock::Clock, arg3: &mut 0x2::tx_context::TxContext) {
        assert!(0x2::clock::timestamp_ms(arg2) < arg0 && arg1 > 0, 0);
        let v0 = Epoch{
            id        : 0x2::object::new(arg3),
            value     : 0,
            timestamp : arg0,
            duration  : arg1,
        };
        0x2::transfer::share_object<Epoch>(v0);
    }

    public fun duration(arg0: &Epoch) : u64 {
        arg0.duration
    }

    public(friend) fun next(arg0: &mut Epoch) {
        arg0.value = arg0.value + 1;
        arg0.timestamp = arg0.timestamp + arg0.duration;
    }

    public fun next_epoch_timestamp(arg0: &Epoch) : u64 {
        arg0.timestamp + arg0.duration
    }

    public(friend) fun set_duration(arg0: &mut Epoch, arg1: u64) {
        assert!(arg1 > 0, 0);
        arg0.duration = arg1;
    }

    public fun timestamp(arg0: &Epoch) : u64 {
        arg0.timestamp
    }

    // decompiled from Move bytecode v6
}

