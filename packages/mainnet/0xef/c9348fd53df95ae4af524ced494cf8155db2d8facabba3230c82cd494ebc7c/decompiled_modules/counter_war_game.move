module 0xefc9348fd53df95ae4af524ced494cf8155db2d8facabba3230c82cd494ebc7c::counter_war_game {
    struct Counter has store, key {
        id: 0x2::object::UID,
        value: u64,
    }

    struct CounterManager has key {
        id: 0x2::object::UID,
        total_created: u64,
    }

    public fun create(arg0: &mut CounterManager, arg1: &mut 0x2::tx_context::TxContext) {
        arg0.total_created = arg0.total_created + 1;
        let v0 = Counter{
            id    : 0x2::object::new(arg1),
            value : 0,
        };
        0x2::transfer::transfer<Counter>(v0, 0x2::tx_context::sender(arg1));
    }

    public fun decrement(arg0: &mut Counter) {
        assert!(arg0.value > 0, 0);
        arg0.value = arg0.value - 1;
    }

    public fun get_total(arg0: &CounterManager) : u64 {
        arg0.total_created
    }

    public fun get_value(arg0: &Counter) : u64 {
        arg0.value
    }

    public fun increment(arg0: &mut Counter) {
        arg0.value = arg0.value + 1;
    }

    fun init(arg0: &mut 0x2::tx_context::TxContext) {
        let v0 = CounterManager{
            id            : 0x2::object::new(arg0),
            total_created : 0,
        };
        0x2::transfer::share_object<CounterManager>(v0);
    }

    // decompiled from Move bytecode v6
}

